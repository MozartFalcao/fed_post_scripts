#!/bin/bash

################################################################################
# Pop!_OS postinstall script. Compatible with ubuntu and ubuntu based distros. #
# Tested only in 20.04 64-bit systems                                          #
# Author: napuh (@napuh_) (github.com/napuh)                                   #
# Feel free to modify the code and send pull requests :D                       #
################################################################################

#Functions to look cool
function print_green {
	echo -e "\e[1;30;42m$1\e[0m"
}

function print_blue {
	echo -e "\e[1;30;44m$1\e[0m"
}

#Starting script
print_green "\nStarting Pop!_OS post-install script.\n"
#Set idle time to 60 minutes so script does not stop 
gsettings set org.gnome.desktop.session idle-delay 3600


# System Update and Upgrade
sudo apt update
sudo apt install --fix-missing -y
sudo apt upgrade --allow-downgrades -y
sudo apt full-upgrade --allow-downgrades -y

# System Backup
## sudo apt-add-repository ppa:teejee2008/ppa -y
## sudo apt update
## sudo apt install -y timeshift

# System Clean Up
sudo apt install -f
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean

########################
####Install packages####
########################
print_green "\nInstalling basic packages\n"

#Update and upgrade packages
print_blue "\nUpdating packages\n"
sudo apt-get -qq update -y >> /dev/null
sudo apt-get -qq upgrade -y >> /dev/null

#Install basic dependencies and tools
print_blue "\nInstalling basic dependencies and tools\n"
sudo add-apt-repository multiverse >> /dev/null
print_blue "\nInstalling ubuntu restricted extras. You may need to accept the EULA of the microsoft fonts\n"
sudo apt-get -qq install -y ubuntu-restricted-extras
print_blue "\nInstalling other basic tools\n"
sudo apt-get -qq install -y \
	curl \
	neofetch \
	screenfetch \
	vlc \
	zip \
	unzip \
	rar \
	gcc \
	make \
	build-essential \		
	python3 \
	python3-pip \
	cmake \
	git \
	npm \
    terminator \
    thunderbird \
    cmatrix \
    gnome-tweak-tool

#Install apt packages
print_blue "\nInstall apt packages\n"
sudo apt-get install -qq -y \	
	gnome-tweaks \	
	software-properties-common \	
	nmap \
	gparted \	
	transmission \
	tree \
	ssh \
	aptitude \
	vim

#Install sublime text
print_blue "\nInstalling sublime text\n"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt -qq install -y apt-transport-https 
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update >> /dev/null
sudo apt -qq install -y sublime-text 

#Install snap
print_blue "\nInstall snap\n"
sudo apt-get -qq install -y snapd 

#Install snap packages
print_blue "\nInstall snap packages\n"
snap install spotify

#Install docker
print_blue "\nInstalling docker\n"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo apt-get -qq install -y docker-ce docker-ce-cli containerd.io 
sudo apt-get install docker-compose
rm get-docker.sh

#############################
####Update everything new####
#############################
print_green "\nUpdating everything\n"
sudo apt-get -qq update -y >> /dev/null
sudo apt-get -qq upgrade -y >> /dev/null

######################
####Install extras####
######################
print_green "\nInstalling extras\n"

#auto-editor
print_blue "\nInstall auto-editor\n"
sudo apt-get install -y libavformat-dev libavfilter-dev libavdevice-dev ffmpeg
pip3 install --upgrade pip
pip3 install auto-editor

#cositas para la bateria
print_blue "\nInstall tlp\n"
sudo apt-get install -y tlp tlp-rdw 

#install tldr
print_blue "\nInstall tldr\n"
pip install tldr

#install thefuck
print_blue "\nInstall thefuck\n"
sudo apt-get install -y python3-dev python3-pip python3-setuptools 
sudo pip3 install thefuck

#add to ~/.bashrc new settings and alias
# cat ./resources/nap_bash_settings >> ~/.bashrc
# source ~/.bashrc

#Apply fixes to ubuntu USB transfer
echo vm.dirty_bytes=50331648 | sudo tee -a /etc/sysctl.conf
echo vm.dirty_background_bytes=16777216 | sudo tee -a /etc/sysctl.conf


## Instalando pacotes Flatpak ##
#flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.kde.okular -y

## Instalando pacotes Snap ##
sudo snap install skype --classic
sudo snap install telegram-desktop
sudo snap install signal-desktop
sudo snap install postman
sudo snap install mailspring
sudo snap install wps-office-multilang
sudo snap install p3x-onenote
sudo snap install ao

###############################
####Custom Apps ####
###############################
#install code
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders

sudo apt-get install -y dotnet-sdk-8.0
sudo apt-get install -y aspnetcore-runtime-8.0

sudo apt-get install -y dotnet-sdk-6.0
sudo apt-get install -y aspnetcore-runtime-6.0


#install brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser


#install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 

sudo apt install libappindicator3-1 libgbm1 libindicator3-7 libu2f-udev

