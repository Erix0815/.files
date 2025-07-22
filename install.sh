#!/bin/bash

# install deps
if ! command -v fastfetch > /dev/null; then
	sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
	sudo apt update
	sudo apt install fastfetch
fi
if ! command -v nala > /dev/null; then sudo apt install nala; fi
if ! command -v unzip > /dev/null; then sudo apt install unzip; fi

# install bitwarden-cli
if ! command -v bw > /dev/null; then
	tmpdir=$(mktemp -d)
	curl -L -o "$tmpdir/bw.zip" "https://vault.bitwarden.com/download/?app=cli&platform=linux"
	unzip "$tmpdir/bw.zip" -d "$tmpdir"
	sudo mv "$tmpdir/bw" /usr/local/bin/
	sudo chmod +x /usr/local/bin/bw
	rm -rf "$tmpdir"
fi

# install ssh-keypair (securely)
bw logout
SESSION=$(bw login --raw e.a.erath@gmail.com)
SESSION=$(bw unlock --raw --session $SESSION)
mkdir -p ~/.ssh
bw get notes main_ssh_public --raw --session $SESSION > ~/.ssh/id_ed25519.pub
bw get notes main_ssh_private --raw --session $SESSION > ~/.ssh/id_ed25519
ssh-keygen -p -f ~/.ssh/id_ed25519 -N $(bw get notes main_ssh_passphrase --raw --session $SESSION)
bw lock
chmod 600 ~/.ssh/id_ed25519*

# install dotfiles
cp -r .erxrc ~
cp .gitconfig ~
cp .nanorc ~
cat .bashrc >> ~/.bashrc
