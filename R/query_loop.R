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
    Sys.sleep(0.5)
    conn <- connect_db(
      dbname = dbname,
      ## dbname = auxiliar_db,
      host = host, port = port, user = user,
      password = password
    )
    out_obj[[i]] <- dbGetQuery(conn, statement)
    message(paste("step", i))
  }
  return(out_obj)
}
