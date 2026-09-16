# ============================================================
# 03 - ANALYSE EN COMPOSANTES PRINCIPALES
# Classification et segmentation avec R
# ============================================================

library(dplyr)
library(ggplot2)

# ------------------------------------------------------------
# 1. Importation
# ------------------------------------------------------------

donnees <- read.csv(
  "data/donnees_quantitatives.csv"
)

# ------------------------------------------------------------
# 2. Standardisation et ACP
# ------------------------------------------------------------

acp <- prcomp(
  donnees,
  center = TRUE,
  scale. = TRUE
)

# ------------------------------------------------------------
# 3. Résumé de l'ACP
# ------------------------------------------------------------

print(summary(acp))

# ------------------------------------------------------------
# 4. Valeurs propres
# ------------------------------------------------------------

valeurs_propres <- acp$sdev^2

pourcentage_variance <- valeurs_propres /
  sum(valeurs_propres) * 100

resultats_acp <- data.frame(
  axe = paste0(
    "Axe ",
    seq_along(valeurs_propres)
  ),
  valeur_propre = valeurs_propres,
  variance_pourcentage = pourcentage_variance
)

print(resultats_acp)

# ------------------------------------------------------------
# 5. Contributions des variables
# ------------------------------------------------------------

contributions_variables <- sweep(
  acp$rotation^2,
  2,
  colSums(acp$rotation^2),
  "/"
) * 100

print(contributions_variables)

# ------------------------------------------------------------
# 6. Export
# ------------------------------------------------------------

dir.create(
  "outputs/tables",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  resultats_acp,
  "outputs/tables/resultats_acp.csv",
  row.names = FALSE
)

write.csv(
  contributions_variables,
  "outputs/tables/contributions_variables_acp.csv"
)

# ------------------------------------------------------------
# 7. Graphique des valeurs propres
# ------------------------------------------------------------

variance <- data.frame(
  axe = seq_along(pourcentage_variance),
  variance = pourcentage_variance
)

graphique_variance <- ggplot(
  variance,
  aes(
    x = axe,
    y = variance
  )
) +
  geom_col() +
  geom_text(
    aes(
      label = round(variance, 1)
    ),
    vjust = -0.3
  ) +
  labs(
    title = "Variance expliquée par les axes",
    x = "Axe principal",
    y = "Variance expliquée (%)"
  ) +
  theme_minimal()

print(graphique_variance)

dir.create(
  "outputs/figures",
  recursive = TRUE,
  showWarnings = FALSE
)

ggsave(
  "outputs/figures/variance_acp.png",
  graphique_variance,
  width = 8,
  height = 5
)
