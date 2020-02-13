# -------------------------------------------------------------------------#
#             TAREA 1: Datos fiscales de las regiones naturales            # 
# -------------------------------------------------------------------------#
# Utilizando como referencia el archivo "clase_4_sri.R" y lo visto en clases
# responder a las siguientes preguntas:

#   
# 1. Genero una variable que se llame región natural
# 
# Hint: Utilizar la función `which` para encontrar las posiciones de las provincias que pertenecen a cada región.
# Ejemplo:
# * No correr * 
# ind <- which(tabla$provin %in% c("AZUAY","BOLIVAR","COTOPAXI"))
# tabla$region <- NA_character_
# tabla$region[ind] <- "Sierra"
# table(tabla$region,useNA = "ifany")
 
# 2. Agrego las compras por fecha y región natural
# 
# Hint: Utilizar la función `aggregate` para encontrar las sumas agrupadas por fecha y region natural.
# 
# 3. ¿Durante que mes entre marzo y mayo de 2016 tuvieron las compras más bajas las distintas regiones?  

# Hint: Filtro la tabla para las fechas señaladas, empleo la función `split` para 
# guardar en una lista la información de cada una de las regiones. Con `lapply` y 
# la función `which.min` hallo la fecha en que se presenta el minimo 
