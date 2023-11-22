# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################


init_project <- function(path, name, dbname, main_script = "main-script", ...) {
  # Check existing directory
  if(file.exists(path))
    stop("The directory in 'path' is already existing.")
  # Create new directory
  dir.create(path=path, recursive=TRUE)
  # Do a backup
  db_backup(dbname = dbname, filename = file.path(path, "db-backup"))
  # TODO: Write a log file
  # Copy templates
  copy_template(file.path(path, "main-script.R"), main_script)
  copy_template(file.path(path, "_remarks.md"), "remarks")
}
