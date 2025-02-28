```
# --- LOGO --- #
echo "  _   _ _                 _          "
echo " | | | | |__  _   _ _ __ | |_ _   _  "
echo " | | | | '_ \| | | | '_ \| __| | | | "
echo " | |_| | |_) | |_| | | | | |_| |_| | "
echo "  \___/|_.__/ \__,_|_| |_|\__|\__,_| "
echo "                      PÓS INSTALAÇÃO "
echo "+-----------------------------------+"
sleep 2

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
```

```
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
```

```
#!/bin/bash

# --- VARIABLES --- #
CHOICE=Softwares

# make sure this is running as root
declare -f VERIFY_ROOT
function VERIFY_ROOT()
{
	uid=$(id -ur)
	if [ "$uid" != "0" ]; then
	        echo "ERROR: This script must be run as root"
		if [ -x /usr/bin/sudo ]; then
			echo "try: sudo $0"
		fi
	        exit 1
	fi
}

# --- IDENTIFY DISTRIBUTION --- #
declare -f VERIFY_DISTRIB
function VERIFY_DISTRIB()
{
	ID=`lsb_release -i`
	RELEASE=`lsb_release -r`
	if [[ $ID = "Distributor ID:	Ubuntu" && $RELEASE = "Release:	20.04" ]]; then
		clear
		lsb_release -a
		MENU_UBUNTU
	elif [[ $ID = "Distributor ID:	LinuxMint" && $RELEASE = "Release:	19.3" ]]; then
		clear
		lsb_release -a
		MENU_MINT
	else	
		echo "# ========== Unsupported distribution ========== #"
		sleep 3

	fi
}

#--- System update function ---#
declare -f UPDATE
function UPDATE()
{
	clear
	echo "=== Updating Repositories ==="
	sleep 2
	sudo rm /var/lib/dpkg/lock-frontend
	sudo rm /var/cache/apt/archives/lock
	sudo apt update -y
	clear
	echo "=== Applying Updates ==="
	sleep 2
	sudo apt dist-upgrade -y
	clear
	echo "=== Finished ==="
	sleep 3
	VERIFY_DISTRIB
}

#--- Functions ---#
declare -f INSTSOFTWARE
function INSTSOFTWARE()
{
	clear
	echo "#========== Installing $CHOICE ==========#"
	sleep 2
	clear
	for CHOICE in $selection; do
		echo "#========== Installing $CHOICE ==========#"
		sleep 2
		case $CHOICE in
			Google-Chrome-Stable )
				INSTCHROME
				;;
			Insync )
				INSTINSYNC
				;;
			Spotify-FlatHub )
				flatpak install flathub com.spotify.Client -y
				;;
			Sublime-Text-FlatHub )
				flatpak install flathub com.sublimetext.three -y
				;;
			Handbrake-FlatHub )
				flatpak install flathub fr.handbrake.ghb -y 
				;;
			WPS-Office-FlatHub )
				flatpak install flathub com.wps.Office -y
				;;
			ONLYOFFICE-FlatHub )
				flatpak install flathub org.onlyoffice.desktopeditors -y
				;;	
			Discord-FlatHub )
				flatpak install flathub com.discordapp.Discord -y
				;;	
			libreoffice )
				INSTLIBREOFFICE
				;;
			Telegram-FlatHub )
				flatpak install flathub org.telegram.desktop -y
				;;
			Tor-Browser-Launcher-FlatHub )
				flatpak install flathub com.github.micahflee.torbrowser-launcher -y
				;;
			Jdownloader-FlatHub )
				flatpak install flathub org.jdownloader.JDownloader -y
				;;		
			Whatsapp-desktop-Snap )
				sudo snap install whatsdesk
				;;
			Vlc )
				sudo snap install vlc
				;;			
			Unpackers )	
				sudo apt install p7zip-full p7zip-rar lzma lzma-dev rar unrar-free p7zip ark ncompress -y 
				;;	
			* )
				apt install $CHOICE -y 
				;;	
		esac		
	done 
	echo "#========== Successfully concluded! ==========#"
	sleep 3
    clear
    VERIFY_DISTRIB			
}

declare -f INSTCHROME
function INSTCHROME()
{
	mkdir /tmp/chrome
	cd /tmp/chrome
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i *.deb
}

declare -f INSTINSYNC
function INSTINSYNC()
{
	mkdir /tmp/insync
	cd /tmp/insync
	wget https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.27.40677-bionic_amd64.deb
	sudo dpkg -i *.deb
	which nautilus && sudo apt install insync-nautilus -y
	which nemo && sudo apt install insync-nemo -y
}

declare -f INSTLIBREOFFICE
function INSTLIBREOFFICE()
{
	sudo add-apt-repository ppa:libreoffice/ppa -y
	sudo apt update && sudo apt dist-upgrade -y
	which libreoffice || sudo apt install libreoffice libreoffice-l10n-br -y
}

#--- Uninstall Programs ---#
declare -f RMSOFTWARES
function RMSOFTWARES()
{
 	for CHOICE in $selection; do
 		echo "#========== Removing $CHOICE ==========#"
		sleep 2
 		sudo apt remove $CHOICE -y
 	done
 	VERIFY_DISTRIB
}

######========== LinuxMint ==========######

###### Main Menu Function ######
declare -f MENU_MINT
function MENU_MINT()
{
	selection=$(zenity --list --title='Selection' --column="#" --column="Softwares" \
	FALSE "Update Repositories and System" \
	FALSE "Install Programs" \
	FALSE "Uninstall Embedded Programs" \
	--radiolist  --height=200 --width=300 )
	
	if [[ -z $selection  ]]; then
		exit 0
	fi
	case "$selection" in
	    "Update Repositories and System" )
	    	UPDATE
	    	;;  	
	    "Install Programs" )
	    	INSTMENU_MINT
	    	;;
	   	"Uninstall Embedded Programs" )
			RMMENU_MINT
			;;
	    * )
	        echo "Invalid option, try again!"
	        ;;
	esac
	exit 0
}

declare -f INSTMENU_MINT
function INSTMENU_MINT()
{
	selection=$(zenity --list --title='Select' --column="#" --column="Softwares" --column="description" \
	FALSE "Google-Chrome-Stable" "Web browser" \
	FALSE "Tor-Browser-Launcher-FlatHub" "Private Web Browser" \
	FALSE "Insync" "Client Google Drive" \
	FALSE "Spotify-FlatHub" "Music Streaming" \
	FALSE "Telegram-FlatHub" "Messenger" \
	FALSE "Discord-FlatHub" "Voice Messenger" \
	FALSE "Jdownloader-FlatHub" "Downloader Manager" \
	FALSE "whatsapp-desktop" "Messenger" \
 	FALSE "Sublime-Text-FlatHub" "IDE for development" \
	FALSE "ubuntu-restricted-extras" "Additional (codec, flash and etc...)" \
	FALSE "mpv" "Video Player" \
	FALSE "celluloid" "Video Player" \
	FALSE "audacious" "Audio Player" \
	FALSE "gnome-calendar" "Calendar" \
	FALSE "gnome-maps" "Maps" \
	FALSE "gnome-contacts" "Contacts" \
	FALSE "gnome-weather" "Weather" \
	FALSE "shutter" "PrintScreen Tool" \
	FALSE "flameshot" "PrintScreen Tool" \
	FALSE "snapd" "core for SNAP containers" \
	FALSE "kdenlive" "Video editor" \
	FALSE "ffmpeg" "Back-End Tool for Media Conversion" \
	FALSE "winff" "Front-End for FFMPEG"\
	FALSE "mint-meta-codecs" "Codec Pack" \
	FALSE "synaptic" "Package Manager" \
	FALSE "gparted" "Partition Manager" \
	FALSE "geary" "EMAIL CLIENT" \
	FALSE "clipit" "Clipboard Manager" \
	FALSE "virtualbox-qt" "Virtualization" \
	FALSE "wine-stable" "Layer for Windows Software" \
	FALSE "libreoffice" "Office Tools" \
	FALSE "WPS-Office-FlatHub" "Office Tools" \
	FALSE "ONLYOFFICE-FlatHub" "Office Tools" \
	FALSE "Handbrake-FlatHub" "Video conversion tools" \
	FALSE "transmission" "Torrent client" \
	FALSE "keepassxc" "Password Manager" \
	FALSE "Unpackers" "zip-rar lzma lzma-dev rar unrar-free p7zip ark ncompress" \
	FALSE "steam-installer" "Game Store" \
	FALSE "zsnes" "SuperNes emulator" \
	FALSE "ttf-mscorefonts-installer" "Microsoft fonts" \
	--separator=" "	--checklist  --height=650 --width=650 )
	
	if [[ -z $selection  ]]; then
		MENU_MINT
	fi
	INSTSOFTWARE
}

declare -f RMMENU_MINT
function RMMENU_MINT()
{
	selection=$(zenity --list --title='Select' --column="#" --column="Softwares" --column="description" \
	FALSE "hexchat" "Chat" \
	FALSE "firefox" "Web browser" \
	FALSE "thunderbird" "EMAIL CLIENT" \
	FALSE "rhythmbox" "Audio Player" \
	--separator=" "	--checklist  --height=650 --width=550 )
	
	if [[ -z $selection  ]]; then
		MENU_MINT
	fi
	RMSOFTWARES
}

######========== Ubuntu ==========######
###### Main Menu Function ######
declare -f MENU_UBUNTU
function MENU_UBUNTU()
{
	selection=$(zenity --list --title='Selection' --column="#" --column="Softwares" \
	FALSE "Update Repositories and System" \
	FALSE "Install Programs" \
	FALSE "Uninstall Embedded Programs" \
	--radiolist  --height=200 --width=300 )
	
	if [[ -z $selection  ]]; then
		exit 0
	fi
	case "$selection" in
	    "Update Repositories and System" )
	    	UPDATE
	    	;;  	
	    "Install Programs" )
	    	INSTMENU_UBUNTU
	    	;;
	   	"Uninstall Embedded Programs" )
			RMMENU_UBUNTU
			;;
	    * )
	        echo "Invalid option, try again!"
	        ;;
	esac
	exit 0
}

declare -f INSTMENU_UBUNTU
function INSTMENU_UBUNTU()
{
	selection=$(zenity --list --title='Select' --column="#" --column="Softwares" --column="description" \
	FALSE "Google-Chrome-Stable" "Web browser" \
	FALSE "Tor-Browser-Launcher-FlatHub" "Private Web Browser" \
	FALSE "Insync" "Client Google Drive" \
	FALSE "Spotify-FlatHub" "Music Streaming" \
	FALSE "Telegram-FlatHub" "Messenger" \
	FALSE "Discord-FlatHub" "Voice Messenger" \
	FALSE "Jdownloader-FlatHub" "Downloader Manager" \
	FALSE "Whatsapp-desktop-Snap" "Messenger" \
	FALSE "Sublime-Text-FlatHub" "IDE for development" \
	FALSE "ubuntu-restricted-extras" "Additional (codec, flash and etc...)" \
	FALSE "mpv" "Video Player" \
	FALSE "celluloid" "Video Player" \
	FALSE "audacious" "Audio Player" \
	FALSE "Vlc" "Audio Player" \
	FALSE "gnome-calendar" "Calendar" \
	FALSE "gnome-maps" "Maps" \
	FALSE "gnome-contacts" "Contacts" \
	FALSE "gnome-weather" "Weather" \
	FALSE "shutter" "PrintScreen Tool" \
	FALSE "flameshot" "PrintScreen Tool" \
	FALSE "kdenlive" "Video editor" \
	FALSE "ffmpeg" "Back-End Tool for Media Conversion" \
	FALSE "winff" "Front-End for FFMPEG"\
	FALSE "synaptic" "Package Manager" \
	FALSE "gparted" "Partition Manager" \
	FALSE "geary" "EMAIL CLIENT" \
	FALSE "virtualbox-qt" "Virtualization" \
	FALSE "wine-stable" "Layer for Windows Software" \
	FALSE "libreoffice" "Office Tools" \
	FALSE "WPS-Office-FlatHub" "Office Tools" \
	FALSE "ONLYOFFICE-FlatHub" "Office Tools" \
	FALSE "Handbrake-FlatHub" "Video conversion tools" \
	FALSE "transmission" "Torrent client" \
	FALSE "keepassxc" "Password Manager" \
	FALSE "Unpackers" "zip-rar lzma lzma-dev rar unrar-free p7zip ark ncompress" \
	FALSE "steam-installer" "Game Store" \
	FALSE "zsnes" "SuperNes emulator" \
	FALSE "ttf-mscorefonts-installer" "Microsoft fonts" \
	FALSE "gnome-tweaks" "Gnome extra settings" \
	--separator=" "	--checklist  --height=650 --width=650 )
	
	if [[ -z $selection  ]]; then
		MENU_UBUNTU
	fi
	which flatpak || sudo apt install flatpak gnome-software-plugin-flatpak -y && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list && sudo apt update	
	INSTSOFTWARE
}

declare -f RMMENU_UBUNTU
function RMMENU_UBUNTU()
{
	selection=$(zenity --list --title='Select' --column="#" --column="Softwares" --column="description" \
	FALSE "firefox" "Web browser" \
	FALSE "thunderbird" "EMAIL CLIENT" \
	FALSE "rhythmbox" "Audio Player" \
	FALSE "remmina" "remote connection" \
	--separator=" "	--checklist  --height=650 --width=550 )
	
	if [[ -z $selection  ]]; then
		MENU_UBUNTU
	fi
	RMSOFTWARES
}

#========== EXECUTION ==========#
VERIFY_ROOT
VERIFY_DISTRIB
```

