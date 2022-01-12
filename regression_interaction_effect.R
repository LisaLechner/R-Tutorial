
############################################
# Regression: Interaktionseffekte
#############################################
library(marginaleffects)

#---------
# Daten einlesen
#--------
dt_panel <- read_csv('./data/merged_so2_trade.csv')

# Cross-Section Datensatz

dt_panel <- dt_panel %>%
  mutate(gdp_ln=log(gdp),
         pm5_gdp_ln=log(pm5_gdp),
         so2_ln = log(so2),
         so2pc_ln = log(so2pc))

#---------
# Modell schätzen
#-------
model <- lm(so2pc_ln~trade_gdp*polity2+gdp_ln+as.factor(iso3c),data=dt_panel)
summary(model)

#---------
# Grafische Darstellung des Interaktionseffektes
#-------
# Conditional Marginal Effects
plot_cme(model, effect = "trade_gdp", condition = c("polity2"))+
  labs(x='Polity 2',y='Marginale Effekte von Trade/GDP auf So2 per capita (log)',
       title='Interaktionseffekt: Trade/GDP x Polity 2 auf So2 per capita (log)')

ggsave('./figs/interaktionseffekt.png')
