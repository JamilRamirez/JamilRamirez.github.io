##############################################################################
# GENERADOR DE REPORTES IDF DESDE EXCEL
#
# Autor: Jamil Ramirez
# Año: 2026
#
# Este script fue desarrollado por Jamil Ramirez para automatizar la generación
# de reportes IDF a partir de series de precipitación máxima anual almacenadas
# en archivos Excel.
#
# Cada columna del Excel representa una estación pluviométrica.
##############################################################################

# Carpeta donde están el Excel, el .R y el .Rmd
setwd("G:/UTP/Hidrologia/R")

required_pkgs <- c(
  "readxl", "rmarkdown", "knitr", "kableExtra",
  "fitdistrplus", "evd", "MASS", "ggplot2", "dplyr",
  "tidyr", "scales", "gridExtra", "lmomco", "PearsonDS"
)

for (p in required_pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p, dependencies = TRUE)
  }
}

library(readxl)
library(rmarkdown)

# ============================================================
# CONFIGURACIÓN
# ============================================================

archivo_excel <- "datos_idf.xlsx"        # Cambia aquí el nombre de tu Excel
hoja_excel    <- 1                       # Número o nombre de hoja
plantilla     <- "plantilla_idf.Rmd"
carpeta_salida <- "Reportes_IDF"

dir.create(carpeta_salida, showWarnings = FALSE)

# Leer Excel
datos_excel <- readxl::read_excel(archivo_excel, sheet = hoja_excel)

# Validación básica
if (ncol(datos_excel) == 0) {
  stop("El Excel no tiene columnas válidas.")
}

# ============================================================
# GENERAR UN PDF POR CADA COLUMNA
# ============================================================

for (col in names(datos_excel)) {
  
  datos <- suppressWarnings(as.numeric(datos_excel[[col]]))
  datos <- datos[!is.na(datos)]
  
  if (length(datos) < 10) {
    warning(paste("La columna", col, "tiene menos de 10 datos válidos. Se omitió."))
    next
  }
  
  # Eliminar valores <= 0
  n_eliminados <- sum(datos <= 0, na.rm = TRUE)
  
  if (n_eliminados > 0) {
    
    warning(
      paste(
        "La columna",
        col,
        "tenía",
        n_eliminados,
        "valores <= 0. Fueron eliminados de la serie."
      )
    )
    
    datos <- datos[datos > 0]
  }
  
  # Verificación final
  if (length(datos) < 10) {
    warning(
      paste(
        "La columna",
        col,
        "tiene menos de 10 datos válidos tras la depuración. Se omitió."
      )
    )
    next
  }
  
  nombre_limpio <- gsub("[^A-Za-z0-9_]", "_", col)
  
  message("Generando reporte para: ", col)
  
  rmarkdown::render(
    input = plantilla,
    output_file = paste0("Reporte_IDF_", nombre_limpio, ".pdf"),
    output_dir = carpeta_salida,
    params = list(
      nombre_estacion = col,
      datos = datos
    ),
    envir = new.env()
  )
}

message("Proceso terminado.")