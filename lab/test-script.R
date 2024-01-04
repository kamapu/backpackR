# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(backpackR)
#library(zip)

# Start a project
init_project("lab/my-project", "test-db", port = "5433")

# do a release
#release_project("lab/my-project", "lab")

sort_releases("lab", "test-db")

## use_template("lab", "main-script")
## use_template("lab/copy-main-script.R", "main-script")

#db_backup(dbname = "test-db", file = "test_bk", path="lab")
build_db(path="lab", dbname="test-db", port="5433", overwrite=TRUE,
    user="miguel")


##
build_db(path = "lab", release = 1, dbname = "test-db", overwrite = TRUE)
build_db(path = "lab", release = 2, dbname = "test-db", overwrite = TRUE)
