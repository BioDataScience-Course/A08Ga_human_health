# Étude de l'obésité - Importation et remaniement des données
# Auteur : ___
# Date : ____
###############################################################################

# Packages utiles
SciViews::R(lang = "fr")

# Importation des données brutes

## Création des dossier `data/` et `cache/`
fs::dir_create("data/cache")

## Importation du dictionnaire des données
biometry_metadata <- read$csv(
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vSasAZFal-ljIJkB8LaPo1q-I6KKUbqXcdDNmbvwMhGD4f1_4tpbTRr1kWGrE4JZ1SHYBAUGfRFHhME/pub?gid=0&single=true&output=csv",
  cache_file = "data/cache/biometry_metadata_raw.csv",
  force = FALSE
)

## Importation du tableau de données
biometry <- read$csv(
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vS9yT2JjKi_LD00flboVYyovOnYMuh5NLKTFXOZYetAUE9xFUQYtUOhVhmb4Xf73mxbt4NThe2kjfe6/pub?gid=0&single=true&output=csv",
  cache_file = "data/cache/biometry_raw.csv",
  force = FALSE
)

# Exploration des données

skimr::skim(biometry)

# Modification des types de variables des données

unique(biometry$genre)
biometry$genre <- factor(biometry$genre, levels = c("h", "f"))

unique(biometry$regime)
biometry$regime <- factor(biometry$regime, levels = c("omnivore", "carnivore", "végétarien"))

unique(biometry$depense)
biometry$depense <- factor(biometry$depense, levels = c(-2, -1, 1, 2), labels = c("très insuffisant", "insuffisant", "suffisant", "plus que suffisant") , ordered = TRUE)

unique(biometry$depense)
biometry$activite <- factor(biometry$activite, levels = c(0:4), ordered = TRUE)

unique(biometry$hormone)
biometry$hormone <- factor(biometry$hormone, levels = c("non", "oui"))

unique(biometry$pathologie)
biometry$pathologie <- factor(biometry$pathologie, levels = c("non", "oui"))

# Correction, filtre, sélection sur le tableau des données

biometry %>.%
  smutate(., 
  # Calcul de l'age des individu
  age = as.numeric(difftime(date_mesure, date_naissance, units = "days")/365.25), 
  # Calcul de la masse corrigée
  masse_corr = masse*(masse_exp_ref/masse_exp)) %>.%
  sdrop_na(., masse_corr) -> 
  biometry

# Ajout des labels et des unités
# TODO


# Sauvegarde local des données importantes 
write$rds(biometry, "data/biometry.rds", compress = "xz")
write$rds(biometry_metadata, "data/biometry_metadata.rds", compress = "xz")

# Élimination des objets de l'environnement global
rm(biometry_metadata, biometry)
