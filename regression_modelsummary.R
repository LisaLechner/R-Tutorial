############################################
# Regressionsoutput zusammenfassen
#############################################


library(tidyverse)
library(modelsummary)


#---------
# Daten einlesen
#--------
dt <- read_csv('./data/merged_so2_trade.csv')

# Cross-Section Datensatz

dt <- dt %>% filter(year == 2012) %>% 
  mutate(gdp_ln=log(gdp),
         pm5_gdp_ln=log(pm5_gdp),
         so2_ln = log(so2),
         so2pc_ln = log(so2pc))


dt_panel <- read_csv('./data/merged_so2_trade.csv')

# Cross-Section Datensatz

dt_panel <- dt_panel %>%
  mutate(gdp_ln=log(gdp),
         pm5_gdp_ln=log(pm5_gdp),
         so2_ln = log(so2),
         so2pc_ln = log(so2pc))

#---------
# Modelle schätzen
#---------

models <- list(
  'Cross-Section 1' = lm(pm5_gdp_ln~trade_gdp,data=dt),
  'Cross-Section 2' = lm(pm5_gdp_ln~trade_gdp+polity2+gdp_ln,data=dt),
  'Cross-Section 3' = lm(pm5_gdp_ln~trade_gdp*polity2+gdp_ln,data=dt),
  'Panel 1' = lm(pm5_gdp_ln~trade_gdp+as.factor(iso3c),data=dt_panel),
  'Panel 2' = lm(pm5_gdp_ln~trade_gdp+polity2+gdp_ln+as.factor(iso3c),data=dt_panel),
  'Panel 3' = lm(pm5_gdp_ln~trade_gdp*polity2+gdp_ln+as.factor(iso3c),data=dt_panel)
)


models2 <- list(
  'Cross-Section 1' = lm(so2_ln~trade_gdp,data=dt),
  'Cross-Section 2' = lm(so2_ln~trade_gdp+polity2+gdp_ln,data=dt),
  'Cross-Section 3' = lm(so2_ln~trade_gdp*polity2+gdp_ln,data=dt),
  'Panel 1' = lm(so2_ln~trade_gdp+as.factor(iso3c),data=dt_panel),
  'Panel 2' = lm(so2_ln~trade_gdp+polity2+gdp_ln+as.factor(iso3c),data=dt_panel),
  'Panel 3' = lm(so2_ln~trade_gdp*polity2+gdp_ln+as.factor(iso3c),data=dt_panel)
)



#---------
# Modelle zusammenfassen
#---------

modelsummary(models,
             fmt=5,
             stars=TRUE,
             title='DV: PM5',
             coef_map = c('trade_gdp'='Trade/GDP',
                          'polity2'='Polity 2',
                          'trade_gdp:polity2'='Trade/GDP x Polity 2',
                          'gdp_ln'='GDP (log)'))

modelsummary(models2,
             fmt=5,
             stars=TRUE,
             title='DV: So2 per capita (log)',
             coef_map = c('trade_gdp'='Trade/GDP',
                          'polity2'='Polity 2',
                          'trade_gdp:polity2'='Trade/GDP x Polity 2',
                          'gdp_ln'='GDP (log)'))


# als Bild Abspeichern (tex, txt, etc geht auch)
modelsummary(models,
             fmt=5,
             stars=TRUE,
             title='DV: So2 per capita (log)',
             coef_map = c('trade_gdp'='Trade/GDP',
                          'polity2'='Polity 2',
                          'trade_gdp:polity2'='Trade/GDP x Polity 2',
                          'gdp_ln'='GDP (log)'),
             output='./tables/regression_pm5.png')

modelsummary(models2,
             fmt=5,
             stars=TRUE,
             title='DV: So2 per capita (log)',
             coef_map = c('trade_gdp'='Trade/GDP',
                          'polity2'='Polity 2',
                          'trade_gdp:polity2'='Trade/GDP x Polity 2',
                          'gdp_ln'='GDP (log)'),
             output='./tables/regression_so2.png')


