#!/bin/bash
# Install with 
#
# curl https://raw.githubusercontent.com/lelandbatey/configDebDev/link-based-install/autoinstall.sh | sh

sudo apt-get update
sudo apt-get -y install git make htop python-pip

# Change the default login shell to bash
sudo chsh -s $(which bash) $(echo $USER)

sudo pip install virtualenv

if [ ! -d "$HOME/bin" ]; then
	mkdir "$HOME/bin"
fi

if [ ! -d "$HOME/bin/venv" ]; then
	virtualenv "$HOME/bin/venv"
fi


# Installs all parts of my dotfiles repository
cd ~
git clone "https://github.com/lelandbatey/configDebDev.git"
cd configDebDev

python install.py --act safe
#python install.py --act prepvim
#python install.py --act bashmarks
