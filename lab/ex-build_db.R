# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(RPostgres)
library(divDB)
library(backpackR)

# Restore first version
sort_releases(path = "lab/exp-references", dbname = "mreferences")
build_db(path = "lab/exp-references", dbname = "mreferences", release = 1,
    overwrite = TRUE)

conn <- connect_db(dbname = "mreferences")
dbGetQuery(conn, paste("select count(*)", "from bibliorefs.main_table"))

# Restore second version
sort_releases(path = "lab/exp-references", dbname = "mreferences")
build_db(path = "lab/exp-references", dbname = "mreferences", release = 2,
    overwrite = TRUE)

dbGetQuery(conn, paste("select count(*)", "from bibliorefs.main_table"))

# Restore third version
sort_releases(path = "lab/exp-references", dbname = "mreferences")
build_db(path = "lab/exp-references", dbname = "mreferences", release = 3,
    overwrite = TRUE)

dbGetQuery(conn, paste("select count(*)", "from bibliorefs.main_table"))

build_db(path = "lab/exp-references", dbname = "mreferences", release = 4,
    overwrite = TRUE)



