# Functions to test projects
# Copyright (c) 2023, Philippe Grosjean (phgrosjean@sciviews.org) &
#   Guyliann Engels (Guyliann.Engels@umons.ac.be)
# Version 1.4.0


# Transformation functions ------------------------------------------------

df_structure <- function(object, ...) {
  list(
    names = if (is.matrix(object)) colnames(object) else names(object),
    labels = if (is.matrix(object)) NULL else lapply(object, function(x) {
      res <- attr(x, "label")
      if (is.null(res) || is.na(res)) "" else as.character(res)
    }),
    units = if (is.matrix(object)) NULL else lapply(object, function(x) {
      res <- attr(x, "units")
      if (is.null(res) || is.na(res)) "" else as.character(res)
    }),
    nrow = nrow(object),
    ncol = ncol(object),
    classes = if (is.matrix(object)) class(object) else
      sapply(object, function(x) class(x)[1]),
    nas = if (is.matrix(object)) sum(is.na(object)) else
      sapply(object, function(x) sum(is.na(x))),
    comment = comment(object)
  )
}

digest <- function(object, algo = "md5", ...) {
  # Remove spec and problems attributes and convert to a data.frame if needed
  attr(object, "spec") <- NULL
  attr(object, "problems") <- NULL
  if (inherits(object, "data.frame"))
    object <- as.data.frame(object)
  digest::digest(object, algo = algo, ...)
}

object_attr <- function(object, attrib = "class", ...) {
  # Only record one or more attributes of an object
  attribs <- strsplit(attrib, ",", fixed = TRUE)[[1]] |> trimws()
  all_attribs <- attributes(object)
  all_attribs[attribs]
}

object_part <- function(object, part = "x", ...) {
  # Only record one or more parts of an object
  parts <- strsplit(part, ",", fixed = TRUE)[[1]] |> trimws()
  if (inherits(object, "data.frame"))
    object <- as.data.frame(object)
  object[parts]
}

# Same as object_part() but instead of recording the parts, it produces a str()
# representation (often much more compact) of the parts
object_str <- function(object, part = "x", ...) {
  res <- object_part(object, part = part)
  str(res, ...) |> utils::capture.output()
}


# Main functions to record results ----------------------------------------

res_dir <- here::here("tests", "results")

# Read and write results
read_res <- function(name, ..., dir = res_dir,
  nthreads = parallel::detectCores(logical = FALSE)) {
  qs::qread(fs::path(dir, name), nthreads = nthreads, ...)
}

write_res <- function(object, name, ..., dir = res_dir,
  nthreads = parallel::detectCores(logical = FALSE)) {
  fs::dir_create(dir)
  qs::qsave(object, file = fs::path(dir, name), nthreads = nthreads, ...)
}

# The main function to put a result in /tests/results
record_res <- function(object_name = ".Last.chunk", name = object_name,
  fun = NULL, ..., dir = res_dir, env = parent.frame()) {
  data <- get0(object_name, envir = env)
  if (is.null(data))
    return(invisible(FALSE))
  
  if (!is.null(fun))
    data <- try(fun(data, ...), silent = TRUE)
  
  write_res(data, name = name, dir = dir)
  invisible(TRUE)
}

# Shortcuts
RO <- record_res

RN <- function(name, object_name = ".Last.chunk", fun = NULL, ...,
  env = parent.frame())
  record_res(object = object_name, name = name, fun = fun, ..., env = env)

RODFS <- function(object_name = ".Last.chunk", name = object_name,
  fun = df_structure, ..., env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, ..., env = env)

RNDFS <- function(name, object_name = ".Last.chunk", fun = df_structure, ...,
  env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, ..., env = env)

ROMD5 <- function(object_name = ".Last.chunk", name = object_name, fun = digest,
  ..., env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, ..., env = env)

RNMD5 <- function(name, object_name = ".Last.chunk", fun = digest, ...,
  env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, ..., env = env)

ROP <- function(object_name = ".Last.chunk", part = "x", name = object_name,
  fun = object_part, ..., env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, part = part,
    ..., env = env)

