# --- LOGO --- #
echo "  _   _ _                 _          "
echo " | | | | |__  _   _ _ __ | |_ _   _  "
echo " | | | | '_ \| | | | '_ \| __| | | | "
echo " | |_| | |_) | |_| | | | | |_| |_| | "
echo "  \___/|_.__/ \__,_|_| |_|\__|\__,_| "
echo "                      PÓS INSTALAÇÃO "
echo "+-----------------------------------+"
sleep 2

# --- FUNÇÕES --- #
# Atualizando os repositórios e fazendo a atualização do sistema
echo "Verificando atualizações do sistema ..."
sleep 2
sudo apt update -y
clear
  
echo "Instalando atualizações do sistema ..."
sleep 2
sudo apt dist-upgrade -y
clear
  
echo "Removendo pacotes desnecessários ..."
sleep 2
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
sudo apt autoremove -y
clear

echo "Instalando Softwares Properties Common ..."
sleep 2
apt install software-properties-common -y
sudo clear

echo "Instalando cURL ..."
sleep 2
sudo apt install curl -y

echo "Baixando e Instalando o Google Chrome ..."
sleep 2
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O googlechrome.deb
sudo apt install -y ./googlechrome.deb
sudo apt install -f -y
