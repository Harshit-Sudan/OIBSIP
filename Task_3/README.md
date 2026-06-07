# Task 3 - Exploit a Vulnerability in a Web Application (SQLi)

## Objective
The objective of this task was to identify and exploit an SQL Injection vulnerability 
in a controlled web application environment. DVWA (Damn Vulnerable Web Application) 
was deployed locally using Docker and tested at different security levels to demonstrate 
both the vulnerability and how it can be properly mitigated.

---

## Tools Used
| Tool | Purpose |
|------|---------|
| Docker Desktop | Used to deploy and run the DVWA container locally |
| DVWA (Damn Vulnerable Web Application) | Target web application for vulnerability assessment |
| Windows 11 | Host operating system |
| Web Browser | Used to interact with the DVWA web interface |
| CrackStation | Used to crack extracted MD5 password hashes |

---

## Lab Environment
DVWA was deployed as a Docker container on a Windows 11 host machine and accessed 
through a web browser at localhost:8080. The application was configured at Low security 
level for the initial assessment to demonstrate the vulnerability, and then switched to 
Impossible security level to validate the mitigation.

---

## Steps Performed

### 1. Deployed DVWA Using Docker
The DVWA container was started using Docker Desktop and verified to be running 
successfully on localhost:8080.

### 2. Logged Into DVWA
Accessed the application through the browser and logged in using the default credentials 
(admin/password). It is worth noting that default credentials are a common security 
misconfiguration in real-world applications and should always be changed after deployment.

### 3. Initialized the Database
After logging in, the database was initialized using the Create/Reset DataBase option to 
ensure the application was ready for testing.

### 4. Confirmed Security Level
Navigated to DVWA Security and confirmed the security level was set to Low before 
starting the assessment.

### 5. Identified the Vulnerability
Opened the SQL Injection module and entered a single quote (') in the User ID field. 
The application returned a SQL syntax error, confirming that user input was being 
passed directly into the database query without any sanitization.

### 6. Exploited the Vulnerability
The following UNION-based SQL injection payload was used to extract usernames and 
password hashes from the database:

```sql
1' UNION SELECT NULL, CONCAT(user, ': ', password) FROM users #
```

The application returned a list of usernames along with their MD5 hashed passwords, 
confirming successful data exfiltration.

### 7. Cracked the Password Hashes
The extracted MD5 hashes were submitted to CrackStation. The plain-text passwords 
were successfully recovered, showing the full impact of the vulnerability — from 
data exfiltration all the way to account takeover.

### 8. Validated the Mitigation
The security level was switched to Impossible and the same payload was run again. 
No output was returned, confirming that parameterized queries successfully block 
the injection attempt.

---

## Results

| Security Level | Payload Result |
|----------------|----------------|
| Low | Successfully extracted usernames and password hashes |
| Impossible | No output returned — injection attempt blocked |

---

## Security Analysis

### Why the Low Security Level Was Vulnerable
At Low security, user input is passed directly into the SQL query without any 
validation or sanitization. This allows an attacker to manipulate the query and 
extract data they should never have access to.

### Why the Impossible Level Blocked It
The Impossible security level uses parameterized queries, meaning user input is 
treated strictly as data and never as part of the SQL query itself. This completely 
eliminates the injection vector regardless of what the attacker enters.

### Real World Impact
SQL Injection is consistently ranked among the most critical web application 
vulnerabilities. A successful attack can lead to unauthorized data access, 
authentication bypass, and in serious cases full database compromise. Cracking 
the extracted hashes further demonstrates how a single vulnerability can escalate 
into a complete account takeover.

---

## What I Learned
This task gave me a clear practical understanding of how SQL Injection works beyond 
just theory. Going through the full process i.e., triggering the error, running the 
payload, cracking the hashes, and then validating the fix made it easy to see 
why input sanitization matters so much. The most interesting part was how a simple 
change in how the query handles input completely shuts down the attack.

---

## Remediation Recommendations
- Use prepared statements and parameterized queries for all database interactions
- Validate and sanitize all user input before processing
- Apply least privilege to database accounts
- Disable detailed error messages in production environments
- Perform regular security testing on web applications

---

## Deliverables
- Supporting Screenshots: `screenshots/`
- Demo Video: [View on LinkedIn](#)
