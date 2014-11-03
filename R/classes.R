setClass("hbaseTable",
          representation = representation(name = "character",
                                          jobj = "jobjRef"))

setClass("hbaseResult",
          representation = representation(table = "hbaseTable",
                                          restrict = "character",
                                          s = "jobjRef",
                                          cacheSize = "integer",
                                          sig = "character")
          )

setClass("hbaseScan",
          representation = representation(table = "hbaseTable",
                                          start = "character",
                                          end = "character",
                                          restrict = "character",
                                          s = "jobjRef",
                                          cacheSize = "integer",
                                          sig = "character"),
          contains = "hbaseResult"
          )

setClass("hbaseScan2",
          representation = representation(table = "hbaseTable",
                                          start = "character",
                                          end = "character",
                                          restrict = "character",
                                          s = "jobjRef",
                                          cacheSize = "integer",
                                          sig = "character"),
          contains = "hbaseResult"
          )

setClass("hbaseGet",
          representation = representation(table = "hbaseTable",
                                          keys = "character",
                                          restrict = "character",
                                          s = "jobjRef",
                                          cacheSize = "integer",
                                          sig = "character"),
          contains = "hbaseResult"
          )


