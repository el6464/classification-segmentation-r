# ============================================================
# 04 - CLASSIFICATION HIERARCHIQUE
# Classification et segmentation avec R
# ============================================================

library(ggplot2)

# ------------------------------------------------------------
# 1. Importation
# ------------------------------------------------------------

donnees <- read.csv(
  "data/donnees_quantitatives.csv"
)

# ------------------------------------------------------------
# 2. Standardisation
# ------------------------------------------------------------

donnees_standardisees <- scale(
  donnees
)

# ------------------------------------------------------------
# 3. Distance euclidienne
# ------------------------------------------------------------

distance <- dist(
  donnees_standardisees,
  method = "euclidean"
)

# ------------------------------------------------------------
# 4. Classification hiérarchique
# ------------------------------------------------------------

classification <- hclust(
  distance,
  method = "ward.D2"
)

# ------------------------------------------------------------
# 5. Dendrogramme
# ------------------------------------------------------------

dir.create(
  "outputs/figures",
  recursive = TRUE,
  showWarnings = FALSE
)

png(
  "outputs/figures/dendrogramme_ward.png",
  width = 1000,
  height = 700
)

plot(
  classification,
  main = "Classification hiérarchique - méthode de Ward",
  xlab = "Individus",
  sub = "",
  ylab = "Distance"
)

dev.off()

# ------------------------------------------------------------
# 6. Proposition d'une partition
# ------------------------------------------------------------

# Le nombre de classes sera déterminé après
# observation du dendrogramme.

# Exemple :
# groupes <- cutree(classification, k = 5)

# print(table(groupes))
