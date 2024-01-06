# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(backpackR)
library(divDB)
library(RPostgres)

source("R/query_loop.R")

query_loop(path = "lab/exp-references", dbname = "mreferences",
    statement = paste("select count(*)", "from bibliorefs.main_table"))

path = "lab/exp-references"
dbname = "mreferences"
statement = paste("select count(*)", "from bibliorefs.main_table")

user = ""
password = ""

i <- tab_rel$nr[1]
i









conn <- connect_db("mreferences")
dbGetQuery(conn, paste("select count(*)", "from bibliorefs.main_table"))



DBI::dbDisconnect(conn)



tab_rel <- sort_releases(path = "lab/exp-references", dbname = "mreferences")


path <- "lab/exp-references"
dbname <- "mreferences"
statement <- paste("select count(*)", "from bibliorefs.main_table")
host <- "localhost"
port <- "5432"
auxiliar_db <- "temp-db2"
user <- ""
password <- ""

i <- tab_rel$nr[1]
