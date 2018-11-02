#!/bin/bash
# Created by http://www.เฮียเบิร์ด.com
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo "Connecting to script.เฮียเบิร์ด.com..."
sleep 0.2
echo "Checking Permision..."
sleep 0.3
# GO TO ROOT
MYIP=$(wget -qO- ipv4.icanhazip.com);
myip=$(wget -qO- ipv4.icanhazip.com);

flag=0
	
#iplist="ip.txt"

wget --quiet -O iplist.txt https://raw.githubusercontent.com/lowkbyza/li/master/iplist.txt

#if [ -f iplist ]
#then

iplist="iplist.txt"

lines=`cat $iplist`
#echo $lines

for line in $lines; do
#        echo "$line"
        if [ "$line" = "$myip" ];
        then
                flag=1
        fi

done

if [ $flag -eq 0 ]
then
   echo  "ขออภัยเฉพาะ IP @ Password ที่ลงทะเบียนเท่านั้นที่สามารถใช้สคริปต์นี้ได้!
ติดต่อ: HERE BIRD (097-026-7262) Facebook : m.me/ceolnw" | lolcat
	exit 1
sleep 1
clear
fi
MYIP=$(wget -qO- ipv4.icanhazip.com)
if [ $MYIP = "" ]; then
   MYIP=`ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1`;
fi

echo "Autoscript Include:" | tee log-install.txt
echo "=======================================================" | tee -a log-install.txt
echo "Service :" | tee -a log-install.txt
echo "---------" | tee -a log-install.txt
echo "Timezone       : Thailand Bangkok (GMT +7)" | tee -a log-install.txt
echo "Fail2Ban       : [on]" | tee -a log-install.txt
echo "(D)DoS Deflate : [on]" | tee -a log-install.txt
echo "Block Torrent  : [off]" | tee -a log-install.txt
echo "IPv6           : [off]" | tee -a log-install.txt
echo "OpenSSH  : 22, 143" | tee -a log-install.txt
echo "Dropbear : 443, 110, 109" | tee -a log-install.txt
echo "Squid3   : 8000, 8080, 3128 (limit to IP $MYIP)" | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (client config : http://$MYIP/client.ovpn)" | tee -a log-install.txt
echo "badvpn   : badvpn-udpgw port 7300" | tee -a log-install.txt
echo "PPTP VPN : TCP 1723" | tee -a log-install.txt
echo "nginx    : 80" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "Tools :" | tee -a log-install.txt
echo "-------" | tee -a log-install.txt
echo "axel, bmon, htop, iftop, mtr, rkhunter, nethogs: nethogs $ether" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "Script :" | tee -a log-install.txt
echo "--------" | tee -a log-install.txt
#echo "screenfetch" | tee -a log-install.txt
echo " พิมพ์ menu (คำสั่งในเมนูแบบคร่าวๆ) :" | tee -a log-install.txt
echo "  - สร้างบัญชี SSH/OpenVPN (user-add)" | tee -a log-install.txt
echo "  - สร้างบัญชีแบบสุ่ม SSH/OpenVPN (user-gen)" | tee -a log-install.txt
echo "  - Ganti Password Akun SSH/OpenVPN (user-pass)" | tee -a log-install.txt
echo "  - Tambah Masa Aktif Akun SSH/OpenVPN (user-renew)" | tee -a log-install.txt
echo "  - ลบบัญชี SSH/OpenVPN (user-del)" | tee -a log-install.txt
echo "  - สร้างบัญชี PPTP VPN (user-add-pptp)" | tee -a log-install.txt
echo "  - Monitoring Dropbear (dropmon)" | tee -a log-install.txt
echo "  - เช็คบัญชี Login Dropbear, OpenSSH, PPTP VPN, OpenVPN (user-login)" | tee -a log-install.txt
echo "  - Kill Multi Login Manual (1-2 Login) (user-limit)" | tee -a log-install.txt
echo "  - AutoKill Multi Login (2-3 Login) (autokill)" | tee -a log-install.txt
echo "  - เช็คบัญชีทั้งหมดพร้อมวันหมดอายุ (user-list)" | tee -a log-install.txt
echo "  - บัญชีที่ online ตอนนี้ (user-active-list)" | tee -a log-install.txt
echo "  - บัญชีที่หมดอายุแล้ว (user-expire-list)" | tee -a log-install.txt
echo "  - Disable Akun Expire (disable-user-expire)" | tee -a log-install.txt
echo "  - ลบบัญชีที่หมดอายุแล้ว (delete-user-expire)" | tee -a log-install.txt
echo "  - แบนบัญชีที่ผิดกฏ (banned-user)" | tee -a log-install.txt
echo "  - Restart Dropbear (service dropbear restart)" | tee -a log-install.txt
echo "  - Memory Usage (ps-mem)" | tee -a log-install.txt
echo "  - Speedtest (speedtest --share)" | tee -a log-install.txt
echo "  - Benchmark (benchmark)" | tee -a log-install.txt
echo "  - Restart Webmin (service webmin restart)" | tee -a log-install.txt
echo "  - Edit Banner SSH Login (Dropbear/OpenSSH) (banner)" | tee -a log-install.txt
echo "  - Edit Port (edit-port)" | tee -a log-install.txt
echo "  - Update Script (update)" | tee -a log-install.txt
echo "  - Reboot Server (reboot)" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "Fitur lain :" | tee -a log-install.txt
echo "------------" | tee -a log-install.txt
echo "Webmin         : http://$MYIP:10000/" | tee -a log-install.txt
echo "vnstat         : http://$MYIP/vnstat/ (เช็ค Bandwith)" | tee -a log-install.txt
echo "MRTG           : http://$MYIP/mrtg/" | tee -a log-install.txt
#echo "Autolimit 2 bitvise per IP to all port (port 22, 143, 109, 110, 443, 1194, 7300 TCP/UDP)" | tee -a log-install.txt
echo "ล็อค บัญชีที่หมดอายุอัตโนมัติตอน 00:00 น." | tee -a log-install.txt
echo "Reboot Server Auto 00:00 และ 12:00" | tee -a log-install.txt
echo "" | tee -a log-install.txt

if [[ $vps = "zvur" ]]; then
	echo "FUCO YOU" | tee -a log-install.txt
	echo "https://www.เฮียเบิร์ด.com" | tee -a log-install.txt
else
	echo "FACEBOOK GROUP" | tee -a log-install.txt
	echo "https://www.facebook.com/ceolnw" | tee -a log-install.txt
fi

echo "เรายังมีสคลิป อื่นๆ อีกมากมาย สนใจติดต่อได้ทันที เครดิตที่รับ" | tee -a log-install.txt
echo "Credit to True Wallet & K Mobile Banking Only" | tee -a log-install.txt
echo "Thanks to พี่เทพทุกท่าน ที่เลือกใช้ สคลิป ของเรา.." | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "Log Instalasi --> /root/log-install.txt" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "FUCK YOU !" | tee -a log-install.txt
echo "=======================================================" | tee -a log-install.txt
