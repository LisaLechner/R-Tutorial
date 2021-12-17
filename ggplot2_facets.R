#######################################
# ggplot Facets
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

# Einlesen der kontinuierlichen Variable (Quelle: EPI https://epi.yale.edu/epi-results/2020/component/ape)
emission <- read_excel('./data/epi_pollution_emission.xlsx')
emission <- emission %>% mutate(iso3c = countrycode(country,"country.name","iso3c")) %>%
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
dt <- full_join(dt,emission)


#-------
# facet_grid
#-------
dt$polity2_category <- factor(dt$polity2_category,levels=c("democracy","transition","autocracy"))

dt %>% dplyr::filter(!is.na(polity2_category)) %>%
  ggplot( aes(pollution_emission_change)) + 
  geom_density()+
  facet_grid(cols=vars(polity2_category))+
  labs(x="Schadstoffaustoßveränderung zw 2005 und 2014",
       y="Frequenz",
       title="Verteilung der Schadstoffaustoßveränderung über Demokratien stratifiziert",
       subtitle = "Daten stammen von EPI (University Yale) und Polity IV Projekt")

dt %>% dplyr::filter(!is.na(polity2_category)) %>%
  ggplot( aes(pollution_emission_change)) + 
  geom_density()+
  facet_grid(rows=vars(polity2_category))+
  labs(x="Schadstoffaustoßveränderung zw 2005 und 2014",
       y="Frequenz",
       title="Verteilung der Schadstoffaustoßveränderung über Demokratien stratifiziert",
       subtitle = "Daten stammen von EPI (University Yale) und Polity IV Projekt")

dt %>% dplyr::filter(!is.na(polity2_category),!is.na(rating)) %>%
  ggplot( aes(pollution_emission_change)) + 
  geom_density()+
  facet_grid(rows=vars(rating),cols=vars(polity2_category),scale="free_y")+
  labs(x="Schadstoffaustoßveränderung zw 2005 und 2014",
       y="Frequenz",
       title="Verteilung der Schadstoffaustoßveränderung über Demokratien stratifiziert",
       subtitle = "Daten stammen von EPI (University Yale) und Polity IV Projekt")


#-------
# facet_grid
#-------
dt %>% dplyr::filter(!is.na(rating)) %>%
  ggplot( aes(pollution_emission_change)) + 
  geom_density()+
  facet_wrap(vars(rating))+
  labs(x="Schadstoffaustoßveränderung zw 2005 und 2014",
       y="Frequenz",
       title="Verteilung der Schadstoffaustoßveränderung über Demokratien stratifiziert",
       subtitle = "Daten stammen von EPI (University Yale) und Polity IV Projekt")


