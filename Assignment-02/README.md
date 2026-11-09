# Assignment 02 — Windows System Check

## Overview

This report documents a basic Windows system assessment completed as part of the **Windows, Linux and Scripting Foundations** course.

The exercise involved inspecting a Windows laptop with built-in administrative and troubleshooting tools, reviewing system resources and selected Windows events, examining local accounts and groups, and identifying areas that may require further attention.

The assessment was intended to be observational. The objective was to collect relevant information, interpret the results, and recommend next steps rather than modify the system or resolve every issue.

> **Privacy note:** Personal identifiers have been removed. The computer name and local account name are redacted. No passwords, recovery keys, serial numbers, network addresses, or other secrets are included.

## 1. Test Environment

The assessment was performed on a personal Windows 11 laptop that is also used for everyday tasks.

| Item | Result |
|---|---|
| Operating system | Windows 11 Pro |
| OS build | 26300 |
| Processor platform | Qualcomm Snapdragon X Elite |
| Available memory recorded during the check | 17.2 GB |
| Disk capacity | 951 GB |
| Free disk space | 537 GB |
| Computer name | Redacted |
| Local account name | Redacted |

### Environment notes

The laptop was initially running Windows 11 Home. During preparation, the Windows edition was changed to Pro so that the administrative tools required for the exercise would be available. The exact tool used for this change is not documented here.

The inspection itself focused on reviewing the system and its configuration; the Windows edition change was a preparation step.

## 2. System Information

The basic system information was reviewed, including the Windows version, processor platform, available memory, and disk capacity.

The system had **537 GB of free space out of 951 GB** at the time of the check. The disk status was also captured in a screenshot as supporting evidence.

These details provide a basic overview of the device and help establish whether it has sufficient resources for normal use.

## 3. System Resource Monitoring

Task Manager was used to inspect current CPU, memory, and SSD activity, as well as active processes. The exact utilization percentages were retained in the supporting screenshots rather than transcribed into this report.

### Process reviewed: Firefox

| Item | Observation |
|---|---|
| Process | Firefox |
| Resource of interest | RAM |
| Reason for review | Browser activity and memory usage should be monitored, especially when investigating unusual system behaviour. |

A web browser can use a significant amount of memory, particularly when several tabs or extensions are open. From a security perspective, administrators should also make sure that the browser is kept up to date and that users are careful with suspicious links, websites, attachments, and downloads.

A vulnerable or outdated browser can increase the risk of exploitation. However, high memory usage on its own does **not** indicate that malware is running in memory or that the system has been compromised.

If unusual behaviour is observed, the administrator should review the browser process, installed extensions, open tabs, and relevant security events before drawing a conclusion.

## 4. Windows Event Log Review

One warning event was selected from Event Viewer for review.

| Field | Recorded information |
|---|---|
| Log | Application |
| Date and time | 27 October 2026, 17:44:45 |
| Level | Warning |
| Source | WMI |
| Component mentioned | `HgsClientWmi` |
| Security context mentioned | `LocalSystem` |

### Event summary

The warning concerned the `HgsClientWmi` system component, which was reported as being registered with a highly privileged `LocalSystem` context.

`LocalSystem` has extensive privileges on a Windows computer. For that reason, a component running under this account deserves attention, particularly if it does not correctly handle user requests or access to privileged operations.

### Assessment and recommended follow-up

This warning should not automatically be treated as evidence of a vulnerability or system compromise. The appropriate next step would be to verify whether the component is expected on the device, identify the software or Windows feature it belongs to, and review its configuration and related events.

I would not change the component's privileges or disable it based only on this single warning.

## 5. Local User Accounts and Groups

The local accounts and groups were reviewed using Windows administrative tools.

### Accounts observed

The system displayed built-in accounts such as `Administrator` and `Guest`, the primary personal user account, and an additional account with a device-related name. Personal account names have been removed from this report.

### Current account context

The account used during the assessment belonged to the following local groups:

- `Administrators`
- `Users`

This means the account had administrative privileges. An administrator account can make system-level changes, so it should be used carefully.

For everyday activity, the principle of least privilege recommends using a standard account whenever administrative rights are not required.

## 6. Windows Security Concepts

The account and group review provided a practical example of several Windows security concepts.

### User account

A user account represents an identity used to sign in to Windows and access system resources. The account's permissions and group memberships influence what the user can do.

### Group

Groups make it easier to manage permissions for multiple accounts. Instead of assigning the same permissions to every account individually, an administrator can assign permissions to a group and then add the relevant accounts to that group.

Examples observed during the review included `Administrators`, `Users`, `Guests`, and `Device Owners`.

### Permissions

Permissions define which actions a user or group can perform on a resource. For example, they can determine whether an account may read, modify, or delete a file, or create new files.

### Privilege management

User privileges should be controlled because an account with unnecessary administrative access can cause more damage if it is misused or compromised.

This is why the **principle of least privilege** is important: each account should have only the permissions required to perform its intended tasks.

The membership of the assessment account in both `Administrators` and `Users` was a concrete example of how group membership affects a user's access context.

## 7. BitLocker

