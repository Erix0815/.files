#!/bin/bash

# install fastfetch
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt install fastfetch

# install nala
sudo apt install nala

# install ssh-keypair (securely)
mkdir -p ~/.ssh
echo "$SSH_PUBLIC_KEY" > ~/.ssh/id_ed25519.pub
echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519
ssh-keyscan github.com >> ~/.ssh/known_hosts

# install dotfiles
cp .erxrc ~
cp .gitconfig ~
cp .nanorc ~
cat .bashrc >> ~/.bashrc
