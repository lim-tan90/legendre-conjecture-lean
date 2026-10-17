param(
    [switch]$Local,
    [switch]$SkipBuild
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
    if ($Local) {
        $lakefile = 'lakefile.local.toml'
        $manifest = '.lake/local-manifest.json'
        Write-Host 'Using local mathlib path dependency.'
    } else {
        $lakefile = 'lakefile.toml'
        $manifest = $null
        Write-Host 'Using mathlib from git (requires network / cache).'
    }

    if (-not $SkipBuild) {
        & lake exe cache get
        if ($LASTEXITCODE -ne 0) { throw "lake exe cache get failed ($LASTEXITCODE)" }
        & lake -f $lakefile build
        if ($LASTEXITCODE -ne 0) { throw "lake build failed ($LASTEXITCODE)" }
    }

    $args = @('scripts/audit.py', '--lakefile', $lakefile, '--skip-build')
    if ($manifest) { $args += @('--manifest', $manifest) }
    & python @args
    if ($LASTEXITCODE -ne 0) { throw "audit failed ($LASTEXITCODE)" }
} finally {
    Pop-Location
}
