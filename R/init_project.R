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
#' @param ... Further arguments (not yet in use).
#'
#' @export
init_project <- function(path, dbname, main_script = "main-script", ...) {
  # Check existing directory
  if (file.exists(path)) {
    stop("The directory in 'path' is already existing.")
  }
  # Create new directory
  dir.create(path = path, recursive = TRUE)
  # Do a backup
  db_backup(dbname = dbname, filename = file.path(path, "db-backup.backup"))
  # TODO: Write a log file
  # Copy templates
  copy_template(file.path(path, "main-script.R"), main_script)
  copy_template(file.path(path, "remarks.md"), "remarks")
}
