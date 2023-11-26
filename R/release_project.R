#' @name release_project
#'
#' @title Pack an update project for release
#'
#' @description
#' A release project includes an initial backup, a main script and all necessary
#' data to update a database starting by the backup.
#'
#' This function will produce a zip file including all the project's content
#' using the name of the database and a time stamp.
#'
#' @param project A character value indicating the path to the project folder.
#' @param path A character value providing the path, where the zip file will
#'     be stored.
#' @param ... Further arguments passed to [zip()] and [read_yaml()].
#'
#' @export
release_project <- function(project, path, ...) {
  description <- read_yaml(file.path(project, "project.yaml"))
  exec_time <- Sys.time()
  zipname <- paste0(
    description$database, "-", format(exec_time, format = "%Y%m%d-%H%M"),
    ".zip"
  )
  description$released = format(exec_time, format = "%Y-%m-%d %H:%M")
  write_yaml(description, file.path(project, "project.yaml"))
  session_info(to_file = file.path(path, "session-info-release.log"))
  filenames <- list.files(project, recursive = TRUE, full.names = TRUE)
  filenames <- gsub(pattern = paste0(project, "/"), "", filenames)
  zip(file.path(normalizePath(path.expand(path)), zipname),
    root = project,
    files = filenames, ...
  )
}
