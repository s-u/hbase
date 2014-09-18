volatiles <- new.env(parent=emptyenv())
.hcfg <- function() {
  if (is.jnull(volatiles$cfg)) {
    hh <- Sys.getenv("HADOOP_HOME")
    if (!nzchar(hh))
      hh <- Sys.getenv("HADOOP_PREFIX")
    if (!nzchar(hh))
      hh <- "/usr/lib/hadoop"
    hcmd <- file.path(hh, "bin", "hadoop")
    if (!file.exists(hcmd))
      stop("Cannot find working Hadoop home. Set HADOOP_PREFIX if in doubt.")
    hb<- Sys.getenv("HBASE_HOME")
    if (!nzchar(hb))
      hb <- Sys.getenv("HBASE_PREFIX")
    if (!nzchar(hb))
      hb <- file.path(hh, "../hbase")
    hbcmd <- file.path(hb, "bin", "hbase")
    if (!file.exists(hbcmd))
      stop("Cannot find working HBase home. Set HBASE_PREFIX if in doubt.")
    .jinit()
    hcp=strsplit(system(paste(shQuote(hcmd),"classpath"), intern=T), ":", fixed=TRUE)[[1]]
    cp=strsplit(system(paste(shQuote(hbcmd),"classpath"), intern=T), ":", fixed=TRUE)[[1]]
    cp=unique(unlist(lapply(c(hcp, cp), Sys.glob)))
    .jaddClassPath(cp)
    .jaddClassPath(system.file("java", package="hbase")) ## for our tools
    cfg=.jcall("org.apache.hadoop.hbase.HBaseConfiguration", "Lorg/apache/hadoop/conf/Configuration;", "create")
    if (is.jnull(cfg))
      stop("cannot load HBase configuration")
    volatiles$cfg <- cfg
  }
  volatiles$cfg
}