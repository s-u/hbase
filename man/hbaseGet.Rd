\name{hbaseGet}
\alias{hbaseGet}
\title{
Create a new hbaseGet object
}
\description{
Function to create a batch get object, which can then be used by
\code{\link{fetch}} to fetch output from an hbase table.
}
\usage{
hbaseGet(table, keys, family, column, cacheSize = 10L)
}
\arguments{
  \item{table}{
an object of class \code{\link{hbaseTable}} on which to perform
the gets.
}
  \item{keys}{
a character vector of keys coorisponding to the rows which
should be returned from the table. Non-matches are silently
dealt with without any warning.
}
  \item{family}{
an optional character vector describing which column families
should be included in the results.

If the column input is missing, the format to family should
be of the form 'family:column', where a missing column is
interpreted as wanting the entire family.

For both cases, names need to be an exact match to the column
family or qualifier names. Family names must match an extant
family name for the given table, otherwise an error will be
thrown; conversely, non-matching column names will simply be
ignored.
}
  \item{column}{
an option character vector describing which columns (also
called column qualifiers) are to be returned from the batch get.
If supplied, it must be of the same length as family and
will be interpreted by relating every element in family with
the coorisponding element in column and returning only those
cells with a column from the associated column family.
}
  \item{cacheSize}{
an integer giving the maximum number of rows to return from the
scanner on any particular call. Should usually be equal to the
maximum length that will be supplied to subsequent calls to
\code{\link{fetch}}.
}
}
\details{
The function creates a new \code{\link{hbaseGet-class}} object,
which can then be called on using the \code{link{fetch}} method
to fetch lines of data matching the given query. See the
documentation on the class and methods for more details.
}
\value{
a single \code{\link{hbaseGet-class}} object.
}
\author{
Taylor Arnold, Simon Urbanek
}
\seealso{
\code{\linkS4class{hbaseGet}}, \code{\linkS4class{hbaseTable}}, \code{link{fetch}}
}
\examples{

\dontrun{
  table = hbaseTable("household_demographics")
  scannner = hbaseGet(table, keys = c("smithjonathan", "doejohn"))
  fetch(scannner, max.row=2L)
}

}
\keyword{ interface }