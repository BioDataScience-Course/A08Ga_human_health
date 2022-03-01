# Importation, remaniement et ajout des labels et unités à biometry2019.rds

SciViews::R

# Importation des données brutes
bio <- read("data/raw/biometry2019.rds")

# Remaniement, ajout des labels, unités,...
# Aidez-vous du dictionnaire des données associé, disponible à l'adresse https://docs.google.com/spreadsheets/d/1j55bB9YEAVbS4eRE-i6L-NEYhHXua-dxs-aQr_qko7k/edit?usp=sharing



# Sauvegarde des données améliorée
write$rds(___, "data/bio2019.rds", compress = "xz")
