### set static IP Network for Raspb
##### sudo nano /etc/dhcpcd.conf

#### for LAN
##### interface eth0

##### static ip_address=192.168.0.10/24
##### static routers=192.168.0.1
##### static domain_name_servers=8.8.8.8 208.67.222.222

#### for WAN
##### interface wlan0

##### static ip_address=192.168.0.200/24
##### static routers=192.168.0.1
##### static domain_name_servers=8.8.8.8 208.67.222.222


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
