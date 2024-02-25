# Vérifications de human_report.qmd
human_report <- parse_rmd("../../human_report.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le rapport est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("human_report.qmd"))
  # La version compilée HTML du rapport est introuvable
  # Vous devez créer un rendu de votre rapport Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.
  
  expect_true(is_rendered_current("human_report.qmd"))
  # La version compilée HTML du rapport existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction", "But", "Matériel et méthodes",
    "Résultats","Description des données", "Tests d'hypothèses",
    "Discussion et conclusions", "Référence")
    %in% (rmd_node_sections(human_report) |> unlist() |> unique())))
  # Les sections (titres) attendues du rapport ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).
  
  expect_true(any(duplicated(rmd_node_label(human_report))))
  # Un ou plusieurs labels de chunks sont dupliqués dans le rapport
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété dans le rapport ?", {
  expect_true(human_report[[1]]$title != "___")
  expect_true(!grepl("__", human_report[[1]]$title))
  expect_true(grepl("^[^_]....+", human_report[[1]]$title))
  # Le nom titre n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer un titre dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.
  
  expect_true(grepl("[a-z]", human_report[[1]]$title))
  # Aucune lettre minuscule n'est trouvée dans le titre
  # Avez-vous bien complété le champ 'titre' dans l'entête YAML ?
  # Vous ne pouvez pas écrire le titre tout en majuscules. Utilisez une
  # majuscule en début de la phrase, et des minuscules ensuite.
  
  expect_true(grepl("[A-Z]", human_report[[1]]$title))
  # Aucune lettre majuscule n'est trouvée dans le titre
  # Avez-vous bien complété le champ 'title' dans l'entête YAML ?
  # Vous ne pouvez pas écrire le titre tout en minuscules. Utilisez une
  # majuscule en début de la phrase, et des minuscules ensuite.
  
  expect_true(human_report[[1]]$author != "___, ___, ___, ___")
  expect_true(!grepl("__", human_report[[1]]$author))
  expect_true(grepl("^[^_]....+", human_report[[1]]$author))
  # Le nom des auteurs n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer vos noms dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.
  
  expect_true(grepl("[a-z]", human_report[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
  
  expect_true(grepl("[A-Z]", human_report[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("L'introduction et le but sont-ils complétées ?", {
  expect_true(!(rmd_select(human_report, by_section("Introduction")) |>
      as_document() |> grepl("...Votre introduction ici...", x = _,
        fixed = TRUE) |> any()))
  # L'introduction n'est pas faite
  # Remplacez "...Votre introduction ici..." par vos propres paragraphes
  # d'introduction (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
  
  expect_true(!(rmd_select(human_report, by_section("But")) |>
      as_document() |> grepl("...Votre but ici...", x = _,
        fixed = TRUE) |> any()))
  # Lu but ne semble pas rédigé
  # Remplacez "...Votre butn ici..." par votre phrase pour specifier votre but
  # (à noter que le contenu de cette section n'est pas évalué automatiquement,
  # mais il le sera par vos enseignants).
})

test_that("Le matériel et méthodes est-il complété ?", {
  expect_true(!(rmd_select(human_report, by_section("Matériel et méthodes")) |>
      as_document() |> grepl("...Votre matmet ici...", x = _,
        fixed = TRUE) |> any()))
  # La partie matériel et méthodes n'est pas rédigée
  # Remplacez "...Votre Mat&met ici..." par vos propres paragraphes
  # décrivant les données et les logiciels utilisés (à noter que le contenu de
  # cette section n'est pas évalué automatiquement, mais il le sera par vos
  # enseignants).
})

test_that("Les résultats sont-ils complétés ?", {
  expect_true(!(rmd_select(human_report, by_section("Description des données")) |>
      as_document() |> grepl("...Vos descriptions des données ici...", x = _,
        fixed = TRUE) |> any()))
  # La partie description des données des résultats n'est pas rédigée
  # Remplacez "...Vos descriptions des données ici..." par vos propres résultats
  # (à noter que le contenu de cette section n'est pas évalué automatiquement, 
  # mais il le sera par vos enseignants).
  
  expect_true(!(rmd_select(human_report, by_section("Tests d'hypothèses")) |>
      as_document() |> grepl("...Vos tests d'hypothèses ici...", x = _,
        fixed = TRUE) |> any()))
  # La partie tests d'hypothèses des résultats n'est pas rédigée
  # Remplacez "...Vos tests d'hypothèses ici..." par vos propres résultats
  # (à noter que le contenu de cette section n'est pas évalué automatiquement, 
  # mais il le sera par vos enseignants).
})

test_that("La partie discussion et conclusions est-elle remplie ?", {
  expect_true(!(rmd_select(human_report, by_section("Discussion et conclusions")) |>
      as_document() |> grepl("...Vos conclusions ici...", x = _,
        fixed = TRUE) |> any()))
  # La discussion et les conclusions ne sont pas faites
  # Remplacez "...Votre discussion ici..." par vos phrases de commentaires
  # libres (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
})
