package Rpkg.hbase;

import java.lang.Math;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.HTable;

public class HBGet extends HBResult {
  String[] k;
  byte[][] family;
  byte[][] familyColumn;
  byte[][] column;
  int keyIndex = 0;
  int familyIndex = 0;
  int familyColumnIndex = 0;

  // Initialize "String[] k" and "HTable t"
  public void initGet(HTable table, String[] keys, int nFamily, int nFamilyColumn) {
    k = keys;
    t = table;
    family = new byte[nFamily][];
    familyColumn = new byte[nFamilyColumn][];
    column = new byte[nFamilyColumn][];
  }

  private Result[] nextResults(int numElements) throws java.io.IOException{
    int n = Math.min(k.length - keyIndex, numElements);
    Result[] res = new Result[n];
    for (int i = 0; i < n; i++) {
      byte[] b = k[keyIndex].getBytes();
      Get g = new Get(b);
      if (familyIndex > 0) {
        for (int j = 0; j < familyIndex; j++)
          g.addFamily(family[j]);
      }
      if (familyColumnIndex > 0) {
        for (int j = 0; j < familyColumnIndex; j++)
          g.addColumn(familyColumn[j], column[j]);
      }
      res[i] = t.get(g);
      keyIndex++;
    }
    return res;
  }

  public void restrict(byte[] family_in) {
    family[familyIndex] = family_in;
    familyIndex++;
  }

  public void restrict(byte[] family_in, byte[] column_in) {
    familyColumn[familyColumnIndex] = family_in;
    column[familyColumnIndex] = column_in;
    familyColumnIndex++;
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