sudo dpkg -i google-chrome-stable_current_amd64.deb 


#install espanso
wget https://github.com/federico-terzi/espanso/releases/download/v2.2.1/espanso-debian-wayland-amd64.deb

sudo apt install ./espanso-debian-wayland-amd64.deb

#oh my zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#nextcloud client desktop 
sudo add-apt-repository ppa:nextcloud-devs/client -y

sudo add-apt-repository ppa:nextcloud-devs/client-alpha -y

sudo apt update

sudo apt install nextcloud-desktop

###############################
####Customize gnome desktop####
###############################

print_green "\nCustimizing gnome desktop\n"
sudo apt-get -qq install -y gnome-tweaks 

#Restore some gnome settings
print_blue "\nRestoring some gnome settings\n"
dconf load /org/gnome/ < ./resources/nap_gnome_settings

# Time and Gnome Top Bar settings
print_blue "\nAdjusting time settings\n"
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.datetime automatic-timezone true
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-format '24h'

# #Apply nordic-darker theme
# print_blue "\nSetting Nordic-darker theme\n"
# mkdir ~/.themes
# cp -r ./resources/Nordic-darker ~/.themes
# gsettings set org.gnome.desktop.interface gtk-theme 'Nordic-darker'
# gsettings set org.gnome.desktop.interface icon-theme 'Pop'

# #Set wallpapers
# print_blue "\nSetting wallpaper\n"
# cp ./resources/nap-wallpaper.jpg ~/.themes
# gsettings set org.gnome.desktop.background picture-uri ~/.themes/nap-wallpaper.jpg
# gsettings set org.gnome.desktop.screensaver picture-uri ~/.themes/nap-wallpaper.jpg

# #Enable maximize button
# print_blue "\nEnable maximize button\n"
# gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# #Set keyboard layouts
# print_blue "\nSetting keyboard layouts\n"
# gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'us+intl')]"

# #Set tap to click on
# print_blue "\nSetting tap to click on\n"
# gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# #Set natural scroll true
# print_blue "\nSet natural-scroll true\n"
# gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true

# #Set idle time to 15 minutes
# print_blue "\nSetting idle time to 15 minutes\n"
# gsettings set org.gnome.desktop.session idle-delay 900

# #Set lockscreen time to 15 minutes
# print_blue "\nSetting lock screen time to 5 minutes\n"
# gsettings set org.gnome.desktop.screensaver lock-delay 300

# #Set the correct theme for the terminal
# print_blue "\nSetting the correct theme for the terminal\n"
# dconf load /org/gnome/terminal/legacy/profiles:/:84b4775b-f78b-4e72-955b-fa81e77344be/ < ./resources/nap_terminal_theme

# #Install dash to dock manually
# print_blue "\nInstall manually dash to dock\n"
# firefox https://extensions.gnome.org/extension/307/dash-to-dock/




#Install user themes extensions
print_blue "\nInstall user themes extension\n"
firefox https://extensions.gnome.org/extension/19/user-themes/


#install dracula theme
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip ~/.themes/

gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"


git clone https://github.com/dracula/zsh.git

ln -s $DRACULA_THEME/dracula.zsh-theme $OH_MY_ZSH/themes/dracula.zsh-theme


###################################
####Install Fonts ####
###################################


declare -a fonts=(
    BitstreamVeraSansMono
    CodeNewRoman
    DroidSansMono
    FiraCode
    FiraMono
    Go-Mono
    Hack
    Hermit
    JetBrainsMono
    Meslo
    Noto
    Overpass
    ProggyClean
    RobotoMono
    SourceCodePro
    SpaceMono
    Ubuntu
    UbuntuMono
)

version='2.1.0'
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

fc-cache -fv








###################################
####Final update for the system####
###################################
print_green "\n Final update for the system \n"
sudo apt update
sudo apt install --fix-missing -y
sudo apt upgrade --allow-downgrades -y
sudo apt full-upgrade --allow-downgrades -y


## sudo npm install -g npm@latest
sudo apt-get -qq update -y >> /dev/null
sudo apt-get -qq upgrade -y >> /dev/null
sudo apt-get autoremove -y --purge >> /dev/null
sudo apt-get autoclean -y >> /dev/null


##configure environment
git config --global user.name "MozartFalcao"
git config --global user.email mozart.falcao@outlook.com


cd ~/
mkdir wks .temp
cd wks
mkdir repos labs studies projects works scripts
cd repos
git clone https://github.com/MozartFalcao/scripts.git
git clone https://github.com/MozartFalcao/fed_post_scripts.git
git clone https://github.com/bikass/kora.git $HOME/.local/share/icons/

cd ~/



# Register espanso as a systemd service (required only once)
espanso service register

# Start espanso
espanso start





##############
####Finish####
##############
print_green "#########################################"
print_green "##                                     ##"
print_green "##  Script has finished please reboot  ##"
print_green "##                                     ##"
print_green "#########################################"