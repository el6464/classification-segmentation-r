# ============================================================
# 01 - PREPARATION DES DONNEES
# Classification et segmentation avec R
# ============================================================

# Packages nécessaires
packages <- c(
  "dplyr",
  "readr",
  "tidyr"
)

packages_manquants <- packages[
  !(packages %in% installed.packages()[, "Package"])
]

if (length(packages_manquants) > 0) {
  install.packages(packages_manquants)
}

library(dplyr)
library(readr)
library(tidyr)

# ------------------------------------------------------------
# 1. Importation
# ------------------------------------------------------------

# Le fichier de données sera placé dans data/
# Adapter le nom du fichier si nécessaire.

donnees <- read_csv(
  "data/donnees_classification.csv",
  show_col_types = FALSE
)

# ------------------------------------------------------------
# 2. Vérification de la structure
# ------------------------------------------------------------

print(dim(donnees))
print(names(donnees))
print(str(donnees))

# ------------------------------------------------------------
# 3. Vérification des valeurs manquantes
# ------------------------------------------------------------

valeurs_manquantes <- donnees %>%
  summarise(
    across(
      everything(),
      ~ sum(is.na(.))
    )
  )

print(valeurs_manquantes)

# ------------------------------------------------------------
# 4. Suppression des doublons
# ------------------------------------------------------------

donnees <- donnees %>%
  distinct()

# ------------------------------------------------------------
# 5. Sélection des variables quantitatives
# ------------------------------------------------------------

donnees_quantitatives <- donnees %>%
  select(
    where(is.numeric)
  )

# ------------------------------------------------------------
# 6. Suppression des lignes incomplètes
# ------------------------------------------------------------

donnees_quantitatives <- donnees_quantitatives %>%
  drop_na()

# ------------------------------------------------------------
# 7. Vérification finale
# ------------------------------------------------------------

print(summary(donnees_quantitatives))

cat(
  "Nombre d'individus :",
  nrow(donnees_quantitatives),
  "\n"
)

cat(
  "Nombre de variables quantitatives :",
  ncol(donnees_quantitatives),
  "\n"
)

# ------------------------------------------------------------
# 8. Export
# ------------------------------------------------------------

dir.create(
  "data",
  showWarnings = FALSE
)

write_csv(
  donnees_quantitatives,
  "data/donnees_quantitatives.csv"
)

cat(
  "Données préparées enregistrées dans data/donnees_quantitatives.csv\n"
)