```
#!/bin/bash

#### BETA FOREVER !!!!!!!!!!

#### UBUNTU SIMPLE POST INSTALLATION SCRIPT

### Just download and run "sudo ./start.sh"

### CREATED by Bruno Raphael Cabral de Mesquita
### Nov/26/2019

### UPDATED by Bruno Raphael Cabral de Mesquita
### Mar/24/2021

cd /tmp

echo "Atualizando lista de repositórios..."
  sudo apt update

echo "Inicializando a atualização dos pacotes..."
  sudo apt upgrade -y

echo "Removendo pacotes que não são mais necessários..."
  sudo apt autoremove -y

echo "Instalando Software Properties Common..."
  sudo apt install software-properties-common -y

echo "Instalando cURL..."
  sudo apt install -y curl

echo "Instalando o dconf..."
  sudo apt install -y dconf-cli

echo "Adicionando repositório do Git..."
  sudo add-apt-repository -y ppa:git-core/ppa
echo "Instalando Git..."
  sudo apt install git -y

echo "Instalando o Xterm (necessário para o Steam)..."
  sudo apt install -y xterm

echo "Baixando o Google Chrome..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O googlechrome.deb
echo "Instalando o Google Chrome ..."
  sudo apt install -y ./googlechrome.deb
  sudo apt install -f -y

echo "Instalando o dotNET 5 SDK..."
  wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo apt install -y ./packages-microsoft-prod.deb
  sudo apt update
  sudo apt install -y apt-transport-https
  sudo apt update
  sudo apt install -y dotnet-sdk-5.0

echo "Instalando openJDK 11 JDK (Java 11 JDK)..."
  sudo apt install -y openjdk-11-jdk

echo "Baixando Microsoft Visual Studio Code..."
  wget https://go.microsoft.com/fwlink/?LinkID=760868 -O visualcode_$(date +"%Y-%m-%d_%H-%M-%S").deb
echo "Instalando o Microsoft Visual Studio Code..."
  sudo apt install -y ./visualcode.deb
  sudo apt install -f -y

echo "Baixando Gitkraken..."
  wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
echo "Instalando Gitkraken..."
  sudo apt install -y ./gitkraken-amd64.deb
  sudo apt install -fy

echo "Instalando DBeaver Community..."
  sudo apt install -y dbeaver-ce

echo "Instalando Docker..."
  sudo apt remove docker docker-engine docker.io containerd runc
  sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io

#echo "Configurando permissões para o Docker..."
  #sudo usermod -aG docker $USER
  #newgrp docker

#echo "Baixando e instalando o Docker Compose..."
  #curl -s https://api.github.com/repos/docker/compose/releases/latest \
  #| grep browser_download_url \
  #| grep docker-compose-Linux-x86_64 \
  #| cut -d '"' -f 4 \
  #| wget -qi -
  #chmod +x docker-compose-Linux-x86_64
  #sudo mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose

#echo "Instalando o Command-line completion para o Docker Compose..."
  #mkdir -p ~/.zsh/completion
  #curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
  #fpath=(~/.zsh/completion $fpath)
  #autoload -Uz compinit && compinit -i
  #exec $SHELL -l

# Oracle VM VirtualBox 6
  #wget https://download.virtualbox.org/virtualbox/6.0.14/Oracle_VM_VirtualBox_Extension_Pack-6.0.14.vbox-extpack
  #wget https://download.virtualbox.org/virtualbox/6.0.14/virtualbox-6.0_6.0.14-133895~Ubuntu~bionic_amd64.deb
  #sudo apt install -y ./virtualbox-6.0_6.0.14-133895~Ubuntu~bionic_amd64.deb
  #sudo apt install -fy
  #sudo VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-6.0.14.vbox-extpack

#echo "Instalando o ZSH..."
  #sudo apt install zsh -y 

#echo "Instalando o Oh-My-ZSH..."
  # sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#echo "Instalando e Configurando o Tema Spaceship para ZSH..."
  # git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  # ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
  # sed -i 's,robbyrussell,spaceship,g' ~/.zshrc
  # echo '
  # SPACESHIP_PROMPT_ORDER=(
  #   time          # Time stamps section
  #   user          # Username section
  #   dir           # Current directory section
  #   host          # Hostname section
  #   git           # Git section (git_branch + git_status)
  #   #hg            # Mercurial section (hg_branch  + hg_status)
  #   package       # Package version
  #   node          # Node.js section
  #   docker        # Docker section
  #   aws           # Amazon Web Services section
  #   gcloud        # Google Cloud Platform section
  #   venv          # virtualenv section
  #   pyenv         # Pyenv section
  #   dotnet        # .NET section
  #   kubectl       # Kubectl context section
  #   battery       # Battery level and status
  #   exec_time     # Execution time
  #   line_sep      # Line break
  #   #vi_mode       # Vi-mode indicator
  #   jobs          # Background jobs indicator
  #   exit_code     # Exit code section
  #   char          # Prompt character
  # )

  # SPACESHIP_USER_SHOW=always
  # SPACESHIP_PROMPT_ADD_NEWLINE=false
  # #SPACESHIP_CHAR_SYMBOL="❯"
  # SPACESHIP_CHAR_SUFFIX=" "
  # ' >> ~/.zshrc

#echo "Instalando DHARMA para o ZSH e Oh-My-ZSH..."
  #sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

#echo "Congifurando plugins do ZSH..."
  # echo '
  # zinit light zdharma/fast-syntax-highlighting
  # zinit light zsh-users/zsh-autosuggestions
  # zinit light zsh-users/zsh-completions
  # ' >> ~/.zshrc

# echo "Instalando NVM (NodeJS Version Manager )..."
#   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# echo 'export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.zshrc
# source ~/.zshrc

# echo "Instalando Node LTS (via NVM)..."
#   nvm install --lts

#echo "Instalando o Yarn..."
  #curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  #echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  #sudo apt update
  #sudo apt install --no-install-recommends yarn

#echo "Instalando Create-React-App (Node/NPM)..."
  #npm install -g create-react-app

#echo "Baixando XAMPP (Apache, PHP 7.3 e MariaDB)..."
  # wget https://sourceforge.net/projects/xampp/files/latest/download -O xampp.run
  # sudo chmod +x xampp.run
  # sudo ./xampp.run &

echo "Instalando Insomnia..."
  wget https://updates.insomnia.rest/downloads/ubuntu/latest\?\&app\=com.insomnia.app\&source\=website -O insomnia_$(date +"%Y-%m-%d_%H-%M-%S").deb

echo "Baixando Steam..."
  cd /tmp
  wget https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb
echo "Instalando Steam..."
  sudo apt install -y ./steam.deb
  sudo apt install -fy

echo "Instalando o qBitTorrent..."
  sudo apt install -y qbittorrent  

echo "Instalando o FFMPEG..."
  sudo apt install -y ffmpeg

echo "Instalando o Lame..."
  sudo apt install -y lame

echo "Instalando o MPV Player..."
  sudo apt install -y mpv

echo "Instalando o SMPlayer..."
  sudo apt install -y smplayer

echo "Instalando o VLC..."
  sudo apt install -y vlc

echo "Instalando o Spotify..."
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt update
  sudo apt install -y spotify-client
  sudo apt install -y -f

echo "Instalando o OBS Studio..."
  sudo add-apt-repository -y ppa:obsproject/obs-studio
  sudo apt install -y obs-studio

#echo "Instalando o AnyDesk..."
# #add repository key to Trusted software providers list
# wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
# #add the repository:
# echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
# #update apt cache:
# sudo apt update
# #install anydesk:
# sudo apt install -y anydesk

echo "Instalando fontes Powerline..."
  sudo apt install fonts-powerline -y

echo "Instalando fontes da Microsoft..."
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
  sudo apt install ttf-mscorefonts-installer -y

# echo "Instalando fontes Fira Code..."
#   cd /tmp
#   wget https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip
#   unzip FiraCode_2.zip
#   mkdir -p ~/.fonts
#   mv ttf/* ~/.fonts

# echo "Instalando o elementary Tweaks..."
#   sudo add-apt-repository ppa:philip.scott/elementary-tweaks -y
#   sudo apt install elementary-tweaks -y

echo "Instalando o GNOME Tweaks"
  sudo apt install -y gnome-tweaks

echo "Instalando o Tema Dracula no GNOME Terminal"
  cd /tmp
  git clone https://github.com/dracula/gnome-terminal
  cd gnome-terminal
  ./install.sh
  cd ..
  rm gnome-terminal -rf

#echo "Instalando o Papirus Icon Theme..."
#echo "Adicionando o repositório do Papirus Themes..."
#   sudo add-apt-repository ppa:papirus/papirus -y
#echo "Instalando o Papirus Icon Theme..."
#   sudo apt install papirus-icon-theme -y
#echo "Instalando o Papirus Folders..."
#   sudo apt install papirus-folders -y
#   papirus-folders -C yaru #change color

echo "Realizando última atualização dos pacotes..."
  sudo apt update -y
  sudo apt upgrade -y

echo "Removendo pacotes que não são mais necessários..."
  sudo apt autoremove -y

echo "Fim da Pós Instalação..."
```

