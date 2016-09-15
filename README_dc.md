# Building a Windows Active Directory Domain Controller in Packer
This can be extremely helpful when testing applications using end to end authentication based on Active Directory
instead of methods such as stored username & passwords

### Building with existing ISOs
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