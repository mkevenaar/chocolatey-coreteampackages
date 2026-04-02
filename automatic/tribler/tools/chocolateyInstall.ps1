$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v8.4.2/Tribler_8.4.2_x64.exe'
  checksum64     = 'edb0ee1a4fa34c16d3e8694aa5194de8fa9ce6b966642d9ec14f77f33eb64164'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
