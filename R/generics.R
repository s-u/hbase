setGeneric("show")
setGeneric("restrict", function(object, family, column) standardGeneric("restrict"))
setGeneric("fetch", function(object, max.rows = object@cacheSize, colIndicator = rep(1L,7)) standardGeneric("fetch"))

setMethod("show", signature(object = "hbaseTable"),
  function(object) {
    cat("\n An object of class \"hbaseTable\"\n\n")
    cat("   Table name: \'", object@name, "\'\n\n", sep="")
  }
)

setMethod("show", signature(object = "hbaseScan"),
  function(object) {
    str(object) # put something nicer here
  }
)

setMethod("show", signature(object = "hbaseGet"),
  function(object) {
    str(object) # put something nicer here
  }
)

setMethod("restrict", signature(object = "hbaseResult"),
  function(object, family, column) {
    family = strsplit(as.character(family), ":", TRUE)


    if (!is.null(family)) {
      if (is.null(column)) {
        for(i in 1:length(family))
          .jcall(object@s, "V", "restrict", charToRaw(family[[i]]))
        return(family)
      } else {
        if (length(family) != length(column))
          stop("family and column, if provided, must be character vectors of the same length")
        for(i in 1:length(family))
          .jcall(object@s, "V", "restrict", charToRaw(family[[i]]), charToRaw(column[[i]]))
        return(paste0(family, ":", column))
      }
    } else if (!is.null(column)) {
      for (o in strsplit(as.character(column), ":", TRUE)) {
        if (is.null(o[[2L]]))
          .jcall(object@s, "V", "restrict", charToRaw(o[[1L]]))
        else
          .jcall(object@s, "V", "restrict", charToRaw(o[[1L]]), charToRaw(o[[2L]]))
      }
      return (column)
    } else return(NA_character_)
  }
)

setMethod("fetch", signature(object = "hbaseResult"),
  function(object, max.rows = object@cacheSize, colIndicator = rep(1L,7)) {
    if (length(colIndicator) != 7L)
      stop("Invalid colIndicator selection")
    if(all(colIndicator == 1))
      res = .jcall(object@s, "[S", "fetch", as.integer(max.rows), .jarray(0L))
    else {
      colIndicator = as.integer(colIndicator != 0)
      res = .jcall(object@s, "[S", "fetch", as.integer(max.rows), .jarray(colIndicator))
    }
    if(!length(res)) return(res)
    colNames = c("row", "family", "column", "timestamp", "type", "version", "value")
    matrix(res, ncol=sum(colIndicator), dimnames=list(NULL, colNames[colIndicator == 1]))
  }
)

setMethod("fetch", signature(object = "hbaseGet"),
  function(object, max.rows = object@cacheSize, colIndicator = rep(1L,7)) {
    callNextMethod()
  }
)

setMethod("fetch", signature(object = "hbaseScan"),
  function(object, max.rows = object@cacheSize, colIndicator = rep(1L,7)) {
    callNextMethod()
  }
)

