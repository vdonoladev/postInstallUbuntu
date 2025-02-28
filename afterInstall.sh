# --- VARIÁVEIS --- #
CHOICE=Softwares

# --- CORES --- #
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'

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

