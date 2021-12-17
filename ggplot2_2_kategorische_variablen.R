#######################################
# ggplot für zwei dsikrete Variablen
#######################################

library(tidyverse)
library(readxl)
library(ggplot2)

# um die Grafiken einfach zu halten (Stichwort Ink-Data Ratio)
theme_set(theme_minimal())

# Einlesen der ersten kategorischen Variable (Quelle: Climate Change Tracker: https://climateactiontracker.org/)
climatetracker <- read_excel('./data/ratings_climateactiontracker.xlsx') %>% 
  mutate(iso3c=countrycode(country,"country.name","iso3c")) %>%
  dplyr::select(-country)


# Einlesen der zweiten kategorischen Variable (Quelle: Polity IV Projekt)

download.file('http://www.systemicpeace.org/inscr/p5v2018.xls',destfile='./data/polity.xls')
polity <- read_excel('./data/polity.xls')
polity <- polity %>% rename(iso3c=scode) %>% 
  mutate(polity2=ifelse(polity2<(-10),NA,polity2)) %>%
  mutate(polity2_category=ifelse(polity2<=(-6),"autocracy","transition")) %>%
  mutate(polity2_category=ifelse(polity2>=(6),"democracy",as.character(polity2_category))) %>%
  dplyr::select(iso3c,year,polity2_category) %>%
  mutate(year=as.numeric(year)) %>% dplyr::filter(year==2015)

dt <- full_join(polity,climatetracker)

table(dt$polity2_category,dt$rating)

#------
# Count
#------
dt %>% dplyr::filter(!is.na(polity2_category),!is.na(rating)) %>%
ggplot( aes(rating,polity2_category)) + geom_count()+
  labs(x="Climate Change Tracker Rating",
       y="Regimetyp",
       title="Regimetyp und Paris Abkommen",
       subtitle = "Daten stammen vom Climate Change Tracker und Polity IV Projekt")


#------
# Jitter
#------
dt$polity2_category <- factor(dt$polity2_category,levels=c("democracy","transition","autocracy"))

dt %>% dplyr::filter(!is.na(polity2_category),!is.na(rating)) %>%
  ggplot( aes(rating,polity2_category)) + geom_jitter()+
  labs(x="Climate Change Tracker Rating",
       y="Regimetyp",
       title="Regimetyp und Paris Abkommen",
       subtitle = "Daten stammen vom Climate Change Tracker und Polity IV Projekt")

