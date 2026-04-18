param(
    [Parameter(Mandatory = $true)]
    [string]$PdfPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath,

    [int]$DestinationWidth = 2200
)

$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Runtime.WindowsRuntime
[void][Windows.Storage.StorageFile, Windows.Storage, ContentType=WindowsRuntime]
[void][Windows.Data.Pdf.PdfDocument, Windows.Data.Pdf, ContentType=WindowsRuntime]
[void][Windows.Data.Pdf.PdfPageRenderOptions, Windows.Data.Pdf, ContentType=WindowsRuntime]
[void][Windows.Storage.Streams.InMemoryRandomAccessStream, Windows.Storage.Streams, ContentType=WindowsRuntime]
[void][Windows.Graphics.Imaging.BitmapDecoder, Windows.Graphics.Imaging, ContentType=WindowsRuntime]
[void][Windows.Graphics.Imaging.SoftwareBitmap, Windows.Graphics.Imaging, ContentType=WindowsRuntime]
[void][Windows.Media.Ocr.OcrEngine, Windows.Media.Ocr, ContentType=WindowsRuntime]
[void][Windows.Media.Ocr.OcrResult, Windows.Media.Ocr, ContentType=WindowsRuntime]

$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object {
    $_.Name -eq "AsTask" -and
    $_.IsGenericMethod -and
    $_.GetParameters().Count -eq 1 -and
    $_.GetGenericArguments().Count -eq 1
})[0]

$asTaskAction = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object {
    $_.Name -eq "AsTask" -and
    -not $_.IsGenericMethod -and
    $_.GetParameters().Count -eq 1
})[0]

function Await-Operation {
    param(
        [Parameter(Mandatory = $true)]$Operation,
        [Parameter(Mandatory = $true)][Type]$ResultType
    )

    $method = $asTaskGeneric.MakeGenericMethod($ResultType)
    $task = $method.Invoke($null, @($Operation))
    $task.Wait()
    return $task.Result
}

function Await-Action {
    param(
        [Parameter(Mandatory = $true)]$Action
    )

    $task = $asTaskAction.Invoke($null, @($Action))
    $task.Wait() | Out-Null
}

function Normalize-Text {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Text
    )

    $normalized = $Text `
        -replace "`0", " " `
        -replace [char]0x2010, "-" `
        -replace [char]0x2011, "-" `
        -replace [char]0x2012, "-" `
        -replace [char]0x2013, "-" `
        -replace [char]0x2014, "-" `
        -replace [char]0x2018, "'" `
        -replace [char]0x2019, "'" `
        -replace [char]0x201C, '"' `
        -replace [char]0x201D, '"' `
        -replace [char]0x2022, "*"

    $normalized = [regex]::Replace($normalized, "[ \t]+\r?\n", "`n")
    $normalized = [regex]::Replace($normalized, "(\r?\n){3,}", "`n`n")
    return $normalized.Trim()
}

$ocrEngine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromUserProfileLanguages()
if ($null -eq $ocrEngine) {
    throw "Windows OCR engine could not be created from user profile languages."
}

$storageFile = Await-Operation ([Windows.Storage.StorageFile]::GetFileFromPathAsync($PdfPath)) ([Windows.Storage.StorageFile])
$pdfDocument = Await-Operation ([Windows.Data.Pdf.PdfDocument]::LoadFromFileAsync($storageFile)) ([Windows.Data.Pdf.PdfDocument])

$outputParent = Split-Path -Parent $OutputPath
if (-not [string]::IsNullOrWhiteSpace($outputParent)) {
    New-Item -ItemType Directory -Force -Path $outputParent | Out-Null
}

$pages = New-Object System.Collections.Generic.List[string]
$textPages = 0

for ($pageIndex = 0; $pageIndex -lt $pdfDocument.PageCount; $pageIndex++) {
    $pageNumber = $pageIndex + 1
    $page = $pdfDocument.GetPage($pageIndex)
    $stream = New-Object Windows.Storage.Streams.InMemoryRandomAccessStream
    $renderOptions = New-Object Windows.Data.Pdf.PdfPageRenderOptions
    $renderOptions.DestinationWidth = $DestinationWidth

    Await-Action ($page.RenderToStreamAsync($stream, $renderOptions))
    $decoder = Await-Operation ([Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($stream)) ([Windows.Graphics.Imaging.BitmapDecoder])
    $bitmap = Await-Operation ($decoder.GetSoftwareBitmapAsync()) ([Windows.Graphics.Imaging.SoftwareBitmap])
    $result = Await-Operation ($ocrEngine.RecognizeAsync($bitmap)) ([Windows.Media.Ocr.OcrResult])
    $text = Normalize-Text -Text $result.Text

    if ([string]::IsNullOrWhiteSpace($text)) {
        $text = "[[NO_EXTRACTED_TEXT]]"
    }
    else {
        $textPages++
    }

    $pages.Add("===== PAGE $pageNumber =====`n$text`n")

    $stream.Dispose()
    $page.Dispose()

    if ($pageNumber % 10 -eq 0 -or $pageNumber -eq $pdfDocument.PageCount) {
        Write-Output "OCR processed page $pageNumber of $($pdfDocument.PageCount)"
    }
}

$combined = ($pages -join "`n").TrimEnd() + "`n"
[System.IO.File]::WriteAllText($OutputPath, $combined, [System.Text.Encoding]::UTF8)

Write-Output "OCR complete: $PdfPath"
Write-Output "Pages with text: $textPages / $($pdfDocument.PageCount)"
Write-Output "Output: $OutputPath"
