\name{hbaseScan-class}
\Rdversion{1.1}
\docType{class}
\alias{hbaseScan-class}
\alias{show,hbaseScan-method}
\title{Class \code{"hbaseScan"}}
\description{
Contains an initiated hbase scanner from which rows of data can
be queried.
}
\section{Objects from the Class}{
Objects should be created by calling \code{\link{hbaseScan}},
rather than directly calling the \code{new} function.
}
\section{Slots}{
  \describe{
    \item{\code{table}:}{The corrisponding hbase table object, of class \code{"hbaseTable"}}
    \item{\code{start}:}{Length one character vector giving the starting key of the scan}
    \item{\code{end}:}{Length one character vector giving the ending key of the scan}
    \item{\code{restrict}:}{Character vector indicating to which family:columns the scan is restricted to}
    \item{\code{s}:}{Object of class \code{"jobjRef"}, referencing the actual java object}
    \item{\code{cacheSize}:}{An \code{"integer"} giving the maximum number of rows to return from a scan}
    \item{\code{sig}:}{A \code{"character"} which gives the signature of the coorisponding object.}
  }
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "hbaseScan")}: ... }
	 }
}
\author{
Taylor Arnold, Simon Urbanek
}
\seealso{
\code{\linkS4class{hbaseGet}}, \code{\linkS4class{hbaseTable}},
\code{\link{hbaseScan}}, \code{\link{fetch}}
}
\examples{
showClass("hbaseScan")
}
\keyword{classes}
