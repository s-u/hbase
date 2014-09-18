\name{hbaseGet-class}
\Rdversion{1.1}
\docType{class}
\alias{hbaseGet-class}
\alias{show,hbaseGet-method}

\title{Class \code{"hbaseGet"}}
\description{
Contains an initiated hbase 'batch get' object from which rows of data can
be queried.
}
\section{Objects from the Class}{
Objects should be created by calling \code{\link{hbaseGet}},
rather than directly calling the \code{new} function.
}
\section{Slots}{
  \describe{
    \item{\code{table}:}{The corrisponding hbase table object, of class \code{"hbaseTable"}}
    \item{\code{keys}:}{\code{"character"} vector giving the keys loaded into the get class}
    \item{\code{restrict}:}{Character vector indicating to which family:columns the scan is restricted to}
    \item{\code{s}:}{Object of class \code{"jobjRef"}, referencing the actual java object}
    \item{\code{cacheSize}:}{An \code{"integer"} giving the maximum number of rows to return from a scan}
    \item{\code{sig}:}{A \code{"character"} which gives the signature of the coorisponding object.}
  }
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "hbaseGet")}: Prints simple description of the object.}
    \item{fetch}{\code{signature(object = "hbaseGet")}: Fetch the next set of results.
    See \code{\link{fetch}} for more details}
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
showClass("hbaseGet")
}
\keyword{classes}
