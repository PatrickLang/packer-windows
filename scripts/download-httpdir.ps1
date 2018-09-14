$httpRoot = "http://$($ENV:PACKER_HTTP_ADDR)"
Write-Output "Searching for updates at $httpRoot"
$httpIndex = Invoke-WebRequest -UseBasicParsing $httpRoot
$httpIndex.Links | Select-Object -Property href | ForEach-Object {
    $fullUrl = "$httpRoot/$($_.href)"
    $localPath = "$($ENV:TEMP)\\$($_.href)"
    Write-Output "Downloading $fullUrl to $localPath"
    Invoke-WebRequest -UseBasicParsing $fullUrl -OutFile $localPath
}