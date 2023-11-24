#' @name copy_template
#'
#' @title Insert templates to working directory
#'
#' @description
#' The package 'backpackR' includes eine collection of templates for files
#' needed to be inserted into a project by `init_project()`.
#'
#' This is a wrapper of [file.copy()].
#'
#' @param filename A character value for the path for the copy of the template.
#'     It may include the name of the file.
#' @param template A character value. The name of the template including.
#'     Since this entry is compared by [pmatch()], it is not necessary to
#'     include the extension.
#' @param ... Further arguments passed to [file.copy()].
#'
#' @export
copy_template <- function(filename, template, ...) {
  path <- file.path(system.file(package = "backpackR"), "templates")
  templates_list <- list.files(path)
  sel_template <- pmatch(template, templates_list)
  if (is.na(sel_template)) {
    stop("The request does not match any installed template.")
  }
  file.copy(from = file.path(
    system.file(package = "backpackR"), "templates",
    templates_list[sel_template]
  ), to = filename, ...)
}
