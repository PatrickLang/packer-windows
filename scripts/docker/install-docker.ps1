Set-ExecutionPolicy Bypass -scope Process
<<<<<<< HEAD
Invoke-WebRequest "https://get.docker.com/builds/Windows/x86_64/docker-1.12.0.zip" -OutFile "$env:TEMP\docker-1.12.0.zip" -UseBasicParsing
Expand-Archive -Path "$env:TEMP\docker-1.12.0.zip" -DestinationPath $env:ProgramFiles
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:ProgramFiles\docker\", [EnvironmentVariableTarget]::Machine)
. 'C:\Program Files\docker\dockerd' --register-service -H npipe:// -H 0.0.0.0:2375 -G docker
=======
New-Item -Type Directory -Path "$($env:ProgramFiles)\docker"
wget -outfile $env:TEMP\docker-1.12.1.zip https://get.docker.com/builds/Windows/x86_64/docker-1.12.1.zip
Expand-Archive -Path $env:TEMP\docker-1.12.1.zip -DestinationPath $env:TEMP -Force
copy $env:TEMP\docker\*.exe $env:ProgramFiles\docker
Remove-Item $env:TEMP\docker-1.12.1.zip
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:ProgramFiles)\docker", [EnvironmentVariableTarget]::Machine)
$env:Path = $env:Path + ";$($env:ProgramFiles)\docker"
. dockerd --register-service -H npipe:// -H 0.0.0.0:2375 -G docker

>>>>>>> 4c353f05df5873bccd1e0e8b82cc013043b4b594
Start-Service Docker

Write-Host "Installing WindowsServerCore container image..."
& "C:\Program Files\docker\docker.exe" pull microsoft/windowsservercore:10.0.14300.1030
<<<<<<< HEAD
& "C:\Program Files\docker\docker.exe" pull microsoft/windowsservercore:latest
=======
& "C:\Program Files\docker\docker.exe" tag microsoft/windowsservercore:10.0.14300.1030 microsoft/windowsservercore:latest
>>>>>>> 4c353f05df5873bccd1e0e8b82cc013043b4b594

if ((get-windowsfeature Hyper-V | where installed).count) {
  Write-Host "Installing NanoServer container image..."
  & "C:\Program Files\docker\docker.exe" pull microsoft/nanoserver:10.0.14300.1030
<<<<<<< HEAD
  & "C:\Program Files\docker\docker.exe" pull microsoft/nanoserver:latest

} else {
  Write-Host "Skipping NanoServer container image"
}
=======
  & "C:\Program Files\docker\docker.exe" tag microsoft/nanoserver:10.0.14300.1030 microsoft/nanoserver:latest
} else {
  Write-Host "Skipping NanoServer container image"
}
>>>>>>> 4c353f05df5873bccd1e0e8b82cc013043b4b594
