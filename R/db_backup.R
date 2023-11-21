#' @name db_backup
#' @rdname db_backup
#'
#' @title Create a backup by 'pg_dump' and restore database
#'
#' @details
#' The function `db_backup()` is a wrapper for **pg_dump**.
#'
#' The function `db_restore()` can restore the created backup files through
#' **pg_restore**.
#'
#' @param dbname Character value indicating the name of the target PostgreSQL
#'     database.
#' @param filename Character value, the name of the backup file including the
#'     path to location and the extension (.backup). If not provided,
#'     the function guess the database's name.
#' @param path_psql Character value indicating the system path to PostgreSQL
#'     binaries (set default for Linux).
#' @param host Character value, the host name.
#' @param port Integer value, the port applied for database connection.
#' @param opts A character value indicating additional options for "pg_restore",
#'     for instance "--clean" or "--create".
#' @param ... Further arguments passed to [system()].
#'
#' @author Miguel Alvarez
#'
#' @export
db_backup <- function(
    dbname, filename, host = "localhost", port = "5432",
    path_psql = "/usr/bin", ...) {
  # Request credentials
  user <- credentials()
  # Set filename if missing
  if (missing(filename)) {
    filename <- paste0(dbname, ".backup")
  }
  system(paste(
    paste0(
      "PGPASSWORD=\"", user["password"], "\""
    ),
    file.path(path_psql, "pg_dump"),
    "-U", user["user"],
    "-h", host,
    "-p", port,
    "-F c", dbname, ">", filename
  ), ...)
  message(paste0("\nDatabase '", dbname, "' backed up in '", filename, "'"))
}

#' @rdname db_backup
#' @aliases db_restore
#' @export
db_restore <- function(
    dbname, filename, host = "localhost", port = "5432",
    path_psql = "/usr/bin", opts = "--clean", ...) {
  # Request credentials
  user <- credentials()
  # Set filename if missing
  if (missing(filename)) {
    filename <- paste0(dbname, ".backup")
  }
  system(paste(
    paste0("PGPASSWORD=\"", user["password"], "\""),
    file.path(path_psql, "pg_restore"),
    "-h", host,
    "-p", port,
    "-U", user["user"],
    opts,
    "-d", dbname,
    "-v", filename
  ), ...)
  message(paste0("\nDatabase '", dbname, "' restored from '", filename, "'"))
}
