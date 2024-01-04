# TODO:   Starts project for test
# 
# Author: Miguel Alvarez
################################################################################

library(backpackR)

cred = credentials()

build_db(path = "lab/references", "references-db", overwrite = TRUE,
    port = "5433", user = unname(cred["user"]),
    password = unname(cred["password"]))

# Error because of creating a new database (it should be cleaned in advance)
# db_backup?

init_project(
    path="lab/references/project-2",
    dbname="references-db",
    port="5433",
    user = unname(cred["user"]),
    password = unname(cred["password"]))


