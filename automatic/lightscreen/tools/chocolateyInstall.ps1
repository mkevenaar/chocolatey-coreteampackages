﻿$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  softwareName = "Lightscreen"
  file         = "$toolsDir\LightscreenSetup-2.4.exe"
  fileType     = "exe"
  silentArgs   = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem -Path $toolsDir\*.exe | % { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }
