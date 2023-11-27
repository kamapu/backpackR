#' @name credentials
#'
#' @title Prompt for credentials
#'
#' @details
#' A wizard that asks for credentials (username and password).
#' This is to avoid writing passwords in the scripts.
#' The credentials are then passed to other functions that require them.
#'
#' @param user A character value with the name of the user. It is optional to
#'     add it straight in the call of the function.
#' @param pw A character value with the password. It is recommended to add it
#'     manually in the prompt.
#'
#' @author Miguel Alvarez
#'
#' @export
credentials <- function(user = "", pw = "") {
  # Top level
  tt <- tktoplevel()
  tkwm.title(tt, "Log in")
  # Preset values
  User <- tclVar(user)
  Password <- tclVar(pw)
  # Labels
  label_User <- tklabel(tt, text = "User-ID:")
  label_Password <- tklabel(tt, text = "Password:")
  # Boxes
  entry_User <- tkentry(tt, width = "20", textvariable = User)
  entry_Password <- tkentry(tt, width = "20", show = "*", textvariable = Password)
  # The grid
  tkgrid(label_User, entry_User)
  tkgrid(label_Password, entry_Password)
  # Nicier arrangements
  tkgrid.configure(entry_User, entry_Password, sticky = "w")
  tkgrid.configure(label_User, label_Password, sticky = "e")
  # Actions
  OnOK <- function() {
    tkdestroy(tt)
  }
  OK_but <- tkbutton(tt, text = " OK ", command = OnOK)
  tkbind(entry_Password, "<Return>", OnOK)
  tkgrid(OK_but)
  tkfocus(tt)
  tkwait.window(tt)
  # Prepare the file
  invisible(c(user = tclvalue(User), password = tclvalue(Password)))
}
