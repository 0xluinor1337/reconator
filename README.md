# 🛰️ Reconator by 0xluinor1337

**Version:** 1.0  
**Author:** [0xluinor1337] (https://github.com/0xluinor1337)  
**Description:** A Bash-based reconnaissance toolkit for gathering information about a domain using popular open-source tools.

---

## 📌 Features

- 🛠️ Uses trusted CLI tools like:
  - `whois`
  - `dig`
  - `nslookup`
  - `dnsrecon`
  - `whatweb`
  - `host`
  - `wafw00f`
  - `curl`
- 📁 Optional logging: saves output of each tool to `logs/<domain>/`
- ✅ Connectivity check with `ping` before executing tools
- 🎨 Color-coded terminal output
- 🧠 Clean modular function-based code

---

## 🖥️ Preview

```bash
===============================================
         Reconator by 0xluinor1337 v1.0
===============================================

Enter the domain name:  example.com
Do you want to save logs(y/n): y
Logs will be saved in: logs/example.com

[+] Running whois....
[+] Running dig....
[+] Running nslookup....
...
```
```
📂 Log Output Structure
logs/
└── example.com/
    ├── whois.log
    ├── dig.log
    ├── nslookup.log
    ├── dnsrecon.log
    ├── whatweb.log
    ├── host_info.log
    ├── wafw00f.log
    └── curl.log
```
## Requirements
sudo apt install -y whois dnsutils dnsrecon curl whatweb wafw00f

## 🚀 How to run 
chmod +x reconator.sh
./reconator.sh
