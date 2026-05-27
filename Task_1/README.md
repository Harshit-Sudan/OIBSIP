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
The scan results differed based on the target machine's configuration:

* **Metasploitable 2 (10.0.2.5):** The scan successfully identified multiple open ports and services, including FTP, SSH, Telnet, and HTTP. 
* **Ubuntu VM (10.0.2.4):** Although the host was confirmed to be "up," but all 1000 scanned TCP ports were reported as "closed" (reset). This indicates that the machine has no services actively listening for connections, making it appear invisible to this specific type of service discovery.

---
## Deliverables
Scan Results: nmap_scan_results.txt

Screenshots: Included in the repository.

Demo Video: HarshitSudan_Task1.mp4
