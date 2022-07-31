shinyServer(function(input, output,session) {
  source("www/global.R")
  shinyjs::useShinyjs()
  
  #---------------------------------------------------------------------------#
  #-------------------------------HEADER--------------------------------------#
  #-------------------------------HEADER--------------------------------------#
  #---------------------------------------------------------------------------#  
  output$messageMenu <- renderMenu({
    msgs <- apply(messageData, 1, function(row){
      #messageData is a data frame with two columns, 'sensor' and 'value'
      messageItem(from = row[["sensor"]], message = row[["value"]])
    })#End msgs
    dropdownMenu(type = "messages", .list = msgs)
  })
  #---------------------------------------------------------------------------#
  #-------------------------------HOME----------------------------------------#
  #-------------------------------HOME----------------------------------------#
  #---------------------------------------------------------------------------#
  #Tab HOME
  output$NhietdoBox1 <- renderValueBox({
    valueBox(realtimeDAT$Nhietdo_A1/10,'Nhiệt độ - khu vực 1',icon = icon("thermometer"),color = "red") 
  })
  
  output$NhietdoBox2 <- renderValueBox({
    valueBox(realtimeDAT$Nhietdo_A2/10,'Nhiệt độ - khu vực 2',icon = icon("thermometer"),color = "red") 
  })
  
  output$NhietdoBox3 <- renderValueBox({
    valueBox(realtimeDAT$Nhietdo_A3/10,'Nhiệt độ - khu vực 3',icon = icon("thermometer"),color = "red") 
  })
  
  output$DoamBox1 <- renderValueBox({
    valueBox(realtimeDAT$Doam_A1/10,'Độ ẩm - khu vực 1',icon = icon("percent"),color = "blue") 
  })
  
  output$DoamBox2 <- renderValueBox({
    valueBox(realtimeDAT$Doam_A2/10,'Độ ẩm - khu vực 2',icon = icon("percent"),color = "blue") 
  })
  
  output$DoamBox3 <- renderValueBox({
    valueBox(realtimeDAT$Doam_A3/10,'Độ ẩm - khu vực 3',icon = icon("percent"),color = "blue") 
  })
  
  output$AnhsangBox1 <- renderValueBox({
    valueBox(realtimeDAT$Anhsang_A1,'Ánh sáng - khu vực 1',icon = icon("lightbulb"),color = "green") 
  })
  
  output$AnhsangBox2 <- renderValueBox({
    valueBox(realtimeDAT$Anhsang_A2,'Ánh sáng - khu vực 2',icon = icon("lightbulb"),color = "green") 
  })
  
  output$AnhsangBox3 <- renderValueBox({
    valueBox(realtimeDAT$Anhsang_A3,'Ánh sáng - khu vực 3',icon = icon("lightbulb"),color = "green") 
  })
  
  #Hien thi MAX_ND
  output$ndo_max_kv1 <- renderText({paste0("KV1-MAX:",round(CONTROL$ND_A1_MAX/10,digits = 1)," \u00B0C")})
  output$ndo_max_kv2 <- renderText({paste0("KV2-MAX:",round(CONTROL$ND_A2_MAX/10,digits = 1)," \u00B0C")})
  output$ndo_max_kv3 <- renderText({paste0("KV3-MAX:",round(CONTROL$ND_A3_MAX/10,digits = 1)," \u00B0C")})
  output$ndo_kv1 <- renderText({paste0("KV1:",round(realtimeDAT$Nhietdo_A1/10,digits = 1)," \u00B0C")})
  output$ndo_kv2 <- renderText({paste0("KV2:",round(realtimeDAT$Nhietdo_A2/10,digits = 1)," \u00B0C")})
  output$ndo_kv3 <- renderText({paste0("KV3:",round(realtimeDAT$Nhietdo_A3/10,digits = 1)," \u00B0C")})
  
  #Hien thi MIN_DA
  output$doam_min_kv1 <- renderText({paste0("KV1-MIN:",round(CONTROL$DA_A1_MIN/10,digits = 1)," %")})
  output$doam_min_kv2 <- renderText({paste0("KV2-MIN:",round(CONTROL$DA_A2_MIN/10,digits = 1)," %")})
  output$doam_min_kv3 <- renderText({paste0("KV3-MIN:",round(CONTROL$DA_A3_MIN/10,digits = 1)," %")})
  output$doam_kv1 <- renderText({paste0("KV1:",round(realtimeDAT$Doam_A1/10,digits = 1)," %")})
  output$doam_kv2 <- renderText({paste0("KV2:",round(realtimeDAT$Doam_A2/10,digits = 1)," %")})
  output$doam_kv3 <- renderText({paste0("KV3:",round(realtimeDAT$Doam_A3/10,digits = 1)," %")})
  
  #Hien thi MIN_AS
  output$asang_min_kv1 <- renderText({paste0("KV1-MIN:",round(CONTROL$AS_A1_MIN)," lux")})
  output$asang_min_kv2 <- renderText({paste0("KV2-MIN:",round(CONTROL$AS_A2_MIN)," lux")})
  output$asang_min_kv3 <- renderText({paste0("KV3-MIN:",round(CONTROL$AS_A3_MIN)," lux")})
  output$anhsang_kv1 <- renderText({paste0("KV1:",round(realtimeDAT$Anhsang_A1)," lux")})
  output$anhsang_kv2 <- renderText({paste0("KV2:",round(realtimeDAT$Anhsang_A2)," lux")})
  output$anhsang_kv3 <- renderText({paste0("KV3:",round(realtimeDAT$Anhsang_A3)," lux")})
  
  #Hien thi trang thai cua cong tac PHUN SUONG
  
  output$PS1 <- renderText({
    if(realtimeDAT$Nhietdo_A1 > CONTROL$ND_A1_MAX){
      "ON"
    }else{
      "OFF"
    }
  })
  
  output$PS2 <- renderText({
    if(realtimeDAT$Nhietdo_A2 > CONTROL$ND_A2_MAX){
      "ON"
    }else{
      "OFF"
    }
  })
  
  output$PS3 <- renderText({
    if(realtimeDAT$Nhietdo_A3 > CONTROL$ND_A3_MAX){
      "ON"
    }else{
      "OFF"
    }
  })
  
  #Hien thi trang thai cua cong tac BOM NUOC
  
  output$BN1 <- renderText({
    if(realtimeDAT$Doam_A1 < CONTROL$DA_A1_MIN){
      "ON"
    }else{
      "OFF"
    }
  })
  
  output$BN2 <- renderText({
    if(realtimeDAT$Doam_A2 < CONTROL$DA_A2_MIN){
      "ON"
    }else{
      "OFF"
    }
  })
  
  output$BN3 <- renderText({
    if(realtimeDAT$Doam_A3 < CONTROL$DA_A3_MIN){
      "ON"
    }else{
      "OFF"
    }
  })
  
  #Hien thi trang thai cua cong tac DEN
  
  output$AS1 <- renderText({
    if(realtimeDAT$Anhsang_A1 < CONTROL$AS_A1_MIN){
      "ON"
    }else{
      "OFF"
    }
  })
  
  output$AS2 <- renderText({
    if(realtimeDAT$Anhsang_A2 < CONTROL$AS_A2_MIN){
      "ON"
    }else{
      "OFF"
    }
  })
  
  output$AS3 <- renderText({
    if(realtimeDAT$Anhsang_A3 < CONTROL$AS_A3_MIN){
      "ON"
    }else{
      "OFF"
    }
  })
  #Hien thi du lieu dang do thi
  
  #NHIET DO
  output$NhietdoGraph <-renderHighchart({
    hchart(DAT_24, "line",color="red",hcaes(x=Time))%>%
    
    #highchart() %>%
    hc_add_series(DAT_24, "line",color="red",hcaes(x=Time,y=Nhietdo_A1/10), marker = list(symbol = 'circle'), name = "Nhiệt độ - KV1", showInLegend = TRUE)  %>%
    hc_add_series(DAT_24, "line",color="blue",hcaes(x=Time,y=Nhietdo_A2/10), marker = list(symbol = 'square'), name = "Nhiệt độ - KV2", showInLegend = TRUE)  %>%  
    hc_add_series(DAT_24, "line",color="green",hcaes(x=Time,y=Nhietdo_A3/10), marker = list(symbol = 'triangle'), name = "Nhiệt độ - KV3", showInLegend = TRUE)  %>%   
    hc_exporting(enabled = TRUE) %>% 
    hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5",shared = TRUE, borderWidth = 0) %>%
    #hc_title(text="Nhiệt độ theo thời gian",align="center") %>%
    hc_subtitle(text=unique(DAT_24$Date),align="center") %>%
    hc_add_theme(hc_theme_elementary()) %>%
    hc_xAxis( title = list(text = "Giờ:phút")) %>%
    hc_yAxis( title = list(text = "\u00B0C")) %>%
    hc_tooltip(table = TRUE,sort = TRUE,
                pointFormat = paste0( '<br> <span style="color:{point.color}"></span>'," {point.y} \u00B0C"),#ky hieu do C
                headerFormat = '<span style="font-size: 13px">{point.key}</span>'
      )
    
  })
  
  #DO AM
  output$DoamGraph <-renderHighchart({
    hchart(DAT_24, "line",color="red",hcaes(x=Time))%>%
    #highchart() %>%
      
      hc_add_series(DAT_24, "line",color="red",hcaes(x=Time,y=Doam_A1/10), marker = list(symbol = 'circle'), name = "Độ ẩm - KV1", showInLegend = TRUE)  %>%
      hc_add_series(DAT_24, "line",color="blue",hcaes(x=Time,y=Doam_A2/10), marker = list(symbol = 'square'), name = "Độ ẩm - KV2", showInLegend = TRUE)  %>%  
      hc_add_series(DAT_24, "line",color="green",hcaes(x=Time,y=Doam_A3/10), marker = list(symbol = 'triangle'), name = "Độ ẩm - KV3", showInLegend = TRUE)  %>%   
      hc_exporting(enabled = TRUE) %>% 
      hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5",shared = TRUE, borderWidth = 0) %>%
      #hc_title(text="Độ ẩm theo thời gian",align="center") %>%
      hc_subtitle(text=unique(DAT_24$Date),align="center") %>%
      hc_add_theme(hc_theme_elementary()) %>%
      hc_xAxis( title = list(text = "Giờ:phút")) %>%
      hc_yAxis( title = list(text = "%")) %>%
      hc_tooltip(table = TRUE,sort = TRUE,
                 pointFormat = paste0( '<br> <span style="color:{point.color}"></span>'," {point.y} %"),#ky hieu %
                 headerFormat = '<span style="font-size: 13px">{point.key}</span>'
      )
  })
  
  #Anh sang
  output$AnhsangGraph <-renderHighchart({
    hchart(DAT_24, "line",color="red",hcaes(x=Time))%>%
      #highchart() %>%
      
      hc_add_series(DAT_24, "line",color="red",hcaes(x=Time,y=Anhsang_A1), marker = list(symbol = 'circle'), name = "Ánh sáng - KV1", showInLegend = TRUE)  %>%
      hc_add_series(DAT_24, "line",color="blue",hcaes(x=Time,y=Anhsang_A2), marker = list(symbol = 'square'), name = "Ánh sáng - KV2", showInLegend = TRUE)  %>%  
      hc_add_series(DAT_24, "line",color="green",hcaes(x=Time,y=Anhsang_A3), marker = list(symbol = 'triangle'), name = "Ánh sáng - KV3", showInLegend = TRUE)  %>%   
      hc_exporting(enabled = TRUE) %>% 
      hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5",shared = TRUE, borderWidth = 0) %>%
      #hc_title(text="Độ ẩm theo thời gian",align="center") %>%
      hc_subtitle(text=unique(DAT_24$Date),align="center") %>%
      hc_add_theme(hc_theme_elementary()) %>%
      hc_xAxis( title = list(text = "Giờ:phút")) %>%
      hc_yAxis( title = list(text = "LUX")) %>%
      hc_tooltip(table = TRUE,sort = TRUE,
                 pointFormat = paste0( '<br> <span style="color:{point.color}"></span>'," {point.y} lux"),#ky hieu lux
                 headerFormat = '<span style="font-size: 13px">{point.key}</span>'
      )
  })
  #---------------------------------------------------------------------------#
  #-------------------------STATISTICS----------------------------------------#
  #-------------------------STATISTICS----------------------------------------#
  #---------------------------------------------------------------------------#

  #TAB STATISTIC
  #hien thi data dang bang
  output$the_data<- DT::renderDataTable({
    DT::datatable(datasensors, options = list(lengthMenu = c(12, 24, 48), pageLength = 20, scrollX = TRUE))
  })
  output$downloadData <- downloadHandler(
    filename = function() { 
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(datasensors, file)
    })
  #---------------------------------------------------------------------------#
  #---------------------------SETTINGS----------------------------------------#
  #---------------------------SETTINGS----------------------------------------#
  #---------------------------------------------------------------------------#
  #Login Logout
  USER <- reactiveValues(Logged = FALSE , session = session$user) 
  source("www/Login.R",  local = TRUE)
  
  output$LoginPage <- renderUI({    
    if (USER$Logged == TRUE) {
      
      #Dang nhap thanh cong
      
      
      fluidRow(
        titlePanel(title = "THIẾT LẬP NGƯỠNG CẢM BIẾN"), align = "center",
        tags$hr(),
        uiOutput("Setup")#hien thi màn hình thiết lập
      )
    }#End IF (login thanh cong)  
  })
  
  
  
  #Man hinh thiet lap nguong
  output$Setup <- renderUI({
    fluidRow(
      #titlePanel(title = "Thiết lập ngưỡng cảnh báo"), align = "center",
      column(width=6,style = "background-color:#F1F1F1",#thiet lap nguong
        #Nhiet do
        column(width = 4,
             column(width = 12,style = "background-color:#DFE8CC",tags$br(),
                    tags$style("#temperature_a1_min {font-size:20px;height:50px;}"),
                    numericInput(inputId="temperature_a1_min",label="Nh. độ A1-MIN",value=CONTROL$ND_A1_MIN/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$style("#temperature_a1_max {font-size:20px;height:50px;}"),
                    numericInput(inputId="temperature_a1_max",label="Nh. độ A1-MAX",value=CONTROL$ND_A1_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$hr(),
                    tags$style("#temperature_a2_min {font-size:20px;height:50px;}"),
                    numericInput(inputId="temperature_a2_min",label="Nh. độ A2-MIN",value=CONTROL$ND_A2_MIN/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$style("#temperature_a2_max {font-size:20px;height:50px;}"),
                    numericInput(inputId="temperature_a2_max",label="Nh. độ A2-MAX",value=CONTROL$ND_A2_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$hr(),
                    tags$style("#temperature_a3_min {font-size:20px;height:50px;}"),
                    numericInput(inputId="temperature_a3_min",label="Nh. độ A3-MIN",value=CONTROL$ND_A3_MIN/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$style("#temperature_a3_max {font-size:20px;height:50px;}"),
                    numericInput(inputId="temperature_a3_max",label="Nh. độ A3-MAX",value=CONTROL$ND_A3_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
             ),
        ),#End column 4
      
        #Do am
        column(width = 4,
             column(width = 12,style = "background-color:#DFE8CC",tags$br(),
                    tags$style("#humidity_a1_min {font-size:20px;height:50px;}"),
                    numericInput(inputId="humidity_a1_min",label="Độ ẩm A1-MIN",value=CONTROL$DA_A1_MIN/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$style("#humidity_a1_max {font-size:20px;height:50px;}"),
                    numericInput(inputId="humidity_a1_max",label="Độ ẩm A1-MAX",value=CONTROL$DA_A1_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$hr(),
                    tags$style("#humidity_a2_min {font-size:20px;height:50px;}"),
                    numericInput(inputId="humidity_a2_min",label="Độ ẩm A2-MIN",value=CONTROL$DA_A2_MIN/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$style("#humidity_a2_max {font-size:20px;height:50px;}"),
                    numericInput(inputId="humidity_a2_max",label="Độ ẩm A2-MAX",value=CONTROL$DA_A2_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$hr(),
                    tags$style("#humidity_a3_min {font-size:20px;height:50px;}"),
                    numericInput(inputId="humidity_a3_min",label="Độ ẩm A3-MIN",value=CONTROL$DA_A3_MIN/10,min = 0,max = 100,step = 0.1,width = NULL),
                    tags$style("#humidity_a3_max {font-size:20px;height:50px;}"),
                    numericInput(inputId="humidity_a3_max",label="Độ ẩm A3-MAX",value=CONTROL$DA_A3_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
             ),
        ),#End column 4
      
        #Anh sang
        column(width = 4,
             column(width = 12,style = "background-color:#DFE8CC",tags$br(),
                    tags$style("#light_a1_min {font-size:20px;height:50px;}"),
                    numericInput(inputId="light_a1_min",label="A. sáng A1-MIN",value=CONTROL$AS_A1_MIN,min = 0,max = 65535,step = 10,width = NULL),
                    tags$style("#light_a1_max {font-size:20px;height:50px;}"),
                    numericInput(inputId="light_a1_max",label="A. sáng A1-MAX",value=CONTROL$AS_A1_MAX,min = 0,max = 65535,step = 10,width = NULL),
                    tags$hr(),
                    tags$style("#light_a2_min {font-size:20px;height:50px;}"),
                    numericInput(inputId="light_a2_min",label="A. sáng A2-MIN",value=CONTROL$AS_A2_MIN,min = 0,max = 65535,step = 10,width = NULL),
                    tags$style("#light_a2_max {font-size:20px;height:50px;}"),
                    numericInput(inputId="light_a2_max",label="A. sáng A2-MAX",value=CONTROL$AS_A2_MAX,min = 0,max = 65535,step = 10,width = NULL),
                    tags$hr(),
                    tags$style("#light_a3_min {font-size:20px;height:50px;}"),
                    numericInput(inputId="light_a3_min",label="A. sáng A3-MIN",value=CONTROL$AS_A3_MIN,min = 0,max = 65535,step = 10,width = NULL),
                    tags$style("#light_a3_max {font-size:20px;height:50px;}"),
                    numericInput(inputId="light_a3_max",label="A. sáng A3-MAX",value=CONTROL$AS_A3_MAX,min = 0,max = 65535,step = 10,width = NULL),
             ),#End column 12
        ),#End column 4
             
             #Email
             tags$hr(),
             column(width = 12,#style = "background-color:#CCCCCC;",
                    tags$h4("Email người nhận"),
                    hr(),
                    textInput("email_to", "TO:", value="itspider2018@gmail.com",),
             ),#End column Email
          
          #OK button
          tags$hr(),  
          column(width = 12,tags$br(),
              tags$style('#Save {background-color: #6BCB77;}'),
              actionButton("Save", "Lưu thiết lập"),
          ),
          tags$hr(),
      ),#End thiet lap nguong
      
      #Cong tac dieu khien
      column(width = 6,
             #Gia tri cam bien hien tai
             tags$h4("GIÁ TRỊ CẢM BIẾN HIỆN TẠI"),
             fluidRow(
               #nhiet do
               column(width = 4,tags$br(),#style = "background-color:#EDDFB3",
                      shinyjs::disabled(numericInput(inputId="nd_ht_a1",label="Nhiệt độ HT (A1)",value=realtimeDAT$Nhietdo_A1/10,width = NULL)), 
               ),
               column(width = 4,tags$br(),#style = "background-color:#EDDFB3",
                      shinyjs::disabled(numericInput(inputId="nd_ht_a2",label="Nhiệt độ HT (A2)",value=realtimeDAT$Nhietdo_A2/10,width = NULL)), 
               ),
               column(width = 4,tags$br(),#style = "background-color:#EDDFB3",
                      shinyjs::disabled(numericInput(inputId="nd_ht_a3",label="Nhiệt độ HT (A3)",value=realtimeDAT$Nhietdo_A3/10,width = NULL)), 
               ),
               #do am
               column(width = 4,tags$br(),#style = "background-color:#EDDFB3",
                      shinyjs::disabled(numericInput(inputId="da_ht_a1",label="Độ ẩm HT (A1)",value=realtimeDAT$Doam_A1/10,width = NULL)), 
               ),
               column(width = 4,tags$br(),#style = "background-color:#EDDFB3",
                      shinyjs::disabled(numericInput(inputId="da_ht_a2",label="Độ ẩm HT (A2)",value=realtimeDAT$Doam_A2/10,width = NULL)), 
               ),
               column(width = 4,tags$br(),#style = "background-color:#EDDFB3",
                      shinyjs::disabled(numericInput(inputId="da_ht_a3",label="Độ ẩm HT (A3)",value=realtimeDAT$Doam_A3/10,width = NULL)), 
               ),
               #anh sang
               column(width = 4,tags$br(),#style = "background-color:#EDDFB3",
                      shinyjs::disabled(numericInput(inputId="as_ht_a1",label="Ánh sáng HT (A1)",value=realtimeDAT$Anhsang_A1,width = NULL)), 
               ),
               column(width = 4,tags$br(),#style = "background-color:#EDDFB3",
                      shinyjs::disabled(numericInput(inputId="as_ht_a2",label="Ánh sáng HT (A2)",value=realtimeDAT$Anhsang_A2,width = NULL)), 
               ),
               column(width = 4,tags$br(),#style = "background-color:#EDDFB3",
                      shinyjs::disabled(numericInput(inputId="as_ht_a3",label="Ánh sáng HT (A3)",value=realtimeDAT$Anhsang_A3,width = NULL)), 
               ),
             ),#End fluidRow cho Gia tri hien tai
             
             #Thiet lap thoi gian
             tags$hr(),
             tags$h4("THIẾT LẬP THỜI GIAN ĐÓNG MỞ THIẾT BỊ"),
             tags$hr(),
             tags$h5("Auto: Luôn luôn đóng/ngắt - Manu: Theo thời gian thiết lập"),
             #style = "background-color:#E2DCC8",
             #Cong tac cho may phun suong
             fluidRow(
               #Cong tac cho bom nuoc
               fluidRow(
                 column(width = 4,
                        switchInput(inputId = "TBN.A1", value = CONTROL$TIME_BN1, disable = FALSE,onLabel = "Auto",offLabel = "Manu",size = "large"),
                        tags$h5("Bơm-KV.1", style = "font-family: 'Helvetica';color: red"),
                 ),#End column 4
                 column(width = 4,
                        switchInput(inputId = "TBN.A2", value = CONTROL$TIME_BN2, disable = FALSE,onLabel = "Auto",offLabel = "Manu",size = "large"),
                        tags$h5("Bơm-KV.2", style = "font-family: 'Helvetica';color: blue"),
                 ),#End column 4
                 column(width = 4,
                        switchInput(inputId = "TBN.A3", value = CONTROL$TIME_BN3, disable = FALSE,onLabel = "Auto",offLabel = "Manu",size = "large"),
                        tags$h5("Bơm-KV.3", style = "font-family: 'Helvetica';color: green"),
                 ),#End column 4
               ),#End fluidRow
               
               fluidRow(
               column(width = 4,
                      switchInput(inputId = "TPS.A1", value = CONTROL$TIME_PS1, disable = FALSE,onLabel = "Auto",offLabel = "Manu",size = "large"),
                      tags$h5("PS-KV.1", style = "font-family: 'Helvetica';color: red"),
               ),#End column 4
               column(width = 4,
                      switchInput(inputId = "TPS.A2", value = CONTROL$TIME_PS2, disable = FALSE,onLabel = "Auto",offLabel = "Manu",size = "large"),
                      tags$h5("PS-KV.2", style = "font-family: 'Helvetica';color: blue"),
               ),#End column 4
               column(width = 4,
                      switchInput(inputId = "TPS.A3", value = CONTROL$TIME_PS3, disable = FALSE,onLabel = "Auto",offLabel = "Manu",size = "large"),
                      tags$h5("PS-KV.3", style = "font-family: 'Helvetica';color: green"),
               ),#End column 4
             ),#End fluidRow
             
             #Cong tac cho den
             fluidRow(
               column(width = 4,
                      switchInput(inputId = "TDen.A1", value = CONTROL$TIME_AS1, disable = FALSE,onLabel = "Auto",offLabel = "Manu",size = "large"),
                      tags$h5("Đèn-KV.1", style = "font-family: 'Helvetica';color: red"),
               ),#End column 4
               column(width = 4,
                      switchInput(inputId = "TDen.A2", value = CONTROL$TIME_AS2, disable = FALSE,onLabel = "Auto",offLabel = "Manu",size = "large"),
                      tags$h5("Đèn-KV.2", style = "font-family: 'Helvetica';color: blue"),
               ),#End column 4
               column(width = 4,
                      switchInput(inputId = "TDen.A3", value =CONTROL$TIME_AS3, disable = FALSE,onLabel = "Auto",offLabel = "Manu",size = "large"),
                      tags$h5("Đèn-KV.3", style = "font-family: 'Helvetica';color: green"),
               ),#End column 4
               tags$hr(),
             ),#End fluidRow cho cong tac den
             ),#End fluid Row cho hang cong tac
             
             #Thiet lap thoi gian Auto/Manual
             fluidRow(
               tags$hr(),  
               column(width = 12,tags$br(),#style = "background-color:#E2DCC8",
                      column(width = 4,
                             tags$style("#timeON {font-size:30px;height:50px;}"),
                             numericInput(inputId="timeON",label="Giờ Khởi động",value=CONTROL$TIME_ON,min = 0,max = 12,step = 1,width = NULL),
                      ),
                      column(width = 1),
                      column(width = 4,
                             tags$style("#timeOFF {font-size:30px;height:50px;}"),
                             numericInput(inputId="timeOFF",label="Giờ Tạm dừng",value=CONTROL$TIME_OFF,min = 13,max = 23,step = 1,width = NULL),
                      ),
               ),
             ),#End fluidRow cho auto ON/OFF
    
      ),#End khung cong tac dieu khien va thoi gian ON/OFF
      
    )#End fluidrow 

  })#End Output Setup
  
  #Nhan nut Luu thiet lap
  observeEvent(input$Save,{
    if(file.exists("www/control.txt")){
      #file.remove("www/control.txt")
    }
    else{
      file.create("www/control.txt")
      head="DATE,TIME,DA_A1_MIN,DA_A1_MAX,DA_A2_MIN,DA_A2_MAX,DA_A3_MIN,DA_A3_MAX,ND_A1_MIN,ND_A1_MAX,ND_A2_MIN,ND_A2_MAX,ND_A3_MIN,ND_A3_MAX,AS_A1_MIN,AS_A1_MAX,AS_A2_MIN,AS_A2_MAX,AS_A3_MIN,AS_A3_MAX,TIME_OFF,TIME_ON,TIME_BN1,TIME_BN2,TIME_BN3,TIME_PS1,TIME_PS2,TIME_PS3,TIME_AS1,TIME_AS2,TIME_AS3"
      write(head,file="www/control.txt",append=TRUE)
    }
    dmy<-format(as.Date(Sys.Date(), '%Y/%m/%d'), '%d/%m/%Y')
    hms<-format(Sys.time(), '%H:%M:%S')
    write.table(dmy,"www/control.txt",quote = FALSE, sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE )
    write.table(hms,"www/control.txt",quote = FALSE,sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE )
    write.table(input$humidity_a1_min*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$humidity_a1_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$humidity_a2_min*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$humidity_a2_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$humidity_a3_min*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$humidity_a3_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$temperature_a1_min*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$temperature_a1_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$temperature_a2_min*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$temperature_a2_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$temperature_a3_min*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$temperature_a3_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$light_a1_min,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$light_a1_max,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$light_a2_min,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$light_a2_max,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$light_a3_min,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$light_a3_max,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$timeOFF,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$timeON,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$TBN.A1,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$TBN.A2,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$TBN.A3,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$TPS.A1,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$TPS.A2,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$TPS.A3,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$TDen.A1,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$TDen.A2,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$TDen.A3,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
    
    #Thay the noi dung TRUE FALSE bang 1 0
    tx  <- readLines("www/control.txt")
    tx2  <- gsub(pattern = "TRUE", replace = 1,
            gsub(pattern = "FALSE", replace = 0, x = tx))
    writeLines(tx2, con="www/control.txt")
    
    #Luu yeu cau Write to PLC vao file request.req, file nay da co do ngay tu khi khoi dong da tao ra file nay roi
    dmy<-format(as.Date(Sys.Date(), '%Y/%m/%d'), '%d/%m/%Y')
    hms<-format(Sys.time(), '%H:%M:%S')
    #write.table("\n","www/request.req",quote = FALSE, sep = "",row.names=FALSE, col.names=FALSE, eol="", append =TRUE )
    write.table(dmy,"www/request.req",quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
    write.table(hms,"www/request.req",quote = FALSE,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
    write.table("W","www/request.req",quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
    
    shinyjs::refresh()
    
  })
  
  
})#End server side
