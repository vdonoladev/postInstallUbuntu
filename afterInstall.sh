# --- LOGO --- #
echo "  _   _ _                 _          "
echo " | | | | |__  _   _ _ __ | |_ _   _  "
echo " | | | | '_ \| | | | '_ \| __| | | | "
echo " | |_| | |_) | |_| | | | | |_| |_| | "
echo "  \___/|_.__/ \__,_|_| |_|\__|\__,_| "
echo "                      PÓS INSTALAÇÃO "
echo "+-----------------------------------+"
sleep 2
Q
# --- REQUISITOS --- #
# Certifique-se de que isso esteja sendo executado como root
declare -f VERIFY_ROOT
function VERIFY_ROOT()
{
  uid=$(id -ur)
  if [ "$uid" != "0" ]; then
    echo "ERRO: este script deve ser executado como root!"
    if [ -x /usr/bin/sudo ]; then
      echo "Tente: sudo $0"
    fi
    exit 1
  fi
}

# --- TESTES E REQUISITOS --- #
declare -f VERIFY_NET
function VERIFY_NET()
{
  if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
    echo -e "${VERMELHO}[ERRO!] - O computador não tem conexão com a Internet. Verifique sua rede. ${SEM_COR}"
    exit 1
  else
    echo -e "${VERDE}[INFORMAÇÃO] - Conexão com a Internet está funcionando normalmente. ${SEM_COR}"
  fi
}

# --- FUNÇÕES --- #
# Atualizando os repositórios e fazendo a atualização do sistema
echo "Verificando atualizações do sistema ..."
sleep 2
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
apt update -y
clear
  
echo "Instalando atualizações do sistema ..."
sleep 2
apt dist-upgrade -y
clear
  
echo "Removendo pacotes desnecessários ..."
sleep 2
apt autoremove -y
clear


# --- APLICAÇÕES --- #
echo
