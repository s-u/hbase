\name{hbaseTable-class}
\Rdversion{1.1}
\docType{class}
\alias{hbaseTable-class}
\alias{show,hbaseTable-method}

\title{Class \code{"hbaseTable"}}
\description{
Contains an hbase table object for passing to get, scan,
put constructors and classes.
}
\section{Objects from the Class}{
Objects should be created by calling \code{\link{hbaseScan}},
rather than directly calling the \code{new} function.
}
\section{Slots}{
  \describe{
    \item{\code{name}:}{Table name}
    \item{\code{jobj}:}{Object of class \code{"jobjRef"} giving a reference to the underlying java object.}
  }
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "hbaseTable")}: ... }
	 }
}
\author{
Taylor Arnold, Simon Urbanek
}
\seealso{
\code{\link{hbaseTable}},\code{\linkS4class{hbaseGet}},
\code{\linkS4class{hbaseScan}}, \code{link{fetch}}
\code{\link{hbasePut}}, \code{\link{hbaseDelete}}
}
\examples{
showClass("hbaseTable")
}
\keyword{classes}
