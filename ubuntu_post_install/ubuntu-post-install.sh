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
print_green "\nStarting UBUNTU post-install script.\n"
#Set idle time to 60 minutes so script does not stop 
gsettings set org.gnome.desktop.session idle-delay 3600


System Update and Upgrade
sudo apt update
sudo apt install --fix-missing -y
sudo apt upgrade --allow-downgrades -y
sudo apt full-upgrade --allow-downgrades -y

# System Clean Up
sudo apt install -f
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean -y


sudo apt install -y ubuntu-restricted-extras
sudo apt-get install -y tlp tlp-rdw
sudo tlp start 
sudo apt install gnome-tweak-tool -y
sudo apt install -y gnome-shell-extensions





sudo add-apt-repository ppa:apt-fast/stable 
sudo apt-get update
sudo apt-get install -y apt-fast 



sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo apt install -y curl neofetch terminator cmatrix gnome-tweaks tree ssh vim git

###############################
####Custom Apps ####
###############################
#install code
sudo apt-get install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

sudo apt install -y apt-transport-https 
sudo apt update
sudo apt install code # or code-insiders

sudo apt-get install -y dotnet-sdk-8.0
sudo apt-get install -y aspnetcore-runtime-8.0

sudo apt-get install -y dotnet-sdk-6.0
sudo apt-get install -y aspnetcore-runtime-6.0


#install brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install -y brave-browser


#install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install libappindicator3-1 libgbm1 libindicator3-7 libu2f-udev -y
sudo dpkg -i google-chrome-stable_current_amd64.deb 

sudo apt update
sudo apt install snapd -y
sudo snap install bitwarden -y
sudo snap install mailspring -y
sudo snap install nextcloud -y



sudo apt install -y python3-pip


curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install -y spotify-client


sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update && sudo apt install -y ulauncher

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
t
sudo apt update && sudo apt install -y sublime-text

sudo apt install vlc -y

sudo apt install wget -y
wget https://updates.getmailspring.com/download?platform=linuxDeb -O mailspring.deb
sudo apt install -y ./mailspring.deb


wget https://github.com/federico-terzi/espanso/releases/download/v2.2.1/espanso-debian-wayland-amd64.deb
sudo apt install -y ./espanso-debian-wayland-amd64.deb


sudo apt-get install nodejs -y
sudo apt install npm -y





#todo put to install zsh
chmod +x zsh-install.sh
wait
./zsh-install.sh


########################
####Install personal things ####
########################
print_green "\nInstalling personal things\n"


##configure environment
git config --global user.name "MozartFalcao"
git config --global user.email mozart.falcao@outlook.com




cd ~/

mkdir wks .temp .themes
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




###################################
####Final update for the system####
###################################
print_green "\n Final update for the system \n"
sudo apt update
sudo apt install --fix-missing -y
sudo apt upgrade --allow-downgrades -y
sudo apt full-upgrade --allow-downgrades -y
sudo apt-get autoclean -y



##############
####Finish####
##############
print_green "#########################################"
print_green "##                                     ##"
print_green "##  Script has finished please reboot  ##"
print_green "##                                     ##"
print_green "#########################################"

print_green "rebooting... "
sleep 3
reboot
