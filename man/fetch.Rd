\name{fetch}
\alias{fetch}
\title{
Fetch results from a get or scan object
}
\description{
A method to fetch results from a get or scan object. The output
format will be the same for both types of requests.
}
\usage{
fetch(object, max.rows = object@cacheSize, colIndicator = rep(1L, 7))
}
\arguments{
  \item{object}{
an object of class \code{\linkS4class{hbaseGet}} or \code{\linkS4class{hbaseScan}}
from which to fetch results.
}
  \item{max.rows}{
maximum number of hbase rows to return. Note: this is not
the same as the number of rows in the result, which is equal
to the number of cells to be returned, and may be much larger
than the number of rows.
}
  \item{colIndicator}{
an integer vector of values 0/1 with length 7 indicating which
attributes should be returned. Specifically, these coorispond
to: (1) row, (2) column family, (3) colum qualifier, (4) timestamp,
(5) type, (6) version, and (7) value.
}
}
\value{
A character matrix, with one row per returned cell. The (named)
columns coorispond to the columns selected in \code{colIndicator}.
}
\author{
Taylor Arnold, Simon Urbanek
}
\seealso{
\code{\linkS4class{hbaseGet}},\code{\linkS4class{hbaseScan}},
}
\examples{

\dontrun{
  table = hbaseTable("household_demographics")
  scannner = hbaseScan(table, start="doe", end="smith",
                       family = c("e:income", "g:num_adults"))
  fetch(scannner, max.row=10)
}

}
\keyword{ interface }