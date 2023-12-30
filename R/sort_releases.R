#' @name sort_releases
#'
#' @title Chronological list of releases
#'
#' @description
#' If a central folder is used to collect releases, a chronological list may be
#' required to restore a particular state of the database.
#' This feature is more likely to be used as an auxiliary by other functions in
#' the package.
#'
#' @param path A character value. The path to the collection of releases.
#' @param dbname A character value indicating the name of the database.
#' @param ... Further arguments (not yet in use).
#'
#' @export
sort_releases <- function(path, dbname, ...) {
  candidates <- list.files(path = path, pattern = ".zip")
  if (length(candidates) == 0) {
    stop("No releases found in 'path'.")
  }
  candidates <- candidates[grepl(dbname, candidates)]
  if (length(candidates) == 0) {
    stop(paste0(
      "No releases for requested database '", dbname,
      "' found in 'path'."
    ))
  }
  time_string <- sub(".*-(\\d{4}\\d{2}\\d{2}-\\d{4})\\.zip", "\\1", candidates)
  candidates <- data.frame(
    nr = seq_along(candidates),
    release = candidates,
    time_release = strptime(time_string, format = "%Y%m%d-%H%M")
  )
  candidates <- candidates[order(candidates$time_release), ]
  row.names(candidates) <- candidates$nr <- seq_along(candidates$nr)
  return(candidates)
}
