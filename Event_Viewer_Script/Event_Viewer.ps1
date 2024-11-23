<# 

This Script parses events inside of event viewer for the specified log type read from a command line argument.
It grabs logs from a specified Range.
To run the script, open PowerShell, modify execution policy, and run it within the terminal.

Usage: Run script by setting execution policy and running the script within the shell with the appropriate arguments.
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
."D:\<Script_Path>\Event_Viewer.ps1" <LogType> <StartDate> <EndDate>
Ex]
."D:\Documents\Programming_Windows\Code_Windows\PowerShell\Event_Viewer.ps1" System "2024-11-19" "2024-11-20"


#>

# Command Line Arguments allow you to denote Logtype and date range.
param(
	$logType,
	$startDateInput,
	$endDateInput
)

# Result export folder defined by path relative to script directory. Exports as "<LogType>_<Date Range>.json"
$outputFilePath = Join-Path -Path $PSScriptRoot -ChildPath ".\Output\$logType`_logs_$startDateInput`_to_$endDateInput`.json"

# Specify a start and end date for events to filter. format [YYYY-MM-DD].
$startDate = Get-Date $startDateInput
$endDate = Get-Date $endDateInput

# Parse event viewer for parameter 1 [LogType] and exports the events that fall within the specified date range.
$event_logs = Get-WinEvent -LogName $logType | Where-Object { 
    $_.TimeCreated -ge $startDate -and $_.TimeCreated -le $endDate 
}


$event_logs | ConvertTo-Json -Depth 3 | Out-File -FilePath $outputFilePath

# Wait for input to close the console window
Read-Host -Prompt "[+] The script has finished executing. The $logType logs are now a JSON in file directory $outputFilePath . Press Enter to Exit"
