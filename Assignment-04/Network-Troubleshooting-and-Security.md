# Network Troubleshooting and Security

**Name:** Milan Nikolic  
**Program and course:** Cybersecurity | Networks & Infrastructure Foundations

---

## 1. Problem Analysis and Security Risk Assessment

### Problem A — Two employees cannot access the internal server

**Possible causes:** The first possible cause is incorrect IP configuration, such as an incorrect IP address, subnet mask, or default gateway. This may happen due to incorrect DHCP settings or because the computers are connected to the wrong VLAN. Another possible cause is firewall or ACL rules blocking communication with the internal server. The problem could also be related to the physical connection, the switch, or the server itself.

**First check:** I would first run `ipconfig /all` on both computers and check the IP address, subnet mask, default gateway, and DNS server. I would compare the information with that of an employee's computer that is not experiencing the problem. Then I would check whether the computers can ping the default gateway, followed by the internal server using its IP address. These checks would help me determine whether the problem starts within the local network or only when communicating with the server.

**Expected results:** The computers may have incorrect network parameters or may be connected to a different network segment. If they can ping the default gateway but not the server, the problem may be related to routing, firewall rules, or server availability. If they cannot even ping the default gateway, I would focus more on local network connectivity, the VLAN, the switch port, or the cable.

**Next step:** If I find incorrect IP configuration, I would check the DHCP scope and the settings assigned to the computers. If the IP configuration is correct, I would check the firewall/ACL rules and the server status, as well as access permissions. If the results point to a local connectivity issue, I would check the cable, switch port, and VLAN configuration.

### Problem B — An employee cannot open a business application by its name

**Possible causes:** One possible cause is a DNS issue, such as an incorrect or unavailable DNS record, an incorrectly configured DNS server, or a problem with the DNS cache on the computer. Another possible cause is that the business application or the server hosting it is not working properly. It is also possible that a firewall is blocking the required communication or that the user does not have the appropriate permissions to access the application.

**First check:** I would first check the computer's DNS settings using `ipconfig /all`, and then run `nslookup application-name` to see which IP address DNS returns for the application name. After that, I would try to open the application using its name and, if the application supports this type of access, directly through the server's IP address.

**Expected results:** If `nslookup` does not return the expected IP address or cannot find the application name, there is a reasonable suspicion of a DNS resolver issue. If the application opens through its IP address but not through its name, DNS is one of the main possible causes. If the application does not open through the IP address either, the server, the application itself, firewall rules, and user permissions need to be checked.

**Next step:** If a DNS issue is confirmed, I would check the DNS record, DNS server, and computer configuration. If DNS resolves the name correctly but the application is still unavailable, I would check whether the service is running on the server, whether there are any firewall restrictions, and whether the user has permission to access it. Ping can be used as an additional connectivity check, but it does not confirm that the business application is working, because an application may be unavailable even when the server is reachable over the network.

### Problem C — An unusual DNS address on one computer

**Possible causes:** The first possible cause is a configuration error or a manual change made by a user or administrator that was not documented. Another possibility is that the DHCP server is assigning an incorrect DNS address due to a misconfiguration. A third possibility is an unauthorized change on the computer or the presence of an unauthorized DHCP server (rogue DHCP) assigning incorrect network addresses to computers.

**First check:** I would first preserve the current network settings and relevant logs, and then check `ipconfig /all` to determine which DNS address the computer is using and whether it was configured manually or obtained through DHCP. I would compare it with the configuration of other computers and the approved network settings. Then I would check the change records, DHCP lease information, and available system and security logs. I would also ask the user whether they had changed anything, but I would not consider their answer sufficient evidence.

**Expected results:** I may find an administrative change that was not properly documented, an incorrect DHCP setting, or an unknown DNS server. I would also check who manages that DNS address and whether it is part of the approved infrastructure. In the logs, I would look for unusual logins and activities that occurred around the same time as the network settings change.

**Next step:** If it turns out to be an error or an approved change, I would correct the configuration through the regular administrative procedure and document the change. If there is no approval and the logs or DHCP records indicate unauthorized activity, I would notify the responsible administrator and continue the investigation. I would not immediately conclude that an attack had occurred based only on a different DNS address.

**Security risk:** A DNS server translates domain names and internal resources into IP addresses. If an attacker sets up an unauthorized DNS server or changes DNS settings, a user may be redirected to fake or malicious websites instead of legitimate ones. This can lead to phishing attacks, credential theft, or traffic redirection. That is why it is important to verify the origin of the DNS address before deciding whether the change is harmless or malicious.

---

## 2. Diagnostic and Evidence Collection Plan

I would carry out the checks in order, but I would adjust the order based on the results. First, I would preserve the current state and evidence, and only then make changes to the configuration. This reduces the possibility of losing information that may be important for identifying the cause of the problem.

### 1. Preserving the Initial State and Evidence

