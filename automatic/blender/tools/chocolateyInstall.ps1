$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender5.1/blender-5.1.0-windows-x64.msi'
  checksum64     = '221efbde5aa3fdf213be699ae8c605f11d10d03bbca4d7fbf6613ca54359052d'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
