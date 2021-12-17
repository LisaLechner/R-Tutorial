#######################################
# ggplot colors
#R colors: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
#Farbpaletten: https://www.zeileis.org/news/colorspace/
#Simulation Farbblindheit: https://www.color-blindness.com/coblis-color-blindness-simulator/


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

# Einlesen von der zweiten kontinuierlichen Variable (GDP, Quelle: Weltbank)
download.file('https://api.worldbank.org/v2/en/indicator/NY.GDP.MKTP.CD?downloadformat=excel',destfile='./data/gdp.xls')
gdp <- read_excel('./data/gdp.xls')


# Umformen des GDP-Datensatzes zum Tidy-Format
names(gdp) <- gdp[3,]
gdp <- gdp[4:nrow(gdp),]
names(gdp)
gdp <- pivot_longer(gdp,cols=5:ncol(gdp),names_to="Year",values_to="gdp")
gdp <- gdp %>% rename(iso3c=`Country Code`,
                      year=Year) %>%
  select(iso3c,year,gdp)%>%
  mutate(year=as.numeric(year))
gdp <- gdp %>% filter(year==2015) %>% mutate(gdp=as.numeric(gdp)) %>%
  mutate(gdp_ln=log(gdp))

dt <- full_join(polity,climatetracker)
dt <- full_join(dt,emission)
dt <- full_join(dt,gdp)

#-------
# 
#-------

dt %>% dplyr::filter(!is.na(polity2_category)) %>%
  ggplot( aes(pollution_emission_change,gdp_ln)) + 
  geom_point(color="red")+
  labs(x="Schadstoffaustoßveränderung zw 2005 und 2014",
       y="BIP (logarithmiert)",
       title="BIP und Schadstoffausstoßveränderung 2005 bis 2014",
       subtitle = "Daten stammen von EPI (University Yale) und Polity IV Projekt")

dt %>% dplyr::filter(!is.na(polity2_category)) %>%
  ggplot( aes(pollution_emission_change,gdp_ln)) + 
  geom_point(aes(color=polity2_category))+
  labs(x="Schadstoffaustoßveränderung zw 2005 und 2014",
       y="BIP (logarithmiert)",
       title="BIP und Schadstoffausstoßveränderung 2005 bis 2014",
       subtitle = "Daten stammen von EPI (University Yale) und Polity IV Projekt")

dt %>% dplyr::filter(!is.na(polity2_category)) %>%
  ggplot( aes(pollution_emission_change,gdp_ln,color=polity2_category)) + 
  geom_point()+
  scale_color_manual(values=c("darkolivegreen","red","gold2"))+
  labs(x="Schadstoffaustoßveränderung zw 2005 und 2014",
       y="BIP (logarithmiert)",
       title="BIP und Schadstoffausstoßveränderung 2005 bis 2014",
       subtitle = "Daten stammen von EPI (University Yale) und Polity IV Projekt")


dt %>% dplyr::filter(!is.na(polity2_category)) %>%
  ggplot( aes(pollution_emission_change,gdp_ln,color=polity2_category)) + 
  geom_point()+
  scale_color_manual(values=c("darkolivegreen","red","gold2"))+
  labs(x="Schadstoffaustoßveränderung zw 2005 und 2014",
       y="BIP (logarithmiert)",
       title="BIP und Schadstoffausstoßveränderung 2005 bis 2014",
       subtitle = "Daten stammen von EPI (University Yale) und Polity IV Projekt",
       color="Regimetyp")


dt %>% dplyr::filter(!is.na(polity2_category)) %>%
  ggplot( aes(pollution_emission_change,gdp_ln,color=polity2_category)) + 
  geom_point()+
  scale_color_manual(values=c("darkolivegreen","red","gold2"))+
  labs(x="Schadstoffaustoßveränderung zw 2005 und 2014",
       y="BIP (logarithmiert)",
       title="BIP und Schadstoffausstoßveränderung 2005 bis 2014",
       subtitle = "Daten stammen von EPI (University Yale) und Polity IV Projekt",
       color="Regimetyp")+
  theme(legend.position = "bottom")
