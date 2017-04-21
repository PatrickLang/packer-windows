mkdir c:\updates
cd c:\updates
$httpRoot = "http://$($ENV:PACKER_HTTP_ADDR)"
Write-Output "Searching for updates at $httpRoot"
$httpIndex = Invoke-WebRequest -UseBasicParsing $httpRoot
$httpIndex.Links | Select-Object -Property href | ForEach-Object {
    if ($_.href -Like "*msu") {
        $fullUrl = "$httpRoot/$($_.href)"
        Write-Output "Downloading $fullUrl"
        Invoke-WebRequest -UseBasicParsing $fullUrl -OutFile $($_.href)
        #dism.exe /online /add-package:"$($_.href)"
        Write-Output "Starting update..."
        wusa.exe "$PWD\\$($_.href)" /quiet /norestart
        $t = Measure-Command { Get-Process wusa | Wait-Process }
        Write-Output "Update process finished in $($t.ToString())"
    }
    else
    {
        Write-Output "Skipping $($_.href)" 
    }
}
notepad.exe # TEMP
cd ~
Remove-Item -Recurse -Force c:\updates