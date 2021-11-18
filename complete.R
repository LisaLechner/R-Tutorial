#######################################
# Vollständigkeit?
#######################################


library(tidyverse)
library(readxl)

#--------
# Vollständigkeit des Polity2 scores
#--------

polity <- read_excel('./data/polity.xls')

# generelle Vollständigkeit

table(is.na(polity$polity2))

# soviel Prozent der Daten fehlen

sum(is.na(polity$polity2))/nrow(polity) 

# Missings über Jahre

na_year <- polity %>% group_by(year) %>% summarize(count_na=sum(is.na(polity2))) 

plot(na_year$year,na_year$count_na)

# Missings über Länder

polity %>% group_by(country) %>% 
  summarize(count_na=sum(is.na(polity2))) %>%
  arrange(-count_na) %>% head(.,20)

