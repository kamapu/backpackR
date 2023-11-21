# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################


bp_init <- function(path, name, ...) {
  # Check existing directory
  if(file.exists(path))
    stop("The directory in 'path' is already existing.")
  # Create new directory
  dir.create(path=path, recursive=TRUE)
  # Connect to database
  bp_connect(dbname=name, ...)
  # Do a backup
  # Write a log file
  # Write a main-script
  file.create(file.path(path, "main-script.R"))
  # Write a description file
  file.create(file.path(path, "_description.md"))
  
}

library(here)
here()
