package Rpkg.hbase;

import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Put;
import java.util.List;
import java.util.ArrayList;
import org.apache.hadoop.hbase.client.RetriesExhaustedWithDetailsException;
import java.lang.System;

public class HBPut {
  List<Put> puts;

  public void loadData(String[] row, String[] family, String[] column, String[] value) {
    int n = row.length;
    puts = new ArrayList<Put>();
    for (int i = 0; i < n; i++) {
      Put p = new Put(row[i].getBytes());
      p.add(family[i].getBytes(), column[i].getBytes(), value[i].getBytes());
      puts.add(p);
    }
  }

  public void putData(HTable table) throws java.io.InterruptedIOException,
    org.apache.hadoop.hbase.client.RetriesExhaustedWithDetailsException {
    table.put(puts);
  }

  public void flush() {
    puts = null;
    System.gc();
  }
}
