$ErrorActionPreference = 'Stop'

if ((Get-OSArchitectureWidth 32) -or ($env:chocolateyForceX86 -eq 'true')) {
   throw "This package doesn't support 32bit architecture"
}

$fileName  = 'nomacs-3.22.1-8f3dff6-neon-24.04-x86_64-quazip-gcc-2404.AppImage.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$zip_path = "$toolsPath\$fileName"
Get-ChildItem $toolsPath\* | Where-Object { $_.PSIsContainer } | Remove-Item -Force -Recurse

$packageArgs = @{
    PackageName  = 'nomacs.portable'
    FileFullPath = $zip_path
    Destination  = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
Remove-Item $zip_path -ea 0
