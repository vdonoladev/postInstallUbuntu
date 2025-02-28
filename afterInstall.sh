TIME=1
clear
while true; do
echo " "
echo "Bem-vindos às configurações do Ubuntu!"
echo " "
echo "Escolha uma opção abaixo para começar!

1 - Verificar o repositório do sistema
2 - Mostrar as atualizações do sistema
3 - Instalar as atualizações do sistema
4 - Limpar o sistema
5 - Remover os pacotes desnecessários do sistema
0 - Sair"

echo " "
echo -n "Opção escolhida: "
read option
case $option in
  1)
    echo Verificando atualizações do sistema ...
    sleep $TIME
    apt update
    ;;
  
  2)
    echo Mostrando atualizações do sistema ...
    sleep $TIME
    apt list --upgradable
    ;;
  
  3)
    echo Instalando atualizações do sistema ...
    sleep $TIME
    apt upgrade -y
  
  4)
    echo Limpando o sistema ...
    apt clean
    apt autoclean
    ;;
  
  5)
    echo Removendo pacotes desnecessários do sistema ...
    sleep $TIME
    apt autoremove -y
    ;;
  
  0)
    echo Saindo ...
    sleep $TIME
    exit 0
  
  *)
    echo Opção inválida, tente novamente!
    ;;
    
esac
done