```
#!/bin/bash  export cor="\033[1;32m"  export corprg="\033[1;34m"  export corlogo="\033[1;31m" echo -e $corlogo "+-----------------------------------+" echo -e $corlogo "  _   _ _                 _          " echo -e $corlogo " | | | | |__  _   _ _ __ | |_ _   _  " echo -e $corlogo " | | | | '_ \| | | | '_ \| __| | | | " echo -e $corlogo " | |_| | |_) | |_| | | | | |_| |_| | " echo -e $corlogo "  \___/|_.__/ \__,_|_| |_|\__|\__,_| " echo -e $corlogo "                      PÓS INSTALAÇÃO " echo -e $corlogo "                     SADRAKE GABRIEL " echo -e $corlogo "             sadrake.silva@gmail.com " echo -e $corlogo "+-----------------------------------+" sleep 2 echo "" echo -e $cor "Adicionando ppa's ... \033[0m" sudo add-apt-repository -y ppa:webupd8team/java
echo "" sudo add-apt-repository -y ppa:sunab/kdenlive-release
echo "" sudo add-apt-repository -y ppa:ubuntuhandbook1/dvdstyler
echo "" sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
echo "" sudo add-apt-repository -y ppa:maarten-baert/simplescreenrecorder
echo "" sudo add-apt-repository -y ppa:webupd8team/sublime-text-3 echo "" sudo add-apt-repository -y ppa:ondrej/php
echo "" sudo add-apt-repository -y ppa:ravefinity-project/ppa
echo "" sudo apt-add-repository -y ppa:teejee2008/ppa
echo "" sudo add-apt-repository -y ppa:papirus/papirus
echo "" echo -e $cor "Executando update ... \033[0m" sudo apt-get update -y
echo "" echo -e $cor "Instalando programas ... \033[0m" echo "" echo -e $cor "... UTILITARIOS ... \033[0m" echo -e $corprg " java8 \033[0m" sudo apt-get install oracle-java8-installer -y
echo "" echo -e $corprg " ubuntu-restricted-extras \033[0m" sudo apt-get install ubuntu-restricted-extras libavcodec-extra -y
echo "" echo -e $corprg " openssh \033[0m" sudo apt-get install openssh-server -y
echo "" echo -e $corprg " virtualbox \033[0m" sudo apt-get install virtualbox -y
echo "" echo -e $corprg " wine \033[0m" sudo apt-get install wine -y
echo "" echo -e $corprg " playonlinux \033[0m" sudo apt-get install playonlinux -y
echo "" echo -e $corprg " gparted \033[0m" sudo apt-get install gparted -y
echo "" echo -e $corprg " rdesktop \033[0m" sudo apt-get install rdesktop -y
echo "" echo -e $corprg " remmina \033[0m" sudo apt-get install remmina remmina-plugin-rdp -y
echo "" echo -e $corprg " sshpass \033[0m" sudo apt-get install sshpass -y
echo "" echo -e $corprg " ufraw \033[0m" sudo apt-get install ufraw -y
echo "" echo -e $corprg " findimagedupes \033[0m" sudo apt-get install findimagedupes -y
echo "" echo -e $corprg " makepasswd \033[0m" sudo apt-get install makepasswd -y
echo "" echo -e $corprg " alien \033[0m" sudo apt-get install alien -y
echo "" echo -e $corprg " figlet \033[0m" sudo apt-get install figlet -y
echo "" echo -e $cor "... MULTIMEDIA ... \033[0m" echo -e $corprg " vlc \033[0m" sudo apt-get install vlc -y
echo "" echo -e $corprg " smplayer \033[0m" sudo apt-get install smplayer -y
echo "" echo -e $corprg " clementine \033[0m" sudo apt-get install clementine -y
echo "" echo -e $corprg " audacious \033[0m" sudo apt-get install audacious -y
echo "" echo -e $corprg " audacity \033[0m" sudo apt-get install audacity -y
echo "" echo -e $corprg " gimp \033[0m" sudo apt-get install gimp -y
echo "" echo -e $corprg " fotowall \033[0m" sudo apt-get install fotowall -y 
echo "" echo -e $corprg " kolourpaint4 \033[0m" sudo apt-get install kolourpaint4 -y
echo "" echo -e $corprg " shutter \033[0m" sudo apt-get install shutter -y
echo "" echo -e $corprg " kdenlive \033[0m" sudo apt-get install kdenlive -y
echo "" echo -e $corprg " simplescreenrecorder \033[0m" sudo apt-get install simplescreenrecorder -y
echo "" echo -e $corprg " cheese \033[0m" sudo apt-get install cheese -y
echo "" echo -e $corprg " brasero \033[0m" sudo apt-get install brasero -y
echo "" echo -e $corprg " xfburn \033[0m" sudo apt-get install xfburn -y
echo "" echo -e $corprg " handbrake \033[0m" sudo apt-get install handbrake -y
echo "" echo -e $corprg " selene \033[0m" sudo apt-get install selene -y
echo "" echo -e $corprg " dvdstyler \033[0m" sudo apt-get remove libwxsvg0 libwxsvg-dev -y
sudo apt-get install dvdstyler dvdstyler-data mjpegtools -y
echo "" echo -e $cor "... PROGRAMACAO ... \033[0m" echo -e $corprg " filezilla \033[0m" sudo apt-get install filezilla -y
echo "" echo -e $corprg " sublime-text \033[0m" sudo apt-get install sublime-text-installer -y
echo "" echo -e $corprg " apache2 \033[0m" sudo apt-get install apache2 -y
echo "" echo -e $corprg " mysql \033[0m" sudo apt-get install mysql-server -y
echo "" echo -e $corprg " php \033[0m" sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt php5-mysql php5-cli -y
sudo /etc/init.d/apache2 restart

echo -e $corprg " mysql-workbench \033[0m" sudo apt-get install mysql-workbench -y
echo "" echo -e $corprg " kompare \033[0m" sudo apt-get install kompare -y
echo "" echo -e $corprg " rapidsvn \033[0m" sudo apt-get install rapidsvn -y
echo "" echo -e $cor "... APARENCIA (ICONES E TEMAS) ... \033[0m" sudo apt-get install ambiance-blackout-flat-colors -y
sudo apt-get install papirus-icon-theme -y
echo "" echo -e $cor "INSTALAR MANUALMENTE: \033[0m" echo " - Google Chrome" echo " - Opera" echo " - Team Viewer" echo " - AnyDesk" echo " - Aker" echo " - Kernel 3.19 (p/ aker)" echo " - Netbeans" echo " - SQL Developer" echo " - Zoiper" echo " - Skype" echo " - Telegram" echo " - 4kdownloader" echo " - MS Office" echo " - SQL Plus" echo "" echo -e $corlogo "+-----------------------------------+" echo -e $corlogo "            ... FIM ...       \033[0m" echo -e $corlogo "+-----------------------------------+" echo ""
```

