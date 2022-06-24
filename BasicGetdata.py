from pymodbus.client.sync import ModbusSerialClient as ModbusClient
import logging

'''logging.basicConfig()
log = logging.getLogger()
log.setLevel(logging.DEBUG)
'''
client = ModbusClient(method='rtu', port='/dev/ttyUSB0',  baudrate=9600, timeout = 3, parity = 'O', stopbits=1,  bytesize=8)
connection = client.connect()
print(connection)

#request = client.read_holding_registers(400,1,unit=1)
request = client.read_holding_registers(address=400,count=27, unit=2)
print(request.registers)
#WRITE TO PLC: client.write_registers(Adress,value,unit=2) 
client.write_registers(500,500,unit=2)
#lam sao de cai pymodbus?
#pip install pymodbus
