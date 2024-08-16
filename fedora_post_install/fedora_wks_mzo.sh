#!/bin/sh


#Functions to look cool
print_green() {
	echo -e "\e[1;30;42m$1\e[0m"
}

print_blue() {
	echo -e "\e[1;30;44m$1\e[0m"
}




# Configure dnf (In order: automatically select fastest mirror, parallel downloads, and disable telemetry)
# fastestmirror=1
printf "%s" "
max_parallel_downloads=10
countme=false
" | sudo tee -a /etc/dnf/dnf.conf

clear
# Prompt Bluetooth
#echo "Do you want bluetooth? [y/n]"
#read -r bluetooth

# Setup RPMFusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
sudo dnf groupupdate core -y


# echo 'Make sure your system has been fully-updated by running "sudo dnf upgrade -y" and reboot it once.'
sudo dnf upgrade -y

#Setting umask to 077
# No one except wheel user and root get read/write files
umask 077
sudo sed -i 's/umask 022/umask 077/g' /etc/bashrc

# Debloat
sudo dnf remove -y anaconda* \
	# Extra Firmware
	zd1211-firmware atmel-firmware libertas-usb8388-firmware abrt* anthy-unicode avahi bluez-cups brasero-libs trousers alsa-sof-firmware boost-date-time yelp orca fedora-bookmarks fedora-chromium-config mailcap open-vm-tools samba-client unbound-libs podman yajl mediawriter nano nano-default-editor sane* perl* thermald NetworkManager-ssh sos kpartx dos2unix sssd cyrus-sasl-plain geolite2* traceroute gnome-themes-extra ModemManager tcpdump mozilla-filesystem nmap-ncat spice-vdagent eog gnome-text-editorevince cheese gnome-classic-session baobab gnome-calculator gnome-characters gnome-system-monitor gnome-font-viewer gnome-font-viewer simple-scan evince-djvu gnome-tour gnome-shell-extension* gnome-weather gnome-boxes gnome-clocks gnome-contacts gnome-tour gnome-logs gnome-remote-desktop totem gnome-calendar gnome-shell-extension-background-logo gnome-maps gnome-backgrounds gnome-software gnome-connections gnome-user-docs gnome-color-manager perl-IO-Socket-SSL adcli mtr realmd teamd vpnc openconnect openvpn ppp pptp qgnomeplatform rsync xorg-x11-drv-vmware hyperv* virtualbox-guest-additions qemu-guest-agent 

# Run Updates
sudo dnf autoremove -y
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates -y
sudo fwupdmgr update -y

# # Configure GNOME
# gsettings set org.gnome.desktop.a11y always-show-universal-access-status true
# #gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
# gsettings set org.gnome.desktop.interface clock-show-weekday true
# gsettings set org.gnome.desktop.interface clock-show-seconds true
# gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# Setup Flathub beta and third party packages
sudo fedora-third-party enable
sudo fedora-third-party refresh
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

sudo dnf install -y flatpak
sudo dnf install -y snapd 
sudo ln -s /var/lib/snapd/snap /snap
sudo dnf install -y wget 



# Install things I need, top is uncategorized
echo "Iniciating all apps installation..."
print_green "\n Iniciating all apps installation...\n"

flatpak install -y flathub 
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.spotify.Client




echo "flatpak foi agora os brabo começa..."
print_green "\n flatpak foi agora os brabo começa....\n"


#BRAVE
sudo dnf install dnf-plugins-core -y

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo -y

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf install brave-browser -y

echo "brave foi..."


#Chrome
sudo dnf install -y fedora-workstation-repositories 

sudo dnf config-manager --set-enabled google-chrome -y

sudo dnf install google-chrome-stable -y

sudo dnf install gnome-tweaks -y

sudo snap install bitwarden -y
sudo snap install mailspring -y
sudo snap install nextcloud-desktop-client -y

sudo dnf install vlc -y
sudo dnf install ffmpeg-free -y

flatpak install flathub org.mozilla.Thunderbird


#VsCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

dnf check-update -y
sudo dnf install code -y
sudo dnf install dotnet-sdk-8.0 -y
sudo dnf install aspnetcore-runtime-8.0 -y
sudo dnf install dotnet-sdk-6.0 -y
sudo dnf install aspnetcore-runtime-6.0 -y

sudo dnf install -y nodejs npm
sudo npm install -g nvm
sudo npm install -g n 
sudo npm install -g n 
sudo npm install -g @angular/cli  

ng version 
sudo yum install -y terminator

sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo


print_green "\n install zsh...\n"
curl -fsSL https://raw.githubusercontent.com/MozartFalcao/fed_post_scripts/develop/fedora_post_install/zsh-install.sh | sudo bash

sudo dnf autoremove -y


print_green "\n now some internal configs...\n"


# Initialize virtualization
# sudo sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
# sudo sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf
# sudo systemctl enable libvirtd
# sudo usermod -aG libvirt "$(whoami)"

# Cockpit is still missing some core functionality, but will switch when it is added.
#sudo systemctl enable cockpit.socket --now

# Harden the Kernel with Kicksecure's patches
# Disables CD ROMs, FireWire, default writes, various kernel flags.
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/modprobe.d/30_security-misc.conf -o /etc/modprobe.d/30_security-misc.conf
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/sysctl.d/30_security-misc.conf -o /etc/sysctl.d/30_security-misc.conf
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/sysctl.d/30_silent-kernel-printk.conf -o /etc/sysctl.d/30_silent-kernel-printk.conf

