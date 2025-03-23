#!usr/bin/env bash

######################################
# Script de Pós-Instalação do Ubuntu #
# Autor: Víctor Donola Ferreira      #
# Data: 23/03/2025                   #
######################################

# --- VARIÁVEIS --- #
set -e
TIME=5

# --- LOGO --- #
echo "  _   _ _                 _          "
echo " | | | | |__  _   _ _ __ | |_ _   _  "
echo " | | | | '_ \| | | | '_ \| __| | | | "
echo " | |_| | |_) | |_| | | | | |_| |_| | "
echo "  \___/|_.__/ \__,_|_| |_|\__|\__,_| "
echo "                   POST INSTALLATION "
echo "+-----------------------------------+"

sleep $TIME

# --- TESTES E REQUISITOS --- #
echo -e "---------------------"
echo -e "Testes e Requisitos"
echo -e "---------------------"

sleep $TIME

# Verificando se o usuário é root
if [ $(id -u) -ne 0 ]; then
  echo "Este script precisa ser executado como root."
  exit 1
fi

# Removendo travas eventuais do APT
echo -e "Removendo travas eventuais do APT..."

rm /var/lib/dpkg/lock-frontend
rm /var/cache/apt/archives/lock

# Atualizando o sistema
echo -e "Atualizando o sistema..."

apt update && apt upgrade -y

# Adicionando e confirmando arquitetura de 32 bits/i386
echo -e "Adicionando e confirmando arquitetura de 32 bits/i386..."

dpkg --add-architecture i386

# --- CONFIGURAÇÕES --- #
echo -e "------------------------"
echo -e "Configurando o sistema"
echo -e "------------------------"

sleep $TIME

# Minimizar janela ao clicar no ícone
echo -e "Minimizando janela ao clicar no ícone..."
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

echo -e "Mostrando porcentagem da bateria..."
gsettings set org.gnome.shell.interface show-battery-percentage true

# --- ADICIONANDO PPA'S --- #
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# --- INSTALANDO PACOTES .DEB --- #
echo -e "-------------------------"
echo -e "Instalando pacotes .DEB"
echo -e "-------------------------"

sleep $TIME

echo -e "Instalando Google Chrome..."
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb

echo -e "Instalando SimpleNote..."
wget -c https://github.com/Automattic/simplenote-electron/releases/download/v2.23.2/Simplenote-linux-2.23.2-amd64.deb
dpkg -i Simplenote-linux-2.23.2-amd64.deb

# --- INSTALANDO PROGRAMAS VIA APT --- #
echo -e "------------------------------"
echo -e "Instalando programas via APT"
echo -e "------------------------------"

sleep $TIME

echo -e "Instalando ubuntu-restricted-extras..."
apt install ubuntu-restricted-extras -y

echo -e "Instalando ubuntu-restricted-addons..."
apt install ubuntu-restricted-addons -y

echo -e "Instalando git..."
apt install git -y

echo -e "Instalando gnome-tweaks..."
apt install gnome-tweaks -y

echo -e "Instalando flatpak..."
apt install flatpak -y

echo -e "Instalando gnome-software..."
apt install gnome-software -y

echo "Instalando gnome-software-plugin-flatpak..."
apt install gnome-software-plugin-flatpak -y

echo -e "Instalando neofetch..."
apt install neofetch -y

echo -e "Instalando curl..."
apt install curl -y

echo -e "Instalando wget..."
apt install wget -y

echo -e "Instalando snapd..."
apt install snapd -y

echo -e "Instalando apt-transport-https..."
apt install apt-transport-https -y

echo -e "Instalando ca-certificates..."
apt install ca-certificates -y

echo -e "Instalando software-properties-common..."
apt install software-properties-common -y

echo -e "Instalando gnome-shell-extensions..."
apt install gnome-shell-extensions -y

echo -e "Instalando gnome-shell-extension-manager..."
apt install gnome-shell-extension-manager -y

echo -e "Instalando chrome-gnome-shell..."
apt install chrome-gnome-shell -y

echo -e "Instalando GUFW (Firewall)..."
apt install gufw -y
ufw default deny incoming
ufw enable
ufw status

echo -e "Instalando suporte ao AppImage..."
apt install libfuse2 -y

echo -e "Instalando libreoffice..."
apt install libreoffice -y
apt install libreoffice-l10n-pt-br -y
apt install libreoffice-style-breeze -y

echo -e "Instalando pacote de fontes da Microsoft..."
apt install msttcorefonts -y --force-yes

echo -e "Instalando transmission..."
apt install transmission -y

echo -e "Instalando meta-pacote de codecs..."
apt install lame mpgtx sox -y

echo -e "Instalando Synaptic..."
apt install synaptic -y

echo -e "Instalando apturl..."
apt install apturl -y
apt install apturl-common -y

# --- INSTALANDO PROGRAMAS VIA FLATPAK --- #
echo -e "----------------------------------"
echo -e "Instalando programas via Flatpak"
echo -e "----------------------------------"

sleep $TIME

echo -e "Instalando Discord..."
flatpak install flathub com.discordapp.Discord -y

echo -e "Instalando VLC..."
flatpak install flathub org.videolan.VLC -y

echo -e "Instalando Telegram Desktop..."
flatpak install flathub org.telegram.desktop -y

echo -e "Instalando Gnome Boxes..."
flatpak install flathub org.gnome.Boxes -y

# --- FINALIZAÇÃO, LIMPEZA E REINICIALIZAÇÃO --- #
echo -e "------------------------------------------------------"
echo -e "Finalizando, limpando e reinicializando o sistema..."
echo -e "------------------------------------------------------"

sleep $TIME

dpkg --configure -a
apt update && apt upgrade -y
apt autoclean
apt autoremove -y
sudo -s update-grub
reboot
