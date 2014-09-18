\name{hbasePut}
\alias{hbasePut}
\title{
Perform a batch put on an hbase table
}
\description{
Initiates and executes a set of put operations on an
hbase table. The put function operators at the cell
level, rather than the row level.
}
\usage{
hbasePut(table, row, family, column, value)
}
\arguments{
  \item{table}{
an object of class \code{\link{hbaseTable}} on which to perform
the put.
}
  \item{row}{
a character vector of rows into which data is being placed.
}
  \item{family}{
a character vector of column families into which data is
being placed. Must be of the same length as family
}
  \item{column}{
a character vector of column qualifiers into which data is
being placed. Must be of the same length as family}
  \item{value}{
a vector of the data which is being placed into the hbase
table. Will be coeherced to a character vector before being
inserted to the table.
}
}
\value{
none
}
\author{
Taylor Arnold, Simon Urbanek
}
\seealso{
\code{\linkS4class{hbaseTable}}
}
\examples{

\dontrun{
  table = hbaseTable("household_demographics")
  hbasePut(table, row=c("smithjonathan","smithjonathan")
           family = c("e","e"), column = c("age", "gender"),
           value = c("29", "male"))

}
}
\keyword{ interface }