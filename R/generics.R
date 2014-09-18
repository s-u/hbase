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
  function(object, family) {
    if (is.na(family)) return(NA_character_)
    flist = strsplit(as.character(family), ":", TRUE)
    for (f in flist) {
      if (length(f) == 1)
        .jcall(object@s, "V", "restrict", charToRaw(f[[1L]]))
      else if (length(f) == 2)
        .jcall(object@s, "V", "restrict", charToRaw(o[[1L]]), charToRaw(o[[2L]]))
    }
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
    if(!length(res)) return(NULL)
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