RNP <- function(name, part = "x", object_name = ".Last.chunk",
  fun = object_part, ..., env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, part = part,
    ..., env = env)

ROA <- function(object_name = ".Last.chunk", attrib = "class",
  name = object_name, fun = object_attr, ..., env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, attrib = attrib,
    ..., env = env)

RNA <- function(name, attrib = "class", object_name = ".Last.chunk",
  fun = object_attr, ..., env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, attrib = attrib,
    ..., env = env)

ROSTR <- function(object_name = ".Last.chunk", part = "x", name = object_name,
  fun = object_str, ..., env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, part = part,
    ..., env = env)

RNSTR <- function(name, part = "x", object_name = ".Last.chunk",
  fun = object_str, ..., env = parent.frame())
  record_res(object_name = object_name, name = name, fun = fun, part = part,
    ..., env = env)


# Set and get references --------------------------------------------------

ref_dir <- here::here("tests", "reference")

# We don't use write_ref() because the mechanism is different!
make_ref <- function(name, ..., dir1 = res_dir, dir2 = ref_dir,
  nthreads = parallel::detectCores(logical = FALSE)) {
  res <- read_res(name, ..., dir = dir1, nthreads = nthreads)
  res <- qs::qserialize(res, preset = "archive")
  res <- qs::base85_encode(res)
  qs::qsave(res, file = fs::path(dir2, name), nthreads = nthreads, ...)
}

read_ref <- function(name, ..., dir = ref_dir,
  nthreads = parallel::detectCores(logical = FALSE)) {
  res <- qs::qread(fs::path(dir, name), nthreads = nthreads, ...)
  res <- qs::base85_decode(res)
  qs::qdeserialize(res)
}

# Get the currently edited file if file == NULL and check it exists and it does
# not starts with a dot (.)
# Also compute the filepath for original, solution and last_saved versions
.check_file <- function(file = NULL) {
  if (is.null(file)) {
    if (!rstudioapi::isAvailable())
      stop("No file provided and not in Rstudio")
    file <- try(rstudioapi::documentPath(), silent = TRUE)
    # If I got an error, either there is no document currently edited, or the
    # document has not been saved yet
    if (inherits(file, "try-error"))
      stop("No file provided and no file currently edited, or the edited file is not saved yet.")
    # Save the document to make sure we have latest version
    rstudioapi::documentSave()
  }
  stopifnot(is.character(file), length(file) == 1, nchar(file) > 0)
  file <- here::here(file)
  if (!fs::file_exists(file))
    stop("File not found")
  filename <- basename(file)
  dirname <- dirname(file)
  if (substring(filename, 1L, 1L) == ".")
    stop("You indicate a file starting with a dot (.), maining it is probably not a working version")
  # Compute names for original, solution, and last_saved versions of this file
  ext <- fs::path_ext(filename)
  basename <- paste0(".", fs::path_ext_remove(filename))
  orig_filename <- paste0(basename, "_original.", ext)
  attr(file, "original") <- fs::path(dirname, orig_filename)
  solut_filename <- orig_filename <- paste0(basename, "_solution.", ext)
  attr(file, "solution") <- fs::path(dirname, solut_filename)
  saved_filename <- orig_filename <- paste0(basename, "_last_saved.", ext)
  attr(file, "last_saved") <- fs::path(dirname, saved_filename)
  
  file
}

save_as_original <- function(file = NULL) {
  file <- .check_file(file)
  fs::file_copy(file, attr(file, "original"), overwrite = TRUE)
}

save_as_solution <- function(file = NULL) {
  file <- .check_file(file)
  fs::file_copy(file, attr(file, "solution"), overwrite = TRUE)
}

switch_to_original <- function(file = NULL, error = TRUE) {
  file <- .check_file(file)
  orig_file <- attr(file, "original")
  if (!fs::file_exists(orig_file)) {
    if (isTRUE(error)) {
      stop("There is no original file ", basename(orig_file), " available")
    } else {# Silently return NULL
      return(invisible(NULL))
    }
  }
  # Make a backup of current version in last_saved first
  fs::file_copy(file, attr(file, "last_saved"), overwrite = TRUE)
  fs::file_copy(orig_file, file, overwrite = TRUE)
  invisible(orig_file)
}

