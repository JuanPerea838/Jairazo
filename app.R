library(shiny)
library(shinydashboard)
library(plotly)
library(datasets)
library(openxlsx)
library(dplyr)
library(stringr)
library(caTools)
library(gapminder)
library(ggplot2)
library(gganimate)
library(tidyverse)
library(plyr)
library(treemap)
library(rworldmap)
library(rgdal)
library(threejs)


datos = read.csv("global_terror.csv", sep=",", stringsAsFactors = F) # Colocarla como variable global

paises = unique(datos$country_txt)

ui <- dashboardPage(skin = "purple",
                    
        dashboardHeader(title = "Proyecto Final" ,titleWidth = 300),
                    
        dashboardSidebar( width = 250,
                          sidebarMenu( 
                          menuItem("Inicio",  icon=icon("info"), tabName = "Inicio"),
                          menuItem("Condiciones atmosfÃ©ricas",  icon=icon("globe"), tabName = "Map"),
                          menuItem("Buscador",  icon=icon("map-marker-alt"), tabName = "Buscador"),
                          menuItem("Tabla de resultados", icon = icon("tasks"), tabName = "Tabla"),
                          menuItem("GrÃ¡ficas", icon = icon("signal"), tabName = "GrÃ¡ficas")
                            )
                    ),
        dashboardBody(
                      tags$head(
                      tags$style(HTML('.main-header .logo {font-family: "Impact", fantasy;font-size: 28px;}')),
                      tags$style(HTML(".main-sidebar { font-size: 18px; }"))
                      ),
                      tabItems(
                        ######################
                        tabItem(tabName = "Inicio",
                                box(title = "InformaciÃ³n de la API", status = "info", collapsible = T, width = 20, solidHeader = TRUE, "La API de CONAGUA (ComisiÃ³n Nacional del Agua) provee mÃ¡s de 13 millones de registros de las condiciones atmosfÃ©ricas de todo el paÃ­s. Contiene datos como la direcciÃ³n del viento, probabilidad de precipitaciÃ³n, descripciÃ³n del cielo, velocidad del viento, 
                                    entre otros datos que ayudarÃ¡n a observar las condiciones de cada estado de la repÃºblica mexicana. Estos datos los puedes encontrar en: https://api.datos.gob.mx/v1/condiciones-atmosfericas", align = "left"),
                                img(src='https://www.revista.unam.mx/wp-content/uploads/img1-45.jpg', width = 870, height = 447)
                                ),
                        ######################
                        tabItem(tabName = "Buscador",
                                selectInput(inputId = "pais", label = "Elija un estado:", 
                                             paises),
                                h3(" "),
                                fluidRow(
                                  box(title = "Condiciones AtmosfÃ©ricas por Estado", status="success", collapsible = T, plotOutput("region1", width = "100%", height = "800px"), width = 10, background = "light-blue"),
                                ),
                        ),
                        ######################
                        tabItem(tabName = "Tabla",
                                selectInput(inputId = "pais", label = "Elija un estado:", 
                                            paises),
                                fluidRow(
                                  box(title = "Condiciones atmosfÃ©ricas", status="success", collapsible = T, plotOutput(outputId = "ojivas",  brush = "plot_brush", height = "500px"), width = 10, height = 20, background = "light-blue"),
                                )
                        ),
                        ######################
                        tabItem(tabName = "Map",
                                
                                box(title = "Mapa", status = "info" , collapsible = T, width = 20, solidHeader = TRUE, 
                                img(src='https://upload.wikimedia.org/wikipedia/commons/4/40/Koppen-Geiger_Map_MEX_present.svg', width = 870, height = 447)
                                ),
                                box(title = "InformaciÃ³n ", status = "info" , collapsible = T, width = 20, solidHeader = TRUE, "En el presente mapa se muestra las zonas climÃ¡ticas generales hasta 2016, 
                                    esto nos sirve para comparar con las condiciones atmosfÃ©ricas hoy en dÃ­a y ver el impacto del calentamiento global.")
                                
                                ),
                        ######################
                        tabItem(tabName = "GrÃ¡ficas",
                                selectInput(inputId = "pais", label = "Elija un estado:", 
                                            paises),
                                fluidRow(
                                  box(title = "Condiciones atmosfÃ©ricas", status="success", collapsible = T, plotOutput(outputId = "ojivas",  brush = "plot_brush", height = "500px"), width = 10, height = 20, background = "teal"),
                                )
                        )
                      )
                      )
                    
)

server <- function(input, output) {
  
  
}

shinyApp(ui = ui, server = server)
