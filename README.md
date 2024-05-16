# backpackR


- [Introduction](#introduction)
- [Suggested Workflow](#suggested-workflow)
- [To restore a project from the
  backups](#to-restore-a-project-from-the-backups)

# Introduction

This package is meant to enable a standard workflow for bulk updates in
relational databases.

# Suggested Workflow

1.  Init project
2.  Run updates
3.  Test updates
4.  Release update

# To restore a project from the backups

To restore your Database from the backups follow this recipe.

``` r
# Load the package
library(backpackR)

# Set variables
path = "path-to-backups"
dbname = "database-name"

# Run the build command (credentials will be prompted)
build_db(path = path, dbname = dbname, overwrite = TRUE)
```