```
#!/usr/bin/env bash

# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------ CABEÇALHO -------------------------------------------------- #
## AUTOR: Edius Ferreira
# ---Created on Wed Feb 15 23:33:30 2023---
## EMAIL: ediusferreira@gmail.com
## GITHUB: edius1987
## NOME: Pós Instalação Ubuntu
## DESCRIÇÃO:
###			Script de pós instalação desenvolvido para base Ubuntu 22.04, 
###			baseado em meu uso pessoal dos programas, configurações e personalizações.
## LICENÇA: MIT License
## Copyright (c) 2023 Edius Ferreira
## VERSÂO: Beta - versão em estágio ainda de desenvolvimento
### Para utilizar baixe e use o comando "./Pos_Install_Ubuntu.sh".

# ------------------------------------------------------------------------------------------------------------- #
# -------------------------------------------- VARIÁVEIS E REQUISITOS ----------------------------------------- #

# Variávveis e links de download dinâmicos.
ppas=(appimagelauncher-team/stable teejee2008/foss)
url_flathub="https://flathub.org/repo/flathub.flatpakrepo"
url_nerd-fonts="https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf"
url_oh_my-bash="https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh"
url_MX="https://github.com/MX-Linux/mx-conky-data.git"
### Programas para instalação e desinstalação.
apps_remover=(	gnome-abrt 
	gnome-boxes
	gedit 
	gnome-clocks 
	gnome-connections 
	gnome-contacts 
	gnome-photos 
	gnome-software 
	gnome-text-editor 
	gnome-tour 
	libreoffice-* 
	usb-creator-gtk 
	totem 
	rhythmbox
	thunderbird
	yelp)

apps=(cheese
	wget
	net-tools
	conky-manager2
	curl
	synaptic
	appimagelauncher
	openssh-server
	fonts-powerline
	python3.11
	python3-pip
	obs-studio
	npm
	npx
	nodejs
	jupyter-notebook
	cowsay
	papirus-folders
	papirus-icon-theme 
	ffmpegthumbnailer 
	flameshot 
	fortune-mod 
	gnome-tweaks 
	fonts-croscore
	heroic-games-launcher-bin 
	hugo 
	lolcat 
	lutris 
	mangohud 
	neofetch 
	virt-manager 
	steam-installer
	steam-devices
	steam
	unrar-free)

flatpak=(com.github.GradienceTeam.Gradience 
	nl.hjdskes.gcolor3 
	org.gimp.GIMP 
	org.ksnip.ksnip
	com.github.johnfactotum.Foliate 
	org.libreoffice.LibreOffice 
	de.haeckerfelix.Fragments
	org.remmina.Remmina
	com.github.muriloventuroso.easyssh
	com.raggesilver.BlackBox
	com.github.xournalpp.xournalpp
	com.github.jeromerobert.pdfarranger
	ca.desrt.dconf-editor
	com.vixalien.sticky
	net.cozic.joplin_desktop
	org.kde.krita
	org.localsend.localsend_app
	com.github.maoschanz.drawing
	com.microsoft.Edge
	com.brave.Browser
	org.gnome.Lollypop
	org.telegram.desktop)

snaps=(spotify discord photogimp vlc atom slack teams-for-linux) 


# ------------------------------------------------------------------------------------------------------------- #
# --------------------------------------------------- TESTE --------------------------------------------------- #
### Check se a distribuição é a correta.
# Obter a versão do sistema
version=$(lsb_release -rs)

# Verificar se a versão é 22.04
if [ "$version" == "22.04" ]; then
    echo "O sistema está executando o Ubuntu 22.04. Iniciando instalação..."
else
    echo "Este script é compatível apenas com o Ubuntu 22.04."
    exit 1
fi

## Adicionando PPAs
echo 'Adicionando PPAs'
echo
for ppa in ${ppas[@]}; do
  apt-add-repository "ppa:"$ppa  -y
done

rm -rf /etc/apt/preferences.d/nosnap.pref
apt update


# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock


### Desinstalando apps desnecessários.
for nome_do_programa in "${apps_remover[@]}"; do
    sudo apt remove "$nome_do_programa" -y
done

### Atualizando sistema após adição de novos repositórios.
sudo apt upgrade -y

# Instalar programas no apt
for nome_do_programa in ${apps[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$apps" -y
  else
    echo "[INSTALADO] - $apps"
  fi
done

echo 'Instalando Snaps e Flatpaks'
snap install ${snaps[@]}
snap install --classic ${snaps_classic[@]}
flatpak remote-add --if-not-exists flathub ${url_flathub[@]}
flatpak install flathub -y ${flatpak[@]}

### Configurando Gnome.
echo 'Configurando GNOME'
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click  true
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true


### Configurando AppImages.
echo 'Configurando AppImages'
mkdir $HOME/Applications
mv *.AppImage $HOME/Applications
chmod 777 -r $HOME/Applications/

### Instalando PPA AppImageLauncher

wget "https://git.opendesktop.org/akiraohgaki/ocs-manager/uploads/d3dc42436b82d11360ebc96b38d4aaf4/ocs-manager-0.8.1-1-x86_64.AppImage"
chmod +x appimaged-x86_64.AppImage
./ocs-manager-0.8.1-1-x86_64.AppImage --install

echo 'Atualizando o sistema'
sudo apt dist-upgrade -y
sudo apt full-upgrade
sudo apt autoclean 

# ----------------------------- Personalização ----------------------------- #
if [ -d "$HOME/".local/share/fonts ]
then
	wget -cq --show-progress "$url_nerd-fonts" -P "$HOME"/.local/share/fonts
	fc-cache -f -v >/dev/null
else
	mkdir -p "$HOME"/.local/share/fonts
	wget -cq --show-progress "$url_nerd-fonts" -P "$HOME"/.local/share/fonts
	fc-cache -f -v >/dev/null
fi

# ----------------------------- Oh my bash! ----------------------------- #
echo 'Instalando Oh My Bash!'
bash -c "$(url_oh_my-bash)"
fc-cache -f -v >/dev/null

# ----------------------------- MX-Conky-Data ----------------------------- #
echo 'Instalando MX-Conky-Data'
git "$(url_MX)" ~/.conky
fc-cache -f -v >/dev/null

# ----------------------------- MComplementos ----------------------------- #

# conky-startup.sh
#
# conky.desktop
#

neofetch

echo
echo
echo "Instalação finalizada, é recomendado reiniciar o sistema."
echo "Até mais e boa trabalho!"
echo 
```

