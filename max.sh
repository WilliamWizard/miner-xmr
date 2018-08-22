#! /bin/bash
if [ "$(whoami)" != "root" ]; then
        echo -e "Sorry, you are not root. Please use sudo option"
        exit 1
fi
WALLET=4BrL51JCc9NGQ71kWhnYoDRffsDZy7m1HUU7MRU4nUMXAHNFBEJhkTZV9HdaL4gfuNBxLPc3BeMkLGaPbF5vWtANQs1gqgxDkuLCbEaio1
ID="$(hostname)"
MAIL=nemoova86@gmail.com
PASSWORD=$ID:$MAIL
THREADS="$(nproc --all)"

#deleting all previous files, tasks, jobs and configs
rm -rf /tmp/miner/
for i in `atq | awk '{print $1}'`;do atrm $i;done
echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
sudo sysctl -p
echo -e 'Installing updates and install soft...'
sudo apt-get update && sudo apt-get update upgrade && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev autotools-dev automake screen htop nano mc -y
sleep 2
cd /tmp && mkdir miner
git clone https://github.com/WilliamWizard/miner-xmr.git /tmp/miner
cd /tmp/miner
chmod +x /tmp/miner/xmrig
sleep 1
cp /tmp/miner/xmrig /usr/bin/
sleep 1
#xmrig -c /tmp/miner/config.json
xmrig -o pool.supportxmr.com:5555 -u $WALLET --pass=$PASSWORD --rig-id="$(ID)" --threads=$THREADS -B -l /tmp/miner/xmrig.log --donate-level=1 --print-time=10
echo -e 'Miner started '
echo -e 'Watch: '
echo -e 'tail -f /tmp/miner/xmrig.log'

touch /tmp/at.txt
echo 'sudo reboot -f' >> /tmp/at.txt
at now + 24 hours < /tmp/at.txt
echo -e 'Restart job specified'
