#######################################
# ggplot für eine kontinuierliche und eine kontinuierliche Variable
#######################################

library(tidyverse)
library(readxl)
library(ggplot2)
library(countrycode)

# um die Grafiken einfach zu halten (Stichwort Ink-Data Ratio)
theme_set(theme_minimal())

# Einlesen der kontinuierlichen Variable (Quelle: EPI https://epi.yale.edu/epi-results/2020/component/ape)
emission <- read_excel('./data/epi_pollution_emission.xlsx')

# Einlesen der kategorischen Variable (Quelle: Climate Change Tracker: https://climateactiontracker.org/)
climatetracker <- read_excel('./data/ratings_climateactiontracker.xlsx')

# Vorbereiten zum mergen (Ländernamen haben manchmal unterschiedliche Bezeichnungen

emission <- emission %>% mutate(iso3c = countrycode(country,"country.name","iso3c")) %>%
  dplyr::select(-country)

climatetracker <- climatetracker %>% 
  mutate(iso3c = countrycode(country,"country.name","iso3c")) %>%
  dplyr::select(-country)

dt <- full_join(emission, climatetracker)

# Beispiel Emissionen gehen nach oben
# 2014: 20
# 2005: 10

(20-10)/10

# Beispiel Emissionen gehen nach unten
# 2014: 10
# 2005: 20

(10-20)/20

#------
# Boxplot
#------

dt %>% filter(!is.na(rating)) %>%
ggplot(aes(rating,pollution_emission_change)) + geom_col()+
  labs(x="Climate change tracker (Ratings)",
       y="Schadstoffemissionsveränderung von 2005 auf 2014",
       title="Schadstoffemission und Ratings durch Climate Change Tracker",
       subtitle = "Daten stammen von EPI (Yale University) und dem Climate Change Tracker")

#------
# Boxplot
#------

dt %>% filter(!is.na(rating)) %>%
  ggplot(aes(rating,pollution_emission_change)) + geom_boxplot()+
  labs(x="Climate change tracker (Ratings)",
       y="Schadstoffemissionsveränderung von 2005 auf 2014",
       title="Schadstoffemission und Ratings durch Climate Change Tracker",
       subtitle = "Daten stammen von EPI (Yale University) und dem Climate Change Tracker")


#------
# Dotplot
#------

dt %>% filter(!is.na(rating)) %>%
  ggplot(aes(rating,pollution_emission_change)) + 
  geom_dotplot(binaxis = "y")+ #hier muss angegeben werden auf welcher Achse die Punkte ihre Verteilung annehmen
  labs(x="Climate change tracker (Ratings)",
       y="Schadstoffemissionsveränderung von 2005 auf 2014",
       title="Schadstoffemission und Ratings durch Climate Change Tracker",
       subtitle = "Daten stammen von EPI (Yale University) und dem Climate Change Tracker")

#------
# Violin
#------
?geom_violin

dt %>% filter(!is.na(rating)) %>%
  ggplot(aes(rating,pollution_emission_change)) + geom_violin()+
  labs(x="Climate change tracker (Ratings)",
       y="Schadstoffemissionsveränderung von 2005 auf 2014",
       title="Schadstoffemission und Ratings durch Climate Change Tracker",
       subtitle = "Daten stammen von EPI (Yale University) und dem Climate Change Tracker")



