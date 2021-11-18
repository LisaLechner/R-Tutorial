#######################################
# Vom langen zum weiten Format und umgekehrt
#######################################

library(tidyverse)

df <- data.frame(leser_in=c("Hugo","Klara","Lois"),
           buch_genre=c("Fantasy","Biographie","Roman","Sachbuch",
                        "Fantasy","Biographie","Roman","Sachbuch",
                        "Fantasy","Biographie","Roman","Sachbuch"),
           buch_anzahl=c(10,1,0,1,
                         0,5,6,2,
                         0,0,0,8))


#---------
# Von lang zu weit
#---------

df_weit <- df %>% pivot_wider(id_cols = "leser_in",
                              names_from="buch_genre",
                              values_from="buch_anzahl")


#---------
# Von weit zu lang
#---------
names(df_weit)
df_lang <- df_weit %>% pivot_longer(cols=2:ncol(df_weit),
                                    names_to="buch_genre",
                                    values_to="buch_anzahl")
