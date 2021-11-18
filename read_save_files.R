#######################################
# Einlesen und Speichern von Datensätzen
# Verwendung des Political Behaviour Datasets: 
# https://vincentarelbundock.github.io/Rdatasets/doc/Stat2Data/Political.html 
# Noch mehr zum Einlesen von Datensätzen: https://r4ds.had.co.nz/data-import.html 
#######################################


#-------
# Einlesen von Daten
#-------

# csv
political <- read.csv('./data/Political.csv')

library(tidyverse)

political <- read_csv('./data/Political.csv')
spec(political)

# excel

library(readxl)
political <- read_excel('./data/Political.xlsx')


# from internet
political <- read_csv('https://vincentarelbundock.github.io/Rdatasets/csv/Stat2Data/Political.csv')

# rds
political <- readRDS('./data/Political.rds')


#-------
# Speichern von Daten
#-------

write.csv(political,'./data/Political_new.csv')
write_csv(political,'./data/Political_new.csv')

saveRDS(political,'./data/Political_new.rds')
