$packageName    = 'faas-cli'
$url          = 'https://github.com/openfaas/faas-cli/releases/download/0.4.20/faas-cli.exe'
$checksum     = '2794dc4478ab4f790bc49634a1b98933bdd1feed00beab0216124f6c7eee8b8b'
$checksumType = 'sha256'

$toolsDir       = "$env:ChocolateyInstall\lib\$packageName\tools\"
$fileFullPath   = "$toolsDir\faas-cli.exe"


Get-ChocolateyWebFile -PackageName "$packageName" -FileFullPath "$fileFullPath" -Url "$url" -Checksum "$checksum" -ChecksumType "$checksumType"
