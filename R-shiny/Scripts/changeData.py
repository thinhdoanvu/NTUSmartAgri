#!/usr/bin/python3

#pip install gspread
#pip install gspread_formatting
#File json API nam trong thu muc chua file Python: gsheet.json
#chmod 755 changeData.py

import gspread
import csv
from gspread_formatting import *
import datetime
# from gspread_formatting import *

#-----------------------------EXCEL----------------------------
date = []
time = []
da1 = []
da2 = []
da3 = []
nd1 = []
nd2 = []
nd3 = []
as1 = []
as2 = []
as3 = []
da1_min = []
da1_max = []
da2_min = []
da2_max = []
da3_min = []
da3_max = []
nd1_min = []
nd1_max = []
nd2_min = []
nd2_max = []
nd3_min = []
nd3_max = []
as1_min = []
as1_max = []
as2_min = []
as2_max = []
as3_min = []
as3_max = []
giomo = []
giotat = []
tg_bom1 = []
tg_bom2 = []
tg_bom3 = []
tg_ps1 = []
tg_ps2 = []
tg_ps3 = []
tg_as1 = []
tg_as2 = []
tg_as3 = []

line_count = 0

#-----  đếm số row   ------- 
with open('www/dataset.csv') as csv_file:
    print('  ------- loading excel success')
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:        
        # dừng đọc khi dữ liệu của cell ở row đó = rỗng
        if row[1] == '':
            print(' ---  file null')
            break     
        line_count += 1
    print(f' ----- Processed {line_count} lines.')

