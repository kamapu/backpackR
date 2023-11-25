# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(backpackR)
library(zip)

# Start a project
init_project("lab/my-project", "test-db")

# do a release
source("R/db_release.R")
db_release("test-db", "lab/my-project", "lab")
#db_release("test-db", "lab/my-project", "../")

## use_template("lab", "main-script")
## use_template("lab/copy-main-script.R", "main-script")

#db_backup(dbname = "test-db", file = "test_bk", path="lab")


