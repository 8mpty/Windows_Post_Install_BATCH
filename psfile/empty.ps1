# Enable TLSv1.2 for compatibility with older clients
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://raw.githubusercontent.com/8mpty/Windows_Post_Install_BATCH/testing_sperate_files/Install.cmd'

$DownloadActivator = 'https://raw.githubusercontent.com/8mpty/Windows_Post_Install_BATCH/testing_sperate_files/IndividualScripts/ActivateWindows.cmd'


$FilePath = "$env:TEMP\Post_Install.cmd"

$ActivatorFilePath = "$env:TEMP\Activator.cmd"

try {
    Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing -OutFile $FilePath
    Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing -OutFile $ActivatorFilePath
} catch {
    Write-Error $_
	Return
}

if (Test-Path $FilePath) {
    Start-Process $FilePath -Wait
    $item = Get-Item -LiteralPath $FilePath
    $item.Delete()
}