length = line_count
print(' ---- length=')
print(length)
# =-=-=-=-=-=-=-=----- lấy tất cả dữ liệu --------=-=-=-=-=-=-=
n = 0
with open('www/dataset.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    for row in csv_reader:
        # dừng đọc khi dữ liệu của cell ở row đó = rỗng
        if row[1] == "":
            break

        if line_count == length:
            break    

        line_count += 1

        if line_count > length - length + 1:            
            date.append(row[0])
            time.append(row[1])
            da1.append(row[2])
            da2.append(row[3])
            da3.append(row[4])
            nd1.append(row[5])
            nd2.append(row[6])
            nd3.append(row[7])
            as1.append(row[8])
            as2.append(row[9])
            as3.append(row[10])
            da1_min.append(row[10])
            da1_max.append(row[12])
            da2_min.append(row[13])
            da2_max.append(row[14])
            da3_min.append(row[15])
            da3_max.append(row[16])
            nd1_min.append(row[17])
            nd1_max.append(row[18])
            nd2_min.append(row[19])
            nd2_max.append(row[20])
            nd3_min.append(row[21])
            nd3_max.append(row[22])
            as1_min.append(row[23])
            as1_max.append(row[24])
            as2_min.append(row[25])
            as2_max.append(row[26])
            as3_min.append(row[27])
            as3_max.append(row[28])
            giomo.append(row[29])
            giotat.append(row[30])
            tg_bom1.append(row[31])
            tg_bom2.append(row[32])
            tg_bom3.append(row[33])
            tg_ps1.append(row[34])
            tg_ps2.append(row[35])
            tg_ps3.append(row[36])
            tg_as1.append(row[37])
            tg_as2.append(row[38])
            tg_as3.append(row[39])
            n +=1

print('n=')
print(n)

#i=0
#while i < n:
#    print(f'{date[i]} {time[i]} : {da1[i]} {da2[i]} {da3[i]} : {nd1[i]} {nd2[i]} {nd3[i]} :  {as1[i]} {as2[i]} {as3[i]} : {da1_min} {da1_max} {da2_min} {da2_max} {da3_min} {da3_max} : {nd1_min} {nd1_max} {nd2_min} {nd2_max} {nd3_min} {nd3_max} : {as1_min} {as1_max} {as2_min} {as2_max} {as3_min} {as3_max} : {giomo} {giotat} : {tg_bom1} {tg_bom2} {tg_bom3} : {tg_ps1} {tg_ps2} {tg_ps3} : {tg_as1} {tg_as2} {tg_as3}')
#    i+=1

# -----------------------------Google Sheet---------------
gs = gspread.service_account("gsheet.json")
sht = gs.open_by_key('1KsE0-DmUPqbbJKJVLwpHzm3BNssRZH7Enmvi6OkVF7k')
worksheet = sht.get_worksheet(0)

# print(worksheet.row_count)

list_of_lists = worksheet.get_all_values()


length_list = len(list_of_lists)

i=0
checked = 0
print('-----')
print(str(list_of_lists[len(list_of_lists) - 1]))
while i < n:
    insertRow = [date[i],time[i],da1[i],da2[i],da3[i],nd1[i],nd2[i],nd3[i],as1[i],as2[i],as3[i],da1_min[i],da1_max[i],da2_min[i],da2_max[i],da3_min[i],da3_max[i],nd1_min[i],nd1_max[i],nd2_min[i],nd2_max[i],nd3_min[i],nd3_max[i],as1_min[i],as1_max[i],as2_min[i],as2_max[i],as3_min[i],as3_max[i],giomo[i],giotat[i],tg_bom1[i],tg_bom2[i],tg_bom3[i],tg_ps1[i],tg_ps2[i],tg_ps3[i],tg_as1[i],tg_as2[i],tg_as3[i]]
    if str(date[i]) == list_of_lists[length_list-1][0] and str(time[i]) == list_of_lists[length_list-1][1]:
        print('trung nhau')
        checked=1
        print(insertRow)
        j = i+1
        while j < n:
            #print('danh sach cac hang can chen')
            insertRow = [date[j],time[j],da1[j],da2[j],da3[j],nd1[j],nd2[j],nd3[j],as1[j],as2[j],as3[j],da1_min[j],da1_max[j],da2_min[j],da2_max[j],da3_min[j],da3_max[j],nd1_min[j],nd1_max[j],nd2_min[j],nd2_max[j],nd3_min[j],nd3_max[j],as1_min[j],as1_max[j],as2_min[j],as2_max[j],as3_min[j],as3_max[j],giomo[j],giotat[j],tg_bom1[j],tg_bom2[j],tg_bom3[j],tg_ps1[j],tg_ps2[j],tg_ps3[j],tg_as1[j],tg_as2[j],tg_as3[j]]
            #print(insertRow)
            length_list +=1
            worksheet.insert_row(insertRow,length_list,value_input_option="USER_ENTERED")
            j += 1
        break
    i+=1
List_Add = []
if(checked == 0):
    print('Insert All')
    j = 0
    while j < n:
        #print('danh sach cac hang can chen')
        insertRow = [date[j],time[j],da1[j],da2[j],da3[j],nd1[j],nd2[j],nd3[j],as1[j],as2[j],as3[j],da1_min[j],da1_max[j],da2_min[j],da2_max[j],da3_min[j],da3_max[j],nd1_min[j],nd1_max[j],nd2_min[j],nd2_max[j],nd3_min[j],nd3_max[j],as1_min[j],as1_max[j],as2_min[j],as2_max[j],as3_min[j],as3_max[j],giomo[j],giotat[j],tg_bom1[j],tg_bom2[j],tg_bom3[j],tg_ps1[j],tg_ps2[j],tg_ps3[j],tg_as1[j],tg_as2[j],tg_as3[j]]
        List_Add.append(insertRow)
        #print(insertRow)
        length_list += 1
        # worksheet.insert_row(insertRow,length_list,value_input_option="USER_ENTERED")
        #print('Length List ')
        #print(length_list)
        j += 1
i=-0
length_list = 1

insertRow = [date[0],time[0]]
worksheet.insert_row(insertRow,2,value_input_option="USER_ENTERED")

sht.values_update(
    'DataSet!A2', 
    params={'value_input_option': "USER_ENTERED"}, 
    body={'values': List_Add},   
)


