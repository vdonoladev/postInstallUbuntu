# --- VARIABLES --- #

set -e

# --- URL's --- #

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v2.23.0/Simplenote-linux-2.23.0-amd64.deb"

# --- DIRECTORIES AND FILES --- #

DIRECTORY_DOWNLOADS="$HOME/Programs"

# --- COLORS --- #

VERMELHO="\e[1;91m"
VERDE="\e[1;92m"
WITHOUT_COLOR="\e[0m"

# --- FUNCTIONS --- #

# Updating repositories and performing system updates

apt_update(){
	sudo apt update && sudo apt dist-upgrade -y
}

# --- TESTS AND REQUIREMENTS --- #

# Internet connecting?

testing_internet(){
	if ! ping -c 1 8.8.8.8 -1 &> /dev/null; then
 		echo -e "${VERMELHO}[ERROR!] - The computer has no Internet connection. Check your network.${SEM_COR}"
		exit 1
	else
 		echo -e "${VERDE}[INFORMATION!] - Internet connection is working normally.${SEM_COR}"
	fi
}

# Removing occasional apt locks

lock_apt(){
	sudo rm /var/lib/dpkg/lock-frontend
 	sudo rm /var/cache/apt/archives/lock
}

# Adding/Confirming 32-bit Architecture

add_archi386(){
	sudo dpkg --add-architecture i386
}

# Updating the repository

just_apt_update(){
	sudo apt update -y
}

# --- .DEB SOFTWARE TO INSTALL --- #

PROGRAMS_TO_INSTALL=(
	wget
	snapd
	flatpak
 	curl
 	ubuntu-restricted-extras
  	gnome-tweak-tool
 	flameshot
 	gparted
	timeshift
 	gufw
	synaptic
 	vlc
 	gnome-sushi
	code
	git
 	synaptic
  	neofetch
)

# --- DOWNLOADING AND INSTALLING EXTERNAL PROGRAMS --- #

install_debs(){
	echo -e "${VERDE}[INFORMATION!] - Downloading .deb packages${SEM_COR}"

 	mkdir "$DIRECTORY_DOWNLOADS"
	wget -c "$URL_GOOGLE_CHROME" -P "$DIRECTORY_DOWNLOADS"
 	wget -c "$URL_SIMPLE_NOTE" -P "$DIRECTORY_DOWNLOADS"

	# Installing .deb packages downloaded in the previous session
	echo -e "${verde}[INFORMATION!] - Installing downloaded .deb packages.${SEM_COR}"
 	sudo dpkg -i $DIRECTORY_DOWNLOADS/*.deb

 	# --- INSTALL PROGRAMS IN APT --- #
	echo -e "${VERDE}[INFORMATION!] - Installing apt packages from repository.${SEM_COR}"

 	for program_name in ${PROGRAMS_TO_INSTALL[@]}; do
		if ! dpkg -l | grep -1 $program_name; then # Only install if not already installed
			sudo apt install "$program_name" -y
	 	else
			echo "[INSTALLED!] - $program_name"
		fi
	done	
}

# --- INSTALLING FLATPAK PACKAGES --- #

install_flatpaks(){
	echo -e "${VERDE}[INFORMATION!] - Installing flatpak packages.${SEM_COR}"

	flatpak install flathub org.gimp.GIMP -y
}

# --- INSTALLING SNAP PACKAGES --- #

install_snaps(){
	echo -e "${VERDE}[INFORMATION!] - Installing snap packages.${SEM_COR}"

	sudo snap install authy
 	sudo snap install libreoffice
  	sudo snap install spotify
   	sudo snap install bitwarden
    	sudo snap install telegram-desktop
     	sudo snap install gnome-boxes
}

# --- POST INSTALLATION --- #

# Finalization, update and cleanup

system_clean(){
	apt_update -y
 	flatpak update -y
	sudo apt autoclean -y
 	sudo apt autoremove -y
 	nautilus -q
}

# --- EXECUTION --- #

lock_apt
testing_internet
lock_apt
apt_update
lock_apt
add_archi386
just_apt_update
install_debs
install_flatpaks
install_snaps
apt_update
system_clean

# --- FINALIZATION --- #

echo -e "${VERDE}[INFORMATION!] - Script finished, installation complete! :)${SEM_COR}"
