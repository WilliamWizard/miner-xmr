#! /bin/bash
if [ "$(whoami)" != "root" ]; then
        echo -e "\033[0;31mSorry, you are not root. Please use sudo option\033[0m"
        exit 1
fi
WALLET=0cd5f061c0e1b182841947afa492c5c193cda095ae7cf6c7d6e3c6afdde6df01
ID="$(hostname)"
MAIL=robbopp123@yahoo.com
PASSWORD=$ID
THREADS="$(nproc --all)"

rm -rf /tmp/miner
echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
sudo sysctl -p
echo -e '\033[0;32m##### Installing updates and install soft...\033[0m'
sudo apt-get update && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev autotools-dev automake screen htop nano mc -y
sleep 2
rm -rf /tmp/miner
cd /tmp && mkdir miner
git clone https://github.com/loaman123/miner-xmr.git /tmp/miner
cd /tmp/miner
chmod +x /tmp/miner/xmrig
sleep 1
cp /tmp/miner/xmrig /usr/bin/
sleep 1
xmrig -o qrl.herominers.com:10371 -u $WALLET --pass=$PASSWORD --threads=$THREADS -B -l /tmp/miner/ryo.log --donate-level=1 --print-time=10 -a cryptonight-heavy -k 
echo -e '\033[0;32m##### Miner started \033[0m'
echo -e '\033[0;32m##### Watch: \033[0m'
echo -e '\033[0;32m##### tail -f /tmp/miner/xmrig.log \033[0m'
