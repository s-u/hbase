package Rpkg.hbase;

import java.util.List;
import java.util.ArrayList;
import java.lang.Math;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.HTable;

public class HBGet extends HBResult {
  String[] k;
  List<byte[]> family;
  List<byte[]> familyColumn;
  List<byte[]> column;

  int keyIndex = 0;

  public void initGet(HTable table, String[] keys) {
    k = keys;
    t = table;
    family = new ArrayList<byte[]>();
    familyColumn = new ArrayList<byte[]>();
    column = new ArrayList<byte[]>();
  }

  private Result[] nextResults(int numElements) throws java.io.IOException{
    int n = Math.min(k.length - keyIndex, numElements);
    Result[] res = new Result[n];
    for (int i = 0; i < n; i++) {
      byte[] b = k[keyIndex].getBytes();
      Get g = new Get(b);
      if (family.size() > 0) {
        for (int j = 0; j < family.size(); j++)
          g.addFamily(family.get(j));
      }
      if (familyColumn.size() > 0) {
        for (int j = 0; j < familyColumn.size(); j++)
          g.addColumn(familyColumn.get(j), column.get(j));
      }
      res[i] = t.get(g);
      keyIndex++;
    }
    return res;
  }

  public void restrict(byte[] family_in) {
    family.add(family_in);
  }

  public void restrict(byte[] family_in, byte[] column_in) {
    familyColumn.add(family_in);
    column.add(column_in);
  }

  public String[] fetch(int numElements, int[] value_ind) throws java.io.IOException {
    Result[] res;
    if (k.length == keyIndex)
      return null;
    res = nextResults(numElements);
    if (value_ind.length == 1)
      return parseResults(res);
    else
      return parseResults(res, value_ind);
  }

  @Override
  public void flush() {
    cells = null;
    t = null;
    k = null;
  }
}
