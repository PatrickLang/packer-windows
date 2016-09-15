# Based off nice step by step at http://woshub.com/how-to-configure-dhcp-server-using-powershell/
Add-WindowsFeature -Name DHCP –IncludeManagementTools
Add-DhcpServerv4Scope -StartRange 192.168.5.32 -EndRange 192.168.5.250 -Name DefaultRange -SubnetMask 255.255.255.0