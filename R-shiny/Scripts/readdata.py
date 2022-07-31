#!/usr/bin/python3
'''
    ./dos2unix.sh readdata.py
    chmod 755 readdata.py
    ./readdata.py
'''
from datetime import datetime
from pymodbus.client.sync import ModbusSerialClient as ModbusClient
import logging
import time 
from datetime import datetime

'''logging.basicConfig()
   log = logging.getLogger()
   log.setLevel(logging.DEBUG)
'''

'''lam sao de cai pymodbus?
   pip3 install pymodbus
'''
client = ModbusClient(method='rtu', port='/dev/ttyUSB0',  baudrate=9600, timeout = 3, parity = 'O', stopbits=1,  bytesize=8)
connection = client.connect()
print(connection)
if connection == True:
  #request = client.read_holding_registers(400,1,unit=1)
  #IN KET QUA RA MAN HINH
  #request = client.read_holding_registers(address=400,count=27, unit=2)
  #print(request.registers)

  #WRITE TO PLC: client.write_registers(Adress,value,unit=2) 
  #client.write_registers(500,500,unit=2)

  
  '''SAVE TO JSON FILE'''
  d_string=""
  t_string=""
  #while True:
  #File name
  f=open("/home/pi/smartagri/output.dat","w")
  now = datetime.now()
  d_string=now.strftime("%d/%m/%Y")
  t_string=now.strftime("%X")
  f.write(d_string+","+t_string+",")
  
  '''Save sensors value to file'''
  for i in range(38)
    request = client.read_holding_registers(address=400+i,count=1, unit=2)
    f.write(str(request.registers)+",")
      
  '''CLOSE FILE'''
  f.close()
    
  '''open file to read'''
  f=open("/var/www/html/smartagri/output.dat","r")
  print("Noi dung cua file"+f.read())
    
  #LAP LAI
  #time.sleep(1)
  quit()
