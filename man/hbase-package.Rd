\name{hbase-package}
\alias{hbase-package}
\alias{hbase}
\alias{fetch-methods}
\alias{fetch,hbaseResult-method}
\alias{show-methods}
\alias{show,ANY-method}
\alias{show,classGeneratorFunction-method}
\alias{show,classRepresentation-method}
\alias{show,envRefClass-method}
\alias{show,genericFunction-method}
\alias{show,genericFunctionWithTrace-method}
\alias{show,MethodDefinition-method}
\alias{show,MethodDefinitionWithTrace-method}
\alias{show,MethodSelectionReport-method}
\alias{show,MethodWithNext-method}
\alias{show,MethodWithNextWithTrace-method}
\alias{show,namedList-method}
\alias{show,ObjectsWithPackage-method}
\alias{show,oldClass-method}
\alias{show,refClassRepresentation-method}
\alias{show,refMethodDef-method}
\alias{show,refObjectGenerator-method}
\alias{show,signature-method}
\alias{show,sourceEnvironment-method}
\alias{show,traceable-method}
\docType{package}
\title{
Direct HBase interface
}
\description{
Direct HBase interface, using a connection through \pkg{rJava}, which allows for
batch get calls, scan calls, batch put operations, and batch delete operations.
}
\details{
\tabular{ll}{
Package: \tab hbase\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2014-09-18\cr
License: \tab MIT | file LICENSE \cr
Depends: \tab methods\cr
Imports: \tab methods\cr
}
}
\author{
Taylor Arnold <taylor.arnold@aya.yale.edu>, Simon Urbanek <simon.urbanek@r-project.org>

Maintainer: Taylor Arnold <taylor.arnold@aya.yale.edu>
}
\keyword{ package }
\seealso{
\code{\link{hbaseTable}}, \code{\link{hbaseGet}}, \code{\link{hbaseScan}},
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