```
#!/usr/bin/env bash


# Colaboração:    Fernando Souza - https://www.youtube.com/@fernandosuporte/

clear

# -------------------------------------------------------------------------------------------------

# Verificar se os programas estão instalados:

which dpkg     1> /dev/null || exit 1
which apt      1> /dev/null || exit 2
which apt-key  1> /dev/null || exit 3
which wget     1> /dev/null || exit 4
which flatpak  1> /dev/null || exit 5
which snap     1> /dev/null || exit 6
which ping     1> /dev/null || exit 7

# -------------------------------------------------------------------------------------------------


echo "
Verificando o acesso à internet..."


ping -c 10 www.google.com.br  1> /dev/null 2> /dev/null


if [ "$?" -eq "0" ];
then 

      echo -e "\e[1;32m\n[VERIFICADO] - Conexão com à internet funcionando normalmente.\n\e[0m"

      sleep 30
else 

     echo -e "\e[1;31m\n[ERRO] - Seu sistema não tem conexão com à internet. Verifique os cabos e o modem.\n\e[0m"

     exit

fi
# -------------------------------------------------------------------------------------------------



# ----------------------------- VARIÁVEIS ----------------------------- #
PPA_LIBRATBAG="ppa:libratbag-piper/piper-libratbag-git"
PPA_LUTRIS="ppa:lutris-team/lutris"
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"

URL_WINE_KEY="https://dl.winehq.org/wine-builds/winehq.key"
URL_PPA_WINE="https://dl.winehq.org/wine-builds/ubuntu/"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.8.0/Simplenote-linux-1.8.0-amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"
URL_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.20.40428-bionic_amd64.deb"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
  snapd
  mint-meta-codecs
  winff
  guvcview
  virtualbox
  flameshot
  nemo-dropbox
  steam-installer
  steam-devices
  steam:i386
  ratbagd
  piper
  lutris
  libvulkan1
  libvulkan1:i386
  libgnutls30:i386
  libldap-2.4-2:i386
  libgpg-error0:i386
  libxml2:i386
  libasound2-plugins:i386
  libsdl2-2.0-0:i386
  libfreetype6:i386
  libdbus-1-3:i386
  libsqlite3-0:i386
)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt update -y

## Adicionando repositórios de terceiros e suporte a Snap (Driver Logitech, Lutris e Drivers Nvidia)##
sudo apt-add-repository "$PPA_LIBRATBAG" -y
sudo add-apt-repository "$PPA_LUTRIS" -y
sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
wget -nc "$URL_WINE_KEY"
sudo apt-key add winehq.key
sudo apt-add-repository "deb $URL_PPA_WINE bionic main"
# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_INSYNC"              -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

## Instalando pacotes Flatpak ##
flatpak install flathub com.obsproject.Studio -y

## Instalando pacotes Snap ##
sudo snap install spotify
sudo snap install slack --classic
sudo snap install skype --classic
sudo snap install photogimp
# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
```

