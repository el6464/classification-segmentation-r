# ============================================================
# 05 - K-MEANS
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
# 3. K-means
# ------------------------------------------------------------

set.seed(123)

# Le nombre de groupes sera ajusté après
# analyse de la classification hiérarchique.

k <- 5

kmeans_resultat <- kmeans(
  donnees_standardisees,
  centers = k,
  nstart = 25
)

# ------------------------------------------------------------
# 4. Taille des groupes
# ------------------------------------------------------------

print(kmeans_resultat$size)

# ------------------------------------------------------------
# 5. Centres des groupes
# ------------------------------------------------------------

print(kmeans_resultat$centers)

# ------------------------------------------------------------
# 6. Ajout du groupe à chaque individu
# ------------------------------------------------------------

donnees_groupes <- as.data.frame(
  donnees
)

donnees_groupes$groupe <- factor(
  kmeans_resultat$cluster
)

print(head(donnees_groupes))

# ------------------------------------------------------------
# 7. Export
# ------------------------------------------------------------

dir.create(
  "outputs/tables",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  donnees_groupes,
  "outputs/tables/resultats_kmeans.csv",
  row.names = FALSE
)

write.csv(
  kmeans_resultat$centers,
  "outputs/tables/centres_groupes_kmeans.csv"
)

# ------------------------------------------------------------
# 8. Visualisation
# ------------------------------------------------------------

# Visualisation simple sur les deux premières variables

graphique <- ggplot(
  donnees_groupes,
  aes(
    x = .data[[names(donnees)[1]]],
    y = .data[[names(donnees)[2]]],
    shape = groupe
  )
) +
  geom_point(
    size = 3
  ) +
  labs(
    title = "Segmentation des individus par K-means",
    x = names(donnees)[1],
    y = names(donnees)[2],
    shape = "Groupe"
  ) +
  theme_minimal()

print(graphique)

ggsave(
  "outputs/figures/kmeans_segmentation.png",
  graphique,
  width = 9,
  height = 6
)
