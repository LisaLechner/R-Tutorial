#######################################
# Tidy Daten?
#######################################


library(tidyverse)
library(readxl)

#----------
# polity
#----------

download.file('http://www.systemicpeace.org/inscr/p5v2018.xls',destfile='./data/polity.xls')
polity <- read_excel('./data/polity.xls')


#----------
# trade
#----------

download.file('https://api.worldbank.org/v2/en/indicator/TG.VAL.TOTL.GD.ZS?downloadformat=excel',destfile='./data/trade.xls')
trade <- read_excel('./data/trade.xls')
names(trade) <- trade[3,]
trade <- trade[4:nrow(trade),]
names(trade)
trade <- pivot_longer(trade,cols=5:ncol(trade),names_to="Year",values_to="trade_gdp")
