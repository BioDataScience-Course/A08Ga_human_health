# Santé humaine liée à l'obésité

Sur base des mesures que vous avez réalisées à la fin du cours de "Science des données : visualisation", vous allez étudier quelques indices qui permettent de quantifier l'obésité et vous les confronterez aux habitudes alimentaires et autres des sujets étudiés. Ce projet correspond au template <https://github.com/BioDataScience-Course/A08Ga_human_health>

## Objectifs

Ce projet est libre et par groupe de quatre étudiants. Il est important, car il vous permet de démontrer que vous avez acquis les compétences suivantes :

-   être capable de partager équitablement le travail entre les membres du groupe
-   être capable de poser une question de recherche
-   réaliser des graphiques et des tableaux en lien avec la question de recherche
-   être capable de réaliser des tests d’hypothèses cohérents dans le contexte
-   pouvoir interpréter correctement des tests d’hypothèses sur le plan statistique, et puis au niveau biologique
-   être capable de synthétiser, discuter et conclure votre analyse dans un rapport

## Consignes

Ce projet comprend deux documents que vous allez devoir compléter. Répartissez-vous judicieusement le travail. Ce projet fait suite au projet A05Ga_23M_biometry. Vous avez pu, lors de ce premier projet collecter, nettoyer et explorer des données en lien avec la santé humaine. Ce nouveau projet va s'appuyer sur les données que vous avez collectées.

Votre progression se fera en plusieurs étapes réparties entre le module 8 et le module 11

### Module 8

-   Commencez par rechercher les éléments intéressants (indices) dans la référence fournie dans le dossier `bibliography` et prenez note de l'endroit où ils se trouvent. Recherchez au moins quatre indices différents et attribuez-vous à chacun un indice à présenter et à calculer.

-   Compléter le fichier `R/import_tidy.R` afin de récupérer les données localement. Vous devez également y ajouter les labels et les unités en utilisant le dictionnaire des données.

-   Compléter le début du fichier `human_notebook.qmd` jusqu'à l'indication "Travaillez jusqu'ici pour le module 8", à la fin des sections consacrées aux test Chi^2^.

### Module 9

-   Rajoutez deux tests t de Student dans `human_notebook.qmd`.

-   Rédigez l'introduction, le but et le matériel et méthodes dans `human_report.qmd`.

Vous devez avoir complété le bloc-notes jusqu'à l'indication "Travaillez jusqu'ici pour le module 9. Commencez à travailler sur le rapport (intro, mat&met)."

### Module 10

-   Réalisez deux ANOVAs à un facteur dans `human_notebook.qmd`.

-   Complétez le rapport `human_report.qmd` pour la partie résultats concernant la description des données.

Vous devez avoir complété le bloc-notes jusqu'à l'indication "Travaillez jusqu'ici pour le module 10. Commencez à rédiger la partie résultats avec la description des données."

### Module 11

-   Ajoutez deux ANOVas à deux facteurs et finalisez le bloc-notes `human_notebook.qmd`.

-   Complétez le rapport `human_report.qmd` jusqu'à la fin.

Vous avez encore du temps pour finaliser ces deux documents bloc-notes et rapport après le module 11, mais gardez bien en vue la deadline indiquée dans la section planning du cours en ligne !

## Ressources bibliographiques

Vous avez à votre disposition une référence (chapitre du livre anthropométrie rédigé par Lebacq (2015)). Une recherche devrait vous mener à compléter ceci par une à deux autres références sous forme de publications scientifiques (pas de site web, Wikipedia ou autre littérature qui n’a pas été revue par des référés). Vous devez citer correctement ces références dans `biometry_report.Rmd` en utilisant les formatages R Markdown adéquats (référez-vous aux aide-mémoires et au bloc-notes où l'introduction est rédigée pour vous comme exemple).

## Notes importantes

Le groupe tout entier est responsable de l’ensemble du travail (il s’agit donc de se répartir le travail, mais ensuite de relire la partie des autres et d’arriver à un consensus qui convienne à tout le monde). Chacun doit aussi contribuer aux différentes parties (pas un qui écrit l’introduction et un autre qui fait tous les tests statistiques, par exemple)

N’oubliez pas de cliquer sur le bouton "Rendu" pour tous vos documents et vérifiez que vous pouvez compiler les versions finales HTML sans erreurs à la fin. Corrigez les erreurs éventuelles rencontrées à ce stade avant de clôturer votre travail. Vérifiez également que votre dernier commit a bien été pushé sur GitHub avant la deadline.

## Référence

*  Lebacq, Thérésa. 2015. "Anthropométrie (IMC, Tour de Taille Et Ratio Tour de Taille/Taille)." In *Enquête de Consommation Alimentaire 2014-2015*. Vol. 1 Bruxelles: WIV-ISP.
