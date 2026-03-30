$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.22/wesnoth-1.19.22-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '805a9da0b230f4334431704ba0cea6b8dcb4613da2530fcf1f315ff382ec67e2'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
