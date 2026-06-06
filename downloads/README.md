# Generador Automático de Reportes IDF en R

**Autor:** Jamil Ramirez

## Descripción

Esta herramienta fue desarrollada por Jamil Ramirez para automatizar el análisis de frecuencia de precipitaciones máximas anuales y la generación de reportes de curvas Intensidad-Duración-Frecuencia (IDF) mediante R y R Markdown.

A partir de un archivo Excel con series de precipitación, el sistema genera automáticamente un reporte PDF para cada estación incluida en el archivo.

## Archivos incluidos

* **plantilla_idf.Rmd**
  Plantilla principal que realiza el análisis estadístico y genera el reporte PDF.

* **generar_reportes_IDF.R**
  Script encargado de leer el archivo Excel y generar automáticamente un reporte para cada estación.

## Formato de entrada

El archivo Excel debe contener:

* Una columna por estación pluviométrica.
* Valores de precipitación máxima anual (PP24).
* Datos numéricos.
* Al menos 10 observaciones válidas por estación.

Ejemplo:

| Estación_A | Estación_B |
| ---------- | ---------- |
| 35.2       | 41.8       |
| 28.6       | 37.5       |
| 44.1       | 52.3       |

## Funcionalidades

* Procesamiento automático de múltiples estaciones.
* Control básico de calidad de datos.
* Eliminación de valores no válidos.
* Ajuste de distribuciones de probabilidad.
* Estimación de precipitaciones de diseño para diferentes períodos de retorno.
* Generación de curvas IDF.
* Creación automática de reportes PDF.

## Requisitos

* R
* RStudio (recomendado)
* Una distribución LaTeX para generar PDF (TinyTeX recomendado)

Las librerías necesarias se instalan automáticamente si no se encuentran disponibles.

## Uso

1. Colocar el archivo Excel en la misma carpeta que los scripts.
2. Modificar el nombre del archivo en `generar_reportes_IDF.R` si es necesario.
3. Ejecutar `generar_reportes_IDF.R`.
4. Los reportes generados se guardarán en la carpeta `Reportes_IDF`.

## Licencia

© 2026 Jamil Ramirez

Este material se distribuye con fines educativos, académicos y profesionales. El usuario es responsable de verificar los resultados antes de su aplicación en proyectos de ingeniería.

