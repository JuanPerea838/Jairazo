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
library(png)


datos = read.csv("QuintanaRoo.csv", sep=",", stringsAsFactors = F) # Colocarla como variable global
#head(datos)

ciudades = unique(datos$city_name)

cozumel = datos %>% 
  filter(results.city == "Cozumel")
islamujeres = datos %>% 
  filter(results.city == "Isla Mujeres")
solidaridad = datos %>% 
  filter(results.city == "Solidaridad")
PuertoMorelos = datos %>% 
  filter(results.city == "Puerto Morelos")
FelipeCarPuerto = datos %>% 
  filter(results.city == "Felipe Carrillo Puerto")
OthonPBlanco = datos %>% 
  filter(results.city == "OthÃ³n P. Blanco")
BenitoJua = datos %>% 
  filter(results.city == "Benito JuÃ¡rez")
JoseMaMor = datos %>% 
  filter(results.city == "Jose Maria Morelos")
LazaCarde = datos %>% 
  filter(results.city == "LÃ¡zaro CÃ¡rdenas")
Tulum = datos %>% 
  filter(results.city == "Tulum")
bacalar = datos %>% 
  filter(results.city == "Bacalar")

ggplot(cozumel, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(islamujeres, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(solidaridad, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(PuertoMorelos, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(FelipeCarPuerto, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(OthonPBlanco, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(BenitoJua, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(JoseMaMor, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(LazaCarde, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(Tulum, aes(x=sky_description, y=temp_celsius))+geom_point()
ggplot(bacalar, aes(x=sky_description, y=temp_celsius))+geom_point()


summary(cozumel$temp_celsius)
summary(cozumel$wind_speed)
summary(cozumel$relative_humidity)
summary(cozumel$precipitation_prob)

summary(islamujeres$temp_celsius)
summary(islamujeres$wind_speed)
summary(islamujeres$relative_humidity)
summary(islamujeres$precipitation_prob)


summary(solidaridad$temp_celsius)
summary(solidaridad$wind_speed)
summary(solidaridad$relative_humidity)
summary(solidaridad$precipitation_prob)

summary(PuertoMorelos$temp_celsius)
summary(PuertoMorelos$wind_speed)
summary(PuertoMorelos$relative_humidity)
summary(PuertoMorelos$precipitation_prob)

summary(FelipeCarPuerto$temp_celsius)
summary(FelipeCarPuerto$wind_speed)
summary(FelipeCarPuerto$relative_humidity)
summary(FelipeCarPuerto$precipitation_prob)

summary(OthonPBlanco$temp_celsius)
summary(OthonPBlanco$wind_speed)
summary(OthonPBlanco$relative_humidity)
summary(OthonPBlanco$precipitation_prob)

summary(BenitoJua$temp_celsius)
summary(BenitoJua$wind_speed)
summary(BenitoJua$relative_humidity)
summary(BenitoJua$precipitation_prob)

summary(JoseMaMor$temp_celsius)
summary(JoseMaMor$wind_speed)
summary(JoseMaMor$relative_humidity)
summary(JoseMaMor$precipitation_prob)

summary(LazaCarde$temp_celsius)
summary(LazaCarde$wind_speed)
summary(LazaCarde$relative_humidity)
summary(LazaCarde$precipitation_prob)

summary(Tulum$temp_celsius)
summary(Tulum$wind_speed)
summary(Tulum$relative_humidity)
summary(Tulum$precipitation_prob)

summary(bacalar$temp_celsius)
summary(bacalar$wind_speed)
summary(bacalar$relative_humidity)
summary(bacalar$precipitation_prob)





ui <- dashboardPage(skin = "purple",
                    
                    dashboardHeader(title = "Proyecto Final" ,titleWidth = 300),
                    
                    dashboardSidebar( width = 250,
                                      sidebarMenu( 
                                        menuItem("Inicio",  icon=icon("info"), tabName = "Inicio"),
                                        menuItem("Condiciones atmosféricas",  icon=icon("globe"), tabName = "Map"),
                                        menuItem("Cozumel", icon = icon("cloud"), tabName = "Cozumel"),
                                        menuItem("Isla Mujeres", icon = icon("cloud"), tabName = "IslaMujeres"),
                                        menuItem("Solidaridad", icon = icon("cloud"), tabName = "Solidaridad"),
                                        menuItem("Puerto Morelos", icon = icon("cloud"), tabName = "PuertoMorelos"),
                                        menuItem("Felipe carrillo Puerto", icon = icon("cloud"), tabName = "FelipeCar"),
                                        menuItem("Othon P. Blanco", icon = icon("cloud"), tabName = "OthonPBlanco"),
                                        menuItem("Benito Juárez", icon = icon("cloud"), tabName = "Benito"),
                                        menuItem("José María Morelos", icon = icon("cloud"), tabName = "JoseMarMor"),
                                        menuItem("Lázaro Cárdenas", icon = icon("cloud"), tabName = "LazaroCard"),
                                        menuItem("Tulum", icon = icon("cloud"), tabName = "Tulum"),
                                        menuItem("Bacalar", icon = icon("cloud"), tabName = "Bacalar")
                                        
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
                                box(title = "Información de la API", status = "info", collapsible = T, width = 20, solidHeader = TRUE, "La API de CONAGUA (Comisión Nacional del Agua) provee más de 13 millones de registros de las condiciones atmosféricas de todo el país. Contiene datos como la dirección del viento, probabilidad de precipitación, descripción del cielo, velocidad del viento, 
                                    entre otros datos que ayudarán a observar las condiciones de cada estado de la república mexicana. Estos datos los puedes encontrar en: https://api.datos.gob.mx/v1/condiciones-atmosfericas", align = "left"),
                                img(src='https://www.revista.unam.mx/wp-content/uploads/img1-45.jpg', width = 870, height = 447)
                                ),
          
                  
                        ######################
                        tabItem(tabName = "Map",
                                
                                box(title = "Mapa", status = "info" , collapsible = T, width = 20, solidHeader = TRUE, 
                                    img(src='https://upload.wikimedia.org/wikipedia/commons/4/40/Koppen-Geiger_Map_MEX_present.svg', width = 870, height = 447)
                                ),
                                box(title = "Información ", status = "info" , collapsible = T, width = 20, solidHeader = TRUE, "En el presente mapa se muestra las zonas climáticas generales hasta 2016, 
                                    esto nos sirve para comparar con las condiciones atmosféricas hoy en día y ver el impacto del calentamiento global.")
                                
                                ),
                        ######################
                        tabItem(tabName = "Cozumel",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                   img(src="https://i.ibb.co/nmsXtMK/Rplot.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/PxL5HJmz/cozu-tempsumm.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/vZdXk2J3/cozu-windspeedsum.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/13hPTPR2/cozu-relative.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/bJkNdJvx/cozu-precprob.jpg") ),
                                   img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Mexico_Quintana_Roo_Cozumel_location_map.svg/545px-Mexico_Quintana_Roo_Cozumel_location_map.svg.png") 

                                ),
                        #######################
                        tabItem(tabName = "IslaMujeres",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/WtRGgtms/Rplot01.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/h4V1R1Kj/isla-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/qM0XJ67G/isla-windspeed.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/RZZ7frK6/isla-relatehum.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/jdX6LqwY/isla-probprep.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Isla_Mujeres_location_map.svg/545px-Isla_Mujeres_location_map.svg.png") 
                                
                                ),       
                        #######################
                        tabItem(tabName = "Solidaridad",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/nrMsrx6p/Rplot02.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/QCpMHMfL/soli-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/G3YtMMdM/soli-windspeed.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/MKmTwvcV/soli-relhum.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/MKSTgyGz/soli-prepprob.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Mexico_Quintana_Roo_Solidaridad_location_map.svg/545px-Mexico_Quintana_Roo_Solidaridad_location_map.svg.png") 
                                
                        ),
                        
                        tabItem(tabName = "PuertoMorelos",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/wTjKtvfh/Rplot03.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/XYttDgV8/pue-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/vBskGHxx/pue-windspe.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/GpY60st1/pue-relhum.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/ZRxgnt67/pue-preprob.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Mexico_Quintana_Roo_Puerto_Morelos_location_map.svg/545px-Mexico_Quintana_Roo_Puerto_Morelos_location_map.svg.png") 
                                
                        ),
                        
                        tabItem(tabName = "FelipeCar",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/3wKfqfs2/Rplot04.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/z3Z0Fxwb/fel-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/7PFkRDm7/fel-windspe.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/vT60nJnw/fel-relhum.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/CMB0JdHS/fel-preprob.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Mexico_Quintana_Roo_Felipe_Carrillo_Puerto_location_map.svg/545px-Mexico_Quintana_Roo_Felipe_Carrillo_Puerto_location_map.svg.png") 
                                
                        ),
                        
                        tabItem(tabName = "OthonPBlanco",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/bJZ76Fn3/Rplot05.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/sg3tF2SB/othon-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/pLk3PtYs/othon-windspe.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/cJbj8MzY/othon-relhum.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/LsXwX0x2/othon-preprob.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Mexico_Quintana_Roo_Othon_P_Blanco_location_map.svg/545px-Mexico_Quintana_Roo_Othon_P_Blanco_location_map.svg.png") 
                                
                        ),
                        
                        tabItem(tabName = "Benito",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/hGWQ4HD7/Rplot06.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/pX3pkgn1/ben-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/xd38f8pW/ben-windspe.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/jSNC1ZHq/ben-relhu.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/k5mDPKsQ/ben-preprob.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Mexico_Quintana_Roo_Benito_Juarez_location_map.svg/545px-Mexico_Quintana_Roo_Benito_Juarez_location_map.svg.png") 
                                
                        ),
                        
                        tabItem(tabName = "JoseMarMor",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/PrB1N6TY/Rplot10.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/sgdZ3v4J/jose-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/fT094xmL/jose-windspe.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/9Qdw0CxH/jose-relhu.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/jq17k8Wm/jose-preprob.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Mexico_Quintana_Roo_Jose_Maria_Morelos_location_map.svg/545px-Mexico_Quintana_Roo_Jose_Maria_Morelos_location_map.svg.png") 
                                
                        ),
                        
                        tabItem(tabName = "LazaroCard",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/x8J9z1gj/Rplot07.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/1XqZzY5f/laz-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/fkQQSjJ5/laz-windspe.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/mZzcMLPF/laz-relhu.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/8k27m2vX/laz-preprob.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Mexico_Quintana_Roo_Lazaro_Cardenas_location_map.svg/545px-Mexico_Quintana_Roo_Lazaro_Cardenas_location_map.svg.png") 
                                
                        ),
                        
                        tabItem(tabName = "Tulum",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/J4z2KFWJ/Rplot08.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/PrJS18mQ/tul-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/TYsC0Y0M/tul-windspe.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/t4VDMQv1/tul-relhu.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/Bv9NWYRm/tul-preprob.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Mexico_Quintana_Roo_Tulum_location_map.svg/545px-Mexico_Quintana_Roo_Tulum_location_map.svg.png") 
                                
                        ),
                        
                        tabItem(tabName = "Bacalar",
                                
                                box(title = "Relación de Temperatura con Descripción del Cielo", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/bJZ76Fn3/Rplot05.jpg") ),
                                box(title = "Summary de la Temperatura", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/05nSdkxk/baca-tempcel.jpg") ),
                                box(title = "Summary de la Velocidad del Viento", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/JnckFmkQ/baca-windspe.jpg") ),        
                                box(title = "Summary de la humedad relativa", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/tJqxQfdG/baca-relhu.jpg") ),
                                box(title = "Summary de la prob. de precipitación", status = "info", collapsible = T, width = 6, solidHeader = TRUE,
                                    img(src="https://i.postimg.cc/RhgnMRG6/baca-prepo.jpg") ),
                                img(src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Mexico_Quintana_Roo_Bacalar_location_map.svg/545px-Mexico_Quintana_Roo_Bacalar_location_map.svg.png") 
                                
                        )
                        
                              )
                      
                                )
                        
                        )
                    


server <- function(input, output){
  
}

shinyApp(ui = ui, server = server)
