#!/bin/bash

# -- Banner  --
RED="\e[31m"
CYAN="\e[36m"
YELLOW="\e[33m"
BLUE="\e[34m"
GREEN="\e[1;32m"
RESET="\e[0m" 
MAGENTA="\e[35m"

echo -e "\n${BLUE}=========================================================${RESET}"
echo -e "${CYAN}            Reconator by 0xluinor1337 v1.0${RESET}"     
echo -e "${BLUE}=========================================================${RESET}"

# ====== user input ======
read -p "Enter the domain name:  " domain_name
read -p "Do you want to save logs(y/n): " save_logs; save_logs=${save_logs,,}; echo ""

# ====== setup log dir or null output ======
if [[ "${save_logs}" == "y" ]]; then
  logs_dir="logs/${domain_name}"
  mkdir -p "${logs_dir}"
  echo -e "Logs will be saved in: ${MAGENTA}${logs_dir} ${RESET}"
else
  logs_dir=""
  echo -e "${YELLOW}Logging disabled. Output will not be saved. ${RESET}"
fi

# ===== Log Output Handler =====
log_output() {
  local filename="$1"
  if [[ "$save_logs" == "y" && -n "$logs_dir" ]]; then
    tee -a "$logs_dir/$filename"
  else
    cat
  fi
}

# ====== recon function ======

whois_lookup() 
 { 
    echo -e "\n${GREEN}[+] Running whois....${RESET}" 
    whois ${domain_name} | log_output "whois.log"
 }

dig_info() 
 { 
    echo -e "\n${GREEN}[+] Running dig....${RESET}"
    dig ${domain_name} ANY | log_output "dig.log" 
 }

nslookup_info() 
  {
    echo -e "${GREEN}[+] Running nslookup....${RESET}"
    nslookup ${domain_name} | log_output "nslookup.log"
  }

dnsrecon_scan() 
 {
    echo -e "${GREEN}[+] Running dnsrecon....${RESET}"
    dnsrecon -d ${domain_name} -v | log_output "dnsrecon.log"
 }

whatweb_fingerprinting() 
 {
    echo -e "\n${GREEN}[+] Running whatweb....${RESET}"
    whatweb -v ${domain_name} | log_output "whatweb.log"
 }

host_info() 
 {
    echo -e "${GREEN}[+] Running host....${RESET}"
    host -a ${domain_name} | log_output "host_info.log"
 }

wafw00f_check() 
 {
    echo -e "\n${GREEN}[+] Running wafw00f....${RESET}"
    wafw00f http://${domain_name}/ -a -v | log_output "wafw00f.log"
 }

curl_response() 
 {
    echo -e "\n${GREEN}[+] Running curl....${RESET}"
    curl ${domain_name} -v | log_output "curl.log"
 }

# ======  main execution func ======
main_exec()
 {
    whois_lookup
    dig_info
    nslookup_info
    dnsrecon_scan
    whatweb_fingerprinting
    host_info
    wafw00f_check
    curl_response
 }

# ====== ping and check connectivity ====== 
echo -e "\nTesting connectivity for "${GREEN}${domain_name}${RESET}" in background...."; echo ""

ping_test() 
 { 
    ping -c 2 "${domain_name}" > /dev/null  2>&1
    return $?
 }; ping_test

if ping_test; then
  echo -e "--> ${GREEN}${domain_name}${RESET} is reachable.";
  main_exec
else
  echo -e "${RED}${domain_name} is unreachable.${RESET}"; 
  exit 1
fi

echo -e "\nPrinting Exit Code: $?"; echo "0 for success  --  1-255 for error"

