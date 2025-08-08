#!/bin/bash
set -e

echo "[+] Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "[+] Installing required packages..."
sudo apt install -y wget git hashdeep p7zip-full patchelf \
xfce4 xfce4-goodies tigervnc-standalone-server x11-xserver-utils \
mesa-utils libgl1-mesa-dri python3-tk gimp mpv vlc abiword ristretto curl

clear

# Removing an old installation if present
if [ -d "$HOME/boxvidra" ]; then
echo -n "An old BoxVidra installation is detected. Remove and continue? (Y/n) "
read rep
if [[ "$rep" =~ ^[Yy]$ ]]; then
rm -rf "$HOME/boxvidra"
else
echo "Cancellation."
exit 1
fi
fi

# Version Selection
echo "Select a BoxVidra version to install:"
echo "1) Box86 (lightweight)"
echo "2) WoW64 (full version)"
read -p "Your choice (1 or 2): " choice
mkdir -p ~/boxvidra
cd ~/boxvidra

case "$choice" in
1)
echo "[+] Downloading glibc.box86..."
wget -c https://github.com/Chrisklucik0/BOXVIDRA-EMULATOR/releases/download/Mangohub/glibc.box86.tar.xz
tar -xf glibc.box86.tar.xz
;;
2)
echo "[+] Downloading glibc.wow64..."
wget -c https://github.com/Chrisklucik0/BOXVIDRA-EMULATOR/releases/download/Mangohub/glibc.wow64.tar.xz
tar -xf glibc.wow64.tar.xz
;;
*)
echo "Invalid option."
exit 1
;;
esac

# Copy scripts to /usr/local/bin to call boxvidra
if [ -d glibc/opt/scripts ]; then
sudo cp glibc/opt/scripts/* /usr/local/bin/
sudo chmod +x /usr/local/bin/*
fi

echo "Installation complete. You can launch BoxVidra with:"
echo "boxvidra"
