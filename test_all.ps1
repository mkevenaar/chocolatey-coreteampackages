#Name can be 'random N' to randomly force the Nth group of packages.

param( [string[]] $Name, [string] $Root = "$PSScriptRoot\automatic", [switch]$ThrowOnErrors )

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }
$global:au_root = Resolve-Path $Root

if (($Name.Length -gt 0) -and ($Name[0] -match '^random (.+)')) {
  [array] $lsau = lsau

  $group = [int]$Matches[1]
  $n = (Get-Random -Maximum $group)
  Write-Host "TESTING GROUP $($n+1) of $group"

  $group_size = [int]($lsau.Count / $group) + 1
  $Name = $lsau | select -First $group_size -Skip ($group_size * $n) | % { $_.Name }

  Write-Host ($Name -join ' ')
  Write-Host ('-' * 80)
}

$options = [ordered]@{
  Force       = $true
  Push        = $false
  Threads     = 10

  IgnoreOn    = @(                                      #Error message parts to set the package ignore status
    'Could not create SSL/TLS secure channel'
    'Could not establish trust relationship'
    'The operation has timed out'
    'Internal Server Error'
    'Service Temporarily Unavailable'
    'Choco pack failed with exit code 1'
  )

  RepeatOn    = @(                                      #Error message parts on which to repeat package updater
    'Could not create SSL/TLS secure channel'             # https://github.com/chocolatey/chocolatey-coreteampackages/issues/718
    'Could not establish trust relationship'
    'Unable to connect'
    'The remote name could not be resolved'
    'Choco pack failed with exit code 1'                  # https://github.com/chocolatey/chocolatey-coreteampackages/issues/721
    'The operation has timed out'
    'Internal Server Error'
    'An exception occurred during a WebClient request'
    'Job returned no object, Vector smash ?'
  )
  RepeatSleep = 60                                      #How much to sleep between repeats in seconds, by default 0
  RepeatCount = 2                                       #How many times to repeat on errors, by default 1

  Report      = @{
    Type   = 'markdown'                                   #Report type: markdown or text
    Path   = "$PSScriptRoot\Update-Force-Test-${n}.md"    #Path where to save the report
    Params = @{                                          #Report parameters:
      Github_UserRepo = $Env:github_user_repo         #  Markdown: shows user info in upper right corner
      NoAppVeyor      = $true                             #  Markdown: do not show AppVeyor build shield
      Title           = "Update Force Test - Group ${n}"
      UserMessage     = "[Ignored](#ignored) | [Update report](https://gist.github.com/$Env:gist_id) | [Build](https://ci.appveyor.com/project/chocolatey-community/chocolatey-coreteampackages-xnxcr)"       #  Markdown, Text: Custom user message to show
    }
  }

  Gist        = @{
    Id          = $Env:gist_id_test                          #Your gist id; leave empty for new private or anonymous gist
    ApiKey      = $Env:github_api_key                        #Your github api key - if empty anoymous gist is created
    Path        = "$PSScriptRoot\Update-Force-Test-${n}.md"  #List of files to add to the gist
    Description = "Update Force Test Report #powershell #chocolatey"
  }

  ModulePaths = @("$PSScriptRoot\scripts\au_extensions.psm1"; "Wormies-AU-Helpers")

  BeforeEach  = {
    param($PackageName, $Options )
    $Options.ModulePaths | % { Import-Module $_ }
    $global:au_Force = $true # Some of the helper scripts rely on this one
  }
}

# https://github.com/majkinetor/au/issues/142

if ($PSVersionTable.PSVersion.major -ge 6) {
  $AvailableTls = [enum]::GetValues('Net.SecurityProtocolType') | Where-Object { $_ -ge 'Tls' } # PowerShell 6+ does not support SSL3, so use TLS minimum
  $AvailableTls.ForEach({ [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor $_ })
}
else {
  [System.Net.ServicePointManager]::SecurityProtocol = 3072 -bor 768 -bor [System.Net.SecurityProtocolType]::Tls -bor [System.Net.SecurityProtocolType]::Ssl3
}

$global:info = updateall -Name $Name -Options $Options

$au_errors = $global:info | ? { $_.Error } | select -ExpandProperty Error

if ($ThrowOnErrors -and $au_errors.Count -gt 0) {
  throw 'Errors during update'
}
