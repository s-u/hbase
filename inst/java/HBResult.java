package Rpkg.hbase;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.client.HTable;

public class HBResult {
  Cell[] cells;
  HTable t;

  public String[] parseResults(Result[] r) {
    int m = r.length;
    int N = 0;
    int iter = 0;
    Result[] res;
    for (int j = 0; j < m; j++)
      N = N + r[j].size();
    String[] val = new String[7*N];
    for (int j = 0; j < m; j++) {
    	res = r;
    	cells = r[j].rawCells();
    	int n = cells.length;
    	for (int i = 0; i < n; i++) {
        Cell c = cells[i];
        val[iter] = new String(c.getRowArray(), c.getRowOffset(), c.getRowLength());
        val[iter+N] = new String(c.getFamilyArray(), c.getFamilyOffset(), c.getFamilyLength());
        val[iter+2*N] = new String(c.getQualifierArray(), c.getQualifierOffset(), c.getQualifierLength());
        val[iter+3*N] = new String(String.valueOf(c.getTimestamp()));
        val[iter+4*N] = new String( String.valueOf( (int) c.getTypeByte() ));
        val[iter+5*N] = new String(String.valueOf(c.getMvccVersion()));
        val[iter+6*N] = new String(c.getValueArray(), c.getValueOffset(), c.getValueLength());
        iter++;
    	}
    }
  	return val;
  }

  public String[] parseResults(Result[] r, int[] value_ind) {
    int m = r.length;
    int N = 0;
    int[] numberColumnsCum = {0,0,0,0,0,0,0};
    int iter = 0;
    Result[] res;
    for (int j = 0; j < 6; j++)
      numberColumnsCum[j+1] = value_ind[j] + numberColumnsCum[j];
    for (int j = 0; j < m; j++)
      N = N + r[j].size();
    String[] val = new String[numberColumnsCum[6]*N];
    for (int j = 0; j < m; j++) {
      res = r;
      cells = r[j].rawCells();
      int n = cells.length;
      for (int i = 0; i < n; i++) {
        Cell c = cells[i];
        if (value_ind[0] == 1)
          val[iter] = new String(c.getRowArray(), c.getRowOffset(), c.getRowLength());
        if (value_ind[1] == 1)
          val[iter+numberColumnsCum[1]*N] = new String(c.getFamilyArray(), c.getFamilyOffset(), c.getFamilyLength());
        if (value_ind[2] == 1)
          val[iter+numberColumnsCum[2]*N] = new String(c.getQualifierArray(), c.getQualifierOffset(), c.getQualifierLength());
        if (value_ind[3] == 1)
          val[iter+numberColumnsCum[3]*N] = new String(String.valueOf(c.getTimestamp()));
        if (value_ind[4] == 1)
          val[iter+numberColumnsCum[4]*N] = new String( String.valueOf( (int) c.getTypeByte() ));
        if (value_ind[5] == 1)
          val[iter+numberColumnsCum[5]*N] = new String(String.valueOf(c.getMvccVersion()));
        if (value_ind[6] == 1)
          val[iter+numberColumnsCum[6]*N] = new String(c.getValueArray(), c.getValueOffset(), c.getValueLength());
        iter++;
      }
    }
    return val;
  }

  public void flush() {
    cells = null;
    t = null;
  }
}
