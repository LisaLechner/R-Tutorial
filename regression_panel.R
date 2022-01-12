###############################
# Regression
###############################

library(tidyverse)
library(modelsummary)

#---------
# Daten einlesen
#--------
dt <- read_csv('./data/merged_so2_trade.csv')


#---------
# Was ist in den Daten?
#--------
names(dt)
head(dt)

#---------
# Annahmen prüfen
#--------

# Sind die Daten annähernd normalverteilt? nicht heteroskedastisch?

hist(dt$pm5_gdp)
hist(dt$gdp)
hist(dt$polity2)
dt <- dt %>% mutate(gdp_ln=log(gdp),
                    pm5_gdp_ln=log(pm5_gdp))

par(mfrow = c(2, 2))
hist(dt$pm5_gdp)
hist(dt$gdp)
hist(dt$pm5_gdp_ln)
hist(dt$gdp_ln)

model1 <- lm(pm5_gdp_ln~trade_gdp+polity2+gdp_ln,data=dt)
plot(model1)

head(dt[17157,])

model2 <- lm(pm5_gdp_ln~trade_gdp+polity2+gdp_ln,data=dt[dt$iso3c!="IND",])
plot(model2)
summary(model2)

# Autokorrelation
par(mfrow = c(1, 1))
acf(resid(model2), main="Autokorrelation in Modell 2")

#---------
# Korrektur der Autokorrelation durch Fixed Effects
#---------
unique(dt$iso3c)

model1 <- lm(pm5_gdp_ln~trade_gdp+as.factor(iso3c),data=dt)
summary(model1)
model2 <- lm(pm5_gdp_ln~trade_gdp+polity2+gdp_ln+as.factor(iso3c),data=dt)
summary(model2)


