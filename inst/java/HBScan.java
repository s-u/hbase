package Rpkg.hbase;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.HTable;

public class HBScan extends HBResult {
  Scan s;
  ResultScanner rs;
  int rs_exists;

  // Initialize "Scan s", "HTable t", and "int rs_exists"
  public void initScan(HTable table) {
    rs_exists = 0;
    s = new Scan();
    t = table;
  }

  public void initScan(HTable table, byte[] start) {
    rs_exists = 0;
    s = new Scan(start);
    t = table;
  }

  public void initScan(HTable table, byte[] start, byte[] stop) {
    rs_exists = 0;
    s = new Scan(start, stop);
    t = table;
  }

  public void restrict(byte[] family) {
    if (rs_exists == 0)
      s = s.addFamily(family);
  }

  public void restrict(byte[] family, byte[] column) {
    if (rs_exists == 0)
      s = s.addColumn(family, column);
  }

  private void init_rs() throws java.io.IOException {
    rs = t.getScanner(s);
    rs_exists = 2;
  }

  public String[] fetch(int numElements, int[] value_ind) throws java.io.IOException {
    if (rs_exists == 0)
      init_rs();
    Result[] res;
    res = rs.next(numElements);
    if (res == null) {
      rs.close();
      return null;
    }
    if (value_ind.length == 1)
      return parseResults(res);
    else
      return parseResults(res, value_ind);  }

  @Override
  public void flush() {
    cells = null;
    s = null;
    t = null;
    rs = null;
  }
}