#######################################
# Mit Ländernamen in R umgehen lernen
#######################################

library(tidyverse)
library(countrycode)

dt1 <- data.frame(country=c("Austria","Russia","Belgium","Sweden","Poland"),
                  x1 = c(3,9,12,2,1))

dt2 <- data.frame(iso3c=c("RUS","BEL","AUT","SWE","POL"),
                  x2 = c("a","k","a","l","k"))

dt3 <- data.frame(iso3n=c(40,643,56,752,616),
                  x3 = c(0,1,1,1,0))


dt1$iso3c <- countrycode(dt1$country,"country.name","iso3c")

dt3$iso3c <- countrycode(dt3$iso3n,"iso3n","iso3c")

dt <- full_join(dt1,dt2)
dt <- full_join(dt,dt3)