```
#!/usr/bin/env bash
#
# pos-os-postinstall.sh - Instalar e configura programas no Pop!_OS (20.04 LTS ou superior)
#
# Website:       https://diolinux.com.br
# Autor:         Dionatan Simioni
#
# ------------------------------------------------------------------------ #
#
# COMO USAR?
#   $ ./pos-os-postinstall.sh
#
# ----------------------------- VARIÁVEIS ----------------------------- #
set -e

##URLS

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.20.0-1_amd64.deb?source=website"
URL_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.7.2.50318-impish_amd64.deb"
URL_SYNOLOGY_DRIVE="https://global.download.synology.com/download/Utility/SynologyDriveClient/3.0.3-12689/Ubuntu/Installer/x86_64/synology-drive-client-12689.x86_64.deb"


##DIRETÓRIOS E ARQUIVOS

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
FILE="/home/$USER/.config/gtk-3.0/bookmarks"


#CORES

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


#FUNÇÕES

# Atualizando repositório e fazendo atualização do sistema

apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

# -------------------------------------------------------------------------------- #
# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}

# ------------------------------------------------------------------------------ #


## Removendo travas eventuais do apt ##
travas_apt(){
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock
}

## Adicionando/Confirmando arquitetura de 32 bits ##
add_archi386(){
sudo dpkg --add-architecture i386
}
## Atualizando o repositório ##
just_apt_update(){
sudo apt update -y
}

##DEB SOFTWARES TO INSTALL

PROGRAMAS_PARA_INSTALAR=(
  snapd
  winff
  virtualbox
  ratbagd
  gparted
  timeshift
  gufw
  synaptic
  solaar
  vlc
  code
  gnome-sushi 
  folder-color
  git
  wget
  ubuntu-restricted-extras
  v4l2loopback-utils
 
)

# ---------------------------------------------------------------------- #

## Download e instalaçao de programas externos ##

install_debs(){

echo -e "${VERDE}[INFO] - Baixando pacotes .deb${SEM_COR}"

mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_INSYNC"              -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SYNOLOGY_DRIVE"      -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
echo -e "${VERDE}[INFO] - Instalando pacotes .deb baixados${SEM_COR}"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
echo -e "${VERDE}[INFO] - Instalando pacotes apt do repositório${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

}
## Instalando pacotes Flatpak ##
install_flatpaks(){

  echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${SEM_COR}"

flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub org.freedesktop.Piper -y
flatpak install flathub org.chromium.Chromium -y
flatpak install flathub org.gnome.Boxes -y
flatpak install flathub org.onlyoffice.desktopeditors -y
flatpak install flathub org.qbittorrent.qBittorrent -y
flatpak install flathub org.flameshot.Flameshot -y
flatpak install flathub org.electrum.electrum -y
}

## Instalando pacotes Snap ##

install_snaps(){

echo -e "${VERDE}[INFO] - Instalando pacotes snap${SEM_COR}"

sudo snap install authy

}


# -------------------------------------------------------------------------- #
# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #


## Finalização, atualização e limpeza##

system_clean(){

apt_update -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y
nautilus -q
}


# -------------------------------------------------------------------------- #
# ----------------------------- CONFIGS EXTRAS ----------------------------- #

#Cria pastas para produtividade no nautilus
extra_config(){


mkdir /home/$USER/TEMP
mkdir /home/$USER/EDITAR 
mkdir /home/$USER/Resolve
mkdir /home/$USER/AppImage
mkdir /home/$USER/Vídeos/'OBS Rec'

#Adiciona atalhos ao Nautilus

if test -f "$FILE"; then
    echo "$FILE já existe"
else
    echo "$FILE não existe, criando..."
    touch /home/$USER/.config/gkt-3.0/bookmarks
fi

echo "file:///home/$USER/EDITAR 🔵 EDITAR" >> $FILE
echo "file:///home/$USER/AppImage" >> $FILE
echo "file:///home/$USER/Resolve 🔴 Resolve" >> $FILE
echo "file:///home/$USER/TEMP 🕖 TEMP" >> $FILE
}

# -------------------------------------------------------------------------------- #
# -------------------------------EXECUÇÃO----------------------------------------- #

travas_apt
testes_internet
travas_apt
apt_update
travas_apt
add_archi386
just_apt_update
install_debs
install_flatpaks
install_snaps
extra_config
apt_update
system_clean

## finalização

  echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
```

