<#
Get attached/detected drive information export to file labeled Drive_Info.txt in child directory Output

Gathers information about all drives attached and mounted on this workstation.
List useful information such as usage, availability, file system type, attached/networked, share path permissions.
Output data to a file labeled Drive_Info.txt.

#>

# Define Output Dir: Export results to a text file labeled Drive_Info.txt in a child directory labeled Output.
$outputFilePath = Join-Path -Path $PSScriptRoot -ChildPath ".\Output\Drive_Info.txt"

# Gather information about all drives attached to this computer and mounted.
# Create variables to contain drive Data for physical disk[drive Info], mounted drives [volInfo], networked shares [netShareInfo] 
$driveInfo = Get-Disk
$volInfo = Get-Volume
$netShareInfo = Get-SmbShare | Select-Object *

# Header with Timestamp for script execution.
"Drive Report generated on $(Get-Date)" | Out-File -FilePath $outputFilePath

# Write variables to output file labeled Drive_Info.txt
"----- Physical Disk Info -----" | Out-File -FilePath $outputFilePath -Append
$driveInfo | Out-File -FilePath $outputFilePath -Append
"----- Volume Info -----" | Out-File -FilePath $outputFilePath -Append
$volInfo | Out-File -FilePath $outputFilePath -Append
"----- Network Shares -----" | Out-File -FilePath $outputFilePath -Append
$netShareInfo | Out-File -FilePath $outputFilePath -Append

# Wait for input to close the console window
Read-Host -Prompt "[+] The script has finished executing. Press Enter to Exit"