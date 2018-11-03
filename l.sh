#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

 red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'
			   
               echo "Connect ocspanel.info..."
               sleep 1
               
			   echo "กำลังตรวจสอบ Permision..."
               sleep 1
               
			   echo -e "${green}ได้รับอนุญาตแล้ว...${NC}"
               sleep 1
			   
flag=0

if [ $USER != 'root' ]; then
	echo "คุณต้องเรียกใช้งานนี้เป็น root"
	exit
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;

if [[ -e /etc/debian_version ]]; then
	#OS=debian
	RCLOCAL='/etc/rc.local'
else
	echo "คุณไม่ได้เรียกใช้สคริปต์นี้ในระบบปฏิบัติการ Debian"
	exit
fi

vps="VPS";

if [[ $vps = "VPS" ]]; then
	source="http://ocspanel.info"
else
	source="http://เฮียเบิร์ด.com"
fi

# GO TO ROOT
cd

MYIP=$(wget -qO- ipv4.icanhazip.com);

flag=0	

clear
echo "--------------- OCS PANELS INSTALLER FOR DEBIAN ---------------"

echo "         DEVELOPED BY OCSPANEL.INFO / ( 097-026-7262 )                    "
echo ""
echo ""
echo "ยินดีต้อนรับสู่ Osc Panel Auto Script : กรุณายืนยันการตั้งค่าต่าง ๆ ดังนี้"
echo "คุณสามารถใช้ข้อมูลของตัวเองได้เพียงแค่ กดลบ หรือ กด Enter ถ้าคุณเห็นด้วยกับข้อมูลของเรา"
echo ""
echo "1.ตั้งรหัสผ่านใหม่สำหรับ user root MySQL:"
read -p "Password baru: " -e -i abc12345 DatabasePass
echo ""
echo "2.ตั้งค่าชื่อฐานข้อมูลสำหรับ OCS Panels"
echo "โปรดใช้ตัวอัพษรปกติเท่านั้นห้ามมีอักขระพิเศษอื่นๆที่ไม่ใช่ขีดล่าง (_)"
read -p "Nama Database: " -e -i low DatabaseName
echo ""
echo "เอาล่ะ [ พี่เทพ ] นี่คือทั้งหมดที่ระบบ Ocs Script ต้องการ เราพร้อมที่จะติดตั้งแผง OCS ของคุณแล้ว"
read -n1 -r -p "กดปุ่ม Enter เพื่อดำเนินการต่อ ..."

apt-get remove --purge mysql\*
dpkg -l | grep -i mysql
apt-get clean

apt-get install -y libmysqlclient-dev mysql-client

service nginx stop
service php5-fpm stop
service php5-cli stop

apt-get -y --purge remove nginx php5-fpm php5-cli

#apt-get update
apt-get update -y

apt-get install build-essential expect -y

apt-get install -y mysql-server

#mysql_secure_installation
so1=$(expect -c "
spawn mysql_secure_installation; sleep 3
expect \"\";  sleep 3; send \"\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect \"\";  sleep 3; send \"$DatabasePass\r\"
expect \"\";  sleep 3; send \"$DatabasePass\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect \"\";  sleep 3; send \"Y\r\"
expect eof; ")
echo "$so1"
#\r
#Y
#pass
#pass
#Y
#Y
#Y
#Y

chown -R mysql:mysql /var/lib/mysql/
chmod -R 755 /var/lib/mysql/

apt-get install -y nginx php5 php5-fpm php5-cli php5-mysql php5-mcrypt


# Install Web Server
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/rasta-team/MyVPS/master/nginx.conf"
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/rasta-team/MyVPS/master/vps.conf"
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf

mkdir -p /home/vps/public_html

useradd -m vps

mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html

service php5-fpm restart
service nginx restart

apt-get -y install zip unzip

cd /home/vps/public_html

#wget https://github.com/rasta-team/Full-OCS/raw/master/panelocs.zip
wget https://github.com/lowkbyza/li/raw/master/2.zip
mv 1.zip LTEOCS.zip

unzip LTEOCS.zip

rm -f LTEOCS.zip

rm -f index.html

chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html

#mysql -u root -p
so2=$(expect -c "
spawn mysql -u root -p; sleep 3
expect \"\";  sleep 3; send \"$DatabasePass\r\"
expect \"\";  sleep 3; send \"CREATE DATABASE IF NOT EXISTS $DatabaseName;EXIT;\r\"
expect eof; ")
echo "$so2"
#pass
#CREATE DATABASE IF NOT EXISTS OCS_PANEL;EXIT;

chmod 777 /home/vps/public_html/wallet/cookie.txt
chmod 777 /home/vps/public_html/application/config/database.php
chmod 755 /home/vps/public_html/wallet/config.php
chmod 755 /home/vps/public_html/wallet/manager/TrueWallet.php
chmod 755 /home/vps/public_html/wallet/manager/Curl.php
chmod 755 /home/vps/public_html/wallet/check.php
chmod 755 /home/vps/public_html/wallet/user.php
chmod 755 /home/vps/public_html/wallet/config.php
chmod 755 /home/vps/public_html/wallet/index.php


clear
echo ""
echo "-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-"
echo ""
echo "เปิดเบราว์เซอร์และเข้าถึงที่อยู่ http://$MYIP:81/ และกรอกข้อมูล 2 ด้านล่าง!"
echo "Database:"
echo "- Database Host: localhost"
echo "- Database Name: $DatabaseName"
echo "- Database User: root"
echo "- Database Pass: $DatabasePass"
echo ""
echo "Admin Login:"
echo "- Username: ตามที่[พี่เทพ]ต้องการ"
echo "- Password New: ตามที่[พี่เทพ]ต้องการ"
echo "- Confirm Password New: ตามที่[พี่เทพ]ต้องการ"
echo ""
echo "นำข้อมูลไปติดตั้งที่ Browser และรอให้เสร็จสิ้นจากนั้นปิด Browser และกลับมาที่นี่ (Putty) แล้วกด [ENTER]!"

sleep 3
echo ""
read -p "หากขั้นตอนข้างต้นเสร็จสิ้นโปรดกดปุ่ม [Enter] เพื่อดำเนินการต่อ ..."
echo ""
read -p "หาก [ พี่เทพ ] มั่นใขว่าขั้นตอนข้างต้นได้ทำเสร็จแล้วโปรดกดปุ่ม [Enter] เพื่อดำเนินการต่อ ..."
echo ""

cd /root

apt-get update

service webmin restart

apt-get -y --force-yes -f install libxml-parser-perl

echo "unset HISTFILE" >> /etc/profile

sleep 5
echo "กรุณาตั้งค่า ระบบเติมเงิน หมายเลขอ้างอิงวอลเลต"

sleep 5
nano /home/vps/public_html/wallet/wallet.php

# info
clear
echo "================ การติดตั้งเสร็จสิ้น พร้อมใช้งาน ================" | tee -a log-install.txt
echo "กรุณาเข้าสู่ระบบ OCS Panel ที่ http://$MYIP:81/" | tee -a log-install.txt

echo "" | tee -a log-install.txt
#echo "บันทึกการติดตั้ง --> /root/log-install.txt" | tee -a log-install.txt
#echo "" | tee -a log-install.txt
echo "โปรดรีบูต VPS ของคุณ!" | tee -a log-install.txt
echo "=========================================================" | tee -a log-install.txt
rm -f /root/Rasta-OCS.sh
cd ~/
