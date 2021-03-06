import-module au

$releases = 'http://www.qbittorrent.org/download.php'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameSkip 1 -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\tools\verification.txt" = @{
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
    }
  }
}

function global:au_GetLatest {
  try {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  } catch {
    if ($_ -match "Unable to connect to the remote server") {
      Write-Host "qbittorrent.org is down, skipping package update..."
      return "ignore"
    } else {
      throw $_
    }
  }

  $re    = 'setup\.exe\/download$'
  $urls  = $download_page.links | ? href -match $re | select -First 2 -expand href
  $url32 = $urls | ? { $_ -notmatch "x64" }  | select -first 1
  $url64 = $urls | ? { $_ -match "x64" } | select -first 1

  $version   = $url32 -split '[_]' | select -Last 1 -Skip 1
  $version64 = $url64 -split '[_]' | select -Last 1 -Skip 2

  if ($version -ne $version64) {
    throw "32-bit and 64-bit version do not match. Please investigate."
  }

  return @{
    URL32    = $url32
    URL64    = $url64
    Version  = $version
    FileType = 'exe'
  }
}

update -ChecksumFor none
