hbaseTable = function(name) {
    cfg <- .hcfg()
    t <- .jnew("org.apache.hadoop.hbase.client.HTable", cfg, as.character(name))
    new("hbaseTable", name = name, jobj = t)
}

hbaseScan = function(table, start, end, family, column,
                     cacheSize = 10L) {
  if (is.character(table))
    table = hbaseTable(table)
  if (!inherits(table, "hbaseTable"))
    stop("invalid table object")
  out = new("hbaseScan", table = table, cacheSize = as.integer(cacheSize),
            sig = "Lorg/apache/hadoop/hbase/client/Scan;")

  if (missing(family)) {
    if (!missing(column))
      warning("Ignoring column input due to missing family input.")
    family = NA_character_
  }
  else if (!missing(column)) {
    if (length(column) != length(family))
      stop("Family and column must have the same length")
    family = paste0(family, ":", column)
  }
  out@restrict = family

  if (!missing(start))
    out@start = start
  if (!missing(end))
    out@end = end

  out@s = .jnew("Rpkg.hbase.HBScan")

  if (!missing(end))
    .jcall(out@s, "V", "initScan", table@jobj, charToRaw(start), charToRaw(end))
  else if (!missing(start))
    .jcall(out@s, "V", "initScan", table@jobj, charToRaw(start))
  else
    .jcall(out@s, "V", "initScan", table@jobj)

  restrict(out, out@restrict)
  return(out)
}

hbaseGet = function(table, keys, family, column,
                     cacheSize = 10L) {
  if (is.character(table))
    table = hbaseTable(table)
  if (!inherits(table, "hbaseTable"))
    stop("invalid table object")
  if (length(keys) == 0L)
    stop("Must supply a vector of keys.")
  out = new("hbaseGet", table = table, keys = keys,
            cacheSize = as.integer(cacheSize),
            sig = "Lorg/apache/hadoop/hbase/client/Scan;")

  if (missing(family)) {
    if (!missing(column))
      warning("Ignoring column input due to missing family input.")
    family = NA_character_
  }
  else if (!missing(column)) {
    if (length(column) != length(family))
      stop("Family and column must have the same length")
    family = paste0(family, ":", column)
  }
  out@restrict = family

  out@s = .jnew("Rpkg.hbase.HBGet")

  .jcall(out@s, "V", "initGet", table@jobj, .jarray(keys))

  restrict(out, out@restrict)
  return(out)
}

hbasePut = function(table, row, family, column, value) {
  if (is.character(table))
    table = hbaseTable(table)
  if (!inherits(table, "hbaseTable"))
    stop("invalid table object")

  if(length(unique(length(row), length(family), length(column),
                   length(value))) != 1L)
    stop("row, family, column, and value must all have the same length")

  obj = .jnew("Rpkg.hbase.HBPut")

  .jcall(obj, "V", "loadData", .jarray(row), .jarray(family), .jarray(column), .jarray(as.character(value)))
  .jcall(obj, "V", "putData", table@jobj)

  .jcall(obj, "V", "flush")
}

hbaseDelete = function(table, row, family, column, allValues = TRUE) {
  if (is.character(table))
    table = hbaseTable(table)
  if (!inherits(table, "hbaseTable"))
    stop("invalid table object")

  obj = .jnew("Rpkg.hbase.HBDelete")

  if (missing(family)) {
    .jcall(obj, "V", "loadData", .jarray(row))
  } else {
    if(length(unique(length(row), length(family), length(column))) != 1L)
      stop("row, family, and column must all have the same length")
    .jcall(obj, "V", "loadData", .jarray(row), .jarray(family), .jarray(column),
           as.integer(allValues))
  }

  .jcall(obj, "V", "putDelete", table@jobj)
}

