library(shiny)
shiny::tags#101 tags in HTML

library(shinydashboard)

library(shinyWidgets)
shinyWidgets::shinyWidgetsGallery()#Shiny switch input

library(highcharter)#highchartOutput

library(tidyverse)#fiter function

library(DBI)#For login database

source("www/global.R")


#HOMEPAGE

header <- dashboardHeader(title = "NTU Smart Agri",#tags$img(src="Pics/header.png",width="100%", align="left"),
  
  dropdownMenuOutput("messageMenu")
  #"NTU Smart-Agri"
)#End header

sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("TRANG CHỦ", tabName = "home", icon = icon("home")),  
      menuItem("Thống kê", tabName = "statictics", icon = icon("dashboard")),
      menuItem("Thiết lập", icon = icon("life-ring"), tabName = "settings", badgeColor = "green")
    ),
    tags$br(),
    tags$img(src="Pics/sanhan_tim3.jpg",width="100%"),
    tags$img(src="Pics/sanhan_tim.png",width="100%"),
    tags$img(src="Pics/sanhan_tim_1.jpg",width="100%")
    
)#End Sidebar

body <- dashboardBody(
    tabItems(
      #---------------------------------------------------------------------------#
      #------------------------------HOME-----------------------------------------#
      #------------------------------HOME-----------------------------------------#
      #---------------------------------------------------------------------------#
      tabItem(tabName = "home",
        fluidRow(
          column(width = 12,
            #tags$head(tags$style(HTML(".small-box {height: 50px}"))),
            valueBoxOutput("NhietdoBox1", width = 4),
            valueBoxOutput("DoamBox1", width = 4),
            valueBoxOutput("AnhsangBox1", width = 4),
          ),#End column
          column(width = 12,
            valueBoxOutput("NhietdoBox2", width = 4),
            valueBoxOutput("DoamBox2", width = 4),
            valueBoxOutput("AnhsangBox2", width = 4),
          ),#End column
          column(width = 12,
            valueBoxOutput("NhietdoBox3", width = 4),
            valueBoxOutput("DoamBox3", width = 4),
            valueBoxOutput("AnhsangBox3", width = 4),
            ),#End column
        ),#End fluidrow
        
        #Cong tac cac thiet bi
        fluidRow(
          column(width = 12,
            tabBox(id = "tabset1",height = "460px", width = 12, 
            # The id lets us use input$tabset1 on the server to find the current tab
              #Tab Nhiệt độ
            
              tabPanel(id = "Nhietdo", "Nhiệt độ",
                column(width=4,
                    tags$h5("TRẠNG THÁI CÔNG TẮC"),
                    fluidRow(
                      column(width=4,"PS-KV1:", verbatimTextOutput("PS1")),
                      column(width=4,"PS-KV2:", verbatimTextOutput("PS2")),
                      column(width=4,"PS-KV3:", verbatimTextOutput("PS3"))
                    ),
                    tags$hr(),
                    fluidRow(
                      column(width=6,
                        tags$h5("NGƯỠNG THIẾT LẬP"),
                        verbatimTextOutput("ndo_max_kv1"),
                        tags$head(tags$style(HTML("#ndo_max_kv1 {font-size: 12px;}"))),
                        tags$br(),
                        verbatimTextOutput("ndo_max_kv2"),
                        tags$head(tags$style(HTML("#ndo_max_kv2 {font-size: 12px;}"))),
                        tags$br(),
                        verbatimTextOutput("ndo_max_kv3"),
                        tags$head(tags$style(HTML("#ndo_max_kv3 {font-size: 12px;}")))
                      ),
                      column(width=6,
                        tags$h5("GIÁ TRỊ HIỆN TẠI"),
                        verbatimTextOutput("ndo_kv1"),
                        tags$head(tags$style(HTML("#ndo_kv1 {font-size: 12px;}"))),
                        tags$br(),
                        verbatimTextOutput("ndo_kv2"),
                        tags$head(tags$style(HTML("#ndo_kv2 {font-size: 12px;}"))),
                        tags$br(),
                        verbatimTextOutput("ndo_kv3"),
                        tags$head(tags$style(HTML("#ndo_kv3 {font-size: 12px;}")))
                      ),
                    )
                    
                  ),#End column 4
                
                #Do thi Nhiet do
                column(width=8,highchartOutput("NhietdoGraph")),#End column 8
              ),#End tab Nhiệt độ
              
              #Tab độ ẩm
              tabPanel(id = "Doam", "Độ ẩm",
                column(width=4,
                  tags$h5("TRẠNG THÁI CÔNG TẮC"),
                  fluidRow(
                    column(width=4,"BN-KV1:", verbatimTextOutput("BN1")),
                    column(width=4,"BN-KV2:", verbatimTextOutput("BN2")),
                    column(width=4,"BN-KV3:", verbatimTextOutput("BN3"))
                  ),#End fliud row
                  
                  tags$hr(),
                  fluidRow(
                    column(width=6,
                      tags$h5("NGƯỠNG THIẾT LẬP"),
                      verbatimTextOutput("doam_min_kv1"),
                      tags$head(tags$style(HTML("#doam_min_kv1 {font-size: 12px;}"))),
                      tags$br(),
                      verbatimTextOutput("doam_min_kv2"),
                      tags$head(tags$style(HTML("#doam_min_kv2 {font-size: 12px;}"))),
                      tags$br(),
                      verbatimTextOutput("doam_min_kv3"),
                      tags$head(tags$style(HTML("#doam_min_kv3 {font-size: 12px;}")))
                    ),
                    #GIÁ TRỊ HIỆN TẠI
                    column(width=6,
                      tags$h5("GIÁ TRỊ HIỆN TẠI"),
                      verbatimTextOutput("doam_kv1"),
                      tags$head(tags$style(HTML("#doam_kv1 {font-size: 12px;}"))),
                      tags$br(),
                      verbatimTextOutput("doam_kv2"),
                      tags$head(tags$style(HTML("#doam_kv2 {font-size: 12px;}"))),
                      tags$br(),
                      verbatimTextOutput("doam_kv3"),
                      tags$head(tags$style(HTML("#doam_kv3 {font-size: 12px;}")))
                    ),
                   ),#End fluid row
                ),#End column 4
                
                #Do thi Do am
                  column(width=8,highchartOutput("DoamGraph"), height="300px"),#End column 8     
              ),#End tab Độ ẩm
            
            #Tab ánh sáng
            tabPanel(id = "Anhsang", "Ánh sáng",
              column(width=4,
                tags$h5("TRẠNG THÁI CÔNG TẮC"),
                fluidRow(
                  column(width=4,"DEN-KV1:", verbatimTextOutput("AS1")),
                  column(width=4,"DEN-KV2:", verbatimTextOutput("AS2")),
                  column(width=4,"DEN-KV3:", verbatimTextOutput("AS3"))
              ),#End fliud row
              tags$hr(),
              fluidRow(
                column(width=6,
                  tags$h5("NGƯỠNG THIẾT LẬP"),
                  verbatimTextOutput("asang_min_kv1"),
                  tags$head(tags$style(HTML("#asang_min_kv1 {font-size: 12px;}"))),
                  tags$br(),
                  verbatimTextOutput("asang_min_kv2"),
                  tags$head(tags$style(HTML("#asang_min_kv2 {font-size: 12px;}"))),
                  tags$br(),
                  verbatimTextOutput("asang_min_kv3"),
                  tags$head(tags$style(HTML("#asang_min_kv3 {font-size: 12px;}")))
                ),
                column(width=6,
                  tags$h5("GIÁ TRỊ HIỆN TẠI"),
                  verbatimTextOutput("anhsang_kv1"),
                  tags$head(tags$style(HTML("#anhsang_kv1 {font-size: 12px;}"))),
                  tags$br(),
                  verbatimTextOutput("anhsang_kv2"),
                  tags$head(tags$style(HTML("#anhsang_kv2 {font-size: 12px;}"))),
                  tags$br(),
                  verbatimTextOutput("anhsang_kv3"),
                  tags$head(tags$style(HTML("#anhsang_kv3 {font-size: 12px;}")))
                ),
              ),#End fluid row
            ),#End column 4

              #Do thi anh sang
              column(width=8,highchartOutput("AnhsangGraph"), height="235px"),#End column 8
            )#End tab KV3
          ),#End tab box
        ),#End column 12
      ),#End fluid row
    ),#End Tab HOME
    #---------------------------------------------------------------------------#
    #-------------------------STATISTICS----------------------------------------#
    #-------------------------STATISTICS----------------------------------------#
    #---------------------------------------------------------------------------#  
    tabItem(tabName = "statictics",
      fluidRow(
        column(3,downloadButton('downloadData', 'Download'),
          tags$style('#downloadData {background-color: #6BCB77;}'),
        ),#End column 3
        column(9,dateRangeInput("daterange", "Lọc theo ngày:",start = min(DAT$Date),end = max(DAT$Date))
                                #format = "dd/mm/yyyy",separator = "/")
        ),#End column 9
        
        shinyjs::useShinyjs(),
        hr(),
        DT::dataTableOutput("the_data")
      ),
                  
    ),#End Tab STATISTICS
    #---------------------------------------------------------------------------#
    #---------------------------SETTINGS----------------------------------------#
    #---------------------------SETTINGS----------------------------------------#
    #---------------------------------------------------------------------------#
    tabItem(tabName = "settings",
      fluidPage(
        uiOutput("uiLogin"),
        textOutput("pass"),
        tags$head(tags$style("#pass{color: red;")),#),    
          
        #hien thi dong login/logout
        uiOutput("userPanel"),
        #Hien thi trang login thanh cong
        uiOutput("LoginPage")
        #uiOutput("Setup"),#hien thi màn hình thiết lập
      )#End fluid page
    )#End Tab Settings
    
  )#End tabItems
)#End Body




dashboardPage(header, sidebar, body)
