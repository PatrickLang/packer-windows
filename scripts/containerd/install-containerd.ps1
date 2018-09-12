mkdir c:\containerd\root
mkdir c:\containerd\config
mkdir c:\containerd\bin
mkdir $ENV:USERPROFILE\.crictl
$oldPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH", $oldPath +";c:\ContainerD\bin", [System.EnvironmentVariableTarget]::Machine)
$env:Path = $env:Path +";c:\ContainerD\bin"
# TODO: copy SRC C:\containerd\bin\containerd-shim-runhcs-v1.exe
# TODO: copy SRC C:\containerd\bin\containerd.exe
# TODO: copy SRC C:\containerd\bin\ctr.exe
# TODO: copy     C:\containerd\bin\runhcs.exe
# TODO: copy     C:\containerd\bin\crictl.exe
# TODO: copy scripts/containerd/config.toml c:\containerd\config
# TODO: copy scripts/containerd/crictl.yaml to %USERPROFILE%\.crictl
Start-Process c:\containerd\bin\containerd.exe -ArgumentList "--config c:\containerd\config\config.toml"