switch_to_solution <- function(file = NULL, error = TRUE) {
  file <- .check_file(file)
  solut_file <- attr(file, "solution")
  if (!fs::file_exists(solut_file)) {
    if (isTRUE(error)) {
      stop("There is no solution file ", basename(solut_file), " available")
    } else {# Silently return NULL
      return(invisible(NULL))
    }
  }
  # Make a backup of current version in last_saved first
  fs::file_copy(file, attr(file, "last_saved"), overwrite = TRUE)
  fs::file_copy(solut_file, file, overwrite = TRUE)
  invisible(solut_file)
}

switch_to_last_saved <- function(file = NULL, error = TRUE) {
  file <- .check_file(file)
  saved_file <- attr(file, "last_saved")
  if (!fs::file_exists(saved_file)) {
    if (isTRUE(error)) {
      stop("There is no last saved file ", basename(saved_file), " available")
    } else {# Silently return NULL
      return(invisible(NULL))
    }
  }
  # We will interchange current and last_saved, be need to temporary rename
  # last_saved into .tmp
  tmp_file <- paste0(saved_file, ".tmp")
  fs::file_copy(saved_file, tmp_file, overwrite = TRUE)
  fs::file_copy(file, saved_file, overwrite = TRUE)
  fs::file_copy(tmp_file, file, overwrite = TRUE)
  fs::file_delete(tmp_file)
  invisible(saved_file)
}

# Encryption/decryption of solutions require a key
set_key <- function() {
  # Try first to retrieve it from a file
  key_file <- here::here("tests/.key")
  if (fs::file_exists(key_file))
    return(qs::qread(key_file))
  pass <- askpass::askpass("Veuillez entrer le mode de passe :")
  if (is.null(pass)) # User cancelled
    return()
  if (digest::digest(pass) != "cfe7383614aacd5035642bf60d7d1a3e")
    stop("Invalid password")
  key <- charToRaw(pass) |> openssl::md5()
  class(key) <- c("aes", "raw")
  # Save this key
  qs::qsave(key, file = key_file)
  invisible(key)
}

# Make sure all files are original or solution versions, and possibly also
# remove last_saved. This is typically used to prepare the repository for an
# assignment, or to switch from originals to solution to verify the tests
prepare_files <- function(type = "original", remove_last_saved = FALSE,
  error = TRUE) {
  if (type != "original" && type != "solution")
    stop("type must be either original or solution")
  # Get a list of original/solution files
  files <- fs::dir_ls(here::here(), all = TRUE, recurse = TRUE,
    type = "file", regexp = paste0("_", type, "\\.[a-zA-Z0-9]+$"))
  if (!length(files)) {# There MUST be at least one orig|solut file
    if (isTRUE(error)) {
      stop("No ", type, " files found")
    } else {
      return(NULL)
    }
  }
  
  prepare_one <- function(file) {
    dir <- dirname(file)
    # We need to remove the leading dot and "_original|_solution" in filename
    orig_filename <- basename(file)
    reg_exp <- paste0("^\\.(.+)(_", type, ")(\\.[a-zA-Z0-9]+)$")
    work_filename <- sub(reg_exp, "\\1\\3", orig_filename)
    # If the filename is not changed, there is a problem with the name !
    if (work_filename == orig_filename)
      stop("Cannot match ", type, " and working version for ", orig_filename)
    work_file <- fs::path(dir, work_filename)
    # Copy original|solution into working version
    fs::file_copy(file, work_file, overwrite = TRUE)
    # Do we also need to eliminate last_saved version, if present?
    if (isTRUE(remove_last_saved)) {
      saved_file <- sub(paste0("_", type), "_last_saved", file)
      if (saved_file != file && fs::file_exists(saved_file))
        fs::file_delete(saved_file)
    }
    file
  }
  unlist(purrr::map(files, prepare_one))
}

