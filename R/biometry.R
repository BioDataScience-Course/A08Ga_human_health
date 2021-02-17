# Importation, Remaniement et ajout des labels à biometry2019.rds

SciViews::R

# Importation des données brutes
bio <- read("data/raw/biometry2019.rds")

# Remaniement, ajout des labels,... 


# Sauvegarde des données améliorée
write(___, "data/bio2019.rds", type = "rds", compress = "xz")
