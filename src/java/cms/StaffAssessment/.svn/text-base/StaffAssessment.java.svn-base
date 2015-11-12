package cms.StaffAssessment;

import java.io.PrintStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.StringTokenizer;
import java.util.Vector;

public class StaffAssessment
{
  private String task;
  private String percentage;
  private String resource;

  private String getYear()
  {
    Calendar cal = Calendar.getInstance();
    String year = "" + cal.get(1);
    return year;
  }

  public boolean isSuperior(Connection conn, String staffid)
  {
    boolean result = false;

    String sql = "SELECT COUNT(*) FROM STAFF_HIERARCHY WHERE SH_REPORT_TO='" + staffid + "'";
    try
    {
      Statement st_sup = conn.createStatement();
      ResultSet rs_sup = st_sup.executeQuery(sql);
      rs_sup.next();
      if (rs_sup.getInt(1) > 0)
        result = true;
    }
    catch (SQLException se)
    {
      System.out.println("Error(staffAssessmentSuperior):" + se);
    }
    return result;
  }

  public boolean assessed(Connection conn, String staffid)
  {
    boolean assess = false;
    String sql = "SELECT COUNT(*) FROM STAFF_TARGET_ACTIVITY_HEAD WHERE STAH_STAFF_ID=? AND STAH_YEAR='" + getYear() + "'";
    try
    {
      PreparedStatement pst_assess = conn.prepareStatement(sql);
      pst_assess.setString(1, staffid);
      ResultSet rs_assess = pst_assess.executeQuery();
      rs_assess.next();
      if (rs_assess.getInt(1) > 0)
        assess = true;
      else
        assess = false;
    }
    catch (SQLException se)
    {
      System.out.println("Error(StaffAssessment assess):" + se);
    }

    return assess;
  }

  public void setTask(String task)
  {
    this.task = task;
  }

  public Vector getResources(String resource)
  {
    StringTokenizer st_resource = new StringTokenizer(resource, ",");
    Vector v_resource = new Vector(5, 1);
    int cnt = 0;
    while (st_resource.hasMoreTokens())
    {
      String temp = st_resource.nextToken();
      v_resource.add(cnt, temp);
      ++cnt;
    }
    return v_resource;
  }

  public void setPercentage(String percentage)
  {
    this.percentage = percentage;
  }

  public void setResource(String resource)
  {
    this.resource = resource;
  }

  public int updateAssessement(Connection conn, String staffid, int id)
  {
    CallableStatement cs = null;
    int stat = 0;
    try
    {
      cs = conn.prepareCall("{? = call ASSESSMENT.UPDATETARGET(?,?,?,?,?)}");
      cs.registerOutParameter(1, 2);
      cs.setString(2, staffid);
      cs.setString(3, getYear());
      cs.setInt(4, id);
      cs.setString(5, this.task);
      cs.setString(6, this.percentage);
      cs.executeUpdate();
      stat = cs.getInt(1);
    }
    catch (SQLException se)
    {
      System.out.println("Error(StaffAssessmentUpdateTarget):" + se);
    }
    return stat;
  }

  public int updateTargetResource(Connection conn, String staffid)
  {
    CallableStatement cs = null;
    int stat = 0;
    try
    {
      cs = conn.prepareCall("{? = call ASSESSMENT.UPDATETARGETRESOURCE(?,?,?)}");
      cs.registerOutParameter(1, 2);
      cs.setString(2, staffid);
      cs.setString(3, getYear());
      cs.setString(4, this.resource);
      cs.executeUpdate();
      stat = cs.getInt(1);
    }
    catch (SQLException se)
    {
      System.out.println("Error(StaffAssessmentUpdateTargetResource):" + se);
    }
    return stat;
  }

  public Vector getAllStaffTargets(Connection conn, String staffid)
  {
    Vector result = new Vector(0, 3);
    try
    {
      String sql = " SELECT STAH_STAFF_ID,SM_STAFF_NAME,STAH_ENTER_DATE FROM STAFF_TARGET_ACTIVITY_HEAD,STAFF_MAIN WHERE SM_STAFF_ID=STAH_STAFF_ID AND STAH_STAFF_ID IN (SELECT SH_STAFF_ID FROM STAFF_HIERARCHY WHERE SH_REPORT_TO='" + staffid + "')";

      Statement st_all = conn.createStatement();
      ResultSet rs_all = st_all.executeQuery(sql);
      int cnt = 0;
      while (rs_all.next())
      {
        result.add(cnt, rs_all.getString(1));
        result.add(cnt++, rs_all.getString(2));
        result.add(cnt++, rs_all.getString(3));
        ++cnt;
      }
    }
    catch (SQLException se)
    {
      System.out.println("Error(StaffAssessmentAllStaff):" + se);
    }
    return result;
  }
}