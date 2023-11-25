# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(backpackR)
library(zip)

# Start a project
init_project("lab/my-project", "test-db")

# do a release
release_project("lab/my-project", "lab")

## use_template("lab", "main-script")
## use_template("lab/copy-main-script.R", "main-script")

#db_backup(dbname = "test-db", file = "test_bk", path="lab")
