<#
Gathers useful information about attached/detected drive information mounted on this workstation. 
Exports to file labeled Drive_Info.txt in child directory Output

List useful information such as 
- Usage 
- Availability
- Fiile system type
- Attached or Networked 
- Share Path 
- Permissions.

Outputs: data to a file labeled Drive_Info.txt.

#>

# Define Output Dir: Export results to a text file labeled Drive_Info.txt in a child directory labeled Output.
$outputFilePath = Join-Path -Path $PSScriptRoot -ChildPath ".\Output\Drive_Info.txt"
# Export Raw output to .csv files.
$outputDiskCSV = Join-Path -Path $PSScriptRoot -ChildPath ".\Output\Disk_Info.csv"
$outputVolumeCSV = Join-Path -Path $PSScriptRoot -ChildPath ".\Output\Volume_Info.csv"
$outputShareCSV = Join-Path -Path $PSScriptRoot -ChildPath ".\Output\Share_Info.csv"


# Gather information about all drives attached to this computer and mounted.
# Create variables to contain drive Data for physical disk[drive Info], mounted drives [volInfo], networked shares [netShareInfo] 
$driveInfo = Get-Disk
$volInfo = Get-Volume
$netShareInfo = Get-SmbShare | Select-Object *

# Header to add Timestamp to log for script execution.
"Drive Report generated on $(Get-Date)" | Out-File -FilePath $outputFilePath

# Write variables to output file labeled Drive_Info.txt
"----- Physical Disk Info -----" | Out-File -FilePath $outputFilePath -Append
$driveInfo | Format-Table -AutoSize | Out-File -FilePath $outputFilePath -Append
$driveInfo | Select-Object DiskNumber, BusType, FriendlyName, UniqueID, Model, SerialNumber, Size | Export-Csv -Path $outputDiskCSV

"----- Volume Info -----" | Out-File -FilePath $outputFilePath -Append
$volInfo | Out-File -FilePath $outputFilePath -Append
$volInfo | Export-Csv -Path $outputVolumeCSV

"----- Network Shares -----" | Out-File -FilePath $outputFilePath -Append
$netShareInfo | Out-File -FilePath $outputFilePath -Append
$netShareInfo | Export-Csv -Path $outputShareCSV

# Wait for input to close the console window
Read-Host -Prompt "[+] The script has finished executing files located in $outputFilePath . Press Enter to Exit"