# Enable Kicksecure CPU mitigations
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/default/grub.d/40_cpu_mitigations.cfg -o /etc/grub.d/40_cpu_mitigations.cfg
# Kicksecure's CPU distrust script
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/default/grub.d/40_distrust_cpu.cfg -o /etc/grub.d/40_distrust_cpu.cfg
# Enable Kicksecure's IOMMU patch (limits DMA)
sudo curl https://raw.githubusercontent.com/Kicksecure/security-misc/master/etc/default/grub.d/40_enable_iommu.cfg -o /etc/grub.d/40_enable_iommu.cfg

# Divested's brace patches
# Sandbox the brace systemd permissions
# If you have VPN issues: https://old.reddit.com/r/DivestOS/comments/12b4fk4/comment/jex4qt2/
sudo mkdir -p /etc/systemd/system/NetworkManager.service.d
sudo curl https://gitlab.com/divested/brace/-/raw/master/brace/usr/lib/systemd/system/NetworkManager.service.d/99-brace.conf -o /etc/systemd/system/NetworkManager.service.d/99-brace.conf
sudo mkdir -p /etc/systemd/system/irqbalance.service.d
sudo curl https://gitlab.com/divested/brace/-/raw/master/brace/usr/lib/systemd/system/irqbalance.service.d/99-brace.conf -o /etc/systemd/system/irqbalance.service.d/99-brace.conf

# GrapheneOS's ssh limits
# caps the system usage of sshd
sudo mkdir -p /etc/systemd/system/sshd.service.d
sudo curl https://raw.githubusercontent.com/GrapheneOS/infrastructure/main/systemd/system/sshd.service.d/local.conf -o /etc/systemd/system/sshd.service.d/local.conf
# echo "GSSAPIAuthentication no" | sudo tee /etc/ssh/ssh_config.d/10-custom.conf
# echo "VerifyHostKeyDNS yes" | sudo tee -a /etc/ssh/ssh_config.d/10-custom.conf

# NTS instead of NTP
# NTS is a more secured version of NTP
sudo curl https://raw.githubusercontent.com/GrapheneOS/infrastructure/main/chrony.conf -o /etc/chrony.conf

# Whonix Machine ID
echo "b08dfa6083e7567a1921a715000001fb" | sudo tee /etc/machine-id

# Remove Firewalld's Default Rules
sudo firewall-cmd --permanent --remove-port=1025-65535/udp
sudo firewall-cmd --permanent --remove-port=1025-65535/tcp
sudo firewall-cmd --permanent --remove-service=mdns
sudo firewall-cmd --permanent --remove-service=ssh
sudo firewall-cmd --permanent --remove-service=samba-client
sudo firewall-cmd --reload

#Randomize MAC address and disable static hostname. This could be used to track general network activity.
sudo bash -c 'cat > /etc/NetworkManager/conf.d/00-macrandomize.conf' <<-'EOF'
[main]
hostname-mode=none

[device]
wifi.scan-rand-mac-address=yes

[connection]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
EOF

sudo systemctl restart NetworkManager
sudo hostnamectl hostname "localhost"

# Disable Bluetooth
# or renable it!
# case "$bluetooth" in
# 	y|Y)
# 		sudo sed -i 's,install bluetooth /bin/disabled-bluetooth-by-security-misc,#install bluetooth /bin/disabled-bluetooth-by-security-misc,g' /etc/modprobe.d/30_security-misc.conf
# 		sudo sed -i 's,install btusb /bin/disabled-bluetooth-by-security-misc,#install btusb /bin/disabled-bluetooth-by-security-misc,g' /etc/modprobe.d/30_security-misc.conf
# 		;;
# 	*)
# 		echo "Disabling Bluetooth..."
# 		sudo systemctl disable bluetooth
# esac
 
# Enable DNSSEC
# causes severe network instability, but working on getting this up and running
# sudo sed -i s/#DNSSEC=no/DNSSEC=yes/g /etc/systemd/resolved.conf
# sudo systemctl restart systemd-resolved

# Make the Home folder private
# Privatizing the home folder creates problems with virt-manager
# accessing ISOs from your home directory. Store images in /var/lib/libvirt/images
chmod 700 /home/"$(whoami)"
# is reset using:
#chmod 755 /home/"$(whoami)"
#
# In Wine, Easy AntiCheat requires Wine to use ptrace as a standard user.
# Kicksecure limits this to root, but the workaround in this file is not comprehensive.
sudo sed -i 's,kernel.yama.ptrace_scope=2,#kernel.yama.ptrace_scope=2,g' /etc/sysctl.d/30_security-misc.conf


########################
####Install personal things ####
########################
print_green "\nInstalling personal things\n"

cd "$HOME/Downloads" || return
wget https://github.com/dracula/gtk/archive/master.zip

mkdir "$HOME/.themes" || return
unzip master.zip -d "$HOME/.themes" 

gsettings set org.gnome.desktop.interface gtk-theme "Dracula" || return
gsettings set org.gnome.desktop.wm.preferences theme "Dracula" || return

git clone https://github.com/bikass/kora.git "$HOME/.icons"


##configure environment
git config --global user.name "MozartFalcao"
git config --global user.email mozart.falcao@outlook.com


cd "$HOME" || return
mkdir wks .temp .themes
cd "wks" || return
mkdir repos labs studies projects works scripts
cd "repos" || return
git clone https://github.com/MozartFalcao/scripts.git
git clone https://github.com/MozartFalcao/fed_post_scripts.git
git clone https://github.com/bikass/kora.git "$HOME"/.local/share/icons/

cd "$HOME" || return

sudo dnf upgrade -y
sudo dnf autoremove -y

print "The configuration is now complete...."
