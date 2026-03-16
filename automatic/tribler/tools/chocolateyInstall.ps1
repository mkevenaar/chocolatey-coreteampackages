$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v8.4.1/Tribler_8.4.1_x64.exe'
  checksum64     = 'a797895215b2b303d8cc63065e88cfdea5259d8dcfdcf85c1329fe14151d7ef5'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
