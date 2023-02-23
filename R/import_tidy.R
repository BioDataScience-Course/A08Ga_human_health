# Importation, nettoyage et sauvegarde local des données

# Packages utiles
SciViews::R()

# Importation des données brutes ---------
## Création des dossier `data/` et `data_raw/`
fs::dir_create("data/data_raw")

## Importation du dictionnaire des données
dico <- read$csv(
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vS6Zv8rMf1eQVOcLanotqeJ8rw2eGVQ3sAXfJk3_mxUDcwALcn9irtcBK42ynfUSuuYA4X7vk4yiBs3/pub?output=csv",
  cache_file = "data/data_raw/dictionnary.csv",
  force = FALSE
)

## Importation du tableau de données
biometry <- read$csv(
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vS3hqfeIg6xGEliHpxQAZEvQxqEdQFSYDll0gysoS8seTjk9BNKHR99poZAOR2Zi5QhPdeSE9Rq4LPA/pub?output=csv",
  cache_file = "data/data_raw/biometry_raw.csv",
  force = FALSE
)

# Exploration des données brutes ----
# visdat::vis_dat(biometry)
# skimr::skim(biometry)
# 
# chart(biometry, ~ date_naissance) +
#   geom_histogram(bins = 50)
# 
# chart(biometry, ~ antecedents_anorexie) +
#   geom_bar()

# Corrections -------
biometry <- sfilter(biometry, id != "00_A") # retirer la ligne d'exemple
biometry <- sdrop_na(biometry, corr_masse) # Retirer les lignes sans correction de masse

biometry$activite_physique[biometry$activite_physique == "très élévée"] <-"très élevée"
biometry$regime_alimentaire[biometry$regime_alimentaire == "omninore"] <-"omnivore"

# Ajout des types de variables -------

biometry <- smutate(biometry,
  activite_physique = factor(activite_physique, 
    levels = c("nulle", "faible", "moyenne", "très élevée")),
  antecedents_obesite = factor(antecedents_obesite, levels = c("oui", "non")),
  antecedents_anorexie = factor(antecedents_anorexie, levels = c("oui", "non")),
  masse_brutes = masse,
  masse = masse_brutes * corr_masse,
  regime_alimentaire = factor(regime_alimentaire, levels = c("omnivore", "carnivore", "végétarien"))
  )

# Ajout des labels et des unités  ---------
# TODO

# Sauvegarde local des données importantes  ---------
write$rds(biometry, "data/biometry.rds", compress = "xz")

# Elimination des objets de l'environnement global
rm(dico, biometry)
