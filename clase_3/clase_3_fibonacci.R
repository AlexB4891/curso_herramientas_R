############################################################################
#                  CURSO: Herramientas de análisis con R                   #
#                     CLASE 3: Estructuras de control                      #
############################################################################

# Una serie Fibonacci es una secuencia de números donde el valor i es igual 
# a la suma de sus dos predecesores:
# 
# Ejemplo:  0 1 1 2 3 5 8 13 21
# 
# Ejercicio: generar una serie de Fibonacci y ubicar el elemento 300 de esta
# serie

# Alternativa 1: A partir de un vector vacio generamos la serie, como los 
# tres primeros números de la serie son fijos creo un condicional para las 
# posiciones 1 (i = 3), 2 (i = 4), 3 (i = 5) para valores i >= 6 ya aplico 
# la suma de los dos antesores

# Vector vacio:

vector <- c()

for (i in 3:302){
  # Posición 1
if(i == 3) {vector[i-2] <- 0}

  # Posición 2
if(i == 4){ vector[i-2] <- 1}

  # Posición 3
if(i == 5){ vector[i-2] <- 1}
  
  # Los siguientes
if(i >=6){vector[i-2] <- vector[i-3]+vector[i-4]}

}

# Elemento 300:

vector[300]

# Elimino el objeto para reciclarlo

rm(vector)

# Alternativa 2: En lugar de usar un vector podemos emplear una lista 

vector <- list()

vector[[1]] <- 0
vector[[2]] <- 1

for(i in 3:300){
  vector[[i]] <- vector[[i-1]] + vector[[i-2]]
}

vector[[300]]

rm(vector)

# Alternativa 3: Cambiando el sentido del indice:

vector <- list(0,1)

for(i in 1:298){
  vector[[i+2]] <- vector[[i]] + vector[[i+1]]
}

vector[[300]]

rm(vector)

