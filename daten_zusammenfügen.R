#######################################
# Daten zusammenfügen
#######################################

library(tidyverse)

dt1 <- data.frame(leser_in=c("Hugo","Klara","Lois"),
                 buch_genre=c("Fantasy","Biographie","Roman","Sachbuch",
                              "Fantasy","Biographie","Roman","Sachbuch",
                              "Fantasy","Biographie","Roman","Sachbuch"),
                 buch_anzahl=c(10,1,0,1,
                               0,5,6,2,
                               0,0,0,8))


dt2 <- data.frame(leser_in=c("Sophie"),
                  buch_genre=c("Fantasy","Biographie","Roman","Sachbuch"),
                  buch_anzahl=c(8,9,6,3))

dt3 <- data.frame(medium = c("Gedruckt","Gedruckt","Digital",
                             "Gedruckt","Gedruckt","Digital",
                             "Gedruckt","Gedruckt","Digital",
                             "Gedruckt","Gedruckt","Digital"))



dt4 <- data.frame(leser_in=c("Hugo","Sophia","Lois","Mara"),
                  buch_genre=c("Fantasy","Biographie","Roman","Sachbuch",
                               "Fantasy","Biographie","Roman","Sachbuch",
                               "Fantasy","Biographie","Roman","Sachbuch",
                               "Fantasy","Biographie","Roman","Sachbuch"),
                  buch_anzahl=c(10,1,0,1,
                                8,9,6,3,
                                0,5,6,2,
                                1,0,0,0))


#-------
# Gleiche Spalten
#-------

ncol(dt1)==ncol(dt2)

rbind(dt1,dt2)

dt5 <- rbind(dt1,dt2)

#-------
# Gleiche Zeilen
#-------

nrow(dt1)==nrow(dt3)

dt6 <- cbind(dt1,dt3)
dt6

#-------
# join
#-------

inner_join(dt1,dt4)

left_join(dt1,dt4)

right_join(dt1,dt4)

full_join(dt1,dt4)
