param(
    [string]$PluginRoot = "plugins\\illuminati-writing",
    [string]$MarketplacePath = ".agents\\plugins\\marketplace.json",
    [string]$OutputDir = "dist"
)

$ErrorActionPreference = "Stop"

$resolvedPluginRoot = (Resolve-Path -LiteralPath $PluginRoot).Path
$resolvedMarketplace = (Resolve-Path -LiteralPath $MarketplacePath).Path
$resolvedOutputDir = Join-Path (Get-Location) $OutputDir

New-Item -ItemType Directory -Force -Path $resolvedOutputDir | Out-Null

$bundleRoot = Join-Path $resolvedOutputDir "illuminati-writing-package"
if (Test-Path -LiteralPath $bundleRoot) {
    Remove-Item -LiteralPath $bundleRoot -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $bundleRoot | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $bundleRoot "plugins") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $bundleRoot ".agents\\plugins") | Out-Null

Copy-Item -LiteralPath $resolvedPluginRoot -Destination (Join-Path $bundleRoot "plugins") -Recurse -Force
Copy-Item -LiteralPath $resolvedMarketplace -Destination (Join-Path $bundleRoot ".agents\\plugins\\marketplace.json") -Force

$installGuide = @(
    "# Install Guide",
    "",
    "Bundle contents:",
    "- plugins/illuminati-writing",
    "- .agents/plugins/marketplace.json",
    "",
    "Install locally:",
    "1. Copy plugins/illuminati-writing into your Codex plugins directory.",
    "2. Merge or copy .agents/plugins/marketplace.json into your marketplace location.",
    "",
    "Typical locations:",
    "- Repo-local marketplace: <repo>/.agents/plugins/marketplace.json",
    "- Home-local marketplace: ~/.agents/plugins/marketplace.json",
    "- Home-local plugin folder: ~/plugins/illuminati-writing"
) -join "`r`n"

Set-Content -LiteralPath (Join-Path $bundleRoot "INSTALL.md") -Value $installGuide -Encoding UTF8

$zipPath = Join-Path $resolvedOutputDir "illuminati-writing-package.zip"
if (Test-Path -LiteralPath $zipPath) {
    Remove-Item -LiteralPath $zipPath -Force
}

Compress-Archive -Path (Join-Path $bundleRoot "*") -DestinationPath $zipPath -Force

Write-Output "Package directory: $bundleRoot"
Write-Output "Package zip: $zipPath"
