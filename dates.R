#######################################
# Mit Datum umgehen lernen in R
#######################################

library(tidyverse)
library(lubridate)

library(stringi)
library(plyr)

#--------
# Datumklasse
#--------

d0 <- "2000-01-01"
class(d0)

d0 <- as.Date(d0)


d1 <- "01.08.2005"
d1 <- as.Date(d1)
d1 <- as.Date(d1,"%d.%m.%Y")

#--------
# Kann damit rechnen
#--------
d1 - d0

day(d0)
month(d1)
year(c(d0,d1))

#------
# komplizierte Variante
#------
d3 <- c("1 November 2008","8 February 2007")
as.Date(d3)

d3 <- stri_split(d3,fixed=" ")
d3 <- ldply(d3)

d3$V2 <- recode(d3$V2,January='1',February='2',
                March='3',April='4',
                May='5',June='6', 
                July='7', August='8', 
                September='9', 
                October='10', November='11',
                December='12')

d3 <- paste0(d3$V1,".",d3$V2,".",d3$V3)
d3
class(d3)

as.Date(d3)
d3 <- as.Date(d3,"%d.%m.%Y")
class(d3)
