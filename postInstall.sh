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

sleep $TIME

rm /var/lib/dpkg/lock-frontend
rm /var/cache/apt/archives/lock

clear

# Atualizando o sistema
echo -e "Atualizando o sistema..."

sleep $TIME

apt update && apt upgrade -y

clear

# Adicionando e confirmando arquitetura de 32 bits/i386
echo -e "Adicionando e confirmando arquitetura de 32 bits/i386..."

sleep $TIME

dpkg --add-architecture i386

clear

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

# --- INSTALANDO PROGRAMAS VIA APT --- #
echo -e "------------------------------"
echo -e "Instalando programas via APT"
echo -e "------------------------------"

sleep $TIME

echo -e "Instalando ubuntu-restricted-extras..."
apt install ubuntu-restricted-extras -y

echo -e "Instalando flatpak..."
apt install flatpak -y

echo -e "Instalando neofetch..."
apt install neofetch -y

echo -e "Instalando curl..."
apt install curl -y

echo -e "Instalando wget..."
apt install wget -y

echo -e "Instalando VSCode..."
apt install code -y

# --- INSTALANDO PROGRAMAS VIA FLATPAK --- #
echo -e "----------------------------------"
echo -e "Instalando programas via Flatpak"
echo -e "----------------------------------"

sleep $TIME

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
