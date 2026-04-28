$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-34.2.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-34.2.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '62cc3d24856c3d25f3ec320e27b4a5503c653369028ed9b22f34c093af76288a'
  checksumType  = 'sha256'
  checksum64    = '6b314b2bda88fe1a1111d2c810e3c1ce4e82fc6b9acbaf7bd6c9069188199d95'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
