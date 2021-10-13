#!/bin/bash
# iao-initialize-directories
# This is an OCD attempt to give order to the primary user's home directory hierarchy.
# This is meant for my own system, which mounts /home on an HDD and root on SSD.

BOLD=$(tput bold)
RESET=$(tput sgr0)

### Script Configuration
#PRIMARY_USER="miles"
#USER_DIR="${HOME}"
#FAST_DIR="/iao"

echo "${BOLD}Primary User's Name:${RESET}"
read PRIMARY_USER # Your primary user's name.

echo "${BOLD}User Home Directory:${RESET} (Full Path)"
read USER_DIR # Wherever a primary user's home directory is.

echo "${BOLD}Fast Storage Directory:${RESET} (Full Path)"
read FAST_DIR # Somewhere on your fastest storage drive.

### Confirmation Prompt
echo "${BOLD}Primary User:${RESET} ${PRIMARY_USER}"
echo "${BOLD}User Home Directory:${RESET} ${USER_DIR}"
echo "${BOLD}Fast Storage Directory:${RESET} ${FAST_DIR}"
echo "${BOLD}Commence setup?${RESET} (y/n)"
read CONFIRMATION_INPUT; [ "${CONFIRMATION_INPUT,,}" = "y" ] && echo "Proceeding..." || exit

# Primary User
echo "${BOLD}Evaluating Primary User${RESET}"
if getent passwd "${PRIMARY_USER}" >/dev/null; then
	echo "User ${PRIMARY_USER} exists."
else
	echo "User ${PRIMARY_USER} doesn't exist."
	echo "${BOLD}Create user?${RESET} (y/n)"
	read USER_CREATION_INPUT; [ "${USER_CREATION_INPUT,,}" = "y" ] && sudo useradd -m ${PRIMARY_USER} || exit
fi

# FAST_DIR
echo "${BOLD}Creating Fast Storage Directory${RESET}"
sudo mkdir -pv "${FAST_DIR}"
echo "${BOLD}Changing Fast Storage Directory Ownership to User${RESET}"
sudo chown -v ${PRIMARY_USER} "${FAST_DIR}"

# Configuration
echo "${BOLD}Cloning and Creating Configuration Directories for User${RESET}"
git clone https://github.com/miaoles/iao-linux-config.git "${USER_DIR}/Configuration"
git clone https://github.com/miaoles/iao-NixOS-home.git "${USER_DIR}/Configuration/nixpkgs"
mkdir -pv "${USER_DIR}/Configuration/Themes"
mkdir -pv "${USER_DIR}/Configuration/Fonts"
mkdir -pv "${USER_DIR}/Configuration/Icons"
mkdir -pv "${USER_DIR}/Configuration/Templates"
mkdir -pv "${USER_DIR}/Configuration/Mozilla"
echo "${BOLD}Linking Configuration Directory Corrections${RESET}"
ln -sv "${USER_DIR}/Configuration" "${USER_DIR}/.config"
ln -sv "${USER_DIR}/Configuration/Themes" "${USER_DIR}/.themes"
ln -sv "${USER_DIR}/Configuration/Fonts" "${USER_DIR}/.fonts"
ln -sv "${USER_DIR}/Configuration/Icons" "${USER_DIR}/.icons"
ln -sv "${USER_DIR}/Configuration/Icons" "${USER_DIR}/.local/share/icons"
ln -sv "${USER_DIR}/Configuration/Mozilla" "${USER_DIR}/.mozilla"
#ln -sv "${USER_DIR}/Configuration/bash/bashrc" "${USER_DIR}/.bashrc"
ln -sv "${USER_DIR}/Configuration/bash/bash_profile" "${USER_DIR}/.bash_profile"
ln -sv "${USER_DIR}/Configuration/gtk-2.0/gtkrc-2.0" "${USER_DIR}/.gtkrc-2.0"
ln -sv "${USER_DIR}/Configuration/xinit/xinitrc" "${USER_DIR}/.xinitrc"
ln -sv "${USER_DIR}/Configuration/Xorg/Xdefaults" "${USER_DIR}/.Xdefaults"
ln -sv "${USER_DIR}/Configuration/Xorg/Xresources" "${USER_DIR}/.Xresources"

# Development
echo "${BOLD}Creating Development Directories for User${RESET}"
mkdir -pv "${USER_DIR}/Development"

# Documents
echo "${BOLD}Creating Documents Directories for User${RESET}"
mkdir -pv "${USER_DIR}/Documents"

# Executables
echo "${BOLD}Cloning Executables Directories in Fast Storage${RESET}"
git clone https://github.com/miaoles/iao-linux-executables.git "${FAST_DIR}/Executables"
echo "${BOLD}Linking Executables Directories for User${RESET}"
ln -sv "${FAST_DIR}/Executables" "${USER_DIR}/Executables"
echo "${BOLD}Linking Executables Directory Corrections${RESET}"
ln -sv "${FAST_DIR}/Executables" "${USER_DIR}/.local/bin"

# Games
echo "${BOLD}Creating Games Directories in Fast Storage${RESET}"
mkdir -pv "${FAST_DIR}/Games"
mkdir -pv "${FAST_DIR}/Steam Library"
mkdir -pv "${FAST_DIR}/Heroic Library"
echo "${BOLD}Linking Games Directories for User${RESET}"
ln -sv "${FAST_DIR}/Games" "${USER_DIR}/Games"

# Images
echo "${BOLD}Creating Images Directories for User${RESET}"
mkdir -pv "${USER_DIR}/Images"
mkdir -pv "${USER_DIR}/Images/Screenshots"
mkdir -pv "${USER_DIR}/Images/Wallpapers"

# Sounds
echo "${BOLD}Creating Sounds Directories for User${RESET}"
mkdir -pv "${USER_DIR}/Sounds"

# Transfers
echo "${BOLD}Creating Transfers Directories for User${RESET}"
mkdir -pv "${USER_DIR}/Transfers"
mkdir -pv "${USER_DIR}/Transfers/Torrents"
mkdir -pv "${USER_DIR}/Transfers/Soulseek"
mkdir -pv "${USER_DIR}/Transfers/Share"
mkdir -pv "${USER_DIR}/Transfers/Downloads"
mkdir -pv "${USER_DIR}/Transfers/Downloads/Archives"
mkdir -pv "${USER_DIR}/Transfers/Downloads/Documents"
mkdir -pv "${USER_DIR}/Transfers/Downloads/Executables"
mkdir -pv "${USER_DIR}/Transfers/Downloads/Images"
mkdir -pv "${USER_DIR}/Transfers/Downloads/Sounds"
mkdir -pv "${USER_DIR}/Transfers/Downloads/Videos"

# Videos
echo "${BOLD}Creating Videos Directories for User${RESET}"
mkdir -pv "${USER_DIR}/Videos"
mkdir -pv "${USER_DIR}/Videos/Recordings"

# Virtual
echo "${BOLD}Creating Virtual Directories in Fast Storage${RESET}"
mkdir -pv "${FAST_DIR}/Virtual"
mkdir -pv "${FAST_DIR}/Virtual/VirtualBox"
mkdir -pv "${FAST_DIR}/Virtual/Proton Prefixes"
mkdir -pv "${FAST_DIR}/Virtual/Wine Prefixes"
mkdir -pv "${FAST_DIR}/Virtual/Wine Prefixes/Default"
echo "${BOLD}Linking Virtual Directories Corrections${RESET}"
ln -sv "${FAST_DIR}/Virtual" "${USER_DIR}/Virtual"
ln -sv "${USER_DIR}/Virtual/Wine Prefixes/Default" "${USER_DIR}/.wine"
