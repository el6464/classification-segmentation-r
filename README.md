# Classification et segmentation de données avec R

## Présentation

Ce projet porte sur l'analyse multivariée et la classification automatique d'individus à partir de plusieurs variables quantitatives.

L'objectif est d'identifier des groupes présentant des caractéristiques similaires et d'explorer la structure des données à l'aide de méthodes statistiques multivariées.

## Méthodologie

L'analyse est réalisée en plusieurs étapes :

1. Préparation des données
2. Analyse exploratoire
3. Analyse des relations entre variables
4. Analyse en composantes principales (ACP)
5. Classification ascendante hiérarchique (CAH)
6. Analyse du dendrogramme
7. Détermination du nombre de classes
8. Segmentation par K-means
9. Interprétation des groupes obtenus

## Méthodes utilisées

### Analyse en composantes principales

L'ACP permet de réduire la dimension des données et de représenter les individus et les variables sur quelques axes principaux.

L'analyse porte notamment sur les contributions des variables et la représentation des individus.

### Classification hiérarchique

Une classification hiérarchique est réalisée à partir d'une distance euclidienne.

Le critère de Ward est utilisé afin d'obtenir une partition des individus en groupes homogènes.

### K-means

La méthode K-means est ensuite utilisée pour construire une segmentation des individus.

Les groupes obtenus sont comparés et caractérisés à partir de leurs principales caractéristiques.

## Outils

- R
- statistiques multivariées
- ACP
- CAH
- K-means
- visualisation de données

## Résultats

L'analyse permet d'identifier plusieurs groupes d'individus présentant des caractéristiques proches.

La classification hiérarchique et K-means sont utilisés conjointement afin d'explorer et de vérifier la structure des groupes.

## Limites

Les résultats d'une classification dépendent des variables sélectionnées, de leur échelle et des paramètres utilisés.

La segmentation obtenue doit donc être interprétée en fonction du contexte et des caractéristiques des données.

## À propos

Projet réalisé dans le cadre d'un travail universitaire en Data Analysis.
