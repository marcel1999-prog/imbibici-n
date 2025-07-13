library(googlesheets4)
library(dplyr)
library(huito)

# Autenticarse en Google Sheets
gs4_auth()

# Leer los datos desde Google Sheets
url <- "https://docs.google.com/spreadsheets/d/1X5wBN_FrxXZ-XCQjYROYdNjaJcSAwmeBk9zd66utBSI/edit?usp=sharing"
gs <- as_sheets_id(url)
fb <- range_read(gs, sheet = "fb")

# Elegir fuentes
font <- c("Courgette", "Tillana")
huito_fonts(font)

# Crear etiquetas
label <- fb %>%
  rename(scientific.name = FACTOR, name = PLOTS) %>%
  mutate(
    number = row_number(),
    barcode = paste(number, gsub("(\\w+\\s+\\w+).*", "\\1", scientific.name), sep = "_"),
    barcode = gsub(" ", "-", barcode)
  ) %>%
  label_layout(size = c(20, 12), border_color = "darkgreen") %>%
  
  # Incluir imágenes
  include_image(
    value = "https://drive.google.com/uc?export=view&id=1fM3-_98oz2-dIjDxu9HJUtVa7m731hDn", # Pitahaya
    size = c(8, 4),
    position = c(4.1, 10.8)
  ) %>%
  
  include_image(
    value = "https://drive.google.com/uc?export=view&id=1vQtmW68NSIsW_pJWfb1cObvx_mtCGZgF", # Nuevo logo universidad
    size = c(2.6, 2.6),
    position = c(18.6, 10.6)
  ) %>%
  
  
  # Textos principales
  include_text(value = "MUESTRARIO DE SEMILLAS DICOTILEDONEAS", position = c(10, 7.5), size = 27, color = "black", font = font[2]) %>%
  include_text(value = "Integrantes", position = c(10, 5.5), size = 14, color = "black", font = font[1]) %>%
  include_text(value = "CHACHAPOYAS - 2025", position = c(10, 1), size = 14, color = "black", font = font[1]) %>%
  include_text(value = "- Bustamante Lopez Patricia", position = c(9.7, 4.5), size = 12, color = "black", font = font[2]) %>%
  include_text(value = "- Grandez Castro Eliseo", position = c(9.25, 4), size = 12, color = "black", font = font[2]) %>%
  include_text(value = "- Lopez Ollaguez Michel", position = c(9.26, 3.5), size = 12, color = "black", font = font[2]) %>%
  include_text(value = "- Vasquez Barboza Percy", position = c(9.42, 3), size = 12, color = "black", font = font[2]) %>%
  include_text(value = "- Vilchez Bustamante Erik", position = c(9.48, 2.5), size = 12, color = "black", font = font[2])


# Vista previa
label %>% label_print(mode = "preview")


# Exportar a PDF en tamaño carta horizontal (11 x 8.5 pulgadas)
label %>% label_print(
  file = "etiqueta_dicotiledoneas.pdf",
  paper = c(11, 8.5)
)
