# Vérifications de human_notebook.qmd
human_notebook <- parse_rmd("../../human_notebook.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("human_notebook.qmd"))
  # La version compilée HTML du carnet de notes est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.
  
  expect_true(is_rendered_current("human_notebook.qmd"))
  # La version compilée HTML du carnet de notes existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Résultats","Description des données", "Description par l'étudiant 1",
    "Description par l'étudiant 2", "Description par l'étudiant 3",
    "Description par l'étudiant 4", "Calcul d'indices", "Indice 1", "Indice 2",
    "Indice 3", "Indice 4", "Tests d'hypothèses", "Test de Chi^2^ 1",
    "Test de Chi^2^ 2", "Test t de Student 1", "Test t de Student 2",
    "ANOVA à un facteur 1", "ANOVA à un facteur 2", "ANOVA à deux facteurs 1",
    "ANOVA à deux facteurs 2", "Discussion et conclusions", "Référence")
    %in% (rmd_node_sections(human_notebook) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).
  
  expect_true(any(duplicated(rmd_node_label(human_notebook))))
  # Un ou plusieurs labels de chunks sont dupliqués dans le bloc-notes
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété dans le bloc-notes ?", {
  expect_true(human_notebook[[1]]$author != "___, ___, ___, ___")
  expect_true(!grepl("__", human_notebook[[1]]$author))
  expect_true(grepl("^[^_]....+", human_notebook[[1]]$author))
  # Le nom des auteurs n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer vos noms dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.
  
  expect_true(grepl("[a-z]", human_notebook[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteurs
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
  
  expect_true(grepl("[A-Z]", human_notebook[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteurs
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("La partie description des données est-elle remplie ?", {
  expect_true(!(rmd_select(human_notebook, by_section("Description des données")) |>
      as_document() |> grepl("...Votre chunk d'importation ici...", x = _,
        fixed = TRUE) |> any()))
  # La description des données n'est pas faite
  # Remplacez "...Votre chunk d'importation ici..." par le chunk correspondant
  # (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
  
  expect_true(!(rmd_select(human_notebook, by_section("Description par l'étudiant 1")) |>
      as_document() |> grepl("...Vos deux descriptions ici...", x = _,
        fixed = TRUE) |> any()))
  # La description des données n'est pas faite pour l'étudiant 1
  # Remplacez "...Vos deux descriptions ici..." par le chunk correspondant
  # (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
  
  expect_true(!(rmd_select(human_notebook, by_section("Description par l'étudiant 2")) |>
      as_document() |> grepl("...Vos deux descriptions ici...", x = _,
        fixed = TRUE) |> any()))
  # La description des données n'est pas faite pour l'étudiant 2
  # Remplacez "...Vos deux descriptions ici..." par le chunk correspondant
  # (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
  
  expect_true(!(rmd_select(human_notebook, by_section("Description par l'étudiant 3")) |>
      as_document() |> grepl("...Vos deux descriptions ici...", x = _,
        fixed = TRUE) |> any()))
  # La description des données n'est pas faite pour l'étudiant 3
  # Remplacez "...Vos deux descriptions ici..." par le chunk correspondant
  # (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
  
  expect_true(!(rmd_select(human_notebook, by_section("Description par l'étudiant 4")) |>
      as_document() |> grepl("...Vos deux descriptions ici...", x = _,
        fixed = TRUE) |> any()))
  # La description des données n'est pas faite pour l'étudiant 4
  # Remplacez "...Vos deux descriptions ici..." par le chunk correspondant
  # (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
})

test_that("La partie calcul et interprétation d'indices est-elle remplie ?", {
  expect_true(!(rmd_select(human_notebook, by_section("Indice 1")) |>
    as_document() |> grepl("^- +\\.\\.\\.+ *$", x = _) |> any()))
  # L'interprétation de l'indice 1 ne semble pas complétée ou vous avez
  # laissé traîné un item de liste avec "-   ..."
  # Vous devez remplacer les indications "..." par vos éléments
  # d'interprétation.
  
  expect_true(!(rmd_select(human_notebook, by_section("Indice 2")) |>
    as_document() |> grepl("^- +\\.\\.\\.+ *$", x = _) |> any()))
  # L'interprétation de l'indice 2 ne semble pas complétée ou vous avez
  # laissé traîné un item de liste avec "-   ..."
  # Vous devez remplacer les indications "..." par vos éléments
  # d'interprétation.
  
  expect_true(!(rmd_select(human_notebook, by_section("Indice 3")) |>
    as_document() |> grepl("^- +\\.\\.\\.+ *$", x = _) |> any()))
  # L'interprétation de l'indice 3 ne semble pas complétée ou vous avez
  # laissé traîné un item de liste avec "-   ..."
  # Vous devez remplacer les indications "..." par vos éléments
  # d'interprétation.
  
  expect_true(!(rmd_select(human_notebook, by_section("Indice 4")) |>
    as_document() |> grepl("^- +\\.\\.\\.+ *$", x = _) |> any()))
  # L'interprétation de l'indice 4 ne semble pas complétée ou vous avez
  # laissé traîné un item de liste avec "-   ..."
  # Vous devez remplacer les indications "..." par vos éléments
  # d'interprétation.
})

test_that("La partie discussion et conclusion est-elle remplie ?", {
  expect_true(!(rmd_select(human_notebook, by_section("Discussion et conclusions")) |>
      as_document() |> grepl("^- +\\.\\.\\.+ *$", x = _) |> any()))
  # La discussion et les conclusions ne sont pas faites
  # Remplacez les "..." par vos phrases de commentaires libres (à noter que
  # le contenu de cette section n'est pas évalué automatiquement, mais il le
  # sera par vos enseignants).
})