**What I would check:** Before making any changes, I would record which computer has the problem, who uses it, when the problem was first noticed, and what its current network settings are. I would pay particular attention to preserving the configuration of the computer involved in Problem C.

**Tool or record:** `ipconfig /all`, a screenshot or saved command output, system and security logs, DHCP records, and available firewall/network logs.

**Expected result:** I would obtain the initial IP address, subnet mask, gateway, and DNS settings, along with timestamps and event records that may help with the investigation.

**How the result affects the next step:** I would move on to active checks only after saving this information. If there is suspicion of an unauthorized change, I would not run `ipconfig /release` or change DNS settings first, because doing so could cause me to lose some useful information.

### 2. Checking IP Configuration

**What I would check:** I would check the IP address, subnet mask, default gateway, and DNS server on the computers experiencing the problem. I would compare this information with a computer that is working correctly and with the approved configuration.

**Tool or record:** `ipconfig /all` on a Windows computer.

**Expected result:** I would expect to see whether the network parameters are correct, whether they were obtained through DHCP, and whether they differ from the configuration of other computers.

**How the result affects the next step:** If I find an incorrect address, subnet mask, gateway, or DNS setting, I would check the DHCP configuration or manual settings. If the parameters are correct, I would continue by checking connectivity.

### 3. Checking Local and Server Connectivity

**What I would check:** I would check whether the computer can communicate with the default gateway, and then with the internal server using its IP address.

**Tool or record:** `ping` to the IP address of the default gateway and the internal server; if necessary, `tracert` for an additional check of the traffic path.

**Expected result:** If the gateway responds, local connectivity is probably established. If the gateway responds but the server does not, the problem may be further along the network, in the firewall rules, or on the server. If the gateway does not respond, I would check the local segment and physical connection.

**How the result affects the next step:** Depending on the results, I would check the VLAN, routing, firewall/ACL rules, or network equipment. An unsuccessful ping is not definitive proof that a device is unavailable because ICMP may be blocked.

### 4. Checking DNS Resolution

**What I would check:** I would check whether the name of the business application and the internal server resolves to the expected IP address.

**Tool or record:** `nslookup application-name` and, if necessary, `nslookup server-name`; as an additional check, I would compare the result with the approved DNS settings.

**Expected result:** I would expect to receive a response from a DNS server and an IP address associated with the requested name. An incorrect or unexpected response may indicate a problem with the DNS record or DNS server.

**How the result affects the next step:** If DNS does not return the expected address, I would check the DNS record, the computer's DNS configuration, and the DHCP options. If the response is correct, I would investigate the availability of the application and server, as well as access permissions.

### 5. Checking DHCP and DNS Services

**What I would check:** I would check whether DHCP is assigning the expected network parameters and whether there is an unknown DHCP server. I would also check whether the DNS server and records match the approved configuration.

**Tool or record:** DHCP lease records, DHCP/DNS settings, and available server logs; comparison of the DHCP scope and assigned DNS addresses with the approved configuration.

**Expected result:** I would expect to determine which DHCP server assigned the address, which DNS parameters it provided, and whether there are any unusual assignments or unknown servers.

**How the result affects the next step:** If DHCP is assigning incorrect parameters, the scope or options need to be corrected and the cause investigated. If an unknown DHCP server or an unapproved change is found, I would document the finding and report it to the administrator before making further changes.

### 6. Checking Firewall Rules, the Server, and the Application

**What I would check:** I would check whether firewall or ACL rules are blocking communication between the affected computers and the internal server. Then I would check whether the server is running, whether the business application is running, and whether users have the required permissions.

**Tool or record:** Review of firewall rules and available logs, server and application status, and an access check from another computer with a working configuration.

**Expected result:** I would expect to determine whether traffic is being blocked by a rule, whether the service is unavailable, or whether the user does not have the appropriate permissions.

**How the result affects the next step:** If I find a blocking rule, I would check whether it is intentional and approved before changing it. If the application or server is not working, I would forward the problem to the server administrator along with the collected results.

### 7. Checking the Switch, Ports, and Cables

**What I would check:** If the previous checks indicate a local connectivity problem, I would check which switch port the computer is connected to, whether the port is assigned to the correct VLAN, and whether there are any visible problems with the cable or port.

**Tool or record:** Review of the switch port status, VLAN configuration check, replacing the cable with a known working cable, and testing another suitable port, with the administrator's approval.

**Expected result:** I would expect to determine whether the problem follows the computer, the cable, or the switch port, and whether other devices on the same segment are affected.

**How the result affects the next step:** If changing the cable or port resolves the problem, the faulty equipment should be replaced or the port correctly configured. If the problem remains, I would continue the investigation based on the results collected earlier.

### Recording Findings and Restricting Access

