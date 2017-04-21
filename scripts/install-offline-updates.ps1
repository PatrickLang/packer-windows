$httpRoot = "http://$($ENV:PACKER_HTTP_ADDR)"
Write-Output "Searching for updates at $httpRoot"
$httpIndex = Invoke-WebRequest -UseBasicParsing $httpRoot
$httpIndex.Links | Select-Object -Property href | ForEach-Object {
    if ($_.href -Like "*msu") {
        $fullUrl = "$httpRoot/$($_.href)"
        $localPath = "$($ENV:TEMP)\\$($_.href)"
        Write-Output "Downloading $fullUrl to $localPath"
        Invoke-WebRequest -UseBasicParsing $fullUrl -OutFile $localPath
        #dism.exe /online /add-package:"$($_.href)"
        Get-item $localPath | Write-Output
        Write-Output "Starting update..."
        wusa.exe $localPath /quiet /norestart /log:"$($ENV:TEMP)\\$($_.href).log"
        $t = Measure-Command { Get-Process wusa | Wait-Process }
        Write-Output "Update process finished in $($t.ToString())"
        Start-Process -wait notepad.exe # TEMP for debugging
        Remove-Item $localPath
    }
    else
    {
        Write-Output "Skipping $($_.href)" 
    }
}