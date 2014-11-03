package Rpkg.hbase;

import java.util.List;
import java.util.ArrayList;
import java.lang.Math;

import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.HTable;

public class HBScan2 extends HBResult {
  String[] start_key;
  String[] end_key;
  List<byte[]> family;
  List<byte[]> familyColumn;
  List<byte[]> column;

  int keyIndex = 0;

  public void initScan(HTable table, String[] skeys, String[] ekeys) {
    start_key = skeys;
    end_key = ekeys;
    t = table;
    family = new ArrayList<byte[]>();
    familyColumn = new ArrayList<byte[]>();
    column = new ArrayList<byte[]>();
  }

  private Result[] nextResults(int numScans, int numElements) throws java.io.IOException{
    int n = Math.min(start_key.length - keyIndex, numScans);
    List<Result> res = new ArrayList<Result>();
    int num_results = 0;
    for (int i = 0; i < n; i++) {
      byte[] b0 = start_key[keyIndex].getBytes();
      byte[] b1 = end_key[keyIndex].getBytes();
      Scan s = new Scan(b0, b1);
      s.setCaching(1000);
      if (family.size() > 0) {
        for (int j = 0; j < family.size(); j++)
          s.addFamily(family.get(j));
      }
      if (familyColumn.size() > 0) {
        for (int j = 0; j < familyColumn.size(); j++)
          s.addColumn(familyColumn.get(j), column.get(j));
      }
      Result[] this_res;
      this_res = t.getScanner(s).next(numElements);
      for (int j = 0; j < this_res.length; j++) {
        res.add(this_res[j]);
        num_results++;
      }
      keyIndex++;
    }
    Result[] res_out = new Result[num_results];
    for (int i = 0; i < num_results; i++) {
      res_out[i] = res.get(i);
    }
    return res_out;
  }

  public void restrict(byte[] family_in) {
    family.add(family_in);
  }

  public void restrict(byte[] family_in, byte[] column_in) {
    familyColumn.add(family_in);
    column.add(column_in);
  }

  public String[] fetch(int numScans, int[] value_ind) throws java.io.IOException {
    Result[] res;
    int numElements = 1000;
    if (start_key.length == keyIndex)
      return null;
    res = nextResults(numScans, numElements);
    if (value_ind.length == 1)
      return parseResults(res);
    else
      return parseResults(res, value_ind);
  }

  @Override
  public void flush() {
    cells = null;
    t = null;
    start_key = null;
    end_key = null;
  }
}
