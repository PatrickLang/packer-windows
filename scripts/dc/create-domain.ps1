# Note: this was inlined to windows_2016_dc.json

param(
    $DomainName,
    $DomainNetbiosName
)


Import-Module ADDSDeployment
Install-ADDSForest -DomainName $DomainName -DomainNetbiosName $DomainNetbiosName -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "Win2012R2" -ForestMode "Win2012R2" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true

# TODO: Add vagrant user to domain administrators group
# TODO: rename computer to "dc"