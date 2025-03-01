# --- VARIABLES --- #
CHOICE=Softwares
TIME=1

# --- REQUIREMENTS --- #

# make sure this is running as root
declare -f VERIFY_ROOT
function VERIFY_ROOT()
{
	uid=$(id -ur)
	if [ "$uid" != "0" ]; then
	        echo "[ERROR!] - This script must be run as root"
		if [ -x /usr/bin/sudo ]; then
			echo "try: sudo $0"
		fi
	        exit 1
	fi
}

# --- TESTS --- #
declare -f VERIFY_NET
function VERIFY_NET()
{
  if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
    echo -e "[ERROR!] - The computer has no Internet connection. Check your network."
    exit 1
  else
    echo -e "[INFORMATION] - Internet connection is working normally."
  fi
}

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
echo "Choose an option below to get started!

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
    sudo rm /var/cache/apt/archives/lock
    apt update -y
    ;;
  
  2)
    echo "Showing system updates ..."
    sleep $TIME
    apt list --upgradable
    ;;
  
  3)
    echo "Installing system updates ..."
    sleep $TIME
    apt dist-upgrade -y
  
  4)
    echo "Cleaning the system ..."
    apt clean
    apt autoclean
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
    ;;
  
  *)
    echo "Invalid option, try again!"
    ;;
    
esac
done
