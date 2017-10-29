import-module au

$releases = 'https://github.com/openfaas/faas-cli/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re = "faas-cli.exe"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url = 'https://github.com' + $url

    $version = $url -split '/' | select -Last 1 -Skip 1

    return @{
        URL32        = $url
        Version      = $version.Replace('v', '')
        ReleaseNotes = "$releases/tag/${version}"
    }
}

update -ChecksumFor 32
