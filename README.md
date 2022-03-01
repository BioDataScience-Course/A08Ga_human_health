Santé humaine
================

# Avant-propos

Les consignes reprises dans ce document, ainsi que dans les différents
fichiers sont susceptibles d’évoluer. N’hésitez pas à vérifier le lien
suivant afin de voir si des modifications n’y ont pas été apportées :
<https://github.com/BioDataScience-Course/A08Gb_human_health>.

Ce projet est un projet de groupe qui porte sur l’ensemble de la
matière. Afin de mener à bien ce travail vous devrez maîtriser
l’ensemble du cours de Science des Données Biologiques I.

# Objectifs

Ce projet est libre et par groupe de quatre. Il est important car il
vous permettra de démontrer que vous avez acquis les compétences
suivantes :

-   être capable de partager le travail entre les membres du groupe.
    Chaque membre du groupe doit travailler avec la même implication.
    Toutefois, le groupe est responsable de l’ensemble du travail (il
    s’agit donc de se répartir le travail, mais ensuite de relire la
    partie des autres et d’arriver à un consensus qui convienne à tout
    le monde). Chacun doit aussi contribuer aux différentes parties (pas
    un qui écrit l’introduction et un autre qui fait tous les tests
    statistiques, par exemple)
-   être capable de poser une question de recherche.
-   réaliser des graphiques et des tableaux en lien avec la question de
    recherche.
-   être capable de réaliser des tests d’hypothèses cohérent dans le
    contexte.
-   pouvoir interpréter correctement des tests d’hypothèses sur le plan
    statistique, et puis au niveau biologique.
-   être capable de synthétiser, discuter et conclure un travail.

# Consignes

Ce projet comprend plusieurs documents que vous allez devoir compléter.
Répartissez-vous judicieusement le travail. Vous pouvez décomposer votre
progression en trois phases détaillées ci-dessous.

**Faites bien attention que le ou les scripts R doivent être exécutables
et que tous les documents R Markdown doivent compiler (bouton ‘Knit’)
sans erreurs en rapports HTML à la fin du travail.**

N’**utilisez pas** l’argument `echo=FALSE` dans vos chunks. Le code R
qui génère les résultats doit rester visible dans les versions HTML.

## Phase d’exploration

Avant de débuter un projet, vous devez réaliser un travail préliminaire
qui consiste à vous documenter sur le sujet et à préparer les données.
Les données brutes se trouvent dans le sous-dossier `data/raw/`. Vous
devez :

-   compléter le fichier `docs/measure_protocol.Rmd` afin de cerner
    précisément la population étudiée et les mesures réalisées. Ce
    document doit vous permettre de déterminer s’il y a des mesures
    manquantes, des erreurs potentielles de mesures,…

-   compléter le fichier `docs/state_of_art.Rmd` sur base d’une petite
    recherche bibliographique que vous commencerez par la publication
    proposée dans le sous-dossier `bibliography/`. Ne dépassez pas 1 à 2
    heures de recherche au total pour chaque personne et maximum 2
    références bibliographiques supplémentaires. Spécifiez votre
    question de recherche et faites-là vérifier par un enseignant avant
    d’aller plus loin.

-   compléter le fichier `docs/dataviz.Rmd` afin d’explorer les données
    mises à votre disposition à l’aide de tableaux de synthèse et de
    graphiques.

Après avoir rempli ces trois premiers fichiers, vous devriez avoir une
vision globale de votre jeu de données et avoir en tête une question de
recherche précise.

## Phase d’analyse

Ceci constitue évidemment une partie cruciale : vous allez utiliser des
tests d’hypothèses pour répondre à votre question de recherche.

Vous devez :

-   calculer divers indices et métriques dans `docs/analysis.Rmd` en
    lien avec la question de recherche. Ces variables calculées
    permettent de mettre en évidences de l’information mieux que chaque
    variable brute individuellement.

-   effectuer différents tests d’hypothèses, toujours dans
    `docs/analysis.Rmd`, afin de répondre d’abord statistiquement, et
    puis avec une interprétation biologique dans le but de fournir des
    éléments de réponse à votre question de recherche.

**Ce document `docs/analysis.Rmd` est central dans le projet.**
Soignez-le tout particulièrement. Vous avez maintenant tous les éléments
nécessaires pour réaliser un rapport. Vous avez réalisé de nombreux
graphiques, de nombreux tests d’hypothèses,… Il est temps de
sélectionner les éléments les plus importants.

## Phase de synthèse

Vous devez compléter un rapport dans `docs/biometry_report.Rmd`. Ce
document va devoir s’appuyer sur les quatre fichiers produits dans les
deux premières phases de ce projet et en reprendre les éléments
importants pour former un développement cohérent de vos analyses et
interprétations pour finir par une discussion et conclusion relative à
votre question de recherche.

# Ressources bibliographiques

Vous avez à votre disposition un article (chapitre du livre
anthropométrie rédigé par Lebacq (2015)). Une recherche devrait vous
mener à compléter ceci par une à deux autres références sous forme de
publications scientifiques (pas de site web, Wikipedia ou autre
littérature qui n’a pas été revue par des référés). Vous devez citer
correctement ces références dans `biometry_report.Rmd` en utilisant les
formatages R Markdown adéquats (référez-vous aux aide-mémoires).

# Références

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-lebacq_theresa_anthropometrie_2015" class="csl-entry">

LEBACQ, Thérésa. 2015. “Anthropométrie (IMC, Tour de Taille Et Ratio
Tour de Taille/Taille).” In *Enquête de Consommation Alimentaire
2014-2015*. Vol. Rapport 1. Bruxelles: WIV-ISP.

</div>

</div>
