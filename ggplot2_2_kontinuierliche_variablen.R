#######################################
# ggplot für zwei kontinuierliche Variablen
#######################################

library(tidyverse)
library(readxl)
library(ggplot2)
library(countrycode)

# um die Grafiken einfach zu halten (Stichwort Ink-Data Ratio)
theme_set(theme_minimal())

# Einlesen der ersten kontinuierlichen Variable (Quelle: EPI https://epi.yale.edu/epi-results/2020/component/ape)
emission <- read_excel('./data/epi_pollution_emission.xlsx')



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

# Vorbereitung des Datensatzes zum mergen 
emission <- emission %>% mutate(iso3c=countrycode(country,"country.name","iso3c"))
gdp <- gdp %>% filter(year==2014) %>% mutate(gdp=as.numeric(gdp)) %>%
  mutate(gdp_ln=log(gdp))

dt <- left_join(emission, gdp)

#------
# Punktediagramm
#------

ggplot(dt, aes(pollution_emission_change,gdp)) + geom_point()+
  labs(x="Schadstoffemissionsveränderung von 2005 auf 2014",
       y="Brutto-Inlandsprodukt",
       title="Korrelation von Schadstoffemission und BIP",
       subtitle = "Daten stammen von EPI (Yale University) und der Weltbank")

ggplot(dt, aes(pollution_emission_change,gdp_ln)) + geom_point()+
  labs(x="Schadstoffemissionsveränderung von 2005 auf 2014",
       y="Brutto-Inlandsprodukt (logarithmiert)",
       title="Korrelation von Schadstoffemission und BIP",
       subtitle = "Daten stammen von EPI (Yale University) und der Weltbank")


#------
# Geom Smooth
#------

ggplot(dt, aes(pollution_emission_change,gdp_ln)) + geom_point()+
  geom_smooth()+
  labs(x="Schadstoffemissionsveränderung von 2005 auf 2014",
       y="Brutto-Inlandsprodukt (logarithmiert)",
       title="Korrelation von Schadstoffemission und BIP",
       subtitle = "Daten stammen von EPI (Yale University) und der Weltbank")
#------
# Quantile
#------

ggplot(dt, aes(pollution_emission_change,gdp_ln)) + geom_point()+
  geom_quantile()+
  labs(x="Schadstoffemissionsveränderung von 2005 auf 2014",
       y="Brutto-Inlandsprodukt (logarithmiert)",
       title="Korrelation von Schadstoffemission und BIP",
       subtitle = "Daten stammen von EPI (Yale University) und der Weltbank")

#------
# Beschriftung
#------

ggplot(dt, aes(pollution_emission_change,gdp_ln)) + geom_text(aes(label=iso3c))+
  geom_quantile()+
  labs(x="Schadstoffemissionsveränderung von 2005 auf 2014",
       y="Brutto-Inlandsprodukt (logarithmiert)",
       title="Korrelation von Schadstoffemission und BIP",
       subtitle = "Daten stammen von EPI (Yale University) und der Weltbank")

dt <- dt %>% mutate(label=ifelse(dt$pollution_emission_change>53|
                                   dt$pollution_emission_change<(-50),
                                 as.character(iso3c),""))

ggplot(dt, aes(pollution_emission_change,gdp_ln)) + 
  geom_point(alpha=0.4)+
  geom_text(aes(label=label))+
  #geom_quantile()+
  labs(x="Schadstoffemissionsveränderung von 2005 auf 2014",
       y="Brutto-Inlandsprodukt (logarithmiert)",
       title="Korrelation von Schadstoffemission und BIP",
       subtitle = "Daten stammen von EPI (Yale University) und der Weltbank")

#------
# Liniengrafik für kontinuierliche Zusammenhänge
#------

# Einlesen von der kontinuierlichen Variable als Paneldatensatz (GDP, Quelle: Weltbank)
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

gdp <- gdp %>% filter(iso3c=="AUT") %>%
  mutate(gdp=as.numeric(gdp))


ggplot(gdp, aes(year,gdp )) + 
  geom_point(alpha=0.4)+
  #geom_quantile()+
  labs(x="",
       y="Brutto-Inlandsprodukt",
       title="Österreich's BIP Verlauf über Zeit",
       subtitle = "Daten stammen von der Weltbank")


ggplot(gdp, aes(year,gdp )) + 
  geom_line()+
  #geom_quantile()+
  labs(x="",
       y="Brutto-Inlandsprodukt",
       title="Österreich's BIP Verlauf über Zeit",
       subtitle = "Daten stammen von der Weltbank")

