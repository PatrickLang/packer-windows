$adapter = get-netadapter
New-NetIPAddress -InterfaceIndex $adapter.ifIndex -IPAddress 192.168.5.1 -AddressFamily IPv4 -PrefixLength 24
