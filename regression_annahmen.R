###############################
# Regression: Annahmen überprüfen
###############################

library(tidyverse)
library(modelsummary)


#---------
# Daten einlesen
#--------
dt <- read_csv('./data/merged_so2_trade.csv')

# Cross-Section Datensatz

dt <- dt %>% filter(year == 2012)
#---------
# Was ist in den Daten?
#--------
names(dt)
head(dt)

#---------
# Lineare Regression schätzen
#--------
model1 <- lm(pm5_gdp~trade_gdp+polity2+gdp,data=dt)
summary(model1)
#---------
# Linearität, Homoskedaszität, und keine extremen Ausreißer
# Plot 1 und 2 geben die Linearität an
  # Plot 1 (Residual vs Fitted): Überprüfung des linearen Zusammenhangs (Rote Linie sollte annhänernd horizontal sein)
  # Plot 2 (Normal Q-Q): Linearität der Residiuen (Punkte sollten auf der strichlierten Linie liegen)
# Plot 3 (Scale-Location): Überprüft die Homogenität der Varianz (Punkte sollten gleichmäßig horizontal verteilt liegen, rote Linie sollten ebenso annhähernd horizontal sein)
# Plot 4 (Residuals vs Leverage): Überprüft den Einfluss von einzelnen Beobachtungen (Ausreißer, welche eine Standardabweichung über 2 haben sollten genauer unter die Lupe genommen werden)
#--------
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

# Schätzung einer Linearen Regression
model1 <- lm(pm5_gdp~trade_gdp+polity2+gdp,data=dt)
par(mfrow = c(2, 2))
plot(model1)

# Regression mit logarithmierte EVs

model2 <- lm(pm5_gdp~trade_gdp+polity2+gdp_ln,data=dt)
plot(model2)

# Regression mit logarithmierte EVs und DV

model3 <- lm(pm5_gdp_ln~trade_gdp+polity2+gdp_ln,data=dt)
plot(model3)

# Korrektur der Ausreißer
dt[90,]

model4 <- lm(pm5_gdp_ln~trade_gdp+polity2+gdp_ln,data=dt[dt$iso3c!="IND",])
plot(model4)
summary(model4)

#---------
# Autokorrelation
#--------
acf(resid(model4), main="Autokorrelation in Modell 4")

#---------
# Keine Multikolliniearität
#--------
model_corr_matrix <- cor(dt %>% 
                           select(pm5_gdp_ln,gdp_ln,polity2,trade_gdp),
                         use = "pairwise.complete.obs")
model_corr_matrix
par(mfrow = c(1, 1))
corrplot::corrplot(model_corr_matrix)

car::vif(model4) # die Variance Inflator Models sollten nicht über 2 liegen

