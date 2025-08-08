#!/bin/bash
set -e

echo "[+] Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "[+] Installing required packages..."
sudo apt install wget git curl tar unzip p7zip-full patchelf \
xfce4 xfce4-goodies tigervnc-standalone-server \
x11-xserver-utils mesa-utils libgl1-mesa-dri \
python3-tk firefox-esr gimp mpv vlc abiword ristretto -y

# Create BoxVidra folder
mkdir -p ~/boxvidra
cd ~/boxvidra

echo ""
echo "Choose a version to install:"
echo "1) Box86 (lighter)"
echo "2) WoW64 (more complete)"
read -p "Number: " choice

case "$choice" in
1) 
echo "[+] BoxVidra Box86 Download..." 
wget -O glibc.box86.tar.xz https://github.com/AGENT404TRD/BOXVIDRA-EMULATOR/releases/download/Glibc/glibc.box86.tar.xz 
tar -xf glibc.box86.tar.xz 
;;
2) 
echo "[+] BoxVidra WoW64 Download..." 
wget -O glibc.wow64.tar.xz https://github.com/AGENT404TRD/BOXVIDRA-EMULATOR/releases/download/Glibc/glibc.wow64.tar.xz 
tar -xf glibc.wow64.tar.xz 
;;
*) 
echo "Invalid option." 
exit 1 
;;
esac

# Move scripts to /usr/local/bin
if [ -d glibc ]; then 
sudo cp glibc/opt/scripts/* /usr/local/bin/ 
sudo chmod +x /usr/local/bin/*
fi

#Windows 10 Theme
echo ""
echo "Choose a theme:"
echo "1) Windows 10 Light"
echo "2) Windows 10 Dark"
echo "3) Windows 10 Red (Gaming)"
echo "4) Windows 10 Purple (Space)"
read -p "Number: " theme

case "$theme" in
1) THEME_URL="Windows.10.Light.tar.xz" ;;
2) THEME_URL="Windows.10.Dark.tar.xz" ;;
3) THEME_URL="Windows.10.Red.tar.xz" ;;
4) THEME_URL="Windows.10.Purple.tar.xz" ;;
*) echo "Invalid option."; exit 1 ;;
esac

wget -O theme.tar.xz https://github.com/AGENT404TRD/BOXVIDRA-EMULATOR/releases/download/Themes/$THEME_URL
tar -xf theme.tar.xz
THEME_DIR=$(find . -maxdepth 1 -type d -name "Windows 10*" | head -n 1)

mkdir -p ~/.themes ~/.icons ~/Desktop
cp -r "$THEME_DIR"/.themes ~/
cp -r "$THEME_DIR"/.icons ~/
cp -r "$THEME_DIR"/WALLPAPERS ~/

echo "[+] Installation complete."
echo "To launch BoxVidra: type 'vncserver:1' then connect via VNC to localhost:5901"
