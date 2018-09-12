packer build --only=hyperv-iso `
             --var iso_url=./iso/17758.iso `
             --var iso_checksum='D999CCCB74FF2EBBFFAA2B6A43C3CAE8CA24875426119CC5FDAC7864542E57A2' `
             windows_server_insider_containerd.json
