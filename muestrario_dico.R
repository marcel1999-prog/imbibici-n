source("https://inkaverse.com/setup.r")




# Cargar librerías necesarias
library(googlesheets4)
library(dplyr)
library(huito)


# Cargar datos

url <- "https://docs.google.com/spreadsheets/d/1wB7ofnxupJinlzvLo2tGYZB0PxZ6LXMFijBQNb7J34I/edit?gid=0#gid=0"

gs <- as_sheets_id(url)
fb <- range_read(gs, sheet = "fb")

View(fb)


# Crear etiqueta


font <- c("Permanent Marker", "Tillana", "Courgette")

huito_fonts(font)

label <- fb %>%
  
  label_layout(
    size = c(4,2.5),
    border_color = "black",
    border_width = 0.5
  ) %>% 
  
  include_barcode(value = "url",
                  size = c(1.8, 1.8),
                  position = c(1, 1)) %>%
  include_image(value = "https://www.untrm.edu.pe/assets/images/untrmazul.png"
                , size = c(1.7, 1.7)
                , position = c(1, 2.2)) %>% 
  include_image(value = "https://drive.google.com/uc?export=view&id=1LJx4DQpiX4KUBEWGiWOK6SQOSu2GOgQ3"
                , size = c(1.8, 1.8) 
                , position = c(2.9, 1.8)) %>% 
  include_text(value = "nombre_comun"
               , size = 6
               , position = c(2.9 , 0.9)
               , font = font[2]) %>% 
  include_text(value = "nombre_cientifico"
               , size = 6
               , position = c(2.9, 0.6)
               , font = font[2])




label %>% 
  label_print(mode = "preview")


label %>%
  label_print(
    mode = "complete",
    filename = "etiquetas_muestrario",
    paper = c(29.7, 21),  # A4 horizontal en cm
    units = "cm",
    margin = 0.2,         # margen opcional
    nlabels = 20,         # ajusta a tu número real
    viewer = TRUE         # abre PDF al terminar
  )
