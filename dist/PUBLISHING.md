# Publishing Guide

This workspace can prepare the plugin for installation, but it cannot push files to a live online marketplace from the current sandboxed session.

Files to publish:
- `dist/illuminati-writing-package.zip`
- `plugins/illuminati-writing/.codex-plugin/plugin.json`
- `.agents/plugins/marketplace.json`

Recommended publish flow:
1. Upload `dist/illuminati-writing-package.zip` to a GitHub repository release, internal file host, or shared drive.
2. Keep the plugin identifier as `illuminati-writing`.
3. If you maintain a plugin catalog, point its source path or download link at the uploaded archive or extracted plugin directory.
4. If you want a public code host page, replace the placeholder example URLs in `plugin.json` with the real homepage and repository URLs before publishing.

Current note:
- The package is ready for local install and for manual upload to a remote host.