# For all _solution.xxx files found, encrypt into _solution.xxx.aes
encrypt_solutions <- function(key = NULL, error = TRUE) {
  # Get a list of solution files
  files <- fs::dir_ls(here::here(), all = TRUE, recurse = TRUE,
    type = "file", regexp = "_solution\\.[a-zA-Z0-9]+$")
  if (!length(files)) {
    if (isTRUE(error)) {
      stop("No solution files found")
    } else {
      return(NULL)
    }
  }
  if (is.null(key))
    key <- set_key()
  
  encrypt_one <- function(file) {
    dest_file <- paste0(file, ".aes")
    cyphr::encrypt_file(file, key = cyphr::key_openssl(key), dest = dest_file)
    # Check that the dest_file is created before removing unencrypted version
    if (!fs::file_exists(dest_file))
      stop("problem when encrypting ", file, ", process interrupted")
    fs::file_delete(file)
    file
  }
  unlist(purrr::map(files, encrypt_one))
}

# For all _solution.xxx.aes files found, decrypt into _solution.xxx
decrypt_solutions <- function(key = NULL, error = TRUE) {
  # Get a list of encrypted solution files
  enc_files <- fs::dir_ls(here::here(), all = TRUE, recurse = TRUE,
    type = "file", regexp = "_solution\\.[a-zA-Z0-9]+.aes$")
  if (!length(enc_files)) {
    if (isTRUE(error)) {
      stop("No encoded solution files found")
    } else {
      return(NULL)
    }
  }
  if (is.null(key))
    key <- set_key()
  
  decrypt_one <- function(file) {
    dest_file <- fs::path_ext_remove(file)
    cyphr::decrypt_file(file, key = cyphr::key_openssl(key), dest = dest_file)
    # Check that the file is actually created before removing encrypted version
    if (!fs::file_exists(dest_file))
      stop("problem when decrypting ", file, ", process interrupted")
    fs::file_delete(file)
    file
  }
  unlist(purrr::map(enc_files, decrypt_one))
}

# Make from R
make_test <- function() {
  odir <- setwd(here::here("tests"))
  on.exit(setwd(odir))
  system("make -s test")
}

make_clean <- function() {
  odir <- setwd(here::here("tests"))
  on.exit(setwd(odir))
  system("make -s clean")
}

make_original <- function() {
  odir <- setwd(here::here("tests"))
  on.exit(setwd(odir))
  system("make -s original")
}

make_solution <- function() {
  odir <- setwd(here::here("tests"))
  on.exit(setwd(odir))
  system("make -s solution")
}

make_prepare <- function() {
  odir <- setwd(here::here("tests"))
  on.exit(setwd(odir))
  system("make -s prepare")
}

# Simplified test functions -----------------------------------------------

# Check if the rendered version of a Quarto or R Markdown file exists
is_rendered <- function(quarto, format = "html") {
  rendered <- sub("\\.[qR]md$", paste0(".", format), quarto)
  rendered_path <- here::here(rendered)
  fs::file_exists(rendered_path)
}

# Check if the rendered version is up-to-date
is_rendered_current <- function(quarto, format = "html") {
  rendered <- sub("\\.[qR]md$", paste0(".", format), quarto)
  quarto_path <- here::here(quarto)
  rendered_path <- here::here(rendered)
  fs::file_exists(rendered_path) &&
    file.mtime(rendered_path) >= file.mtime(quarto_path)
}

# A data file exists and contains a data.frame
is_data <- function(name, dir = "data", format = "rds", check_df = FALSE) {
  data_path <- here::here(dir, paste(name, format, sep = "."))
  res <- fs::file_exists(data_path)
  if (!res)
    return(structure(FALSE, message = paste0("The data file ", data_path,
      " is not found.")))
  res <- try(data.io::read(data_path, type = format), silent = TRUE)
  if (inherits(res, "try-error"))
    return(structure(FALSE, message = res))
  
  if (isTRUE(check_df) && !inherits(res, "data.frame"))
    return(structure(FALSE, message = paste0("The data file ", data_path,
      " is found but it does not contains a data frame.")))
  
  # Everything is OK
  TRUE
}

is_data_df <- function(name, dir = "data", format = "rds", check_df = TRUE)
  is_data(name, dir = dir, format = format, check_df = check_df)

