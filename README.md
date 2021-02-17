# La santé humaine

## Avant-propos

Les consignes reprises dans ce document, ainsi que dans les différents fichiers sont susceptibles d'évoluer. N'hésitez pas à vérifier le lien suivant afin de voir si des modifications n'y ont pas été apportées : <https://github.com/BioDataScience-Course/A08Gb_human_health>

Ce projet est un projet de groupe et qui porte sur l'ensemble de la matière. Afin de mener à bien ce travail vous devrez maîtriser l'ensemble du cours de Science des données biologiques I.

## Objectifs

Ce projet est libre et par groupe de 4. Ce dernier permettra de démontrer que vous avez acquis les compétences suivantes :

- être capable de se partager le travail entre les membres du groupe. Chaque membre du groupe doit travailler avec la même implication.
- être capable de se fixer une question de recherche.
- réaliser des graphiques et des tableaux en lien avec la question de recherche.
- être capable de réaliser un test d'hypothèse cohérent.
- savoir décrire un test d'hypothèse cohérent.
- être capable de décrire correctement les résultats d'un test d'hypothèse.

## Consignes

Ce projet est complexe et comprend plusieurs documents que vous allez devoir compléter. Vous allez devoir judicieusement vous partager le travail. Ce projet va se décomposer en 3 phases.

Chaque document doit être exécutable. Il ne peut donc pas dépendre d'un autre document.

### Phase d'exploration

Avant de débuter un projet, vous devez réaliser un travail préliminaire. Les données se trouve dnas le dossier `docs/raw/`. Vous devez

- compléter le fichier `state_of_art.Rmd` afin de proposer un état de l'art.
- compléter le fichier `measure_protocol.Rmd` afin de cerner précisément la population étudiée et les mesures réalisées. Ce document doit vous permettre de cerner les mesures manquantes, les erreurs potentielles de mesures,...
- compléter le fichier `dataviz.Rmd` afin d'explorer les données brutes mises à votre disposition.

Après avoir réalisé ces 3 premiers fichiers, vous devriez avoir une vision globale du jeu de données. Il est maintenant temps de vous fixer un but précis. La santé humaine est une thématique large que l'on peut explorer sous divers angles. 

Il est évident que votre but doit être une question que vous vous posez en lien avec la santé humaine que vous pouvez traiter grâce aux données mise à votre disposition.

### Phase de test

Avant de débuter cette seconde phase, vous devez compléter le script `biometry.R`. Ce script sera votre point de départ pour cette seconde phase. A présent vous devrez utiliser le fichier que vous allez généré bio2019.rds dans le dossier `docs/`.

Vous devez

- compléter le fichier `metrics.Rmd` afin de calculer divers indices en lien avec le but.
- compléter le fichier `hypothesis_testing.Rmd` afin de proposer divers tests d'hypothèses en lien avec votre but.

Vous avez atteint un nouveau palier dans votre étude. Vous avez réalisé de nombreux graphiques, de nombreux tests d'hypothèses,... Il est temps de sélectionner les éléments les plus importants.

### Phase de synthèse

Vous devez compléter un rapport de synthèse nommé `biometry_report.Rmd`. Ce document va devoir s'appuyer  sur les 5 fichiers produits dans les 2 premières phases de ce projet.

Vous allez également devoir proposer une présentation de 5 diapositives. Vous allez créer ce fichier et le nommer `biometry_presentation.Rmd`


