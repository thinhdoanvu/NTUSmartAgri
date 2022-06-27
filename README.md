# install pip3 for python3
sudo apt-get install python3-pip | pip3 install pymodbus

# Prevent password for sudo chown

## Only chown:
chmod u+s /bin/chown
sudo -i
visudo
dthinh ALL=NOPASSWD: /bin/chown

## for ALL:
dthinh ALL+NOPASSWD: ALL

# How to auto run script after rebooting
chmod 777 /home/pi/programs/*
crontab -e

## Choose: 1 for nano
## Adding this line into crontab
@reboot bash /home/pi/programs/AutoRun.sh

# Configure USB port to transfer data between PLC and Raspperry Pi 
sudo chown pi /dev/ttyUSB0

# Always run scripts
while true
do

# Checking control file
t=$(tail -1 /home/pi/programs/control.ctrl|cut -f3)

# Read data
#### if [ "$t" == "R" ]; then
#### echo -e "Reading... from PLC \n"
#### python3 /home/pi/programs/readdata.py
#### echo -e "Reading completed!"
#### sed 's/\[//g' /home/pi/programs/output.dat | sed 's/\]//g'>/home/pi/programs/tam
#### cat /home/pi/programs/data.txt /home/pi/programs/tam >/home/pi/programs/t
#### mv /home/pi/programs/t /home/pi/programs/data.txt
#### rm /home/pi/programs/tam
#### rm /home/pi/programs/output.dat
#### fi

# Send data
#### if [ "$t" == "W" ]; then
#### echo -e "Writting... to PLC \n"
#### python3 /home/pi/programs/senddata.py
#### echo -e "Writting completed!"
#### Chen ky tu cuoi cung la @
#### date +"%d-%m-%y">/home/pi/programs/d
#### date +"%T">/home/pi/programs/t
#### paste d t >/home/pi/programs/dt
#### awk '{printf "\r"$0"\tR"}' dt>>/home/pi/programs/control.ctrl
#### rm /home/pi/programs/d
#### rm /home/pi/programs/t
#### rm /home/pi/programs/dt
#### fi

#### if [ "$t" == "#" ]; then
#### echo -e "Nothing at all \n"
#### fi

# Repeat after each xxx seconds
#### sleep 300
#### done
