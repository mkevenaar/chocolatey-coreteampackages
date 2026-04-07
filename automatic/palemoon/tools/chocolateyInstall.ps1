$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-34.2.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-34.2.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '4d3c838d4be62ddafe9789ba9f40f156b4eb3af105a84ca02e3e8e7cc9d07d83'
  checksumType  = 'sha256'
  checksum64    = '0f3853f9073cd1f701053e42a497d5d767a49a4492e32d8937605e35562126bd'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