is_identical_to_ref <- function(name, part = NULL, attr = NULL) {
  ref <- read_ref(name) # Note: generate an error if the object does not exist
  res <- read_res(name) # Idem
  
  if (!is.null(part)) {
    ref <- ref[[part]]
    res <- res[[part]]
  }
  
  if (!is.null(attr)) {
    ref <- attr(ref, attr)
    res <- attr(res, attr)
  }
  
  # Items cannot be NULL
  if (is.null(res) && is.null(ref))
    structure(FALSE, message = "Both res and ref are NULL")
  
  identical(res, ref)
}

is_equal_to_ref <- function(name, part = NULL, attr = NULL) {
  ref <- read_ref(name) # Note: generate an error if the object does not exist
  res <- read_res(name) # Idem
  
  if (!is.null(part)) {
    ref <- ref[[part]]
    res <- res[[part]]
  }
  
  if (!is.null(attr)) {
    ref <- attr(ref, attr)
    res <- attr(res, attr)
  }
  
  # Items cannot be NULL
  if (is.null(res) && is.null(ref))
    structure(FALSE, message = "Both res and ref are NULL")
  
  all.equal(res, ref)
}

has_labels_all <- function(name, part = NULL) {
  res <- read_res(name)$labels
  res <- sapply(res, nchar) > 0
  all(res, na.rm = TRUE)
}

has_labels_any <- function(name, part = NULL) {
  res <- read_res(name)$labels
  res <- sapply(res, nchar) > 0
  any(res, na.rm = TRUE)
}

has_units_all <- function(name, part = NULL) {
  res <- read_res(name)$units
  res <- sapply(res, nchar) > 0
  all(res, na.rm = TRUE)
}

has_units_any <- function(name, part = NULL) {
  res <- read_res(name)$units
  res <- sapply(res, nchar) > 0
  any(res, na.rm = TRUE)
}

is_display_equation <- function(text, object) {
  reg_exp <- paste0("`r +eq__\\(", object, "\\)`")
  grepl(reg_exp, text) |> any()
}

is_display_param_equation <- function(text, object) {
  reg_exp <- paste0("`r +eq__\\(", object, ", +use_coefs *= *TRUE[^`]*\\)`")
  grepl(reg_exp, text) |> any()
}

is_inline_equation <- function(text, object) {
  reg_exp <- paste0("`r +eq_\\(", object, "\\)`")
  grepl(reg_exp, text) |> any()
}

is_inline_param_equation <- function(text, object) {
  reg_exp <- paste0("`r +eq_\\(", object, ", +use_coefs *= *TRUE[^`]*\\)`")
  grepl(reg_exp, text) |> any()
}


# Tests reporter ----------------------------------------------------------

sddReporter <- testthat::LocationReporter

sddReporter$public_methods$start_test <- function(context, test) {
  self$cat_line("  ", cli::symbol$bullet, " ", test)
}

sddReporter$public_methods$end_test <- function(context, test) {
  cli::cat_rule(width = 30L)
}

sddReporter$public_methods$add_result <- function(context, test, result) {
  status <- expectation_type(result)
  status_fr <- switch(status,
    success = "réussi",
    failure = "échec",
    error = "erreur",
    skip = "ignoré",
    warning = "avis")
  if (status == "error" || status == "failure") {
    self$cat_line("    ", cli::col_red(cli::symbol$cross), " ",
      expectation_location(result), " [", status_fr, "]")
  } else if (status == "avis") {
    self$cat_line("    ", cli::col_yellow(cli::symbol$warning), " ",
      expectation_location(result), " [", status_fr, "]")
  } else if (status == "skip") {
    self$cat_line("    ", cli::col_cyan(cli::symbol$info), " ",
      expectation_location(result), " [", status_fr, "]")
  } else {# success
    self$cat_line("    ", cli::col_green(cli::symbol$tick), " ",
      expectation_location(result), " [", status_fr, "]")
  }
}

sddReporter$public_methods$start_file <- function(name) {
  name <- sub("test-([0-9]+)", "Fichier \\1 : ", name)
  name <- sub("\\.R$", "", name)
  name <- gsub("__", "/", name)
  name <- paste0("\n", cli::symbol$pointer, " ", name)
  self$cat_line(cli::col_cyan(name))
}

