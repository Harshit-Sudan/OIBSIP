# Task 1 - Basic Network Scanning with Nmap

## Objective
The objective of this task was to perform basic network reconnaissance using Nmap in a virtual lab environment to identify active hosts, open ports, and running services.

---

## Tools Used
* **Nmap**: Network exploration and security auditing tool.
* **Kali Linux**: The primary attacker machine.
* **VirtualBox**: Used for managing the virtualized lab environment.
* **Metasploitable 2 / Ubuntu**: Target machines for testing.

---

## Lab Environment
A virtualized lab environment was created using VirtualBox NAT Network configuration. All virtual machines were connected to the same isolated virtual network for safe testing and analysis.

---

## Steps Performed

### 1. Verified Network Configuration
Used the following command to check the IP address of the machines:

```bash
ip a
```

### 2. Performed Host Discovery
Executed an Nmap ping scan to identify active hosts in the subnet:

```bash
sudo nmap -sn 10.0.2.0/24
```

### 3. Performed Service Version Detection
Executed a service version scan on the target machines (Metasploitable 2 and Ubuntu):

```bash
# Scan Metasploitable 2
sudo nmap -sV 10.0.2.5
# Scan Ubuntu VM
sudo nmap -sV 10.0.2.4
```
## Results
The network scan showed a clear difference between the two machines. Metasploitable 2 is open for testing, while the Ubuntu machine is locked down and secure.

* **Metasploitable 2 (10.0.2.5):** The scan found many active services, such as FTP, SSH, Telnet, and HTTP. Detailed results are available in [nmap_scan_results.txt](nmap_scan_results.txt).
* **Ubuntu VM (10.0.2.4):** Even though the host was "up" and reachable, all 1000 scanned ports were "closed." This means no services were running, and the machine is properly hardened. 

---
## Analysis of Open Ports

The service version scan on Metasploitable 2 identified several open ports and services.

| Port | Service | Significance |
| :--- | :--- | :--- |
| **21** | FTP | Used for file transfers. Credentials may be transmitted in plaintext, making them vulnerable to interception. |
| **22** | SSH | Secure remote administration service. Common target for brute-force attacks if weak passwords are used. |
| **23** | Telnet | Legacy remote access protocol that does not encrypt traffic, making it highly insecure. |
| **25** | SMTP | Email transfer service. Misconfigured servers can be abused for spam or mail relay attacks. |
| **53** | DNS | Provides domain name resolution services and is critical for network communication. |
| **80** | HTTP | Web server service that may be vulnerable to common web application attacks such as XSS and SQL Injection. |
| **111** | rpcbind | Used by RPC services to map ports. Often targeted during network reconnaissance. |
| **445** | SMB | File and printer sharing service. Historically associated with several major network exploits. |
| **1099** | Java RMI | Java Remote Method Invocation service. Can be vulnerable to remote code execution if improperly configured. |
| **1524** | bindshell | Known backdoor service intentionally included in Metasploitable for security testing. |
| **2049** | NFS | Network File System service used for file sharing. Misconfigurations may expose sensitive data. |
| **2121** | ProFTPD | Alternative FTP service that may contain vulnerabilities depending on version and configuration. |
| **3306** | MySQL | Database service. Unauthorized access may lead to disclosure or modification of stored data. |
| **5432** | PostgreSQL | Database management service that should be properly secured to prevent unauthorized access. |
| **6000** | X11 | Remote graphical display service that may expose desktop sessions if unsecured. |
| **6667** | IRC | Internet Relay Chat service. Historically used by botnets for command-and-control communication. |
| **8009** | AJP | Apache JServ Protocol connector used by Tomcat. Misconfigurations can expose web applications. |
| **8180** | Tomcat HTTP | Java web application server used to host web applications and management interfaces. |

## Security Observation
The Metasploitable 2 machine intentionally exposes numerous network services for vulnerability assessment practice. The large number of open ports significantly increases the attack surface and demonstrates how attackers can gather information during reconnaissance.

In contrast, the Ubuntu virtual machine responded to network probes but had no active services listening on the scanned ports. Nmap reported all 1000 TCP ports as closed, indicating a more secure and hardened configuration with a much smaller attack surface.

## Deliverables
Scan Results: [nmap_scan_results.txt](nmap_scan_results.txt)

Screenshots: Included in the repository.

Demo Video: HarshitSudan_Task1.mp4
