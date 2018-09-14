mkdir c:\containerd\root
mkdir c:\containerd\config
mkdir c:\containerd\bin
mkdir $ENV:USERPROFILE\.crictl
$oldPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH", $oldPath +";c:\ContainerD\bin", [System.EnvironmentVariableTarget]::Machine)
$env:Path = $env:Path +";c:\ContainerD\bin"

pushd $ENV:TEMP
$httpRoot = "http://$($ENV:PACKER_HTTP_ADDR)"
Write-Output "Searching for updates at $httpRoot"
$httpIndex = Invoke-WebRequest -UseBasicParsing $httpRoot
$httpIndex.Links | Select-Object -Property href | ForEach-Object {
    $fullUrl = "$httpRoot/$($_.href)"
    $localPath = "$($ENV:TEMP)\\$($_.href)"
    Write-Output "Downloading $fullUrl to $localPath"
    Invoke-WebRequest -UseBasicParsing $fullUrl -OutFile $localPath
}
move-item containerd-shim-runhcs-v1.exe C:\containerd\bin\containerd-shim-runhcs-v1.exe
move-item containerd.exe C:\containerd\bin\containerd.exe
move-item ctr.exe C:\containerd\bin\ctr.exe
move-item runhcs.exe C:\containerd\bin\runhcs.exe
move-item crictl.exe C:\containerd\bin\crictl.exe
# TODO: copy scripts/containerd/crictl.yaml to %USERPROFILE%\.crictl
Start-Process c:\containerd\bin\containerd.exe -ArgumentList "--config c:\containerd\config\config.toml"