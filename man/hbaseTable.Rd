\name{hbaseTable}
\alias{hbaseTable}
\title{
Construct hbaseTable object
}
\description{
Function to create an \code{hbaseTable} object, which can then
be used by \code{hbaseGet} and \code{hbaseScan}.
}
\usage{
hbaseTable(name)
}
\arguments{
  \item{name}{
character vector of length one giving the name of the hbase table.
Must be a valid pre-existing table, or the function will throw an
error.
}
}
\details{
The first call to \code{hbaseTable} typically produces many lines
of logging to \code{stdout} from the itil
}
\value{
a single \code{\link{hbaseTable-class}} object.
}
\author{
Taylor Arnold, Simon Urbanek
}
\seealso{
\code{\linkS4class{hbaseGet}}, \code{\linkS4class{hbaseScan}},
\code{link{fetch}}, \code{\linkS4class{hbaseTable}},
\code{\link{hbasePut}}, \code{\link{hbaseDelete}}
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