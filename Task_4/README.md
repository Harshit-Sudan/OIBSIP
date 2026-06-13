# Task 4 - Network Security Assessment

## Objective
The objective of this task was to perform a network security assessment on a virtual lab environment using Nmap and Wireshark.The assessment involved scanning the target system for open ports and running services, capturing live network traffic, analyzing the findings, and documenting potential security risks along with recommendations.

---

## Tools Used
| Tool | Purpose |
|------|---------|
| Nmap | Network scanning and service version detection |
| Wireshark | Packet capture and network traffic analysis |
| Kali Linux | Assessment machine used for scanning and capture |
| Ubuntu Linux | Target machine for the assessment |

---

## Lab Environment
A virtualized lab environment was set up using VirtualBox with both virtual machines connected through a VirtualBox NAT Network.This kept the assessment completely isolated from the host system.Kali Linux was used as the assessment machine and Ubuntu Linux was used as the target.

---

## Steps Performed

### 1. Checked IP Addresses of Both Machines
Ran the following command on both Kali and Ubuntu to identify their IP addresses on the NAT Network.
```bash
ip a
```
- Kali Linux (Assessment Machine): `10.0.2.15`
- Ubuntu Linux (Target Machine): `10.0.2.4`

### 2. Verified Connectivity
Confirmed that Kali could reach the Ubuntu target over the NAT Network using a ping test.
```bash
ping 10.0.2.4
```
Successful replies confirmed both machines could communicate.

### 3. Stopped Services and Verified
SSH and Apache were stopped on the Ubuntu machine to establish a baseline state.
```bash
sudo systemctl stop ssh apache2
```
Verified both services were no longer listening using:
```bash
sudo ss -tuln | grep -E ':22|:80'
```
No output confirmed both ports were inactive.

### 4. Baseline Nmap Scan
With services stopped, a scan was performed to document the network state before any services were active.Results were saved to a file.
```bash
sudo nmap -sV -sS 10.0.2.4 -oN nmap_before.txt
```
No open ports were found at this stage.The Wireshark capture was stopped and the following filter was applied to confirm no services were listening:

| Filter | Purpose |
|--------|---------|
| `tcp.flags.reset == 1` | Confirmed RST packets — all connection attempts were being rejected |

### 5. Started Services and Verified
SSH and Apache HTTP were started on the Ubuntu machine to simulate a realistic server environment with active services.
```bash
sudo systemctl start ssh apache2
```
Verified both services were now listening using:
```bash
sudo ss -tuln | grep -E ':22|:80'
```
Output confirmed port 22 and port 80 were active.

### 6. Started Wireshark Packet Capture
Wireshark was launched on Kali, the eth0 interface was selected, and packet capture was started before running the active scan.

### 7. Active Nmap Scan
A service version scan was run against the target and results were saved to a file.
```bash
sudo nmap -sV -sS 10.0.2.4 -oN nmap_results.txt
```

### 8. Stopped Capture and Analyzed Traffic in Wireshark
The Wireshark capture was stopped after the scan completed. The following filters were applied to analyze the traffic from the active scan:

| Filter | Purpose |
|--------|---------|
| `tcp.port == 22` | Isolated SSH traffic on port 22 |
| `tcp.port == 80` | Isolated HTTP traffic on port 80 |

---

## Results

| Port | State | Service | Version |
|------|-------|---------|---------|
| 22/tcp | Open | SSH | OpenSSH 10.2p1 Ubuntu 2ubuntu3.2 (Ubuntu Linux; protocol 2.0) |
| 80/tcp | Open | HTTP | Apache httpd 2.4.66 ((Ubuntu)) |

Two services were found running on the target System i.e., SSH on port 22 and Apache HTTP on port 80.

---

## Analysis of Findings

### Finding 1 - SSH Service Exposure (Port 22)
SSH was running and reachable from the network. While SSH itself is a secure protocol, an exposed SSH service is a common target for brute-force attacks. If password-based authentication is enabled and weak credentials are in use, this becomes a straightforward attack vector. The Wireshark filter `tcp.port == 22` confirmed active SSH communication between the two machines.

### Finding 2 - HTTP Service Exposure (Port 80)
Apache was serving unencrypted HTTP traffic on port 80. Unlike SSH, HTTP does not encrypt its content — everything transmitted over this connection is visible in plain text to anyone on the same network running a packet capture. The Wireshark filter `tcp.port == 80` confirmed HTTP traffic was fully visible. The Apache default page was also being served, which reveals software and version information to potential attackers.

### Baseline vs Active Scan Comparison
The baseline scan with no services running showed only RST packets in Wireshark (`tcp.flags.reset == 1`) — the system was rejecting all connection attempts. After enabling SSH and Apache, the same scan returned two open ports. This comparison clearly demonstrates how each running service adds to the attack surface.

---

## What I Learned
This task tied together a lot of what I worked on throughout the internship. Running the baseline before enabling services was something I hadn't done before, and it made the difference between the two scans very easy to understand and explain. Using `ss` to verify services before and after was also useful — it gave immediate confirmation that the stop and start commands had actually worked before running the scan. Seeing HTTP traffic appear in plain text in Wireshark while SSH traffic showed up as encrypted was a practical demonstration of why switching to HTTPS matters.

---

## Recommendations
- Disable SSH if remote access is not required; if it is needed, use key-based authentication and restrict access by IP
- Replace HTTP with HTTPS to encrypt web traffic
- Remove or replace the Apache default page to avoid exposing version information
- Apply a default-deny firewall policy and only allow ports that are actively needed
- Regularly scan your own systems to catch services that should not be running

---

## Deliverables
- Security Assessment Report: [network_security_assessment.md](network_security_assessment.md)
- Baseline Nmap Scan: [nmap_before.txt](nmap_before.txt)
- Active Nmap Scan Results: [nmap_results.txt](nmap_results.txt)
- Wireshark Capture: [wireshark_capture.pcap](wireshark_capture.pcap)
- Demo Video: [View on LinkedIn](<your-linkedin-post-url>)
