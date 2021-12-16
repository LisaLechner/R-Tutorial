#######################################
# ggplot für eine kontinuierliche Variable
#######################################

library(tidyverse)
library(readxl)
library(ggplot2)

# um die Grafiken einfach zu halten (Stichwort Ink-Data Ratio)
theme_set(theme_minimal())

# Einlesen der kontinuierlichen Variable (Quelle: EPI https://epi.yale.edu/epi-results/2020/component/ape)
emission <- read_excel('./data/epi_pollution_emission.xlsx')

#------
# Dichtefunktion
#------

ggplot(emission, aes(pollution_emission_change)) + geom_density()+
  labs(x="Schadstoffemissionsveränderung von 2005 auf 2014",
       y="Dichte",
       title="Dichtefunktion der Schadstoffemissionsveränderung",
       subtitle = "Daten stammen von EPI (Yale University)")


#------
# Dotplot
#------

ggplot(emission, aes(pollution_emission_change)) + geom_dotplot()+
  labs(x="Schadstoffemissionsveränderung von 2005 auf 2014",
       y="Häufigkeit",
       title="Verteilung der Schadstoffemissionsveränderung",
       subtitle = "Daten stammen von EPI (Yale University)")


#------
# Histogramm
#------

ggplot(emission, aes(pollution_emission_change)) + geom_histogram()+
  labs(x="Schadstoffemissionsveränderung von 2005 auf 2014",
       y="Häufigkeit",
       title="Verteilung der Schadstoffemissionsveränderung",
       subtitle = "Daten stammen von EPI (Yale University)")


