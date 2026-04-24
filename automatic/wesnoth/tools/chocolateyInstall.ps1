$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.23/wesnoth-1.19.23-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '69d2d16d491d1cb374a9a687cd23b803b44775ecb8339641abe45bef4bd273d9'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
