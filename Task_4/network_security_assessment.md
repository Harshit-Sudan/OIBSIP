# Network Security Assessment Report

**Prepared By:** Harshit Sudan  
**Internship:** Security Analyst Intern – Oasis Infobyte  
**Task:** Task 4 – Network Security Assessment  
**Environment:** VirtualBox NAT Network (Isolated Virtual Lab)

---

## Executive Summary

A network security assessment was performed against an Ubuntu Linux target machine within an isolated virtual lab environment. Nmap was used to identify active services and Wireshark was used to capture and analyze the corresponding network traffic.

Two exposed services were identified during the assessment:

- SSH service on port 22
- Apache HTTP service on port 80

No critical vulnerabilities were identified. However, both services increase the attack surface of the target system and require appropriate security controls.

---

## Scope of Assessment

| Component | Description |
|------------|------------|
| Assessment Machine | Kali Linux |
| Target Machine | Ubuntu Linux |
| Environment | VirtualBox NAT Network |
| Tools Used | Nmap, Wireshark |
| Assessment Type | Internal Network Security Assessment |

---

## Methodology

The assessment was conducted in two phases.

### Baseline Assessment

All services on the target machine were stopped before scanning. A baseline scan was performed to observe the system with no active services.

No open ports were detected, and packet analysis showed TCP reset responses indicating that connection attempts were being rejected.

### Active Assessment

SSH and Apache HTTP services were enabled on the target system. A second scan was performed while Wireshark captured network traffic.

The scan identified two active services exposed to the network.

---

## Finding 1 – SSH Service Exposure

### Description

Port 22/TCP was found open and running OpenSSH.

### Evidence

| Port | State | Service | Version |
|--------|-------|---------|---------|
| 22/TCP | Open | SSH | OpenSSH 10.2p1 Ubuntu 2ubuntu3.2 |

Wireshark traffic analysis using the filter:

```
tcp.port == 22
```

confirmed communication associated with the SSH service.

### Risk

Although SSH is a secure protocol, exposed SSH services are frequently targeted by brute-force attacks and unauthorized login attempts. Weak credentials or password-based authentication can increase the likelihood of compromise.

### Recommendation

- Disable SSH if remote access is not required.
- Use key-based authentication.
- Restrict access to trusted hosts.
- Keep OpenSSH updated.

---

## Finding 2 – HTTP Service Exposure

### Description

Port 80/TCP was found open and running Apache HTTP Server.

### Evidence

| Port | State | Service | Version |
|--------|-------|---------|---------|
| 80/TCP | Open | HTTP | Apache httpd 2.4.66 |

Wireshark analysis using the filter:

```
tcp.port == 80
```

confirmed communication associated with the HTTP service.

### Risk

HTTP traffic is transmitted without encryption. Additionally, exposing unnecessary web services increases the attack surface of the system. The default Apache page was accessible, which may contribute to information disclosure.

### Recommendation

- Replace HTTP with HTTPS.
- Remove the default Apache page.
- Disable the web server if not required.
- Restrict access using firewall rules.
- Keep Apache updated.

---

## Baseline vs Active Scan Comparison

| Phase | Open Ports |
|---------|-----------|
| Baseline (services stopped) | None |
| Active (services running) | 22, 80 |

The comparison between the baseline and active scans demonstrated how enabling services increases the attack surface of a system.

---

## Risk Summary

| Finding | Severity |
|----------|---------|
| SSH Service Exposure | Low |
| HTTP Service Exposure | Medium |

**Overall Risk Level:** Low to Medium

No critical vulnerabilities were identified during the assessment. The identified risks primarily relate to service exposure and unnecessary attack surface.

---

## Conclusion

This assessment demonstrated the use of Nmap and Wireshark to identify active services and analyze network traffic within a controlled environment. Comparing the baseline and active states highlighted the impact that running services have on system exposure.

Regular security assessments, service hardening, and the use of secure communication protocols are important measures for reducing risk and maintaining a secure network environment.

---

## Disclaimer

This assessment was performed entirely within a private and isolated virtual lab environment. Both systems are owned and operated by me for educational purposes as part of the Oasis Infobyte Security Analyst Internship. No unauthorized systems were scanned or tested.
