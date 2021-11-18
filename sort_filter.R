#######################################
# Daten sortieren und Filtern
#######################################

library(tidyverse)
political <- read.csv('./data/Political.csv')


#--------------
# Daten sortieren
#--------------

head(political)

political <- political %>% arrange(Year)
head(political,20)


political <- political %>% arrange(desc(Year))
head(political,20)

#--------------
# Daten filtern
#--------------

table(political$Year)

political1 <- political %>% filter(Year==1)
View(political1)
nrow(political1)

table(political$Year,political$Paper)
political1_paper4 <- political %>% filter(Year>=2,Paper==4)
                                        
