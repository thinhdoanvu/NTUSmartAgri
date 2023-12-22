### Set timezone, date, time
#### list time zone
###### timedatectrl list-timezone
###### Ket qua la: Asia/Ho_Chi_Minh

#### Set timezone
###### timedatectrl set-timezone Asia/Ho_Chi_Minh

#### OFF syncs time from Inernet
###### timedatectrl set-ntp FALSE

#### Set time
###### timectrl seet-time 17:20:30

#### Setdate and time
###### sudo date --set="20220731 17:26:30"

### set static IP Network for Raspb
##### sudo nano /etc/dhcpcd.conf

#### for LAN
##### interface eth0

##### static ip_address=10.9.0.10/28
##### static routers=10.9.0.1
##### static domain_name_servers=8.8.8.8 10.9.0.1

#### for WAN
##### interface wlan0

##### static ip_address=192.168.0.200/24
##### static routers=192.168.0.1
##### static domain_name_servers=8.8.8.8 208.67.222.222

## In the same Network, Port forwarding setting is not necessary
### install pip3 for python3
###### sudo apt-get install python3-pip 
###### pip3 install pymodbus

### Prevent password for sudo chown

##### Only chown:
###### chmod u+s /bin/chown
###### sudo -i
###### visudo
###### dthinh ALL=NOPASSWD: /bin/chown

##### for ALL:
###### dthinh ALL+NOPASSWD: ALL

#### How to auto run script after rebooting
###### chmod 777 /var/www/html/smartagri/*
###### crontab -e

###### Choose: 1 for nano
###### Adding this line into crontab
###### @reboot bash /var/www/html/smartagri/AutoRun.sh

### Configure USB port to transfer data between PLC and Raspperry Pi 
##### sudo chown pi /dev/ttyUSB0
##### cd /var/www/html/smartagri

##### while true
##### do
### convert Mac/DOS format file created by PHP
###### ./dos2unix.sh control.ctrl
###### chmod 777 control.ctrl
###### chmod 777 control.txt
###### chmod 777 config.cfg
###### chmod 777 data.txt
###### t=$(tail -1 control.ctrl | cut -f3)

### DOC DU LIEU
###### if [ "$t" == "R" ]; then
###### echo -e "Reading... from PLC \n"
###### ./readdata.py
###### if [ -e output.dat ];then
###### chmod 777 output.dat
###### sed 's/\[//g' output.dat | sed 's/\]//g'> tam
###### cat data.txt tam >t
###### mv t data.txt

#### Save settings range into control.txt
###### tail -30 tam | sed 's/},/}/g'>tail
###### echo "{" >head
###### cat head tail >t
###### mv t control.txt
###### chmod 777 control.ctrl
###### chmod 777 control.txt
###### chmod 777 config.cfg
###### chmod 777 data.txt
###### rm tam
###### rm output.dat
###### rm tail
###### rm head
###### echo -e "Reading completed!"
###### fi
###### fi

### GHI DU LIEU
###### if [ "$t" == "W" ]; then
###### echo -e "Writting... to PLC \n"
###### sed 's/\"//g' control.txt | sed 's/{//g' | sed 's/}//g' | sed 's/:/\t/g' | sed 's/\,//g' | cut -f2 | tail -30 >config.cfg
###### ./senddata.py
###### echo -e "Writting completed!"

### Chen ky tu cuoi cung la W
###### date +"%d-%m-%y" >d
###### date +"%T" >t
###### paste d t >dt
###### awk '{printf "\n"$0"\tR"}' dt >>control.ctrl
###### chmod 777 control.ctrl
###### chmod 777 control.txt
###### chmod 777 config.cfg
###### rm d
###### rm t
###### rm dt
###### fi

###### if [ "$t" == "#" ]; then
###### echo -e "Nothing at all \n"
###### fi

###### sleep 60
###### done

# Neu SERVER loi khong the truy cap:
## An error has occurred!
## An error has occurred. Check your logs or contact the app author for clarification.

### Buoc 1. Copy file data.txt tuu pi@10.9.0.10/pi/home/smartagri/www/data.txt .
### Buoc 2. Kiem tra header cua file data:
        head -1 data.txt
        Ket qua: Date,Time,Doam_A1,Doam_A2,Doam_A3,Nhietdo_A1,Nhietdo_A2,Nhietdo_A3,Anhsang_A1,Anhsang_A2,Anhsang_A3
### Buoc 3. nano data.txt, sua header thanh:
          Date,Time,Doam_A1,Doam_A2,Doam_A3,Nhietdo_A1,Nhietdo_A2,Nhietdo_A3,Anhsang_A1,Anhsang_A2,Anhsang_A3,DA_A1_MIN,DA_A1_MAX,DA_A2_MIN,DA_A2_MAX,DA_A3_MIN,DA_A3_MAX,ND_A1_MIN,ND_A1_MAX,ND_A2_MIN,ND_A2_MAX,ND_A3_MIN,ND_A3_MAX,AS_A1_MIN,AS_A1_MAX,AS_A2_MIN,AS_A2_MAX,AS_A3_MIN,AS_A3_MAX,TIME_OFF,TIME_ON,TIME_BN1,TIME_BN2,TIME_BN3,TIME_PS1,TIME_PS2,TIME_PS3,TIME_AS1,TIME_AS2,TIME_AS3

### Buoc 4. Refresh trang, NEU CAT NOI DUNG data.txt co qua nhieu dong header se bao loi he thong:
      grep -v "Date,Time,Doam_A1,Doam_A2,Doam_A3" data.txt >temp
      mv temp data.txt
      Lam lai buoc 2

Neu van con loi: 

### Buoc 5. Copy header sau cho file output.dat, LUU Y: LAM CHO FILE OUTPUT CUA RASP va CA SERVER
          Date,Time,Doam_A1,Doam_A2,Doam_A3,Nhietdo_A1,Nhietdo_A2,Nhietdo_A3,Anhsang_A1,Anhsang_A2,Anhsang_A3,DA_A1_MIN,DA_A1_MAX,DA_A2_MIN,DA_A2_MAX,DA_A3_MIN,DA_A3_MAX,ND_A1_MIN,ND_A1_MAX,ND_A2_MIN,ND_A2_MAX,ND_A3_MIN,ND_A3_MAX,AS_A1_MIN,AS_A1_MAX,AS_A2_MIN,AS_A2_MAX,AS_A3_MIN,AS_A3_MAX,TIME_OFF,TIME_ON,TIME_BN1,TIME_BN2,TIME_BN3,TIME_PS1,TIME_PS2,TIME_PS3,TIME_AS1,TIME_AS2,TIME_AS3


### How To Fix the “Warning: Remote Host Identification Has Changed” Error (on Mac)

rm ~/.ssh/known_hosts
