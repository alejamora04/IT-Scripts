================================================================================================
Event_Viewer.ps1
================================================================================================
Parses specified event logs and output it to .txt File.


================================================================================================
Drive_Script.ps1
================================================================================================
Gathers useful information about attached/detected drive information mounted on this workstation. 
Exports information to several files in a subdirectory.
Information Includes
- Usage 
- Availability
- Fiile system type
- Attached or Networked 
- Share Path 
- Permissions.

Outputs: 
Data to a file labeled Drive_Info.txt.
Raw Outputs for Volume Info, Disk Info, and Share info in a CSV.


================================================================================================
Format_Drive.ps1
================================================================================================
Wipes all data and partitions from a specified drive including OS disk.
Checks for bad sectors 0's drive.
Reinitializes it.

Wipes all data and partitions from disk selected via Unique ID.
Initializes selected disk as GPT.
Creates a single partition spanning the whole disk.
Formats the partition as NTFS and labels it “BackupDrive”.