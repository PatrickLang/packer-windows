if (Test-Path ./output-hyperv-iso) {
  Remove-Item -Recurse -Force ./output-hyperv-iso
}

packer build --only=hyperv-iso `
             --var iso_url=./iso/17763.253.190108-0006.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso `
             windows_2019_docker.json
