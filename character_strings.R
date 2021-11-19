#######################################
# Umgang mit Character Strings (Textfeldern)
#######################################

#------------
# Pakete laden
#------------
library(tidyverse)
library(stringi)

# String Character

unis <- c("Universität Innsbruck (Sowi), Universitätsstraße 15a, 6020 Innsbruck",
          "Universität Graz, Universitätsplatz 3, 8010 Graz",
          "Universität Wien (NIG) (Powi), Universitätsstraße 7, 1010 Wien")
class(unis)
unis

#------------
# Zeichen löschen/ersetzen
#------------

gsub("Universität","Uni",unis)
gsub("Universität","",unis)
stri_replace(unis,fixed="Universität","Uni")
stri_replace_all(unis,regex="[[:digit:]]","X")


#------------
# Zeichen suchen
#------------

stri_detect(unis,regex="\\([[:alpha:]]{1,}\\)")

#------------
# Zeichen extrahieren
#------------

stri_extract(unis,regex="\\([[:alpha:]]{1,}\\)")
stri_extract_last(unis,regex="\\([[:alpha:]]{1,}\\)")
stri_extract_all(unis,regex="\\([[:alpha:]]{1,}\\)")

#------------
# character vektor teilen
#------------

l <- stri_split(unis,fixed=",")
library(plyr)
dt <- ldply(l)
names(dt) <- c("Name","Straße","Stadt")