```
#!/bin/bash

## Removendo travas eventuais do apt ##

sudo rm /var/lib/dpkg/lock-frontend ; sudo rm /var/cache/apt/archives/lock ;

## Atualizando o repositório ##

sudo apt update && 

## Instalando pacotes e programas do repositório deb do Ubuntu ##

sudo apt install python3 python-pip wine nautilus-dropbox docker docker-compose git build-essential libssl-dev flatpak gnome-software-plugin-flatpak -y &&

## Instalando pacotes Snap ##

sudo snap install slack --classic &&  
sudo snap install skype --classic &&  
sudo snap install code --classic &&  
sudo snap install --edge node --classic && 
sudo snap install insomnia &&  
sudo snap install spotify &&
sudo snap install wps-office-multilang && 

## Adicionando repositório Flathub ##

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && 

## Instalando Apps do Flathub ##

sudo flatpak install flathub com.obsproject.Studio -y &&
sudo flatpak install flathub com.sublimetext.three -y &&
sudo flatpak install flathub io.dbeaver.DBeaverCommunity -y &&
 

## Softwares que precisam de download externo ##

cd ~/Downloads/ && wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i *.deb && wget -c https://uploads.treeunfe.me/downloads/instalar-freenfe.exe &&

##Softwares alternativos Windows##

##GIMP e PhotoGIMP
flatpak install flathub org.gimp.GIMP -y && wget -c https://doc-0s-1g-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/0v83rmt4mij9897co9ufvor2r1jcj1am/1567965600000/07452089978596344616/*/12i-ihCDSZelx30-oNHJaKAzUei1etsbS?e=download && unzip 12i-ihCDSZelx30-oNHJaKAzUei1etsbS?e=download && cd "PHOTOGIMP V2018 - DIOLINUX" && cd "PATCH" && mkdir -p /home/$USER/.var/app/org.gimp.GIMP/config/GIMP/2.10/ && cp -R * /home/$USER/.var/app/org.gimp.GIMP/config/GIMP/2.10/ &&

## Wine softwares ###
## wget -c https://uploads.treeunfe.me/downloads/instalar-freenfe.exe

wine instalar-freenfe.exe ;

## Atualização do sistema ##

sudo apt update && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y &&

#Fim do Script ##

echo "Finalizado"
```

