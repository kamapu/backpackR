% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/query_loop.R
\name{query_loop}
\alias{query_loop}
\title{Run a query across backup versions}
\usage{
query_loop(
  path,
  dbname,
  statement,
  host = "localhost",
  port = "5432",
  user = "",
  password = "",
  ...
)
}
\arguments{
\item{path}{A character value with the path to the collection of releases
(backups).}

\item{dbname}{A character value with the name of the database.}

\item{statement}{A character value with a SQL statement. This will be passed
to \code{\link[=dbSendQuery]{dbSendQuery()}}.}

\item{host}{A character value with the host of the database.}

\item{port}{A character value with the port of the database.}

\item{user}{A character value with the name of the user connecting the
database. If not provided, it will be prompted by \code{\link[=credentials]{credentials()}}.}

\item{password}{A character value with the password of the user. If not
provided, it will be prompted by \code{\link[=credentials]{credentials()}}.}

\item{...}{Further argunents passed to \code{\link[=build_db]{build_db()}}.}
}
\value{
A data frame resulting from applying \code{\link[=rbind]{rbind()}} to every run output from
\code{\link[=dbGetQuery]{dbGetQuery()}}.
}
\description{
Queries across versions may be useful to display the evolution of databases
in the time.
}
