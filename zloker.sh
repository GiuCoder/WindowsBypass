#!/bin/bash

# Set colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[1;33m'
nc='\033[0m'

# Set emojis
warn_emoji='🚨'
check_emoji='✅'
loading_emoji='⏳'
clear
# Print cool text banner
echo -e "${green}
███████╗██╗░░░░░░█████╗░██╗░░██╗███████╗██████╗░
╚════██║██║░░░░░██╔══██╗██║░██╔╝██╔════╝██╔══██╗
░░███╔═╝██║░░░░░██║░░██║█████═╝░█████╗░░██████╔╝
██╔══╝░░██║░░░░░██║░░██║██╔═██╗░██╔══╝░░██╔══██╗
███████╗███████╗╚█████╔╝██║░╚██╗███████╗██║░░██║
╚══════╝╚══════╝░╚════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝
${yellow}Windows Tweak Creator - GiuCoder
${nc}"

# Confirmation from user
read -p "$(echo -e "${yellow}${warn_emoji}  Warning: This script bypasses Windows 11 requirements by modifying registry keys. Use at your own risk. Continue? [y/n]:${nc}")" -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "$(echo -e "${yellow}${loading_emoji}  Applying tweaks...${nc}")"

    # Apply registry tweaks
    reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassTPMCheck /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\Setup\LabConfig" /v BypassSecureBootCheck /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\Setup\LabConfig" /v AllowUpgradesWithUnsupportedTPMOrCPU /t REG_DWORD /d 1 /f &

    # Start loading animation
    i=0
    while kill -0 $! &>/dev/null
    do
        i=$(( (i+1) %4 ))
        printf "\r$(echo -e "${yellow}${loading_emoji}  Applying tweaks...${nc}")  ${check_emoji}  ${loading_emoji: $i:1}"
        sleep 0.1
    done

    # Confirmation message
    echo -e "\n$(echo -e "${green}${check_emoji}  Tweaks applied successfully. You can now upgrade to Windows 11.${nc}")"
else
    echo -e "$(echo -e "${red}${warn_emoji}  Script aborted.${nc}")"
fi
