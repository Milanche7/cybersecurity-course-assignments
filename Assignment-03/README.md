# Assignment 03 — PowerShell System Check

## Overview

This assignment documents a basic Windows system check completed as part of the **Windows, Linux and Scripting Foundations** course.

The goal was to use PowerShell to collect information about the computer, check its network configuration and internet connectivity, review the Windows Update service, and inspect available disk space. The final task was to create a PowerShell script that automates several of these checks and reports a condition that may require attention.

The checks were observational. I used PowerShell commands to collect and review information without making changes to the system.

> **Privacy note:** Computer and account names, local IP addresses, gateway details, DNS addresses, and other personal network information have been omitted or redacted. No credentials or secrets are included.

## 1. PowerShell Version

The system was using **Windows PowerShell 5.1.26100.9818**.

This version was installed with Windows. The result identifies the built-in Windows PowerShell environment; a newer PowerShell version can be installed separately if it is needed.

## 2. Computer Name and Current User

I used the following commands to identify the computer and the account currently signed in:

```powershell
whoami
$env:COMPUTERNAME
```

Both commands returned the expected information. The actual computer name and account name have been removed from this public report.

## 3. IP Address and Network Configuration

I used `Get-NetIPConfiguration` to review the network adapters and their configuration.

The output showed the active Wi-Fi connection, including its IPv4 address, default gateway, and DNS server. The system also had virtual network adapters associated with Hyper-V and Tailscale. Disconnected adapters were not included in the summary.

The actual IP addresses and network details have been redacted because they are specific to my local environment.

## 4. Internet Connectivity and DNS Resolution

I used three PowerShell commands to check different parts of the network connection.

### HTTPS connectivity

```powershell
Test-NetConnection google.com -Port 443
```

**Result:** `TcpTestSucceeded: True`

The test successfully established a TCP connection to Google on port 443 using the Wi-Fi interface.

### DNS resolution

```powershell
Resolve-DnsName google.com
```

**Result:** DNS resolution was successful. The command returned both IPv4 (`A`) and IPv6 (`AAAA`) records. The returned addresses have been omitted.

### IP connectivity

```powershell
Test-NetConnection 8.8.8.8
```

**Result:** `PingSucceeded: True` with a recorded round-trip time of 44 ms.

Together, these checks confirmed that the system could resolve the domain name and communicate with an external address. The HTTPS test also confirmed that a TCP connection on port 443 was successful.

## 5. Windows Update Service

I checked the Windows Update service using:

```powershell
Get-Service -Name wuauserv | Select-Object Name, Status, StartType
```

| Property | Result |
|---|---|
| Service | `wuauserv` |
| Status | `Stopped` |
| Start type | `Manual` |

The service was stopped and configured for manual startup at the time of the check. This status alone does not necessarily indicate a problem, because the service is not configured to run continuously.

## 6. Disk Usage

I used `Get-PSDrive` with the `FileSystem` provider to review used and free storage space.

| Disk information | Result |
|---|---:|
| Used space | 379.77 GB |
| Free space | 571.61 GB |
| Approximate total capacity | 951.38 GB |

The disk had more than 570 GB of free space, with less than half of its approximate capacity in use. Based on this check, there was no current need to add more storage.

## 7. System Assessment

Based on the checks performed, the computer was operating as expected.

The computer name, current user, and network configuration were returned correctly. The system had an assigned IP address, DNS resolution worked, and the internet connectivity tests were successful.

The `wuauserv` service was stopped and set to manual startup. This was not treated as a problem by itself. The disk also had enough free space, so additional storage was not required in the near future.

The installed PowerShell version was Windows PowerShell 5.1, which comes with Windows. A newer, separately installed PowerShell version could be considered where required.

The script created for this assignment also collects information about the five processes with the highest reported CPU usage. However, the available report did not include a separate memory-usage measurement, so I cannot draw a conclusion about RAM usage from these results.

Overall, the checks did not identify any significant issue with the system.

## 8. PowerShell Automation — `SystemSecurityCheck.ps1`

For the final task, I created a script that collects basic system information and displays the results in one place.

The script performs the following checks:

- Retrieves the computer name, current user, and PowerShell version.
- Collects IPv4 addresses, excluding loopback and automatic private addresses (`169.254.x.x`).
- Checks the status of the `wuauserv` service.
- Uses `Get-PSDrive` to display disk size, used space, and free space in GB.
- Finds the five processes with the highest reported CPU usage.
- Checks the free space on the system drive and displays a warning if it is below 20 GB.

The script is available here: [`scripts/SystemSecurityCheck.ps1`](scripts/SystemSecurityCheck.ps1).

### Running the script

Open PowerShell, navigate to the folder containing the script, and run:

```powershell
.\SystemSecurityCheck.ps1
```

The script is designed to collect and display information. It does not change system settings or stop processes.

### Automatic disk-space check

The final part of the script checks whether the system drive has less than 20 GB of free space:

- If the C: drive cannot be found, the script reports that it was not found.
- If free space is below 20 GB, the script displays a warning.
- Otherwise, it reports that disk space is OK.

The 20 GB value is a threshold selected for this assignment, not a universal Windows security standard.

## Conclusion

This assignment gave me more practice using PowerShell to collect system information and check basic Windows and network functionality. I used commands such as `Get-NetIPConfiguration`, `Test-NetConnection`, `Resolve-DnsName`, `Get-Service`, and `Get-PSDrive` to review different parts of the system.

The final script combines several of these checks and uses variables, pipeline operations, and `if` conditions to make the results easier to review. It also helped me understand how PowerShell can be used to automate repetitive system checks instead of running every command separately.

## Evidence and Screenshots

Screenshots can be added to a `screenshots/` folder to support the results in this report.

Suggested evidence:

| Suggested file name | Evidence |
|---|---|
| `01-powershell-version.png` | PowerShell version information |
| `02-computer-and-user.png` | Computer name and current user, with identifiers redacted |
| `03-network-configuration.png` | `Get-NetIPConfiguration` output, with network details redacted |
| `04-connectivity-and-dns.png` | Internet connectivity and DNS test results |
| `05-windows-update-service.png` | `wuauserv` status and startup type |
| `06-disk-usage.png` | Used and free disk space |
| `07-system-security-check.png` | Output from `SystemSecurityCheck.ps1` |

Before uploading screenshots, remove computer and account names, local IP addresses, gateway and DNS details, device identifiers, and any other information that should not be public.

---

**Course:** Windows, Linux and Scripting Foundations  
**Assignment:** 03 — PowerShell System Check  
**Document type:** Practical Windows system check and PowerShell automation
