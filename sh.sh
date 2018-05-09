#! /bin/bash
if [ "$(whoami)" != "root" ]; then
	echo -e "\033[0;31mSorry, you are not root. Please use sudo option\033[0m"
	exit 1
fi
echo -e '\033[0;32m##### Installing updates and install soft...\033[0m'
sudo apt-get update && sudo apt-get install tmux mc git libpcre16-3 screen -y && wget https://minergate.com/download/deb-cli -O minergate-cli.deb && sudo dpkg -i minergate-cli.deb
