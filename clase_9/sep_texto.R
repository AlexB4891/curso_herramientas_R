library(tidyverse)
library(foreign)
library(rgdal)
library(rgeos)
library(smoothr)

# Creo los archivos separados:

tabla <- read_csv("saiku-export.csv")

names(tabla) <- c("activ","provin","tipo_c","grupo_e",
            "gran_c","clase","anio","mes","estado",
            "compras_t","ventas_t","impuesto_c")


to_rbind_1 <- tabla[1:70000,] %>% 
  select("activ","provin","anio")

write_delim(to_rbind_1,path = "delim_t_1.txt",delim = "\t")

to_rbind_2 <- tabla[70001:nrow(tabla),] %>% 
  select("activ","provin","anio")

write_rds(to_rbind_2,path = "delim_t_2.rds")

to_join <- tabla %>% 
  select(-c("activ","provin","anio"))

save(to_join,file = "to_join.RData")

# Simplifico el shape file

load("shapes_ecuador.RData")


prov <- sh[[3]]

rm(sh)

prov_s <- ms_simplify(prov,keep = 0.001)


write_rds(prov_s,path = "nxprovincias_simp.rds")

# Generar centroides:

mapa_ec <- read_rds("nxprovincias_simp.rds")

centroides <- SpatialPointsDataFrame(gCentroid(mapa_ec, byid=TRUE), 
                                     mapa_ec@data, match.ID=FALSE)

write_rds(centroides,"centroides.rds")
