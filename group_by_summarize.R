#######################################
# Daten gruppieren und Zusammenfassen
#######################################

library(tidyverse)
political <- read.csv('./data/Political.csv')


# Überblick über Gruppen verschaffen

summary(political$Paper)

political %>% group_by(Year) %>% summarize(mean(Paper))

# neue Variable generieren

political2 <- political %>% group_by(Year) %>% 
  summarize(Paper_mean = mean(Paper)) %>% 
  ungroup()

political <- left_join(political,political2)