BitLocker was available on the system, and drive protection was reported as active during the check.

BitLocker uses encryption to protect data stored on a drive. It is especially useful if a laptop or storage device is lost or stolen because it helps prevent an unauthorised person from accessing the data simply by removing the drive or accessing it outside the normal Windows environment.

### Recovery key consideration

The BitLocker recovery key was not readily available in the location checked during the assessment. This is an important point to address.

If Windows requests the recovery key and it cannot be found, access to the encrypted data may be lost. The key should be located and stored securely in an appropriate location separate from the laptop.

**The recovery key must never be uploaded to GitHub or included in screenshots or public documentation.**

BitLocker protects data at rest. It does not replace backups and does not, by itself, protect a running system from malware.

## 8. Backup and File History

The review identified backup-related options through **OneDrive** and **File History**.

### Backup

A backup is a separate copy of important data that can be used to recover information if the original files are deleted, damaged, lost, or made unavailable.

### File History

File History can automatically save copies of files from selected folders. It can also retain previous file versions, allowing a user to restore an earlier version when needed.

### Data protection versus data recovery

Data protection aims to reduce the chance of data being lost, deleted, or accessed or modified without authorisation. Data recovery provides a way to restore information if data loss still occurs.

The availability of OneDrive and File History options does not, by itself, prove that a complete backup is configured and working. An administrator should verify the backup settings, confirm that copies are being created, and test whether files can actually be restored.

## 9. Findings and Recommendations

The following findings were identified during the assessment. They represent items for further review, not proof that the system has been compromised.

### Finding 1 — BitLocker recovery key not readily available

**Observation:** BitLocker protection was active, but the recovery key was not readily available in the location checked.

**Why it matters:** If Windows requests the recovery key and it cannot be located, access to the encrypted data may be lost.

**Recommended next step:** Locate the recovery key and store it securely, separately from the laptop. Consider keeping an additional protected copy in another appropriate location. Do not store the key in public repositories or alongside the device.

### Finding 2 — High memory usage while idle

**Observation:** The system appeared to use a considerable amount of RAM even when there was little user activity. The exact utilization percentage was not transcribed into this report.

**Why it matters:** High memory usage can be caused by normal applications and background processes, but it may also indicate unnecessary processes or an issue that needs investigation. It is not, by itself, evidence of malware.

**Recommended next step:** Review processes with the highest memory usage, identify applications that start automatically, and verify whether the activity is expected. Run a security scan if there are additional suspicious indicators. Avoid terminating unfamiliar processes before checking their purpose.

### Finding 3 — Multiple background services require review

**Observation:** A number of services were running in the background, and the purpose of every service was not known during the initial check.

**Why it matters:** Unnecessary or poorly configured services can increase a system's attack surface. A vulnerable service may provide an opportunity for unauthorised access.

**Recommended next step:** Review unfamiliar services, identify the software they belong to, and determine whether they are required. Do not disable services indiscriminately: some are necessary for Windows or installed applications. Any change should be based on a clear understanding of the service.

### Additional observation — WMI warning

The `HgsClientWmi` warning described in the Event Viewer section should be investigated to confirm that the component and its privileged context are expected. The warning alone is not enough to conclude that a security issue exists.

## 10. Conclusion

Based on the checks performed, the laptop had some basic security measures in place, including active BitLocker protection and available backup options through OneDrive and File History. However, several areas require additional attention before the system can be considered adequately reviewed.

The first priority is to locate and securely store the BitLocker recovery key. I would also verify that the backup options are correctly configured and that files can be restored. In addition, I would review memory usage, unfamiliar background services, and the WMI warning recorded in Event Viewer.

I would also check that Windows Security is active and up to date. Unnecessary preinstalled applications, sometimes referred to as **bloatware**, should be reviewed as well. Removing applications that are not needed may free disk space and reduce unnecessary background activity. In some cases, it may also reduce the system's attack surface, but applications should not be removed before their purpose is understood.

With more time and access to additional tools, I would carry out a more detailed review of running processes and services, inspect relevant security events, verify backup configuration, and test the recovery process.

Overall, the assessment provided a useful baseline of the system's condition and identified practical steps that could improve its security and reliability.

## 11. Evidence and Screenshots

Screenshots can be added to the [`screenshots/`](screenshots/) folder to support the findings in this report.

Suggested evidence:

| Suggested file name | Evidence |
|---|---|
| `01-system-information.png` | Windows version and basic system information |
| `02-disk-status.png` | Disk capacity and available space |
| `03-task-manager.png` | CPU, memory, SSD activity, and relevant process |
| `04-event-viewer-warning.png` | Selected WMI warning event |
| `05-local-users-and-groups.png` | Local accounts and group membership |
| `06-bitlocker-status.png` | BitLocker availability and protection status |
| `07-backup-options.png` | OneDrive or File History options |

Before uploading screenshots, remove or obscure personal account names, computer names, email addresses, device identifiers, recovery keys, serial numbers, network information, and any other private data.

---

**Course:** Windows, Linux and Scripting Foundations  
**Assignment:** 02 — Windows System Check  
**Document type:** Practical system assessment
