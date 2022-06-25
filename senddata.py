from datetime import datetime
from pymodbus.client.sync import ModbusSerialClient as ModbusClient
import logging
import time 
from datetime import datetime
import array as arr

#lam sao de cai pymodbus?
#pip3 install pymodbus

'''logging.basicConfig()
   log = logging.getLogger()
   log.setLevel(logging.DEBUG)
'''
client = ModbusClient(method='rtu', port='/dev/ttyUSB0',  baudrate=9600, timeout = 3, parity = 'O', stopbits=1,  bytesize=8)
connection = client.connect()
print(connection)

if connection == True:
  '''FILE NAME'''
  values=[]
  with open("/home/pi/programs/config.cfg") as file:
    i = 1
    for line in file:
      val = line
      values.append(val) 
      i += 1

    '''Ghi noi dung ra cac thanh ghi, do ko chiu sap xep thanh ghi nen gio phai lam bang tay
       WRITE TO PLC: client.write_registers(Adress,value,unit=2)
    '''
  print("Seting range for Temperature-A1\n")
  client.write_registers(32710,int(values[0]),unit=2)
  client.write_registers(32711,int(values[1]),unit=2)
  print("Seting range for Temperature-A2\n")
  client.write_registers(32716,int(values[2]),unit=2)
  client.write_registers(32717,int(values[3]),unit=2)
  print("Seting range for Temperature-A3\n")
  client.write_registers(32722,int(values[4]),unit=2)
  client.write_registers(32723,int(values[5]),unit=2)

  print("Seting range for Light-A1\n")
  client.write_registers(32712,int(values[6]),unit=2)
  client.write_registers(32713,int(values[7]),unit=2)
  print("Seting range for Light-A2\n")
  client.write_registers(32718,int(values[8]),unit=2)
  client.write_registers(32719,int(values[9]),unit=2)
  print("Seting range for Light-A3\n")
  client.write_registers(32724,int(values[10]),unit=2)
  client.write_registers(32725,int(values[11]),unit=2)

  print("Seting range for Humidity-A1\n")
  client.write_registers(32714,int(values[12]),unit=2)
  client.write_registers(32715,int(values[13]),unit=2)
  print("Seting range for Humidity-A2\n")
  client.write_registers(32720,int(values[14]),unit=2)
  client.write_registers(32721,int(values[15]),unit=2)
  print("Seting range for Humidity-A3\n")
  client.write_registers(32726,int(values[16]),unit=2)
  client.write_registers(32727,int(values[17]),unit=2)

  print("Seting Time Off\n")
  client.write_registers(32728,int(values[18]),unit=2)
  print("Seting Time On\n")
  client.write_registers(32738,int(values[19]),unit=2)

  print("Seting Pump Time Off\n")
  client.write_registers(32735,int(values[20]),unit=2)
  client.write_registers(32736,int(values[21]),unit=2)
  client.write_registers(32737,int(values[22]),unit=2)

  print("Seting Spray Time Off\n")
  client.write_registers(32732,int(values[23]),unit=2)
  client.write_registers(32733,int(values[24]),unit=2)
  client.write_registers(32734,int(values[25]),unit=2)

  print("Seting Light Time Off\n")
  client.write_registers(32729,int(values[26]),unit=2)
  client.write_registers(32730,int(values[27]),unit=2)
  client.write_registers(32731,int(values[28]),unit=2)
