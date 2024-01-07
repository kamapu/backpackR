# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

devtools::install()
library(backpackR)

query_loop(path = "lab/exp-references", dbname = "mreferences",
    statement = paste("select count(*)", "from bibliorefs.main_table"))
