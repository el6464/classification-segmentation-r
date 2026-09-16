# ============================================================
# 02 - ANALYSE EXPLORATOIRE
# Classification et segmentation avec R
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

# ------------------------------------------------------------
# 1. Importation des données préparées
# ------------------------------------------------------------

donnees <- read_csv(
  "data/donnees_quantitatives.csv",
  show_col_types = FALSE
)

# ------------------------------------------------------------
# 2. Statistiques descriptives
# ------------------------------------------------------------

statistiques <- donnees %>%
  summarise(
    across(
      everything(),
      list(
        moyenne = ~ mean(.x, na.rm = TRUE),
        mediane = ~ median(.x, na.rm = TRUE),
        ecart_type = ~ sd(.x, na.rm = TRUE),
        minimum = ~ min(.x, na.rm = TRUE),
        maximum = ~ max(.x, na.rm = TRUE)
      )
    )
  )

print(statistiques)

# ------------------------------------------------------------
# 3. Matrice de corrélation
# ------------------------------------------------------------

matrice_correlation <- cor(
  donnees,
  use = "complete.obs"
)

print(matrice_correlation)

# ------------------------------------------------------------
# 4. Sauvegarde
# ------------------------------------------------------------

dir.create(
  "outputs/tables",
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  matrice_correlation,
  "outputs/tables/matrice_correlation.csv"
)

# ------------------------------------------------------------
# 5. Distribution des variables
# ------------------------------------------------------------

donnees_longues <- donnees %>%
  pivot_longer(
    cols = everything(),
    names_to = "variable",
    values_to = "valeur"
  )

graphique_distribution <- ggplot(
  donnees_longues,
  aes(x = valeur)
) +
  geom_histogram(
    bins = 30
  ) +
  facet_wrap(
    ~ variable,
    scales = "free"
  ) +
  labs(
    title = "Distribution des variables",
    x = "Valeur",
    y = "Nombre d'observations"
  ) +
  theme_minimal()

print(graphique_distribution)

dir.create(
  "outputs/figures",
  recursive = TRUE,
  showWarnings = FALSE
)

ggsave(
  "outputs/figures/distribution_variables.png",
  graphique_distribution,
  width = 10,
  height = 7
)
