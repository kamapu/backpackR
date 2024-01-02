#' @name init_project
#'
#' @title Initialize a new project for database updates
#'
#' @description
#' A project folder will contain all necessary data and scripts needed to update
#' a database into a new version. This strategy will allow to rebuild the
#' database in a preferential version and document at the same time all the
#' process done on the way.
#'
#' @param path A character value indicating the path for the new project.
#' @param dbname A character value with the name of the database to be updated.
#' @param main_script A character value with the name of the template used as
#'     main script in the project.
#' @param host Character value, the host name.
#' @param port Integer value, the port applied for database connection.
#' @param user A character value with the name of the user connecting the
#'     database. If not provided, it will be prompted by [credentials()].
#' @param password A character value with the password of the user. If not
#'     provided, it will be prompted by [credentials()].
#' @param ... Further arguments (not yet in use).
#'
#' @export
init_project <- function(
    path, dbname, main_script = "main-script", host = "localhost",
    port = "5432", user = "", password = "", ...) {
  # Check existing directory
  if (file.exists(path)) {
    stop("The directory in 'path' is already existing.")
  }
  # Create new directory
  dir.create(path = path, recursive = TRUE)
  # Request credentials
  if (user == "" | password == "") {
    cred <- credentials(user = user, password = password)
    user <- unname(cred["user"])
    password <- unname(cred["password"])
  }
  # Do a backup
  db_backup(
    dbname = dbname,
    filename = file.path(path, "db-backup.backup"),
    host = host,
    port = port,
    user = user,
    password = password
  )
  # Connect the database
  conn <- connect_db(
    dbname = dbname, host = host,
    port = port, user = user,
    password = password
  )
  # Write a log file
  log <- list(
    database = dbname,
    user = user,
    initialized = format(Sys.time(), format = "%Y-%m-%d %H:%M"),
    dms = dbGetQuery(conn, "select version()")[[1]],
    server = dbGetQuery(conn, "show server_version")[[1]]
  )
  write_yaml(log, file.path(path, "project.yaml"))
  # Copy templates
  copy_template(file.path(path, "main-script.R"), main_script)
  copy_template(file.path(path, "remarks.md"), "remarks")
  # Save session info
  session_info(to_file = file.path(path, "session-info-init.log"))
}
