$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '25.8.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/25.8.6/win/x86/LibreOffice_25.8.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/25.8.6/win/x86_64/LibreOffice_25.8.6_Win_x86-64.msi'
  checksum               = '139531c0d15180f6d09793d244c2b4a797f6fcb8a5c88dc80fa4cc0a1e5646af'
  checksum64             = 'af055751df683b4ccd5e89b75e55eb77c0a383b7e1f39882d7e3dd99111b645c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn /passive /norestart /l*v "{0}"' -f "$($env:TEMP)\$($env:ChocolateyPackageName).$($env:ChocolateyPackageVersion).MsiInstall.log"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}

if (-not (IsUrlValid $packageArgs.url)) {
  $exactVersion = GetLibOExactVersion $packageArgs.version
  $packageArgs.url = $exactVersion.Url32
  $packageArgs.url64bit = $exactVersion.Url64
}

Install-ChocolateyPackage @packageArgs
