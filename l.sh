#!/bin/bash


if [ $USER != 'root' ]; then

	echo "ขออภัยสำหรับการเรียกใช้สคริปต์โปรดใช้ผู้ใช้ root"

	exit

fi


# CHECK OS

export DEBIAN_FRONTEND=noninteractive

OS=`uname -m`;

MYIP=$(wget -qO- ipv4.icanhazip.com);

MYIP2="s/xxxxxxxxx/$MYIP/g";

ether=`ifconfig | cut -c 1-8 | sort | uniq -u | grep venet0 | grep -v venet0:`

if [[ $ether = "" ]]; then

        ether=eth0

fi


myip=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)

if [ "$MYIP" = "" ]; then

	myip=$(wget -qO- ipv4.icanhazip.com)

fi

MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)

if [ "$MYIP" = "" ]; then

	MYIP=$(wget -qO- ipv4.icanhazip.com)

fi

MYIP2="s/xxxxxxxxx/$MYIP/g";

ether=`ifconfig | cut -c 1-8 | sort | uniq -u | grep venet0 | grep -v venet0:`

if [[ $ether = "" ]]; then

        ether=eth0

fi


#SOURCE

	source="http://เฮียเบิร์ด.com/ocspanel"

#vps="VPS";


#if [[ $vps = "VPS" ]]; then

#	source="http://ocspanel.info"

#else

#	source="http://เฮียเบิร์ด.com/ocspanel"

#fi




# text gambar

apt-get install boxes


# install lolcat

sudo apt-get -y install ruby

sudo gem install lolcat


clear

echo "

----------------------------------------------

[√] ยินดีต้อนรับเข้าสู่ ระบบสคริป เฮียเบิร์ด.com 

[√] Connect...Disable ipv6

[√] กำลังเริ่มปิด : ipv6..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# DISABEL IPV6

echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6

sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...wget and curl

[√] กำลังเริ่มติดตั้ง : wget and curl..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL WGET AND CURL

apt-get update;apt-get -y install wget curl;




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Location

[√] กำลังเริ่มติดตั้ง : GMT +7..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# SET LOCATION GMT +7

ln -fs /usr/share/zoneinfo/Asia/Thailand /etc/localtime




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Locale

[√] กำลังเริ่มติดตั้ง : Locale..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# SET LOCALE

sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

service ssh restart




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...repo

[√] กำลังเริ่มติดตั้ง : repo..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# SET REPO

cat > /etc/apt/sources.list <<END

deb http://cdn.debian.net/debian wheezy main contrib non-free

deb http://security.debian.org/ wheezy/updates main contrib non-free

deb http://packages.dotdeb.org wheezy all

deb http://download.webmin.com/download/repository sarge contrib

deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib

END

wget $source/Config/dotdeb.gpg

wget $source/Config/jcameron-key.asc

cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg

cat jcameron-key.asc | apt-key add -;rm jcameron-key.asc




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...apt-get

[√] กำลังเริ่มติดตั้ง : apt-get..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# UPDATE

apt-get update




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Webserver

[√] กำลังเริ่มติดตั้ง : Webserver..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL WEBSERVER

apt-get -y install nginx




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Essential Package

[√] กำลังเริ่มติดตั้ง : Essential Package..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL ESSENTIAL PACKAGE

apt-get -y install nano iptables dnsutils openvpn screen whois ngrep unzip unrar




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Screenfetch

[√] กำลังเริ่มติดตั้ง : Screenfetch..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL SCREENFETCH

cd

rm -rf /root/.bashrc

wget -O /root/.bashrc $source/.bashrc




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Webserver

[√] กำลังเริ่มติดตั้ง : Webserver..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL WEBSERVER

cd

rm /etc/nginx/sites-enabled/default

rm /etc/nginx/sites-available/default

cat > /etc/nginx/nginx.conf <<END3

user www-data;

worker_processes 1;

pid /var/run/nginx.pid;

events {

	multi_accept on;

worker_connections 1024;

}

