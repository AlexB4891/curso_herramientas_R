# -------------------------------------------------------------------------#
#                CLASE 4: Manipulación de bases de datos I                 #
# -------------------------------------------------------------------------#
# Fecha: 08 de noviembre de 2019
# Elaborado por: Alex Bajaña

# Apertura de datos:
# Ojo con la coerción

tabla <- read.csv("saiku-export.csv")

# Arreglo los nombres:
names(tabla) <- c("activ","provin","tipo_c","grupo_e",
                  "gran_c","clase","anio","mes","estado",
                  "compras_t","ventas_t","impuesto_c")

# Creo la variable `fecha` y la convierto en fecha:
tabla$fecha <- paste0(tabla$anio,"-",tabla$mes,"-01")

tabla$fecha <- as.Date(tabla$fecha)

# Ventas totales, función agregate:
vt <- aggregate(formula = ventas_t ~ fecha,
          data = tabla,
          FUN = function(x) sum(x)/10e6)

# Creo una serie de tiempo con el total de ventas:
vt_ts <- ts(vt$ventas_t,start = 2015,end = 2017,frequency = 12)

# Diferencio la serie con 12 retardos:
vt_dff <- diff(vt_ts,lag = 12)

# Graficó:
plot.new()
frame()
par(mfcol=c(2,1))
plot(vt_ts,
     type='l',col='red',
     xlab = "Tiempo (t)",
     ylab = "Ventas Totales (t)")
plot(vt_dff,
     type='l',col='red',
     xlab = "Tiempo (t)",
     ylab = "Ventas (t) - Ventas (t-12)")


# Encuentro las posiciones donde se hallan los sectores:
#    petrolero (B)
#    manufacurea (C)

ind <- which(tabla$activ == "B")
ind_2 <- which(tabla$activ == "C")

# Creo el factor que me indicara el sector
tabla$s_petro <- NA_real_
tabla$s_petro[ind] <- "Sector petrolero"
tabla$s_petro[ind_2] <- "Manufactura"


# agrego por las variables fecha y s_petro
comp <- aggregate(formula = ventas_t ~ fecha + s_petro,
          data = tabla,
          FUN = function(x) sum(x)/10e6)

# separa en vectores para poder graficar:
fecha <- comp$fecha[comp$s_petro == "Sector petrolero"]
sp <- comp$ventas_t[comp$s_petro == "Sector petrolero"]
no_sp <- comp$ventas_t[comp$s_petro == "Manufactura"]

# cambio de escala para comparar:
sp <- (sp - mean(sp))/sd(sp)

no_sp <- (no_sp - mean(no_sp))/sd(no_sp)

# Gráfico que compara las dos series centradas:

plot.new()
frame()
plot(fecha,sp, type="o", col="blue", pch="o", lty=1, ylim=c(-2,4), ylab="Ventas",xlab = "Fecha")
points(fecha, no_sp, col="red", pch="*")
lines(fecha, no_sp, col="red",lty=2)
legend(as.Date("2015-01-01"),4,
       legend=c("Petrolero","Manufactura"), 
       col=c("blue","red"),
       pch=c("o","*"),lty=c(1,2), 
       ncol=1)

# En que mes tienen las peores ventas el sector manufacturero:

separada <- split(comp,comp$s_petro)

lapply(separada,function(x){
  ind <- which.min(x$ventas_t)
  
  x$fecha[ind]
})
