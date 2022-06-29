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
  f=open("/var/www/html/smartagri/output.dat","a")
  now = datetime.now()
  d_string=now.strftime("%x")
  t_string=now.strftime("%X")
  #print(" "+'"Date"'+":"+'"'+d_string+'"'+",")
  #print(" "+'"Time"'+":"+'"'+t_string+'"'+",")
  #print(request.registers)
  f.write(" {\n")
  f.write("  "+'"Date"'+":"+'"'+d_string+'"'+",\n  "+'"Time"'+":"+'"'+t_string+'"'+",\n")
  
  '''Save data to file with json format'''
  request = client.read_holding_registers(address=400,count=1, unit=2)
  f.write("  "+'"DA_A1"'+":"+'"'+str(request.registers)+'"'+",\n")
  request = client.read_holding_registers(address=401,count=1, unit=2)
  f.write("  "+'"DA_A2"'+":"+'"'+str(request.registers)+'"'+",\n")
  request = client.read_holding_registers(address=402,count=1, unit=2)
  f.write("  "+'"DA_A3"'+":"+'"'+str(request.registers)+'"'+",\n")
  request = client.read_holding_registers(address=403,count=1, unit=2)
  f.write("  "+'"ND_A1"'+":"+'"'+str(request.registers)+'"'+",\n")
  request = client.read_holding_registers(address=404,count=1, unit=2)
  f.write("  "+'"ND_A2"'+":"+'"'+str(request.registers)+'"'+",\n")
  request = client.read_holding_registers(address=405,count=1, unit=2)
  f.write("  "+'"ND_A3"'+":"+'"'+str(request.registers)+'"'+",\n")
  request = client.read_holding_registers(address=406,count=1, unit=2)
  f.write("  "+'"AS_A1"'+":"+'"'+str(request.registers)+'"'+",\n")
  request = client.read_holding_registers(address=407,count=1, unit=2)
  f.write("  "+'"AS_A2"'+":"+'"'+str(request.registers)+'"'+",\n")
  request = client.read_holding_registers(address=408,count=1, unit=2)
  f.write("  "+'"AS_A3"'+":"+'"'+str(request.registers)+'"'+",\n")
  f.write(" },\n")
  
  '''CLOSE FILE'''
  f.close()
    
  '''open file to read'''
  f=open("/var/www/html/smartagri/output.dat","r")
  print("Noi dung cua file"+f.read())
    
  #LAP LAI
  #time.sleep(1)

