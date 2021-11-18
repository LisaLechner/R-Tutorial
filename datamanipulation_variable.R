#######################################
# Datenmanipulation von Variablen
#######################################

library(tidyverse)
political <- read.csv('./data/Political.csv')
names(political)
ncol(political)
#--------
# Variablen generieren
#--------
# option ohne tidyverse
Alter <- round(rnorm(59,mean=20,sd=3))
political$Alter <- Alter
political$Alter <- round(rnorm(59,mean=20,sd=3))

# option mit tidyverse
political %>% mutate(Alter = Alter)
political <- political %>% mutate(Alter = Alter)

#--------
# Variablen löschen
#--------
# Option ohne tidyverse
political$Alter <- NULL

# Option mit Tidyverse
political <- political %>% mutate(Alter = Alter)
political <- political %>% select(-Alter)

political2 <- political %>% select(Year,Paper)
political2 <- political[c("Year","Paper")]
#--------
# Variablen umbenennen
#--------
# Option ohne tidyverse
political$Alter_neu <- political$Alter
political$Alter <- NULL
names(political)
names(political)[names(political)=="Alter"] <- "Alter_neu2"

# Option mit tidyverse
political <- political %>% mutate(Alter = Alter)
political <- political %>% rename(Alter_neu=Alter)
names(political)

#--------
# Variablen umkodieren
#--------
table(political$Sex)
political$Sex_c <- ifelse(political$Sex==0,'male','female')
table(political$Sex_c)
political$Sex_c <- NULL

political$Sex_c <- recode(political$Sex,`0`="male",`1`="female")

political <- political %>% 
  mutate(Sex_c=recode(Sex,`0`="male",`1`="female"))
table(political$Sex_c)
