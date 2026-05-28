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

Metasploitable 2 (10.0.2.5): The scan found many active services, such as FTP, SSH, Telnet, and HTTP. Detailed results are in nmap_scan_results.txt.

Ubuntu VM (10.0.2.4): Even though the host was "up" and reachable, all 1000 scanned ports were "closed." This means no services were running, and the machine is properly hardened. See the scan output below:
<img width="784" height="321" alt="image" src="https://github.com/user-attachments/assets/83a5b85f-e92e-4bf1-ac54-13615020b002" />

---
## Deliverables
Scan Results: nmap_scan_results.txt

Screenshots: Included in the repository.

Demo Video: HarshitSudan_Task1.mp4
