library(RPostgres)
library(divDB)
library(backpackR)

# start-dontrun ----------------------------------------------------------------
setwd("lab/project-1")
conn <- connect_db(dbname = "test-db")

## release_project(project="../project-1", path="../")
# end-dontrun ------------------------------------------------------------------

# Drop schema if existing
dbSendQuery(conn, "drop schema if exists data_frames cascade")

# Create schema
dbSendQuery(conn, "create schema data_frames")

# Import iris on it
dbWriteTable(conn, c("data_frames", "iris"), iris)
