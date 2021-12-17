#######################################
# ggplot maps
#######################################

library(tidyverse)
library(readxl)
library(ggplot2)

# um die Grafiken einfach zu halten (Stichwort Ink-Data Ratio)
theme_set(theme_minimal())


climatetracker <- read_excel('./data/ratings_climateactiontracker.xlsx') 

#-------
# Geographische Karte darstellen
#-------
ggplot(climatetracker, aes(map_id = country)) +
  geom_map(aes(fill = rating), map = map_data("world")) +
  scale_fill_manual(values=c("darkolivegreen","red","orange","navyblue"))+
  expand_limits(x = map_data("world")$long, y = map_data("world")$lat)

all_countries <- data.frame(country=unique(map_data("world")$region))
climatetracker <- right_join(climatetracker,all_countries)

#-------
ggplot(climatetracker, aes(map_id = country)) +
  geom_map(aes(fill = rating), map = map_data("world")) +
  scale_fill_manual(values=c("darkolivegreen","red","orange","navyblue"))+
  expand_limits(x = map_data("world")$long, y = map_data("world")$lat)+
  labs(title="INDC Zugeständnisse nach Climate Change Tracker",
       fill="Climate Change Tracker Ratings")+
  theme(legend.position = "bottom")

