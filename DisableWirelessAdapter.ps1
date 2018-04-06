#Disables the wireless adaptor (for devices that have wired and wireless) 
#so that it doesn't try to pull A DHCP for both on the same device

#get network adapter with Wireless in name
$wmi = Get-WmiObject -Class Win32_NetworkAdapter -filter "Name LIKE '%Wireless%'"
#Disable adapter
$wmi.disable()
