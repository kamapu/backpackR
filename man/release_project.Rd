% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/release_project.R
\name{release_project}
\alias{release_project}
\title{Pack an update project for release}
\usage{
release_project(project, path, ...)
}
\arguments{
\item{project}{A character value indicating the path to the project folder.}

\item{path}{A character value providing the path, where the zip file will
be stored.}

\item{...}{Further arguments passed to \code{\link[=zip]{zip()}} and \code{\link[=read_yaml]{read_yaml()}}.}
}
\description{
A release project includes an initial backup, a main script and all necessary
data to update a database starting by the backup.

This function will produce a zip file including all the project's content
using the name of the database and a time stamp.
}
