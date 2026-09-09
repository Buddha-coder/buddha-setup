#!/data/data/com.termux/files/usr/bin/bash

# Futuristic Cyberpunk Banner
clear
echo -e "\033[91m\033[1m"
echo "  ___ _   _ ____  ____  _   _    _    "
echo " | __| | | |  _ \|  _ \| | | |  / \   "
echo " | _|| |_| | | | | | | | |_| | / _ \  "
echo " |_|  \___/|_| |_|_| |_|\___/ /_/ \_\ "
echo " [ RESTRICTED ACCESS // PROTOCOL 0x77 ]"
echo -e "\033[0m"

# Authentication Prompt
echo -e "\033[93m[!] Authentication Required for Operator Buddha Setup.\033[0m"
read -s -p "Enter Decryption Key: " USER_KEY
echo ""

# Decryption Check
echo -e "\n\033[96m[*] Verifying authorization key...\033[0m"

openssl enc -d -aes-256-cbc -pbkdf2 -in payload.enc -k "$USER_KEY" 2>/dev/null | tar -xzf - -C ~/

if [ $? -ne 0 ]; then
    echo -e "\033[91m[X] ACCESS DENIED: Invalid Security Key!\033[0m"
    echo -e "\033[91m[!] Terminating Session & Deleting Workspace...\033[0m"
    exit 1
fi

echo -e "\033[92m[✓] ACCESS GRANTED: Decryption Successful!\033[0m"
echo -e "\033[96m[*] Installing dependencies & deploying system...\033[0m"

# Dependencies install karein
pkg update -y
pkg install python figlet termux-api zsh curl unzip -y

# Hack Nerd Font Setup
mkdir -p ~/.termux
curl -fLo ~/.termux/Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip -o ~/.termux/Hack.zip HackNerdFont-Regular.ttf -d ~/.termux/
mv ~/.termux/HackNerdFont-Regular.ttf ~/.termux/font.ttf
rm ~/.termux/Hack.zip
termux-reload-settings

# Auto-run HUD in shell
if ! grep -q "cyber_hud.py" ~/.bashrc 2>/dev/null; then
    echo "python ~/cyber_hud.py" >> ~/.bashrc
fi

echo -e "\033[92m\n[✓] BUDDHA Cyber Matrix Fully Deployed!\033[0m"
python ~/cyber_hud.py

