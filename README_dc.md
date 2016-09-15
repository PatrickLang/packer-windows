# Building a Windows Active Directory Domain Controller in Packer
This can be extremely helpful when testing applications using end to end authentication based on Active Directory
instead of methods such as stored username & passwords

## Building with existing ISOs
If you have already downloaded the ISOs or would like to override them, set these additional variables:
- iso_url - path to existing ISO
- iso_checksum - md5sum of existing ISO (if different)

```
packer build -var 'iso_url=./server2016tp5.iso' .\windows_2016_dc.json
```


If you only want to build with Hyper-V, add `--only hyperv-iso`. You can also specify `hyperv_switchname` and there will be no prompts at all during the `packer build`
```
packer build --only hyperv-iso -var 'hyperv_switchname=Ethernet' -var 'iso_url=./server2016tp5.iso' .\windows_2016_dc.json
```


## Issues & TODOs
* Issue: ./dc/static-ip.ps1 changes the only vNIC's IP. This breaks the host -> guest connection for WinRM remoting. Another vSwitch is needed for internal vs external network
 * Alternative - do this in Vagrant instead?
* TODO: confirm that static IP persists. May need to save MAC address or _something else?_ in the box and reapply when its deployed
* TODO: Update other packerfiles here to call sysprep so they can join the domain
* TODO: Vagrantfile to deploy a DC and some domain joined servers
* TODO: remove ENV:\ dump from inline powershell script