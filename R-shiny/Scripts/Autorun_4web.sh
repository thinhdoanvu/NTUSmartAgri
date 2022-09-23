#!/usr/bin/env bash
#export LC_ALL=en_US.UTF-8
export SHELL=bash

#after reboot: autorun
#chmod 777 /home/pi/smartagri/*
#crontab -e
#Choose: 1 for nano
#@reboot bash /srv/shiny-server/smartagri/Autorun_4web.sh 2>/srv/shiny-server/smartagri/log

#convert Mac/DOS format file created by PHP chu R thi khong can dung
#dung lenh cat -e www/request.req de kiem tra ky tu ket thuc dong co phai la $M^ khong? (ky tu ket thuc cua Linux)
#./dos2unix.sh www/request.req
cd /srv/shiny-server/smartagri

while true
do

################################################################
#BUOC 1. Ngay khi khoi dong Server Web
################################################################

# Tao file yeu cau Raspberry gui file output.dat
if [ -e www/request.req ]; then
echo -e "file exist"
else
date +%d/%m/%Y >d
date +"%T" >t
paste d t >dt
awk '{printf $0"\tR"}' dt > www/request.req

chmod 777 www/request.req
rm d
rm t
rm dt
fi

t=$(tail -1 www/request.req | cut -f3)

#Sau khi da co file request.req, tien hanh kiem tra dong cuoi cung cua file
#Neu yeu cau Raspb GUI du lieu len cho Server
#if [ "$t" == "R" ]; then
# Gui file yeu cau den Raspberry Pi4
#scp www/request.req pi@10.9.0.10:/home/pi/smartagri/www
#sleep 10 #Cho 10s de PLC gui du lieu cho Raspb
#scp pi@10.9.0.10:/home/pi/smartagri/www/output.dat www
#fi

#Trong truong hop lan dau tien thuc hien chuong trinh, file control.txt chua co
#control.txt duoc trich loc tu file output.dat sau khi yeu cau doc ket qua tu sensors
if [ -e www/control.txt ]; then
echo -e "file control.txt exist\n"
else
echo -e "DATE,TIME,DA_A1_MIN,DA_A1_MAX,DA_A2_MIN,DA_A2_MAX,DA_A3_MIN,DA_A3_MAX,ND_A1_MIN,ND_A1_MAX,ND_A2_MIN,ND_A2_MAX,ND_A3_MIN,ND_A3_MAX,AS_A1_MIN,AS_A1_MAX,AS_A2_MIN,AS_A2_MAX,AS_A3_MIN,AS_A3_MAX,TIME_OFF,TIME_ON,TIME_BN1,TIME_BN2,TIME_BN3,TIME_PS1,TIME_PS2,TIME_PS3,TIME_AS1,TIME_AS2,TIME_AS3" > www/control.txt
fi
tail -1 www/output.dat | sed 's/,/\t/g' | cut -f1,2,12- | sed 's/\t/,/g' >> www/control.txt
if [ -e www/config.cfg ]; then
tail -1 www/control.txt | sed 's/,/\t/g' | cut -f3- | tr '\t' '\n' > www/config.cfg
fi
################################################################
#BUOC 2. Gui cac tham so dieu khien den cho Raspb de gui len PLC
################################################################
if [ "$t" == "W" ]; then
echo -e "Writting... to PLC \n"
tail -1 www/control.txt | sed 's/,/\t/g' | cut -f3- | tr '\t' '\n' > www/config.cfg
#Gui file control.cfg sang cho Raspberry Pi4
scp www/config.cfg pi@10.9.0.10:/home/pi/smartagri/www
scp www/request.req pi@10.9.0.10:/home/pi/smartagri/www
scp www/control.txt pi@10.9.0.10:/home/pi/smartagri/www
fi

#Chen ky tu cuoi cung la R
date +%d/%m/%Y >d
date +"%T" >t
paste d t >dt
awk '{printf "\n"$0"\tR"}' dt >> www/request.req
chmod 777 www/request.req
chmod 777 www/control.txt
chmod 777 www/config.cfg
rm d
rm t
rm dt

################################################################
#BUOC 3. Doc noi dung file output.dat de lay du lieu cho data.txt
################################################################
if [ -e www/data.txt ]; then
echo -e "file data.txt exist"
else
echo -e "Date,Time,Doam_A1,Doam_A2,Doam_A3,Nhietdo_A1,Nhietdo_A2,Nhietdo_A3,Anhsang_A1,Anhsang_A2,Anhsang_A3,DA_A1_MIN,DA_A1_MAX,DA_A2_MIN,DA_A2_MAX,DA_A3_MIN,DA_A3_MAX,ND_A1_MIN,ND_A1_MAX,ND_A2_MIN,ND_A2_MAX,ND_A3_MIN,ND_A3_MAX,AS_A1_MIN,AS_A1_MAX,AS_A2_MIN,AS_A2_MAX,AS_A3_MIN,AS_A3_MAX,TIME_OFF,TIME_ON,TIME_BN1,TIME_BN2,TIME_BN3,TIME_PS1,TIME_PS2,TIME_PS3,TIME_AS1,TIME_AS2,TIME_AS3" > www/data.txt
tail -1 www/output.dat >> www/data.txt
#Copy len Google Sheet cua cave
#2 file: changedata.py va gsheet.json cung 1 folder
tail -1 www/output.dat > www/dataset.csv
fi

number=$(wc -l www/output.dat | sed 's/ /\t/g' | cut -f1)
if [ $number -gt 60 ]; then #Do moi 30s doc du lieu 1 lan
echo -e "copy to data.txt"
tail -1 www/output.dat >> www/data.txt
echo -e "delete file output.dat"
end=$(($number - 1))
echo 2 $end | sed 's/ /,/g' | awk '{print "sed -i "$0"d www/output.dat"}' > del.sh
echo 2 $end | sed 's/ /,/g' | awk '{print "sed -i "$0"d www/request.req"}' >> del.sh
bash del.sh
echo -e "Not enough data output.dat lines"
fi

#waitting for 30 seconds
sleep 30
done