```
#!/bin/bash

clear
while true; do
echo -e "#############################################################
        \e[1;31mPROGRAM INSTALLATION SYSTEM\e[0m                     #
                                                                     #
        Enter the number of the program you want to install:         #
                                                                     #
        1 - Gnome Tweak Tool                                         # 
        2 - Utilitários de arquivo                                   #
        3 - Virtualbox                                               #
        4 - VLC player                                               #
        5 - Gimp                                                     #
        6 - Pinta                                                    # 
        7 - Brasero                                                  #
        8 - Google Chrome                                            #
        9 - Skype                                                    #
       10 - Blender                                                  #
       11 - Clean the system                                         #
       12 - Gparted                                                  #
       13 - Editor Dconf                                             # 
       14 - Audacity                                                 #
       15 - Install all programs                                     #
       0 - Exit                                                      #
######################################################################"

echo " "
echo -n "->OPTION:  "

read option

# checks if an option has been entered.
if [ -z $option ]; then
    echo ERROR: enter an option
    exit
fi

case $option in

    1)
   apt install gnome-tweak-tool -y;;
    2)
   sudo apt install unace rar unrar p7zip-rar p7zip sharutils uudeview mpack arj cabextract lzip lunzip plzip -y;;
    3)
   wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
   wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
   sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"
   sudo apt update
   sudo apt install virtualbox-6.0 -y;;
    4)
   sudo apt install vlc -y;;
    5)  
   sudo apt install gimp -y;;
    6)  
   sudo apt install pinta -y;;
    7)  
   sudo apt install brasero -y;;
    8) 
   wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
   sudo dpkg -i google-chrome-stable_current_amd64.deb
   ;;

    9) 
   echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skype-stable.list
   wget https://repo.skype.com/data/SKYPE-GPG-KEY
   sudo apt-key add SKYPE-GPG-KEY
   sudo apt install apt-transport-https
   sudo apt update
   sudo apt install skypeforlinux -y
   ;;
   10)  
   sudo apt update
   apt install blender -y
   ;;
   11)
   sudo apt clean
   sudo apt autoclean   
   sudo apt autoremove -y
   ;;
   12)
   sudo apt install gparted -y
   ;;
   13) 
   sudo apt install dconf-editor -y
   ;;
   14)  
   sudo apt install audacity -y
   ;;
   15)
   apt install unace rar unrar p7zip-rar p7zip sharutils uudeview mpack arj cabextract lzip lunzip plzip -y
   wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
   wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
   sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"
   sudo apt update
   sudo apt install virtualbox-6.0 -y
   apt install vlc gimp pinta brasero gnome-tweak-tool -y
   wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
   sudo dpkg -i google-chrome-stable_current_amd64.deb
   ;;
    0)  
   echo "" 
        echo Exiting the installation system ...
   sleep 3
        exit
   ;;
    *)
        echo
        echo ERROR: Incorrect option!
   echo ""
   echo "Try again!"
        echo 
   ;;
esac
done
```
