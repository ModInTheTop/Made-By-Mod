if [[ $islem == 1 || $islem == 01 ]]; then
clear

sleep 5
pkg install git -y
pkg install python python3 -y
pkg install pip pip3 -y
pkg install curl -y
apt update
apt upgrade -y
clear
sleep 3
bash alhack.sh

elif [[ $islem == 2 || $islem == 02 ]]; then
clear
sleep 3
cd Tools
git clone https://github.com/htr-tech/zphisher
cd zphisher
bash zphisher.sh

elif [[ $islem == 3 || $islem == 03 ]]; then
clear
sleep 3
cd Tools
git clone https://github.com/techchipnet/CamPhish
cd CamPhish
bash camphish.sh

elif [[ $islem == 4 || $islem == 04 ]]; then
clear
sleep 3
git clone https://github.com/zidansec/subscan
cd subscan
./subscan $sc
       
elif [[ $islem == 5 || $islem == 05 ]]; then
clear
sleep 3
cd Tools
git clone https://github.com/juzeon/fast-mail-bomber.git
cd fast-mail-bomber/
mv config.example.php config.php
php index.php update-providers
rm -rf data/nodes.json data/dead_providers.json
sleep 4
php index.php update-nodes
php index.php refine-nodes
php index.php start-bombing $mail

elif [[ $islem == 6 || $islem == 06 ]]; then
clear
sleep 3
cd Tools
git clone https://github.com/palahsu/DDoS-Ripper.git
cd DDoS-Ripper
python3 DRipper.py

elif [[ $islem == 7 || $islem == 07 ]]; then
clear
sleep 3
cd Tools
sudo apt update -y
sudo apt install php nodejs npm adb scrcpy wget unzip apktool jq -y
git clone https://github.com/tegal1337/CiLocks
cd CiLocks
chmod +x cilocks
sudo bash cilocks
 
elif [[ $islem == 8 || $islem == 08 ]]; then
clear
sleep 3 
rm -rf Tools

bash Mod.sh

elif [[ $islem == 9 || $islem == 09 ]]; then
clear
sleep 3
cd Tools
apt update
apt install git curl
git clone https://github.com/htr-tech/track-ip.git
cd track-ip
bash trackip

elif [[ $islem == 10 || $islem == 010 ]]; then
clear
sleep 3
cd Tools
git clone https://github.com/BullsEye0/dorks-eye.git
cd dorks-eye
pip install -r requirements.txt
python3 dorks-eye.py

elif [[ $islem == 11 || $islem == 011 ]]; then
clear
sleep 3
cd Tools
apt update && apt upgrade && apt install git && apt install python2
git clone https://github.com/jaykali/hackerpro.git
cd hackerpro
sudo bash install.sh
python2 hackerpro.py

elif [[ $islem == 12 || $islem == 012 ]]; then
clear
sleep 3
cd Tools
git clone https://github.com/Tuhinshubhra/RED_HAWK
cd RED_HAWK
php rhawk.php

elif [[ $islem == 13 || $islem == 013 ]]; then
clear
sleep 3
cd Tools
git clone https://github.com/Devil-Tigers/TigerVirus
apt update
apt upgrade -y
pkg install git -y
cd TigerVirus
bash app.sh

elif [[ $islem == 14 || $islem == 014 ]]; then
clear
sleep 3
cd Tools
pkg install curl -y
upgrade -y
pkg install git -y
git clone https://github.com/king-hacking/info-site.git
cd info-site
bash info.sh

elif [[ $islem == 15 || $islem == 015 ]]; then
clear
sleep 3
cd Tools
sudo apt-get update
sudo apt-get install php
sudo apt-get install php-curl
git clone https://github.com/MrSqar-Ye/BadMod.git
cd BadMod
chmod u+x INSTALL
chmod u+x BadMod.php
sudo php BadMod.php

elif [[ $islem == 16 || $islem == 016 ]]; then
clear
sleep 3
cd Tools
git clone https://github.com/fu8uk1/facebash
cd facebash
bash install.sh
chmod +x facebash.sh
tor
sudo ./facebash.sh

elif [[ $islem == 17 || $islem == 017 ]]; then
clear
sleep 3
cd Tools
pkg install git
pkg install python2
apt install git
apt install python2
git clone https://github.com/D4RK-4RMY/DARKARMY
cd DARKARMY
chmod +x darkarmy.py
python2 darkarmy.py

elif [[ $islem == 18 || $islem == 018 ]]; then
clear
sleep 3
cd Tools
sudo apt-get install tor
pip3 install requests
git clone https://github.com/FDX100/Auto_Tor_IP_changer.git
cd Auto_Tor_IP_changer
sleep 8
python3 install.py
aut

else   
	clear
        echo -e '\033[36;40;1m Keni futur kodin e gabuar'	
	sleep 1
	clear 
	bash Mod.sh
fi
