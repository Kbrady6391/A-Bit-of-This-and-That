#This Script is designed to determine if a machine is a Desktop, Laptop, or Microsoft Surface
#It should be part of your task sequence placed immediately after the Apply Operating system step.
#You need to ensure that powershell is part of your bootPE and might need to enable the execution policy also.
#Also a Set Task Sequence Variable will need to be set called "OSDComputerName"  and the value is $OSDComputerName
#This should be placed after the Apply Windows Settings step.


#Get PC Serial Number from Bios
$SerialNumber = (Get-WmiObject -Class Win32_BIOS | Select-Object SerialNumber)

#Get PC Product Number from Bios
$Product = (Get-WmiObject -class win32_baseboard | Select-Object Product)

#Specify Product output
$Product = "$($Product.product)"

#Trim first 0 off the serial number for a Microsoft Surface.
#Surfaces are given a 12 digit serial number and depending on the naming convention you may need to remove more than one if you
#are using the serial number. in my case I only need to remove the leading number.

$String = $SerialNumber.SerialNumber
$string1 = $string.Substring(1)

#Create OSD Task Sequence Environment Object
#This variable is only available during a PXE OS Deploymnent
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment

#Determine if the system is a laptop
Function Get-Laptop
{
 Param(
 [string]$computer = “localhost”
 )
 $isLaptop = $false
 if(Get-WmiObject -Class win32_systemenclosure -ComputerName $computer |
    Where-Object { $_.chassistypes -eq 9 -or $_.chassistypes -eq 10 `
    -or $_.chassistypes -eq 14})
   { $isLaptop = $true }
 if(Get-WmiObject -Class win32_battery -ComputerName $computer)
   { $isLaptop = $true }
 if(Get-WmiObject -class win32_baseboard -Computername $computer |
    where-object {$_.Product -like 'Surface*'}) 
    { $isLaptop = $false } 
 $isLaptop
} # end function Get-Laptop

cls

# *** entry point to script ***

#If(get-Laptop) { “it’s a laptop” }
#else { “it’s not a laptop”} 

#Determine if the system is a Surface
Function Get-Surface
{
Param(
[String]$Computer = "localhost"
)
    $isSurface = $false
if(Get-WmiObject -class win32_baseboard | Select-Object $type |
    where-object{ $_.product -like 'Surface*'})
    {$isSurface = $true}
  $isSurface 
}
#If(get-Surface) { “it’s a Surface” }
#else { “it’s not a Surface”} 


If (Get-laptop) 
{
$OSDComputername = "GVLL$($String)"
}
Else
{
$OSDComputername = "GVLW$($String)"
}

if (Get-surface)
{
$OSDComputername = "GVLS$($String1)"
}
#Else
#{
#$OSDComputername = "GVLL$($SerialNumber.SerialNumber)"
#}

$TSEnv.Value("OSDComputerName") = "$OSDComputerName"
$TSEnv.value("Product") = "$Product"

$osdcomputername
#get-laptop
#$Product
#get-surface
