package Rpkg.hbase;

import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Delete;
import java.util.List;
import java.util.ArrayList;

public class HBDelete {
  List<Delete> deletes;

  public void loadData(String[] row) {
    int n = row.length;
    deletes = new ArrayList<Delete>();
    for (int i = 0; i < n; i++) {
      Delete d = new Delete(row[i].getBytes());
      deletes.add(d);
    }
  }

  public void loadData(String[] row, String[] family, String[] column, int allValues) {
    int n = row.length;
    deletes = new ArrayList<Delete>();
    for (int i = 0; i < n; i++) {
      Delete d = new Delete(row[i].getBytes());
      if (allValues != 0) d.deleteColumns(family[i].getBytes(), column[i].getBytes());
      else d.deleteColumn(family[i].getBytes(), column[i].getBytes());
      deletes.add(d);
    }
  }

  public void putDelete(HTable table) throws java.io.IOException {
    table.delete(deletes);
  }
}