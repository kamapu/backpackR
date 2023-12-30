# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(RPostgres)
library(backpackR)

cred <- credentials(user = "miguel")

conn <- dbConnect(RPostgres::Postgres(), dbname = "test-db", host="localhost", port="5433",
    user=unname(cred["user"]), password=unname(cred["password"]))

x <- dbGetQuery(conn, "select version()")[[1]]
dbGetQuery(conn, "show server_version")



dbGetQuery(conn, "select @version")

