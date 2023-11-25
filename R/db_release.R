# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

db_release <- function(dbname, project, path, ...) {
  zipname <- paste0(dbname, "-", format(Sys.time(), format = "%Y%m%d-%H%M"),
      ".zip")
  filenames <- list.files(project, recursive = TRUE, full.names = TRUE)
  filenames <- gsub(pattern = paste0(project, "/"), "", filenames)
  #zip(file.path(path, zipname), project, mode = "cherry-pick", ...)
  zip(file.path(normalizePath(path.expand(path)), zipname), root = project,
      files = filenames)
}
