#!/usr/bin/env bash
#export LC_ALL=en_US.UTF-8
export SHELL=bash

#please run this command: chmod u+s /bin/chown in order to prevent password for sudo chown
#sudo -i
#visudo
#dthinh ALL=NOPASSWD: /bin/chown
#for ALL:
#dthinh ALL+NOPASSWD: ALL

#after reboot: autorun
#chmod 777 /home/pi/programs/*
#crontab -e
#Choose: 1 for nano
#@reboot bash /home/pi/programs/AutoRun.sh

#Chuong trinh chinh o day!
#cd /home/dthinh/smartagri
#sudo chown pi /dev/ttyUSB0

#convert Mac/DOS format file created by PHP chu R thi khong can dung
#./dos2unix.sh www/control.ctrl
while true
do

################################################################
#BUOC 1. Ngay khi khoi dong Raspb thi lam ngay viec nay
################################################################
if [ -e www/request.req ]; then
t=$(tail -1 www/request.req | cut -f3)
fi

#Neu yeu cau tu phia server la GHI du lieu
if [ "$t" == "R" ]; then

#Kiem tra header file output.dat, neu chua co thi tao moi
if [ -e www/output.dat ];then
echo "file output.dat is exist"
else
echo -e "Date,Time,Doam_A1,Doam_A2,Doam_A3,Nhietdo_A1,Nhietdo_A2,Nhietdo_A3,Anhsang_A1,Anhsang_A2,Anhsang_A3,DA_A1_MIN,DA_A1_MAX,DA_A2_MIN,DA_A2_MAX,DA_A3_MIN,DA_A3_MAX,ND_A1_MIN,ND_A1_MAX,ND_A2_MIN,ND_A2_MAX,ND_A3_MIN,ND_A3_MAX,AS_A1_MIN,AS_A1_MAX,AS_A2_MIN,AS_A2_MAX,AS_A3_MIN,AS_A3_MAX,TIME_OFF,TIME_ON,TIME_BN1,TIME_BN2,TIME_BN3,TIME_PS1,TIME_PS2,TIME_PS3,TIME_AS1,TIME_AS2,TIME_AS3" > www/output.dat
fi
fi

#Doc du lieu tu cam bien
echo -e "Reading... from PLC \n"
#./readdata.py
if [ -e www/output.dat ];then
echo "file output.dat is exist"
chmod 777 www/output.dat
#Copy file output.dat chua gia tri cua cam bien tu Raspb len Server
#scp www/output.dat dthinh@10.9.0.11:/home/dthinh/smartagri/www
fi
################################################################
#BUOC 2. Gui cac tham so dieu khien tu Raspb den PLC
################################################################

#Neu yeu cau tu phia server la GHI du lieu
if [ "$t" == "W" ]; then
echo -e "Writting... to PLC \n"
if [ -e  www/config.cfg ]; then
#./senddata.py
echo -e "Writting completed!"
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
else
echo -e "file config.cfg does not exist"
fi
fi

################################################################
#BUOC 3. Doc noi dung cac thanh ghi de lay du lieu cho data.txt (luu du phong o day)
#Khong gui file data len Server phong T.hop Server loi van co data de phan tich
################################################################
if [ -e www/data.txt ]; then
echo -e "data file is exist"
else
echo -e "Date,Time,Doam_A1,Doam_A2,Doam_A3,Nhietdo_A1,Nhietdo_A2,Nhietdo_A3,Anhsang_A1,Anhsang_A2,Anhsang_A3" > www/data.txt
tail -1 www/output.dat >> www/data.txt
fi

number=$(wc -l www/output.dat | sed 's/ /\t/g' | cut -f1)
if [ $number -gt 3 ]; then #Do moi 30s doc du lieu 1 lan
echo -e "copy to data.txt"
tail -1 www/output.dat >> www/data.txt
echo -e "delete file output.dat"
end=$(($number - 1))
echo 2 $end | sed 's/ /,/g' | awk '{print "sed -i "$0"d www/output.dat"}' > del.sh      
bash del.sh
fi

#waitting for 30 s
sleep 30
done
