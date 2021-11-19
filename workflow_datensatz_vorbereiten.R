#######################################
# Workflow
#######################################

#------------
# Pakete laden
#------------
library(tidyverse)
library(readxl)

#----------
# So2
#----------

so2 <- read_csv('./data/SO2_raw.csv') 
so2 <- so2 %>% pivot_longer(cols=4:ncol(so2),values_to="so2",names_to="year") %>%
  rename(iso3c=iso) %>% mutate(year=as.numeric(gsub("SO2.raw.","",year))) %>%
  select(iso3c,year,so2)


#----------
# PM5
#----------
download.file('https://api.worldbank.org/v2/en/indicator/EN.ATM.PM25.MC.M3?downloadformat=excel',destfile='./data/pm5.xls')
pm5 <- read_excel('./data/pm5.xls')
names(pm5) <- pm5[3,]
pm5 <- pm5[4:nrow(pm5),]
names(pm5)
pm5 <- pivot_longer(pm5,cols=5:ncol(pm5),names_to="Year",values_to="pm5_gdp")
pm5 <- pm5 %>% rename(iso3c=`Country Code`,
                      year=Year) %>%
  select(iso3c,year,pm5_gdp) %>%
  mutate(year=as.numeric(year))



#----------
# GDP
#----------
download.file('https://api.worldbank.org/v2/en/indicator/NY.GDP.MKTP.CD?downloadformat=excel',destfile='./data/gdp.xls')
gdp <- read_excel('./data/gdp.xls')
names(gdp) <- gdp[3,]
gdp <- gdp[4:nrow(gdp),]
names(gdp)
gdp <- pivot_longer(gdp,cols=5:ncol(gdp),names_to="Year",values_to="gdp")
gdp <- gdp %>% rename(iso3c=`Country Code`,
                      year=Year) %>%
  select(iso3c,year,gdp)%>%
  mutate(year=as.numeric(year))

#----------
# polity
#----------

download.file('http://www.systemicpeace.org/inscr/p5v2018.xls',destfile='./data/polity.xls')
polity <- read_excel('./data/polity.xls')
polity <- polity %>% rename(iso3c=scode) %>% 
  mutate(polity2=ifelse(polity2<(-10),NA,polity2)) %>%
  dplyr::select(iso3c,year,polity2)%>%
  mutate(year=as.numeric(year))


#----------
# trade
#----------

download.file('https://api.worldbank.org/v2/en/indicator/TG.VAL.TOTL.GD.ZS?downloadformat=excel',destfile='./data/trade.xls')
trade <- read_excel('./data/trade.xls')
names(trade) <- trade[3,]
trade <- trade[4:nrow(trade),]
names(trade)
trade <- pivot_longer(trade,cols=5:ncol(trade),names_to="Year",values_to="trade_gdp")
trade <- trade %>% rename(iso3c=`Country Code`,
                          year=Year) %>%
  select(iso3c,year,trade_gdp)%>%
  mutate(year=as.numeric(year))

#----------
# merge all
#----------

dt <- full_join(so2,pm5)
dt <- full_join(dt,gdp)
dt <- full_join(dt,polity)
dt <- full_join(dt,trade)

str(dt)

dt <- dt %>% filter(year>1945) %>%
  mutate(gdp=as.numeric(gdp),
         pm5_gdp=as.numeric(pm5_gdp),
         trade_gdp=as.numeric(trade_gdp)) %>%
  mutate(so2pc = so2/gdp)

write_csv(dt,'./data/merged_so2_trade.csv')
