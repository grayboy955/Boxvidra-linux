#!/bin/bash
set -e

echo "[+] Mise à jour des paquets..."
sudo apt update && sudo apt upgrade -y

echo "[+] Installation des paquets requis..."
sudo apt install wget git curl tar unzip p7zip-full patchelf \
                 xfce4 xfce4-goodies tigervnc-standalone-server \
                 x11-xserver-utils mesa-utils libgl1-mesa-dri \
                 python3-tk firefox-esr gimp mpv vlc abiword ristretto -y

# Création dossier BoxVidra
mkdir -p ~/boxvidra
cd ~/boxvidra

echo ""
echo "Choisissez une version à installer :"
echo "1) Box86 (plus léger)"
echo "2) WoW64 (plus complet)"
read -p "Numéro: " choice

case "$choice" in
1)
    echo "[+] Téléchargement BoxVidra Box86..."
    wget -O glibc.box86.tar.xz https://github.com/AGENT404TRD/BOXVIDRA-EMULATOR/releases/download/Glibc/glibc.box86.tar.xz
    tar -xf glibc.box86.tar.xz
    ;;
2)
    echo "[+] Téléchargement BoxVidra WoW64..."
    wget -O glibc.wow64.tar.xz https://github.com/AGENT404TRD/BOXVIDRA-EMULATOR/releases/download/Glibc/glibc.wow64.tar.xz
    tar -xf glibc.wow64.tar.xz
    ;;
*)
    echo "Option invalide."
    exit 1
    ;;
esac

# Déplacer scripts dans /usr/local/bin
if [ -d glibc ]; then
    sudo cp glibc/opt/scripts/* /usr/local/bin/
    sudo chmod +x /usr/local/bin/*
fi

# Thème Windows 10
echo ""
echo "Choisissez un thème :"
echo "1) Windows 10 Light"
echo "2) Windows 10 Dark"
echo "3) Windows 10 Red (Gaming)"
echo "4) Windows 10 Purple (Space)"
read -p "Numéro: " theme

case "$theme" in
1) THEME_URL="Windows.10.Light.tar.xz" ;;
2) THEME_URL="Windows.10.Dark.tar.xz" ;;
3) THEME_URL="Windows.10.Red.tar.xz" ;;
4) THEME_URL="Windows.10.Purple.tar.xz" ;;
*) echo "Option invalide."; exit 1 ;;
esac

wget -O theme.tar.xz https://github.com/AGENT404TRD/BOXVIDRA-EMULATOR/releases/download/Themes/$THEME_URL
tar -xf theme.tar.xz
THEME_DIR=$(find . -maxdepth 1 -type d -name "Windows 10*" | head -n 1)

mkdir -p ~/.themes ~/.icons ~/Desktop
cp -r "$THEME_DIR"/.themes ~/
cp -r "$THEME_DIR"/.icons ~/
cp -r "$THEME_DIR"/WALLPAPERS ~/

echo "[+] Installation terminée."
echo "Pour lancer BoxVidra : tapez 'vncserver :1' puis connectez-vous via VNC sur localhost:5901"
