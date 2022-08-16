PWD <- "/home/dthinh/smartagri/www"
DAT <- read.table(file.path(PWD,"data.txt"),header = TRUE, sep = ",")
datasensors <- DAT[ , c(1:11)]
realtimeDAT <- tail(read.table(file.path(PWD,"output.dat"),header = TRUE, sep = ","),1)

#File control.txt
CONTROL_BOT <- read.table(file.path(PWD,"control.txt"),header = TRUE, sep = ",")
CONTROL <- tail(CONTROL_BOT,1)
  
DAT$Date <- as.Date(DAT$Date,format="%d/%m/%Y")
#Giai thich: trong file csv minh ky hieu: 05/05/2021 <=> minh hieu la: D/M/Y
#Ep R hieu day la du lieu Date voi dinh dang: D/M/Y
#Tu do R se tra ve gia tri la: 2021-05-05 (Y-M-D)

DAT_24 <- tail(DAT,48)
#Ly do: 1 ngay minh thu du lieu 48 lan. Neu lay so dong > so lan doc data se gay ra groups trong truc X

#Xay dung file warnings.txt
if(file.exists(file.path(PWD,"warning.txt"))){
  file.remove(file.path(PWD,"warning.txt"))
  file.create(file.path(PWD,"warning.txt"))
  write.table("sensor",file.path(PWD,"warning.txt"),quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table("value",file.path(PWD,"warning.txt"),quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE )
}else{
  file.create(file.path(PWD,"warning.txt"))
  write.table("sensor",file.path(PWD,"warning.txt"),quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table("value",file.path(PWD,"warning.txt"),quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE )
}

#So sanh cac sensors: Nhiet do
if(realtimeDAT$Nhietdo_A1 > CONTROL$ND_A1_MAX){
  write.table("ND-KV1>ND-MAX",file.path(PWD,"warning.txt"),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$Nhietdo_A1,file.path(PWD,"warning.txt"),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$ND_A1_MAX,file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$Nhietdo_A2 > CONTROL$ND_A2_MAX){
  write.table("ND-KV2>ND-MAX",file.path(PWD,"warning.txt"),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$Nhietdo_A2,file.path(PWD,"warning.txt"),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$ND_A2_MAX,file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$Nhietdo_A3 > CONTROL$ND_A3_MAX){
  write.table("ND-KV3>ND-MAX",file.path(PWD,"warning.txt"),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$Nhietdo_A3,file.path(PWD,"warning.txt"),quote = F,sep = ">",row.names=FALSE, col.names=FALSE, eol=">", append =TRUE)
  write.table(CONTROL$ND_A3_MAX,file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

#So sanh cac sensors: Do am
if(realtimeDAT$Doam_A1 < CONTROL$DA_A1_MIN){
  write.table("DA-KV1<MIN",file.path(PWD,"warning.txt"),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$Doam_A1,file.path(PWD,"warning.txt"),quote = F,sep = "<",row.names=FALSE, col.names=FALSE, eol="<", append =TRUE)
  write.table(CONTROL$DA_A1_MIN,file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$Doam_A2 < CONTROL$DA_A2_MIN){
  write.table("DA-KV2<MIN",file.path(PWD,"warning.txt"),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$Doam_A2,file.path(PWD,"warning.txt"),quote = F,sep = "<",row.names=FALSE, col.names=FALSE, eol="<", append =TRUE)
  write.table(CONTROL$DA_A2_MIN,file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$Doam_A3 < CONTROL$DA_A3_MIN){
  write.table("DA-KV3<MIN",file.path(PWD,"warning.txt"),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$Doam_A3,file.path(PWD,"warning.txt"),quote = F,sep = "<",row.names=FALSE, col.names=FALSE, eol="<", append =TRUE)
  write.table(CONTROL$DA_A3_MIN,file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

#So sanh cac sensors: Anh sang
if(realtimeDAT$Anhsang_A1 < CONTROL$AS_A1_MIN){
  write.table("AS-KV1<MIN",file.path(PWD,"warning.txt"),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$Anhsang_A1,file.path(PWD,"warning.txt"),quote = F,sep = "<",row.names=FALSE, col.names=FALSE, eol="<", append =TRUE)
  write.table(CONTROL$AS_A1_MIN,file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$Anhsang_A2 < CONTROL$AS_A2_MIN){
  write.table("AS-KV2<MIN",file.path(PWD,"warning.txt"),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$Anhsang_A2,file.path(PWD,"warning.txt"),quote = F,sep = "<",row.names=FALSE, col.names=FALSE, eol="<", append =TRUE)
  write.table(CONTROL$AS_A2_MIN,file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

if(realtimeDAT$Anhsang_A3 < CONTROL$AS_A1_MIN){
  write.table("AS-KV3<MIN",file.path(PWD,"warning.txt"),quote = F, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
  write.table(realtimeDAT$Anhsang_A3,file.path(PWD,"warning.txt"),quote = F,sep = "<",row.names=FALSE, col.names=FALSE, eol="<", append =TRUE)
  write.table(CONTROL$AS_A3_MIN,file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

con <- file(file.path(PWD,"warning.txt")) 
numline <- length(readLines(con))
if(numline == 1){
  write.table("Cảm_biến:",file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE)
  write.table("Trong_ngưỡng",file.path(PWD,"warning.txt"),quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
}

messageData <- read.table(file.path(PWD,"warning.txt"),header = TRUE)