During the checks, I would record the date and time, the computer and user affected, the commands that were run, the results obtained, and every change that was made. I would preserve relevant logs and the initial configuration before changing any settings. If serious indicators of unauthorized activity are confirmed, such as an unknown DHCP/DNS server together with suspicious logins or changes, I would notify the responsible administrator. In accordance with the procedure, the administrator would restrict the affected computer's network access, for example by isolating the device, to prevent the problem from spreading further. I would not isolate a device without a reason based only on one unusual DNS address.

---

## 3. Risk Mitigation Measures and Prevention of Similar Problems

### 3.1. Network Segmentation

The guest Wi-Fi network should be separated from the business network, for example by using a dedicated VLAN and a separate IP segment. Guests should be allowed to access the internet, but not to freely access internal computers, servers, and the business application. If necessary, parts of the business network can also be separated, such as IT, Finance, and Human Resources, in order to limit unnecessary movement between segments.

### 3.2. Firewall Rules and Access Control

Firewall rules should allow only the communication required between network segments and business services. Only users and devices that need access to the internal server for their work should be allowed to access it. This reduces the risk of unauthorized access and limits the possibility of an attacker easily reaching other parts of the network after gaining access to one device.

### 3.3. Protecting Network Settings

Only authorized personnel should have access to the configuration of routers, switches, firewalls, and DHCP/DNS services. Administrative accounts should be protected with strong passwords and used only when necessary. Every configuration change should be approved and documented so that it can later be determined who made the change, when it was made, and why. This reduces the risk of accidental and unauthorized changes.

### 3.4. Checking, Monitoring, and Storing Logs

Network settings should be checked regularly, and available system, DHCP, DNS, and firewall logs should be reviewed. Important events should be stored in a central location and, if possible, forwarded to a SIEM system to make it easier to monitor and correlate events. This can help identify unusual logins, changes to DNS settings, or the appearance of an unknown DHCP server earlier.

### 3.5. Regular Updates and Maintenance

Network equipment, servers, and operating systems should be updated regularly, including router and switch firmware where applicable. Updates reduce the risk of known vulnerabilities being exploited. In addition, the physical condition of the equipment and the integrity of cables, ports, and power supplies should be checked periodically so that technical problems can be identified in time.

### Problem D — Protecting the Guest Wi-Fi Network

A password for the guest Wi-Fi network alone is not enough to protect business resources. The password controls who can connect to the wireless network, but it does not automatically determine which internal devices and services connected guests can access. If the guest and business networks are not properly separated, a device connected to the guest network may be able to attempt communication with internal computers and servers. Therefore, the guest network should be placed in a separate VLAN or network segment, and firewall rules should block access to the business network while allowing only the necessary internet access. In addition to segmentation, appropriate wireless security should be used, such as WPA2 or WPA3 with a strong password. This combines protection of wireless access itself with restrictions on communication after a device connects.

---

## 4. Report for the Administrator

**Subject:** Reported Issues with Access to Internal Resources and Unusual DNS Configuration

### Known Information

- Two employees cannot access the internal server, although they can open some websites.
- One employee cannot open the business application using its name; it is not known whether access through the IP address works.
- A DNS address was found on one computer that differs from the addresses on other computers, and no approval for the change was found in the available records.
- The company uses a separate guest Wi-Fi network, but its isolation from the business network needs to be checked.

### Possible Causes and Risks to Investigate

The reported issues may be related to incorrect IP configuration, DHCP or DNS settings, VLAN segmentation, firewall/ACL rules, physical connectivity, or the unavailability of the server and application. The different DNS address may be the result of an error or an administrative change that was not documented, but it may also indicate an unauthorized change or an unknown DHCP server. None of these causes, including a possible attack, has been confirmed yet.

### Recommended Steps

- Before making changes, preserve the current IP/DNS configuration, relevant DHCP, DNS, system, and firewall logs, and record the time and the devices affected.
- Check the IP parameters and the availability of the default gateway and internal server, and then check DNS resolution of the business application's name.
- Review DHCP lease information and configuration, check the origin of the unusual DNS address, and determine whether an unknown DHCP/DNS server exists.
- Check firewall rules, server and application availability, user permissions, and, if necessary, the physical network equipment.
- If additional evidence of unauthorized activity appears, notify the responsible administrator and consider temporarily isolating the affected computer.

### Priority Recommendations

- First, verify and ensure complete isolation of the guest Wi-Fi network from the business network, with appropriate firewall rules.
- Restrict administrative access to network equipment and DHCP/DNS settings, with mandatory approval and documentation of changes.
- Introduce regular reviews and retention of relevant network logs so that unusual changes and events can be detected more easily.

**Conclusion:** The priority is to investigate the problems without rushing to change the configuration. Evidence should be preserved first and the exact cause identified before targeted changes are made. Special attention should be given to the unusual DNS address and the isolation of the guest network, but no attack should be considered confirmed until there is appropriate evidence.
