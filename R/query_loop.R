#' @name query_loop
#'
#' @title Run a query across backup versions
#'
#' @description
#' Queries across versions may be useful to display the evolution of databases
#' in the time.
#'
#' @param path A character value with the path to the collection of releases
#'     (backups).
#' @param dbname A character value with the name of the database.
#' @param statement A character value with a SQL statement. This will be passed
#'     to [dbSendQuery()].
#' @param host A character value with the host of the database.
#' @param port A character value with the port of the database.
#' @param user A character value with the name of the user connecting the
#'     database. If not provided, it will be prompted by [credentials()].
#' @param password A character value with the password of the user. If not
#'     provided, it will be prompted by [credentials()].
#' @param ... Further argunents passed to [build_db()].
#'
#' @return
#' A data frame resulting from applying [rbind()] to every run output from
#' [dbGetQuery()].
#'
#' @export
query_loop <- function(
    path, dbname, statement,
    ## auxiliar_db = "temp-db",
    host = "localhost",
    port = "5432", user = "", password = "", ...) {
  # list releases
  tab_rel <- sort_releases(path = path, dbname = dbname)
  # Request credentials
  if (user == "" | password == "") {
    cred <- credentials(user = user, password = password)
    user <- unname(cred["user"])
    password <- unname(cred["password"])
  }
  out_obj <- list()
  # Loop
  for (i in tab_rel$nr) {
    build_db(
      path = path, dbname = dbname, release = i,
      # auxiliar_db = auxiliar_db,
      overwrite = TRUE, host = host, port = port,
      user = user, password = password, ...
    )
    # Sys.sleep(0.5)
    conn <- connect_db(
      dbname = dbname,
      ## dbname = auxiliar_db,
      host = host, port = port, user = user,
      password = password
    )
    out_obj[[i]] <- dbGetQuery(conn, statement)
    message(paste("step", i))
  }
  # return(out_obj)
  return(do.call(rbind, out_obj))
}
