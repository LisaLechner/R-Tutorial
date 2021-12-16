#######################################
# Maßzahlen
#######################################

library(tidyverse)
library(readxl)

# Einlesen der kontinuierlichen Variable (Quelle: EPI https://epi.yale.edu/epi-results/2020/component/ape)
emission <- read_excel('./data/epi_pollution_emission.xlsx')

# Einlesen der kategorischen Variable (Quelle: Climate Change Tracker: https://climateactiontracker.org/)
climatetracker <- read_excel('./data/ratings_climateactiontracker.xlsx')


#------
# Maße der Zentralen Tendenz
#------

# arithmetisches Mittel

mean(emission$pollution_emission_change,na.rm = TRUE)

# Median

median(emission$pollution_emission_change)

# Modus
modus <- function(V) {
  uniqV <- unique(V)
  uniqV[which.max(tabulate(match(V, uniqV)))]
}

modus(climatetracker$rating)

#-----
# Maße der Streuung
#-----

#-----
# Varianz
#-----

var(emission$pollution_emission_change,na.rm = TRUE)


#-----
# Standardabweichung
#-----

sqrt(var(emission$pollution_emission_change))

sd(emission$pollution_emission_change)


#-----
# Interquartilsabstand
#-----

IQR(emission$pollution_emission_change)


#----
# Zusammenfassung
#----

summary(emission$pollution_emission_change)


#-----
# Häufigkeitstabelle
#-----

table(climatetracker$rating)