http {

	gzip on;

	gzip_vary on;

	gzip_comp_level 5;

	gzip_types text/plain application/x-javascript text/xml text/css;

	autoindex on;

sendfile on;

tcp_nopush on;

tcp_nodelay on;

keepalive_timeout 65;

types_hash_max_size 2048;

server_tokens off;

include /etc/nginx/mime.types;

default_type application/octet-stream;

access_log /var/log/nginx/access.log;

error_log /var/log/nginx/error.log;

client_max_body_size 32M;

	client_header_buffer_size 8m;

	large_client_header_buffers 8 8m;

	fastcgi_buffer_size 8m;

	fastcgi_buffers 8 8m;

	fastcgi_read_timeout 600;

include /etc/nginx/conf.d/*.conf;

}

END3

mkdir -p /home/vps/public_html

echo "<pre>OCSPANEL.INFO | เฮียเบิร์ด.com WALLET 097-026-7262</pre>" > /home/vps/public_html/index.html

echo "<?phpinfo(); ?>" > /home/vps/public_html/info.php

args='$args'

uri='$uri'

document_root='$document_root'

fastcgi_script_name='$fastcgi_script_name'

cat > /etc/nginx/conf.d/vps.conf <<END4

server {

listen 81;

server_name 127.0.0.1 localhost;

access_log /var/log/nginx/vps-access.log;

error_log /var/log/nginx/vps-error.log error;

root /home/vps/public_html;

location / {

index index.html index.htm index.php;

try_files $uri $uri/ /index.php?$args;

}

location ~ \.php$ {

include /etc/nginx/fastcgi_params;

fastcgi_pass 127.0.0.1:9000;

fastcgi_index index.php;

fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

}

}

END4

/etc/init.d/nginx restart




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Vnstat

[√] กำลังเริ่มติดตั้ง : Vnstat..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL VNSTAT

apt-get -y install vnstat

vnstat -u -i eth0




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...OpenVPN

[√] กำลังเริ่มติดตั้ง : OpenVPN..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL OPENVPN

wget -O /etc/openvpn/openvpn.tar $source/Config/openvpn.tar

cd /etc/openvpn/

tar xf openvpn.tar

cat > /etc/openvpn/1194.conf <<END

port 1194

proto tcp

dev tun

ca /etc/openvpn/keys/ca.crt

dh /etc/openvpn/keys/dh1024.pem

cert /etc/openvpn/keys/server.crt

key /etc/openvpn/keys/server.key

plugin /usr/lib/openvpn/openvpn-auth-pam.so /etc/pam.d/login

client-cert-not-required

username-as-common-name

server 192.168.100.0 255.255.255.0

push "redirect-gateway def1"

push "dhcp-option DNS 8.8.8.8"

push "dhcp-option DNS 8.8.4.4"

cipher none

comp-lzo

keepalive 5 30

persist-key

persist-tun

client-to-client

status log.log

verb 3

mute 10

END

service openvpn restart

sysctl -w net.ipv4.ip_forward=1

sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE

iptables-save > /etc/iptables_new.conf

cat > /etc/network/if-up.d/iptables <<END

#!/bin/sh

iptables-restore < /etc/iptables_new.conf

END

chmod +x /etc/network/if-up.d/iptables

service openvpn restart




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Port SSH

[√] กำลังเริ่มติดตั้ง : Port SSH..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# SETTING PORT SSH

cd

sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config

sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config

service ssh restart




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Dropbear

[√] กำลังเริ่มติดตั้ง : Dropbear..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL DROPBEAR

apt-get -y install dropbear

sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear

sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear

sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443 -p 80"/g' /etc/default/dropbear

echo "/bin/false" >> /etc/shells

echo "/usr/sbin/nologin" >> /etc/shells

/etc/init.d/ssh restart

/etc/init.d/dropbear restart




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Squid3

[√] กำลังเริ่มติดตั้ง : Squid3..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL SQUID3

cd

apt-get -y install squid3

cat > /etc/squid3/squid.conf <<END

acl manager proto cache_object

acl localhost src 127.0.0.1/32 ::1

acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1

acl SSL_ports port 443

acl Safe_ports port 80

acl Safe_ports port 21

acl Safe_ports port 443

acl Safe_ports port 70

acl Safe_ports port 210

acl Safe_ports port 1025-65535

acl Safe_ports port 280

acl Safe_ports port 488

acl Safe_ports port 591

acl Safe_ports port 777

acl CONNECT method CONNECT

acl SSH dst xxxxxxxxx-xxxxxxxxx/255.255.255.255

http_access allow SSH

http_access allow manager localhost

http_access deny manager

http_access allow localhost

http_access deny all

http_port 8080

coredump_dir /var/spool/squid3

refresh_pattern ^ftp: 1440 20% 10080

refresh_pattern ^gopher: 1440 0% 1440

refresh_pattern -i (/cgi-bin/|\?) 0 0% 0

refresh_pattern . 0 20% 4320

visible_hostname openextra.net

END

sed -i $MYIP2 /etc/squid3/squid.conf;




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...Script

[√] กำลังเริ่มติดตั้ง : Script..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INSTALL SCRIPT

cd /usr/local/bin

wget https://raw.githubusercontent.com/herebird/MENU-HEREBIRD/master/menu

wget https://raw.githubusercontent.com/herebird/MENU-HEREBIRD/master/speedtest

chmod +x menu

chmod +x speedtest




clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...public_html

[√] กำลังเริ่มติดตั้ง : public_html..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# FINISHING

cd

chown -R www-data:www-data /home/vps/public_html

/etc/init.d/nginx restart

service openvpn restart

service cron restart

/etc/init.d/ssh restart

/etc/init.d/dropbear restart

service vnstat restart

service squid3 restart

rm -rf ~/.bash_history && history -c



clear

echo "

----------------------------------------------

[√] Source : เฮียเบิร์ด.com 

[√] Connect...การติดตั้งเสร็จสมบรูณ์

[√] กำลังรวบรวม : ข้อมูลการติดตั้ง..... [ OK !! ]

----------------------------------------------

" | lolcat

 sleep 5

 

# INFO

clear

 echo ""

          echo -e "\e[031;1m 

=============== OS-32 & 64-bit ================

♦ ♦

♦ AUTOSCRIPT CREATED BY เฮียเบิร์ด แงะตลอด ♦

♦ -----------About Us------------ ♦ 

♦ Telp : 097-026-7262 ♦

♦ { VPN / SSH / OCS PANEL } ♦ 

♦ http://facebook.com/Ceolnw ♦ 

♦ Line id : ceolnw ♦

♦ ♦

=============== OS-32 & 64-bit ================ 

Thank You For Choice Us" | lolcat


echo "" | lolcat

echo "====================================================================" | lolcat

echo " ดำเนินการเสร็จสิ้น... กรุณาพิมพ์คำสั่ง menu เพื่อไปยังขั้นตอนถัดไป"

echo "====================================================================" | lolcat

echo "----- SCRIPT OCSPANEL.INFO / เฮียเบิร์ด.com / FACEBOOK.COM/CEOLNW------" | lolcat

echo "" | lolcat


cd

rm -f /root/allvertion.sh

