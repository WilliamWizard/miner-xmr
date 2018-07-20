#! /bin/bash
if [ "$(whoami)" != "root" ]; then
	echo -e "\033[0;31mSorry, you are not root. Please use sudo option\033[0m"
	exit 1
fi
echo -e '\033[0;32m##### Installing updates and install soft...\033[0m'
sudo apt-get update && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev autotools-dev automake screen htop -y
sleep 2
git clone https://github.com/hyc/cpuminer-multi && cd cpuminer-multi
sleep 1
./autogen.sh
sleep 1
CFLAGS="-march=native" ./configure
sleep 1
make && make install
sleep 1
cp minerd /usr/bin/
sleep 1
screen -dmS miner bash -c 'minerd -a cryptonight -o stratum+tcp://xmr.pool.minergate.com:45700 -u mattgradon@gmail.com -p x'
echo -e '\033[0;32m##### Start miner on screen (to attach use [screen -x miner])...\033[0m'
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "@reboot screen -dmS miner bash -c 'minerd -a cryptonight -o stratum+tcp://xmr.pool.minergate.com:45700 -u mattgradon@gmail.com -p x'" >> mycron
#install new cron file
crontab mycron
rm mycron
