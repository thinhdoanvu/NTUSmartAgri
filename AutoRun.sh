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

sudo chown pi /dev/ttyUSB0
while true
do

t=$(tail -1 /home/pi/programs/control.ctrl|cut -f3)

#DOC DU LIEU
if [ "$t" == "R" ]; then
echo -e "Reading... from PLC \n"
python3 /home/pi/programs/readdata.py
if [ -e output.dat ]; then
#checking file if existed
echo -e "Reading completed!"
sed 's/\[//g' /home/pi/programs/output.dat | sed 's/\]//g'>/home/pi/programs/tam
cat /home/pi/programs/data.txt /home/pi/programs/tam >/home/pi/programs/t
mv /home/pi/programs/t /home/pi/programs/data.txt
rm /home/pi/programs/tam
rm /home/pi/programs/output.dat
fi
fi

#GHI DU LIEU
if [ "$t" == "W" ]; then
echo -e "Writting... to PLC \n"
python3 /home/pi/programs/senddata.py
echo -e "Writting completed!"
#Chen ky tu cuoi cung la @
date +"%d-%m-%y">/home/pi/programs/d
date +"%T">/home/pi/programs/t
paste d t >/home/pi/programs/dt
awk '{printf "\r"$0"\tR"}' dt>>/home/pi/programs/control.ctrl
rm /home/pi/programs/d
rm /home/pi/programs/t
rm /home/pi/programs/dt
fi

if [ "$t" == "#" ]; then
echo -e "Nothing at all \n"
fi

sleep 300
done
