$images = ""
if (Test-Path env:docker_images) {
  $images = $env:docker_images.split() 
}

function CtrPull {
  Param ([string]$image)

  if ($image -eq "") {
    return
  }

  Write-Host Installing $image ...
  $j = Start-Job -ScriptBlock { ctr.exe --debug images pull $args[0] } -ArgumentList "$image"
  while ( $j.JobStateInfo.state -ne "Completed" -And $j.JobStateInfo.state -ne "Failed" ) {
    Write-Host $j.JobStateInfo.state
    Start-Sleep 30
  }

  $results = Receive-Job -Job $j
  $results
}

$images | foreach {
  CtrPull $_
}