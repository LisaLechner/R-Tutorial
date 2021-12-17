#######################################
# ggplot für eine dsikrete Variable
#######################################

library(tidyverse)
library(readxl)
library(ggplot2)

# um die Grafiken einfach zu halten (Stichwort Ink-Data Ratio)
theme_set(theme_minimal())

# Einlesen der kategorischen Variable (Quelle: Climate Change Tracker: https://climateactiontracker.org/)
climatetracker <- read_excel('./data/ratings_climateactiontracker.xlsx')

#------
# Barchart
#------

ggplot(climatetracker, aes(rating)) + geom_bar()+
  labs(x="INDC Zugeständnisse",
       y="Häufigkeit",
       title="Verteilung der INDC Zugeständnisse",
       subtitle = "Daten stammen vom Climate Change Tracker")

ggplot(climatetracker, aes(rating)) + geom_bar()+
  labs(x="INDC Zugeständnisse",
       y="Häufigkeit",
       title="Verteilung der INDC Zugeständnisse",
       subtitle = "Daten stammen vom Climate Change Tracker")+
  theme(axis.text.x = element_text(angle = 90))


ggplot(climatetracker, aes(rating)) + geom_bar(width=0.1)+
  labs(x="INDC Zugeständnisse",
       y="Häufigkeit",
       title="Verteilung der INDC Zugeständnisse",
       subtitle = "Daten stammen vom Climate Change Tracker")+
  theme(axis.text.x = element_text(angle = 90))


ggplot(climatetracker, aes(rating)) + geom_bar(width=0.1)+
  labs(x="INDC Zugeständnisse",
       y="Häufigkeit",
       title="Verteilung der INDC Zugeständnisse",
       subtitle = "Daten stammen vom Climate Change Tracker")+
  coord_flip()
  


count <- climatetracker %>% mutate(count=1) %>% 
  group_by(rating) %>% 
  dplyr::summarise(count=sum(count))

climatetracker <- left_join(climatetracker,count) %>%
  arrange(desc(count)) 

climatetracker$rating <- factor(climatetracker$rating,levels=unique(climatetracker$rating))


ggplot(climatetracker, aes(rating)) + geom_bar(width=0.1)+
  labs(x="INDC Zugeständnisse",
       y="Häufigkeit",
       title="Verteilung der INDC Zugeständnisse",
       subtitle = "Daten stammen vom Climate Change Tracker")+
  coord_flip()



