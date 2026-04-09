$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18/wesnoth-1.18.7/wesnoth-1.18.7-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '1ebe433b8f7b526944b63d15caf11f42481375130431237b3f1139a517c7c7bb'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
