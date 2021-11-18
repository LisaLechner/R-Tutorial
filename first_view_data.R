#######################################
# Einen Datensatz kennenlernen
# Use the Political Behaviour Dataset: 
# https://vincentarelbundock.github.io/Rdatasets/doc/Stat2Data/Political.html 
#######################################


source('read_save_files.R')

# View 
View(political)

# Variablen Namen
names(political)

# Struktur des Datensatzes
str(political)

# Datenart

class(political$Participate)
political$Participate <- as.numeric(political$Participate)


# Ersten und letzten Zeilen eines Datensatzes
head(political)
tail(political)

# Zusammenfassung der Daten

summary(political)
summary(political$Paper)

table(political$Paper)

# Missing Data?

is.na(political$Participate)
table(is.na(political$Participate))
