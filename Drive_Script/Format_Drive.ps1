# Selects Disk by UniqueID
$selectedDrive = Get-Disk | Where-Object UniqueId -eq <Unique Drive ID>

# Clear the disk
Clear-Disk -UniqueId $selectedDrive.UniqueId -RemoveData -RemoveOEM

# Initialize the disk as GPT
Initialize-Disk -UniqueId $selectedDrive.UniqueId -PartitionStyle GPT

# Create a new partition and format
New-Partition -DiskNumber $selectedDrive.Number -UseMaximumSize -AssignDriveLetter | Format-Volume -FileSystem NTFS -NewFileSystemLabel "NewDrive"