<#
  SystemSecurityCheck.ps1
  This script performs a basic security check on the system,
  including gathering system information and checking service status.
#>

# 1. Collect system information

$computerName = $env:COMPUTERNAME
$currentUser = $env:USERNAME
$powerShellVersion = $PSVersionTable.PSVersion

$ipAddresses = Get-NetIPAddress -AddressFamily IPv4 |
    Where-Object { $_.IPAddress -ne '127.0.0.1' -and $_.IPAddress -notlike '169.254*' } |
    Select-Object -ExpandProperty IPAddress -Unique

$service = Get-Service -Name 'wuauserv' -ErrorAction SilentlyContinue |
    Select-Object Name, Status, StartType

$diskInfo = Get-PSDrive -PSProvider FileSystem |
    Select-Object Name,
        @{Name = 'SizeGB'; Expression = { [math]::Round(($_.Used + $_.Free) / 1GB, 2) }},
        @{Name = 'UsedGB'; Expression = { [math]::Round($_.Used / 1GB, 2) }},
        @{Name = 'FreeGB'; Expression = { [math]::Round($_.Free / 1GB, 2) }}


# 2. Find processes using the most CPU

$topProcesses = Get-CimInstance Win32_PerfFormattedData_PerfProc_Process |
    Where-Object { $_.Name -ne '_Total' -and $_.Name -ne 'Idle' } |
    Sort-Object PercentProcessorTime -Descending |
    Select-Object -First 5 Name, IDProcess, PercentProcessorTime

# 3. Display results

Write-Output "=== SYSTEM SECURITY CHECK ==="

Write-Output "Computer name: $computerName"
Write-Output "Current user: $currentUser"
Write-Output "PowerShell version: $powerShellVersion"

Write-Output "`nIPv4 addresses:"
$ipAddresses

if ($null -ne $service) {
    Write-Output "`nwuauserv status: $($service.Status)"
}
else {
    Write-Output "`nwuauserv status: Not found"
}

Write-Output "`nDisk information:"
$diskInfo | Format-Table -AutoSize

Write-Output "`nTop 5 processes by CPU usage:"
$topProcesses | Format-Table -AutoSize

# 4. Check for potential problems

$systemDisk = $diskInfo | Where-Object Name -eq 'C'

if ($null -eq $systemDisk) {
    Write-Output 'C: drive not found'
}
elseif ($systemDisk.FreeGB -lt 20) {
    Write-Output 'WARNING: Low free disk space!'
}
else {
    Write-Output 'Disk space: OK'
}
