\name{hbaseDelete}
\alias{hbaseDelete}
\title{
Perform a batch delete on an hbase table
}
\description{
Initiates and executes a set of delete operations on an
hbase table.
}
\usage{
hbaseDelete(table, row, family, column, allValues = TRUE)
}
\arguments{
  \item{table}{
an object of class \code{\link{hbaseTable}} on which to perform
the deletion.
}
  \item{row}{
a character vector of rows to remove.
}
  \item{family}{
an optional character vector. If given it must be the same length
as \code{row}, and gives the column family to delete from the given
row.
}
  \item{column}{
an optional character vector. If given it must be the same length
as \code{row}, and gives the column qualifier to delete from the given
row. Must be supplied if \code{family} is provided.
}
  \item{allValues}{
logical flag. If set to \code{TRUE}, the default, it will delete all
relevent values for the row (and family/column if supplied). Otherwise
only the most recent timestamp will be deleted. The latter is
}
}
\value{
none
}
\author{
Taylor Arnold, Simon Urbanek
}
\seealso{
\code{\linkS4class{hbaseScan}},
}
\examples{

\dontrun{
  table = hbaseTable("household_demographics")
  hbaseDelete(table, row=c("smithjonathan","smithjonathan")
           family = c("e","e"), column = c("age", "gender"))

}

}
\keyword{ interface }