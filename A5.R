#Instalamos los paquetes necesarios

install.packages('readxl','xlsx','ggplot2')

#Llamamos a las librerías

library(readxl)
library(xlsx)
library(ggplot2)

read_xlsx("C:/Users/pilar/Rstudio/semillas.xlsx")

#Cargamos las variables en vectores

seed_number <- c(semillas$SEMILLA)
tgr <- c(semillas$TASA_GERMINACION_REAL)
tgt <- c(semillas$TASA_GERMINACION_TEORICA)

#Creamos vectores vacíos

descartar <- c()
aprobar <- c()

#Iteración

i = 1

while (i<=length(seed_number)) {
  if (tgr[i]-tgt[i]<0) {
    descartar[i] <- seed_number[i]
  }
  else
    aprobar[i] <- seed_number[i]
  i <- i+1
}

#Eliminamos NA creando una función

eliminar_NA <- function(x) {
  return(x [! is.na (x)])
}

aprobar <- eliminar_NA(aprobar)
descartar <- eliminar_NA(descartar)

#Plot

ggplot(semillas, 
       aes(TASA_GERMINACION_TEORICA, TASA_GERMINACION_REAL, colour = SEMILLA))+ 
  geom_point()+
  labs(title = 'TGR vs TGT de 200 semillas', 
       x = 'Tasa de germinación teórica', 
       y = 'Tasa de germinación real', 
       colour = 'N° Semilla')
ggsave('plot_TGT_TGR_S200.png', width=8, height=8)

#Guardamos los archivos en un Excel

df_final <- data.frame(
  'Aprobar' = aprobar
)

write.xlsx(df_final, 
           "C:/Users/pilar/Rstudio/Semillas_aprobadas.xlsx", 
           sheetName="Aprobadas", col.names=TRUE, 
           row.names=TRUE, append=FALSE)
