[CmdletBinding()]
param(
    [string]$ArchivePath
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$archiveDirectory = Join-Path $repoRoot "third_party/archives"
$vendorDirectory = Join-Path $repoRoot "vendor"
$targetDirectory = Join-Path $vendorDirectory "AutoHotInterception"

if ([string]::IsNullOrWhiteSpace($ArchivePath)) {
    $archives = @(Get-ChildItem -Path $archiveDirectory -Filter "AutoHotInterception-*.zip" -File)

    if ($archives.Count -ne 1) {
        throw "Expected exactly one AutoHotInterception-*.zip in '$archiveDirectory'; found $($archives.Count). Specify -ArchivePath to select an archive."
    }

    $ArchivePath = $archives[0].FullName
}
elseif (-not [System.IO.Path]::IsPathRooted($ArchivePath)) {
    $ArchivePath = Join-Path $repoRoot $ArchivePath
}

if (-not (Test-Path -LiteralPath $ArchivePath -PathType Leaf)) {
    throw "Archive not found: $ArchivePath"
}

if ([System.IO.Path]::GetExtension($ArchivePath) -ne ".zip") {
    throw "The dependency archive must be a .zip file: $ArchivePath"
}

New-Item -ItemType Directory -Path $vendorDirectory -Force | Out-Null

if (Test-Path -LiteralPath $targetDirectory) {
    Remove-Item -LiteralPath $targetDirectory -Recurse -Force
}

New-Item -ItemType Directory -Path $targetDirectory -Force | Out-Null
Expand-Archive -LiteralPath $ArchivePath -DestinationPath $targetDirectory -Force

Write-Host "Extracted AHI archive to: $targetDirectory"
Write-Host "The extracted vendor directory is ignored by Git; commit the original ZIP under third_party/archives/."
