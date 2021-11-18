#######################################
# Objekttypen und Zugriff auf Objekte
#######################################

#------
# Nummerisch
#------

x <- 1
y <- 2

x

#------
# Character
#------

z <- "hallo"

z

#------
# Logische Werte
#------

ja <- TRUE
nein <- FALSE

ja

ja - nein

#------
# Vektor
#------

X <- c(1,2,4,5,6,9)
Z <- c("Hello","Hi","Servus")
tf <- c(TRUE,FALSE,TRUE,TRUE)

X
X[2]
tf[3:4]


#------
# Faktoren
#------

land <- c("Österreich","Deutschland","Österreich","Griechenland","Island","Island")
class(land)
land
land <- factor(land)
land
land <- as.character(land)
land
land <- as.factor(land)

#------
# Matrix
#------

M <- matrix(X,nrow=2)
M
M[1,2]

#------
# Datensatz
#------

df <- data.frame(id=c(1,2,3),name=c("Hugo","Klara","Ria"),alter=c(0,10,8))
df

df$name
df$name[1]
df[2,]
df[2,1]


