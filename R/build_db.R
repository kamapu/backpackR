#' @name build_db
#'
#' @title Restore a database from a released backup
#'
#' @description
#' Releases are a collection of scripts and data required to update a database
#' from one to another version.
#'
#' @param path A character value with the path to the collection of releases
#'     (backups).
#' @param dbname A character value with the name of the database.
#' @param release A character value or a string used to select the respective
#'     version of the release. For character, the password 'last' refers to
#'     the newest version. Other character values will be matched with the names
#'     of the collected releases. If this pattern does not match any release
#'     or matches more than one, an error message will be retrieved.
#'     For integers, the order of the backup according to [sort_releases()].
#'     Negative values will be used to count backward with 0 as the newest
#'     release.
#' @param auxiliar_db A character value. It can be used to create a different
#'     database as the one backed up. This may be useful when exploring the
#'     content of old version without altering the current one.
#' @param overwrite A logical value indicating whether the existing database
#'     will be overwritten by the restore or not.
#' @param host A character value with the host of the database.
#' @param port A character value with the port of the database.
#' @param user A character value with the name of the user connecting the
#'     database. If not provided, it will be prompted by [credentials()].
#' @param password A character value with the password of the user. If not
#'     provided, it will be prompted by [credentials()].
#' @param ... Further argunents passed to [db_restore()].
#'
#' @export
build_db <- function(
    path, dbname, release = "last", auxiliar_db,
    overwrite = FALSE, host = "localhost", port = "5432", user, password, ...) {
  # list releases
  tab_rel <- sort_releases(path = path, dbname = dbname)
  # Select release
  if (is.character(release)) {
    if (release == "last") {
      N <- nrow(tab_rel)
    } else {
      N <- which(grepl(release, tab_rel$release))
      if (length(N) != 1) {
        N <- NA
      }
    }
    if (is.na(N)) {
      stop(paste0(
        "No or multiple releases matching the request '", release,
        "'"
      ))
    }
  } else {
    if (release > 0) {
      if (release > nrow(tab_rel)) {
        stop(paste0(
          "The requested release number '", release,
          "' is higher than the number of stored releases '",
          nrow(tab_rel), "'."
        ))
      } else {
        N <- release
      }
    }
    if (release <= 0) {
      if (-release > nrow(tab_rel)) {
        stop(paste0(
          "The requested release number '", -release,
          "' is higher than the number of stored releases '",
          nrow(tab_rel), "'."
        ))
      } else {
        N <- nrow(tab_rel) + release
      }
    }
  }
  sel_rel <- tab_rel$release[N]
  new_wd <- file.path(tempdir(), dbname)
  unzip(
    zipfile = file.path(path, sel_rel),
    exdir = new_wd
  )
  # Request credentials
  if (missing(user) | missing(password)) {
    if (missing(user)) {
      user <- ""
    }
    if (missing(password)) {
      password <- ""
    }
    cred <- credentials(user = user, password = password)
    user <- unname(cred["user"])
    password <- unname(cred["password"])
  }
  # Restore database
  if (missing(auxiliar_db)) {
    auxiliar_db <- dbname
  }
  # Check if database exists, if not create. Use argument overwrite.
  conn <- dbConnect(RPostgres::Postgres(),
    dbname = "postgres",
    user = user,
    password = password,
    host = host,
    port = port
  )
  db_exists <- dbGetQuery(
    conn,
    paste0(
      "select exists (select 1 from pg_database where datname = '",
      auxiliar_db, "')"
    )
  )
  if (db_exists & !overwrite) {
    stop(paste0(
      "Database '", auxiliar_db,
      "' already exists. Use 'overwrite = TRUE' to overwrite it."
    ))
  }
  if (!db_exists) {
    dbSendQuery(conn, paste0("create database \"", auxiliar_db, "\""))
  }
  db_restore(dbname = auxiliar_db, filename = file.path(
    tempdir(), dbname,
    "db-backup.backup"
  ), host = host, port = port, ...)
  # Read the R script
  m_script <- readLines(con = file.path(tempdir(), dbname, "main-script.R"))
  # Outcomment setting working directory
  idx <- grepl("setwd(", m_script, fixed = TRUE)
  m_script[idx] <- paste("#", m_script[idx])
  # Reset working directory
  line_1 <- paste0("setwd(\"", file.path(tempdir(), dbname), "\")\n\n")
  m_script <- c(line_1, m_script)
  writeLines(m_script, con = file.path(tempdir(), dbname, "main-script.R"))
  # Run the script
  source(file = file.path(tempdir(), dbname, "main-script.R"))
}
