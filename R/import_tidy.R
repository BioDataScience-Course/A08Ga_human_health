# Importation, nettoyage et sauvegarde local des données

# Packages utiles
SciViews::R(lang = "fr")


# Importation des données brutes ------------------------------------------

# Création des dossier `data/` et `data_cache/`
dir_create("data/data_cache")

# Importation du dictionnaire des données
dictionnary <- read$csv(
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vS6Zv8rMf1eQVOcLanotqeJ8rw2eGVQ3sAXfJk3_mxUDcwALcn9irtcBK42ynfUSuuYA4X7vk4yiBs3/pub?output=csv",
  cache_file = "data/data_cache/dictionnary.csv",
  force = FALSE
)

# Importation du tableau de données
biometry <- read$csv(
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vS3hqfeIg6xGEliHpxQAZEvQxqEdQFSYDll0gysoS8seTjk9BNKHR99poZAOR2Zi5QhPdeSE9Rq4LPA/pub?output=csv",
  cache_file = "data/data_cache/biometry_raw.csv",
  force = FALSE
)


# Exploration des données brutes ------------------------------------------

# Vous pouvez décommenter et/ou ajouter ici le code qui vous permet de prendre
# connaissance de vos données brutes, par exemple :
# (note : ne modifiez pas encore le tableau `biometry` ici)
#visdat::vis_dat(biometry)
#skimr::skim(biometry)
#
#chart(biometry, ~ date_naissance) +
#  geom_histogram(bins = 50)
#
#chart(biometry, ~ antecedents_anorexie) +
#  geom_bar()


# Corrections -------------------------------------------------------------

# Retirer la ligne d'exemple
biometry <- sfilter(biometry, id != "00_A")

# Retirer les lignes sans correction de masse
biometry <- sdrop_na(biometry, corr_masse)

# Correction de niveaux mal othographiés
(.= biometry$activite_physique)[. == "très élévée"] <- "très élevée"
(.= biometry$regime_alimentaire)[. == "omninore"] <- "omnivore"


# Ajout des types de variables --------------------------------------------

biometry <- smutate(biometry,
  activite_physique = factor(activite_physique, 
    levels = c("nulle", "faible", "moyenne", "très élevée")),
  antecedents_obesite = factor(antecedents_obesite, levels = c("oui", "non")),
  antecedents_anorexie = factor(antecedents_anorexie, levels = c("oui", "non")),
  masse_brutes = masse,
  masse = masse_brutes * corr_masse,
  regime_alimentaire = factor(regime_alimentaire,
    levels = c("omnivore", "carnivore", "végétarien"))
)


# Ajout des labels et des unités ------------------------------------------

# TODO


# Sauvegarde locale des données et nettoyage de l'environnement -----------

write$rds(biometry, "data/biometry.rds", compress = "xz")
rm(dictionnary, biometry)
