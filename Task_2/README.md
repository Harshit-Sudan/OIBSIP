# Task 2 - Basic Firewall Configuration with UFW

## Objective
The objective of this task was to configure a basic host-based firewall using UFW (Uncomplicated Firewall) 
on Ubuntu Linux. The firewall was set up to allow SSH access while blocking HTTP traffic, and then verified 
to confirm the rules were applied correctly.

---

## Tools Used
| Tool | Purpose |
|------|---------|
| UFW (Uncomplicated Firewall) | Firewall management utility built into Ubuntu Linux |
| Ubuntu Linux | Operating system used for this task |
| VirtualBox | Used to run and manage the virtual machine environment |

---

## Lab Environment
An Ubuntu Linux virtual machine was set up using VirtualBox with the network adapter in NAT mode. 
This provided basic internet connectivity while keeping the testing environment isolated from the host network.

---

## Steps Performed

### 1. Verified UFW Installation
Before making any changes, I confirmed that UFW was installed and available on the system.
```bash
ufw --version
```

### 2. Checked Current Firewall Status
I checked the existing firewall state to understand the default configuration before applying any rules.
```bash
sudo ufw status
```

### 3. Set Default Firewall Policies
The firewall was configured to block all incoming traffic by default, while allowing outgoing connections 
so the system could still communicate externally.
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### 4. Allowed SSH Access
SSH was explicitly permitted so the machine could still be accessed remotely after the firewall was enabled.
```bash
sudo ufw allow ssh
```

### 5. Blocked HTTP Traffic
HTTP traffic on port 80 was denied to prevent any unsolicited incoming web requests.
```bash
sudo ufw deny 80/tcp
```

### 6. Enabled the Firewall
With all rules in place, the firewall was activated to enforce the configuration.
```bash
sudo ufw enable
```

### 7. Verified the Configuration
Ran a verbose status check to confirm all rules were active and correctly applied.
```bash
sudo ufw status verbose
```

---

## Results
The firewall was successfully configured and reported as **active**. The final ruleset was:

| Port | Protocol | Action | Purpose |
|------|----------|--------|---------|
| 22 | TCP | ALLOW | Permit SSH remote administration |
| 80 | TCP | DENY | Block HTTP web traffic |

---

## Security Analysis

### SSH Access (Port 22)
SSH was kept open to allow secure remote administration. Since SSH encrypts communication between 
the client and server, it is much safer than older remote access protocols such as Telnet.

### HTTP Traffic (Port 80)
HTTP was blocked because the system was not running a web server. Blocking unnecessary services 
helps reduce the attack surface and improve overall security.

### Default Deny Policy
Setting the default incoming policy to deny means any port not explicitly allowed is automatically 
blocked. This is generally considered the right starting point for any firewall configuration, since 
it forces you to consciously decide what to allow rather than what to block.

---

## What I Learned
Working through this task gave me a practical understanding of how host-based firewalls work at the 
command line level. Setting up UFW from scratch made it clear how quickly an improperly configured 
firewall can either lock you out of your own machine or leave unnecessary ports exposed. The order of 
operations matters too — allowing SSH before enabling the firewall is an easy step to miss that could 
cause real problems in a remote access scenario.

---

## Security Observation
This task demonstrates the principle of least privilege in practice — only the services that are 
actually needed are permitted, and everything else is blocked. It is a simple configuration, but it 
reflects the kind of thinking that applies to real-world firewall management as well.

---

## Deliverables
- Firewall Configuration Script: [ufw_configuration.sh](./ufw_configuration.sh)
- Supporting Screenshot: `screenshots/ufw_status.png`
- Demo Video: [View on LinkedIn]()
