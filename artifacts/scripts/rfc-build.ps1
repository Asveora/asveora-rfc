# ==============================
# RFC BUILD SCRIPT (POWERSHELL)
# ==============================

$ErrorActionPreference = "Stop"

# Resolve base (script location assumption)
$BASE = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

# Adjust if script is NOT inside /scripts
# If you place it elsewhere, set manually:
# $BASE = "C:\path\to\framework-rfc-stack"

$SRC     = Join-Path $BASE "src"
$MANIFEST = Join-Path $BASE "manifest\build-order.txt"
$BUILD   = Join-Path $BASE "build"
$MERGED  = Join-Path $BUILD "_merged.md"
$OUTPUT  = Join-Path $BUILD "RFC.html"
$CSS     = Join-Path $BASE "styles\rfc.css"
$PANDOC  = Join-Path $BASE "tools\pandoc\pandoc.exe"

Write-Host "=============================="
Write-Host "RFC BUILD START (POWERSHELL)"
Write-Host "=============================="
Write-Host "Base:     $BASE"
Write-Host "Manifest: $MANIFEST"
Write-Host "Src:      $SRC"
Write-Host "Build:    $BUILD"
Write-Host "=============================="
Write-Host ""

# Ensure build dir exists
New-Item -ItemType Directory -Force -Path $BUILD | Out-Null

# Validate manifest
if (!(Test-Path $MANIFEST)) {
    throw "Manifest not found: $MANIFEST"
}

Write-Host "[1/3] Reading manifest..."
$files = Get-Content $MANIFEST | Where-Object { $_ -and $_.Trim() -ne "" }

Write-Host "Manifest OK"
Write-Host ""

Write-Host "[2/3] Building merged markdown..."

# Clear old file
"" | Set-Content $MERGED

foreach ($f in $files) {

    $path = Join-Path $SRC $f

    if (Test-Path $path) {

        Add-Content $MERGED ""
        Add-Content $MERGED "=============================="
        Add-Content $MERGED "SOURCE: $f"
        Add-Content $MERGED "=============================="
        Add-Content $MERGED ""

        Get-Content $path | Add-Content $MERGED

        Add-Content $MERGED ""

    } else {
        Write-Host "WARNING: Missing file: $f"
        Write-Host "EXPECTED: $path"
    }
}

Write-Host "Merge complete: $MERGED"
Write-Host ""

Write-Host "[3/3] Running Pandoc..."

if (!(Test-Path $PANDOC)) {
    throw "Pandoc not found: $PANDOC"
}

& $PANDOC $MERGED `
    -o $OUTPUT `
    --standalone `
    --toc `
    --css=$CSS `
    --from markdown

Write-Host ""
Write-Host "=============================="
Write-Host "SUCCESS"
Write-Host "Output: $OUTPUT"
Write-Host "=============================="