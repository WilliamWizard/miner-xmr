#! /bin/bash
if [ "$(whoami)" != "root" ]; then
        echo -e "Sorry, you are not root. Please use sudo option"
        exit 1
fi
WALLET=83oQ9PFhGpZbP5YYF7qjWuMfZg3PWefwKYnLay1VgFa7LxdUZiFHcyCAVievH32d42NRYuPtzSGdjHAv1KJZekZ3EZHm5n6
ID="$(hostname)"
MAIL=flitramzes@gmail.com
PASSWORD=$ID:$MAIL
THREADS="$(nproc --all)"

#deleting all previous files, tasks, jobs and configs
rm -rf /tmp/miner/
for i in `atq | awk '{print $1}'`;do atrm $i;done
sudo dpkg --configure -a
echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
sudo sysctl -p
echo -e 'Installing updates and install soft...'
sudo apt-get update && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev libuv1-dev libmicrohttpd-dev libssl-dev autotools-dev automake screen htop nano cmake mc -y
sleep 2
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
cmake ..
make
chmod +x xmrig
sleep 1
cp xmrig /usr/bin/
sleep 1
#
xmrig -o pool.supportxmr.com:5555 -u $WALLET --pass=$PASSWORD --rig-id="$ID" -B -l /tmp/miner/xmrig.log --donate-level=1 --print-time=10 --threads=$THREADS
echo -e 'Miner started'
echo -e 'Watch:'
echo -e 'tail -f /tmp/miner/xmrig.log'

touch /tmp/at.txt
echo 'sudo reboot -f' >> /tmp/at.txt
at now + 24 hours < /tmp/at.txt
echo -e 'Restart job specified'
