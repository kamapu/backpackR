# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

devtools::install_github("kamapu/backpackR")

library(divDB)
library(backpackR)
library(biblioDB)

# creates database
conn <- connect_db(dbname = "postgres")

dbSendQuery(conn, "drop database if exists mreferences")
dbSendQuery(conn, "create database mreferences")

DBI::dbDisconnect(conn)

# Initialize 3 projects
cred <- credentials()

init_project(path = "lab/exp-references/project-1", dbname = "mreferences",
    user = cred["user"], password = cred["password"])

## Edit Project 1

init_project(path = "lab/exp-references/project-3", dbname = "mreferences",
    path_bk = "lab/exp-references")

## Edit Project 2
release_project("lab/exp-references/project-2-old", "lab/exp-references")
init_project(path = "lab/exp-references/project-3", dbname = "mreferences",
    path_bk = "lab/exp-references")

conn <- connect_db(dbname = "mreferences")
DBI::dbGetQuery(conn, paste("select count(*)", "from bibliorefs.main_table"))
