# --- VARIABLES --- #

TIME=1

# --- LOGO --- #
echo "  _   _ _                 _          "
echo " | | | | |__  _   _ _ __ | |_ _   _  "
echo " | | | | '_ \| | | | '_ \| __| | | | "
echo " | |_| | |_) | |_| | | | | |_| |_| | "
echo "  \___/|_.__/ \__,_|_| |_|\__|\__,_| "
echo "                   POST INSTALLATION "
echo "+-----------------------------------+"
sleep $TIME

# --- SYSTEM UPDATE FUNCTION --- #
echo " "
echo "Welcome to Ubuntu Settings!"
echo " "
echo "Chose an option below to get started!

1 - Check the system repository
2 - Show system updates
3 - Install system updates
4 - Clean the system
5 - Remove unnecessary packages
0 - Exit"

echo " "
echo -n "Chosen option: "
read option
case $option in
  1)
    echo "Checking the system for updates ..."
    sleep $TIME
    sudo rm /var/lib/dpkg/lock-frontend
    sudo rm/var/cache/apt/archives/lock
    sudo apt update
    ;;
  
  2)
    echo "Showing system updates ..."
    sleep $TIME
    sudo apt list --upgradable
    ;;
  
  3)
    echo "Installing system updates ..."
    sleep $TIME
    sudo apt upgrade -y
  
  4)
    echo "Cleaning the system ..."
    sudo apt clean -y
    sudo apt autoclean -y
    ;;
  
  5)
    echo "Removing unnecessary packages from the system ..."
    sleep $TIME
    apt autoremove -y
    ;;
  
  0)
    echo "Exiting ..."
    sleep $TIME
    exit 0
  
  *)
    echo "Opção inválida, tente novamente!"
    ;;
    
esac
done