# Limit the number of uses of the test
test_dir <- function(path, reporter = sddReporter, times = 10L, ...) {
  if (length(times) != 1 || !is.numeric(times) || times < 1L)
    stop("times must be a positive integer")
  if (fs::file_exists(".cnt")) {
    cnt <- try(readLines(".cnt") |> as.integer(), silent = TRUE)
    if (inherits(cnt, "try-error"))
      cnt <- times
  } else {
    cnt <- times
  }
  if (cnt < 1L) {
    cat("Désolé, vous avez épuisé vos ", times, " essais pour les tests !\n",
      sep = "")
    return(invisible())
  }
  # Decrement cnt, save and indicate how much is left
  cnt <- cnt - 1L
  writeLines(as.character(cnt), ".cnt")
  if (cnt == 0L) {
    cat("Attention : ceci est votre dernier essai pour les tests !\n",
      sep = "")
  } else {
    cat("Il vous reste ", cnt, " essais pour les tests après celui-ci.\n",
      sep = "")
  }
  # Run the tests
  testthat::test_dir(path, reporter = reporter, ...)
}

# Functions for Quarto and R Markdown documents ---------------------------

# A hook to save the result of evaluations in chunks as .Last.chunk (if printed
# because things returned invisibly are not recorded)
knitr::opts_chunk$set(render = function(x, ...){
  svMisc::assign_temp(".Last.chunk", x, replace.existing = TRUE)
  knitr::knit_print(x, ...)
})

# A hook to save results after a code chunk is evaluated
knitr::knit_hooks$set(record = function(before, options, envir) {
  if (!before) {
    fun_name <- options$record
    fun <- get(fun_name, mode = "function", envir = envir)
    object <- options$object
    if (is.null(object)) {
      # If the function name starts with RN, we use .Last.chunk
      # otherwise, we use same name as label
      if (substring(fun_name, 1L, 2L) == "RN") {
        object <- ".Last.chunk"
      } else {
        object <- options$label
      }
      cat(fun_name, "('", options$label, "')\n", sep = "")
    } else {
      object <- options$object
      cat(fun_name, "('", object, "', '", options$label, "')\n", sep = "")
    }
    arg <- options$arg
    if (is.null(arg)) {
      fun(object_name = object, name = options$label, env = envir)
    } else {# There is an extra argument
      fun(object_name = object, name = options$label, arg, env = envir)
    }
    NULL
  }
})

# A simple multiple choice system in a R chunk, compatible with git
select_answer <- function(x, name = NULL) {
  ans <- strsplit(x, "\n[", fixed = TRUE)[[1]][-1]
  # Keep only ckecked answers
  checked <- grepl("^[xX]\\]", ans)
  ans <- ans[checked]
  # Remove check marks
  ans <- sub("^[xX]\\] ? ?", "", ans)
  # Print result
  cat(ans, "", sep = "\n")
  # Save a digest of the results in a variable in \tests\results
  # Note: the chunk label is only available on the document
  # rendering, not when the chunk is executed in the R console!
  # So, if we rely on it, nothing is saved unless the document is
  # knitted!
  if (is.null(name))
    name <- knitr::opts_current$get('label')
  if (!is.null(name)) {
    dir.create(here::here("tests", "results"), showWarnings = FALSE)
    res <- digest::digest(ans)
    # In case we are in correction mode, output more info
    if (getOption("learnitdown.correction", default = FALSE)) {
      # Second line is 1/0 for each option (checked or not)
      res <- c(res, paste(as.integer(checked), collapse = " "))
      # Finally add the whole text
      res <- c(res, x)
    }
    write_res(res, name)
  }
  invisible(ans)
}

# Obfuscate missing words
obfuscate <- function(x) {
  stopifnot(length(x) == 1, is.character(x))
  qs::base91_encode(charToRaw(x))
}

get_word <- function(x) {
  stopifnot(length(x) == 1, is.character(x))
  rawToChar(qs::base91_decode(x))
}
