package cms.leave;

import java.sql.*;
import java.util.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import common.CommonFunction;

public class LeaveLeave
{
  private Connection getConnection()
  {
    Connection localConnection = null;
    try
    {
      InitialContext localInitialContext = new InitialContext();
      Context localContext = (Context)localInitialContext.lookup("java:comp/env");
      DataSource localDataSource = (DataSource)localContext.lookup("jdbc/cmsdb");
      localConnection = localDataSource.getConnection();
    }
    catch (Exception localException)
    {
      System.out.println("LeaveLeave(getConnection):" + localException);
    }
    return localConnection;
  }

  private String formatTime(double paramDouble)
  {
    String str1 = "";
    int i = (int)paramDouble;
    int j = (int)((paramDouble - (int)paramDouble) * 60.0D);
    String str2 = "0" + Integer.toString(j);
    str1 = i + ":" + str2;
    return str1;
  }

  private String getLeaveType(String paramString)
  {
    if (paramString.equals("001"))
      return "Annual Leave";
    if (paramString.equals("003"))
      return "Medical Leave";
    if (paramString.equals("005"))
      return "Replacement Leave";
    if (paramString.equals("004"))
      return "UnRecorded Leave";
    if (paramString.equals("015"))
      return "Time Off Leave";
    if (paramString.equals("007"))
      return "Maternity Leave";
    if (paramString.equals("008"))
      return "Paternity Leave";
    if (paramString.equals("009"))
      return "Compassionate Leave";
    if (paramString.equals("010"))
      return "Hajj Leave";
    if (paramString.equals("014"))
      return "Cuti Bencana Alam";
    if (paramString.equals("016"))
      return "Cuti Latihan Pasukan Sukarela";
    if (paramString.equals("017"))
      return "Cuti Menghadiri Latihan";
    if (paramString.equals("018"))
      return "Cuti Memasuki Peperiksaan";
    if (paramString.equals("019"))
      return "Cuti Mengambil Bahagian Dalam Sukan";
    if (paramString.equals("020"))
      return "Cuti Mengikuti Kursus Intensif";
    if (paramString.equals("021"))
      return "Cuti Dibawah Program PLKN";
    if (paramString.equals("022"))
      return "Cuti Mesyuarat Persatuan Iktisas";
    if (paramString.equals("023"))
      return "Cuti Lain Kursus";
    if (paramString.equals("024")) {
      return "Cuti Latihan Syarikat Kerjasama";
    }
    return "Emergency Leave";
  }

  private String getLeaveSQL(String paramString1, String paramString2)
  {
    String str = "";
    if (paramString2.equals("view")) {
      str = "SELECT sld_staff_id,sld_apply_date,sld_date_from,sld_date_to,sld_total_day,sld_leave_type,sld_status," +
      			"sld_substitute, sld_leave_reason,sld_contact_address,sld_contact_number,sld_leavetype_conn " +
      			"FROM STAFF_LEAVE_DETL WHERE sld_ref_id = '" + paramString1 + "'";
    }
    else if (paramString2.equals("approve")) {
      str = "SELECT sld_ref_id,sld_staff_id,sld_apply_date,sld_date_from,sld_date_to,sld_total_day,sld_leave_type," +
      			"sld_status,sld_substitute,sld_leavetype_conn  " +
      			"FROM STAFF_LEAVE_DETL WHERE sld_approve_by ='" + paramString1 + "' " + 
      			"AND (sld_status='RECOMMEND' OR sld_status='APPLY')";
    }
    else if (paramString2.equals("cancel"))
      str = "SELECT sld_ref_id,sld_staff_id,sld_apply_date,sld_date_from,sld_date_to,sld_total_day,sld_leave_type," +
      			"sld_status,sld_substitute,sld_leavetype_conn  " +
      			"FROM STAFF_LEAVE_DETL WHERE sld_approve_by ='" + paramString1 + "' " + 
      			"AND (sld_status='CANCEL_RECOMMEND' OR sld_status='CANCEL_APPLY')";
    else
      str = "SELECT sld_ref_id,sld_staff_id,sld_apply_date,sld_date_from,sld_date_to,sld_total_day,sld_leave_type," +
      			"sld_status,sld_substitute,sld_leavetype_conn  " +
      			"FROM STAFF_LEAVE_DETL WHERE sld_recommend_by='" + paramString1 + "' " + 
      			"AND (sld_status='APPLY' OR sld_status='CANCEL_APPLY')";
    return str;
  }

  private String getOvertimeSQL(String paramString1, String paramString2)
  {
    String str = "";
    if (paramString2.equals("approve")) {
      str = "SELECT slo_ref_id,slo_staff_id,slo_date,slo_total_hours FROM STAFF_LEAVE_OVERTIME WHERE (slo_status='RECOMMEND' OR slo_status='APPLY') AND slo_approve_by='" + paramString1 + "'";
    }
    else if (paramString2.equals("recommend"))
      str = "SELECT slo_ref_id,slo_staff_id,slo_date,slo_total_hours FROM STAFF_LEAVE_OVERTIME WHERE slo_status='APPLY' AND slo_recommend_by='" + paramString1 + "'";
    else
      str = "SELECT slo_staff_id,slo_date,slo_total_hours,slo_workorder_id FROM STAFF_LEAVE_OVERTIME WHERE (slo_status='APPLY' OR slo_status='RECOMMEND') AND slo_ref_id='" + paramString1 + "'";
    return str;
  }

  private String getUserStatusSQL(String paramString1, String paramString2)
  {
    String str = "";
    if (paramString2.equals("RL")) {
      str = "SELECT count(*) FROM staff_leave_detl WHERE sld_recommend_by='" + paramString1 + "' AND (sld_status='APPLY' OR sld_status='CANCEL_APPLY')";
    }
    else if (paramString2.equals("AL")) {
      str = "SELECT count(*) FROM staff_leave_detl WHERE sld_approve_by='" + paramString1 + "' AND((sld_status='RECOMMEND' OR sld_status='APPLY' ) OR (sld_status='CANCEL_RECOMMEND' OR sld_status='CANCEL_APPLY'))";
    }
    else if (paramString2.equals("RO")) {
      str = "SELECT count(*) FROM staff_leave_overtime WHERE slo_recommend_by='" + paramString1 + "' and slo_status='APPLY'";
    }
    else if (paramString2.equals("AO"))
      str = "SELECT count(*) FROM staff_leave_overtime WHERE slo_approve_by='" + paramString1 + "' AND (slo_status='RECOMMEND' OR slo_status='APPLY')";
    return str;
  }

  public String getStaffName(String paramString)
  {
    Connection localConnection = null;
    String str = "";
    Statement localStatement = null;
    ResultSet localResultSet = null;
    localConnection = getConnection();
    try
    {
      localStatement = localConnection.createStatement();
      localResultSet = localStatement.executeQuery("SELECT sm_staff_name FROM STAFF_MAIN WHERE sm_staff_id='" + paramString + "'");
      localResultSet.next();
      str = localResultSet.getString(1);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("LeaveLeave(getStaffName):" + localSQLException);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
        if (localConnection != null)
          localConnection.close();
      }
      catch (Exception localException)
      {
        System.out.println("LeaveLeave(getStaffName):" + localException);
      }
    }
    return str;
  }

  public Vector getLeaveTypes()
  {
    Connection localConnection = null;
    Vector localVector = new Vector(1, 1);
    Statement localStatement = null;
    String str = "SELECT LT_LEAVE_CODE,LT_DESC FROM LEAVE_TYPE WHERE LT_APPLY_ONLINE='Y' AND LT_LEVEL='1' ";
    ResultSet localResultSet = null;
    localConnection = getConnection();
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); ) {
        if (localResultSet.getString(2).equals("EMERGENCY LEAVE"))
          continue;
        localVector.add(localResultSet.getString(1));
        localVector.add(localResultSet.getString(2));
      }

    }
    catch (SQLException localSQLException1)
    {
      localSQLException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localStatement != null)
          localStatement.close();
        if (localResultSet != null)
          localResultSet.close();
        if (localConnection != null)
          localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        localSQLException2.printStackTrace();
      }
    }
    return localVector;
  }

  public Vector getAllLeaveTypes()
  {
    Connection localConnection = null;
    Vector localVector = new Vector(1, 1);
    Statement localStatement = null;
    String str = "SELECT LT_LEAVE_CODE,LT_DESC FROM LEAVE_TYPE WHERE LT_APPLY_ONLINE='Y' and LT_LEVEL='1' ";
    ResultSet localResultSet = null;
    localConnection = getConnection();
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(localResultSet.getString(2))) {
        localVector.add(localResultSet.getString(1));
      }
    }
    catch (SQLException localSQLException1)
    {
      localSQLException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localStatement != null)
          localStatement.close();
        if (localResultSet != null)
          localResultSet.close();
        if (localConnection != null)
          localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        localSQLException2.printStackTrace();
      }
    }
    return localVector;
  }

  public Vector getLeaveTypesConn(String paramString)
  {
    Connection localConnection = null;
    Vector localVector = new Vector(1, 1);
    Statement localStatement = null;
    String str = "SELECT LT_LEAVE_CODE,LT_DESC FROM LEAVE_TYPE WHERE LT_APPLY_ONLINE='Y' AND LT_LEVEL='2' AND LT_LEAVE_HEAD='" + paramString + "' ";
    ResultSet localResultSet = null;
    localConnection = getConnection();
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(localResultSet.getString(2))) {
        localVector.add(localResultSet.getString(1));
      }
    }
    catch (SQLException localSQLException1)
    {
      localSQLException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localStatement != null)
          localStatement.close();
        if (localResultSet != null)
          localResultSet.close();
        if (localConnection != null)
          localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        localSQLException2.printStackTrace();
      }
    }
    return localVector;
  }

  public Hashtable<String,String> getLeavesBalances(String paramString1, String paramString2)
  {
    Connection localConnection = null;
    Hashtable<String,String> localHashtable = new Hashtable<String,String>(1, 0.75F);
    Statement localStatement = null;
    String str = "SELECT SLH_ANNUAL_BALANCE_DAYS,SLH_UNRECORDED_BALANCE_DAYS,SLH_REPLACEMENT_BALANCE_HOURS " +
    				"FROM STAFF_LEAVE_HEAD WHERE SLH_STAFF_ID = '" + paramString1 + "' AND SLH_YEAR = '" + paramString2 + "'";
    
    ResultSet localResultSet = null;
    localConnection = getConnection();
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); )
      {
        if (localResultSet.getString(1) != null)
          localHashtable.put("001", localResultSet.getString(1));
        else
          localHashtable.put("001", "0");
        
        if (localResultSet.getString(1) != null)
          localHashtable.put("002", localResultSet.getString(1));
        else
          localHashtable.put("002", "0");
        
        if (localResultSet.getString(2) != null)
          localHashtable.put("004", localResultSet.getString(2));
        else
          localHashtable.put("004", "0");
        
        if (localResultSet.getString(3) != null)
          localHashtable.put("005", formatTime(localResultSet.getDouble(3)));
        else {
          localHashtable.put("005", "0");
        }
      }
    }
    catch (SQLException sqle) {
      System.out.println("LeaveLeave(getLeavesBalances)" + sqle);
    }
    finally
    {
      try
      {
        if (localStatement != null)
          localStatement.close();
        if (localResultSet != null)
          localResultSet.close();
        if (localConnection != null)
          localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        localSQLException2.printStackTrace();
      }
    }
    return localHashtable;
  }

  public Vector queryHOD(String paramString)
  {
    Connection localConnection = null;
    Vector localVector = new Vector(1, 1);
    Statement localStatement = null;
    localConnection = getConnection();
    String str = "SELECT SM.SM_STAFF_ID,SM.SM_STAFF_NAME FROM STAFF_MAIN SM ,STAFF_HIERARCHY SH WHERE SM.SM_STAFF_ID= SH.SH_REPORT_TO AND SH.SH_STAFF_ID='" + paramString + "' AND SH.SH_SYS_ID='ADM_AL'";
    ResultSet localResultSet = null;
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(localResultSet.getString(2))) {
        localVector.add(localResultSet.getString(1));
      }
    }
    catch (SQLException localSQLException1)
    {
      localSQLException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localStatement != null)
          localStatement.close();
        if (localResultSet != null)
          localResultSet.close();
        if (localConnection != null)
          localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        localSQLException2.printStackTrace();
      }
    }
    return localVector;
  }

  public Vector getLeaveTypesDetl(String paramString)
  {
    Connection localConnection = null;
    Vector localVector = new Vector(1, 1);
    Statement localStatement = null;
    localConnection = getConnection();
    String str = "SELECT LTD_CODE, LTD_DESC FROM CMSADMIN.leave_type_detl WHERE LTD_LEAVE_CODE = '" + paramString + "'";
    ResultSet localResultSet = null;
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(localResultSet.getString(2))) {
        localVector.add(localResultSet.getString(1));
      }
    }
    catch (SQLException localSQLException1)
    {
      localSQLException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localStatement != null)
          localStatement.close();
        if (localResultSet != null)
          localResultSet.close();
        if (localConnection != null)
          localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        localSQLException2.printStackTrace();
      }
    }
    return localVector;
  }

  public int getAppliedLeaveDays(String paramString1, String paramString2)
  {
    Connection conn = null;
    int i = 0;
    CallableStatement cstmt = null;
    conn = getConnection();
    try
    {
    	cstmt = conn.prepareCall("{? = call cmsadmin.leave.CalculateLeaveDays2(?,?)}");
    	cstmt.registerOutParameter(1, 2);
    	cstmt.setString(2, paramString1);
    	cstmt.setString(3, paramString2);
    	cstmt.executeUpdate();
    	i = cstmt.getInt(1);
    }
    catch (SQLException sqle) {
    	sqle.printStackTrace();
    }
    finally
    {
      try {
    	  if (cstmt != null) cstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException e) { }
    }
    return i;
  }

  public int getAppliedShiftLeaveDays(String staffID, String fromDate, String toDate)
  {
    Connection conn = null;
    int noDay = 0;
    CallableStatement cstmt = null;
    conn = getConnection();
    try
    {
    	cstmt = conn.prepareCall("{? = call cmsadmin.leave.CalculateShiftLeaveDays(?,?,?)}");
    	cstmt.registerOutParameter(1, 2);
    	cstmt.setString(2, staffID);
    	cstmt.setString(3, fromDate);
    	cstmt.setString(4, toDate);
    	cstmt.executeUpdate();
    	noDay = cstmt.getInt(1);
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
    finally {
      try {
    	  if (cstmt != null) cstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException sqle) { }
    }
    return noDay;
  }

  public int getAppliedMaternityLeaveDays(String paramString1, String paramString2)
  {
    Connection localConnection = null;
    int i = 0;
    CallableStatement localCallableStatement = null;
    localConnection = getConnection();
    try
    {
      localCallableStatement = localConnection.prepareCall("{? = call cmsadmin.leave.CalculateMaternityLeaveDays(?,?)}");
      localCallableStatement.registerOutParameter(1, 2);
      localCallableStatement.setString(2, paramString1);
      localCallableStatement.setString(3, paramString2);
      localCallableStatement.executeUpdate();
      i = localCallableStatement.getInt(1);
    }
    catch (SQLException localSQLException1)
    {
      localSQLException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localCallableStatement != null)
          localCallableStatement.close();
        if (localConnection != null)
          localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        localSQLException2.printStackTrace();
      }
    }
    return i;
  }

  public int getTakenLeaveDays(String staffID, String leavetype, String leaveYear)
  {
    Connection conn = null;
    int noDay = 0;
    PreparedStatement pstmt = null;
    ResultSet rset = null;
    
    StringBuilder sb = new StringBuilder("");
    sb.append("SELECT sum(nvl(sld_total_day,0)) FROM staff_leave_detl ");
    sb.append("WHERE sld_staff_id = ? AND to_char(sld_date_from,'yyyy') = ? AND sld_leavetype_conn = ?");
    
    conn = getConnection();
    try {
    	pstmt = conn.prepareStatement(sb.toString());
    	pstmt.setString(1, staffID);
    	pstmt.setString(2, leaveYear);
    	pstmt.setString(3, leavetype);
    	rset = pstmt.executeQuery();
    	
    	if (rset.isBeforeFirst()) {
    		if (rset.next()) {
    			noDay = rset.getInt(1);
    		}
    	}
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
    finally {
      try {
    	  if (rset != null) rset.close();
    	  if (pstmt != null) pstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException sqle) { }
    }
    return noDay;
  }

  
  public int getMaxDay_ByLeave(String leaveCode)
  {
    Connection conn = null;
    int noDay = 0;
    PreparedStatement pstmt = null;
    ResultSet rset = null;
    
    StringBuilder sb = new StringBuilder("");
    sb.append("SELECT nvl(lt_max_day,0) FROM leave_type WHERE lt_leave_code = ?");
    
    conn = getConnection();
    try {
    	pstmt = conn.prepareStatement(sb.toString());
    	pstmt.setString(1, leaveCode);
    	rset = pstmt.executeQuery();
    	
    	if (rset.isBeforeFirst()) {
    		if (rset.next()) {
    			noDay = rset.getInt(1);
    		}
    	}
    }
    catch (SQLException e) {
      e.printStackTrace();
    }
    finally {
      try {
    	  if (rset != null) rset.close();
    	  if (pstmt != null) pstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException sqle) { }
    }
    return noDay;
  }

  public Vector getAppliedLeaves(String paramString1, String paramString2, String paramString3)
  {
    Calendar localCalendar = Calendar.getInstance();
    String str = "" + localCalendar.get(1);
    Vector localVector = null;
    localVector = getAppliedLeaves(paramString1, str, paramString2, paramString3);
    return localVector;
  }

  public Vector getAppliedLeaves(String paramString1, String paramString2, String paramString3, String paramString4)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    String str1 = "SELECT sld_ref_id,sld_apply_date,sld_date_from,sld_date_to,sld_total_day,sld_leave_type,sld_status,nvl(sld_leavetype_conn, '-') FROM staff_leave_detl";
    Calendar localCalendar = Calendar.getInstance();
    String str2 = "" + localCalendar.get(1);
    Vector localVector = new Vector(1, 1);
    localConnection = getConnection();
    if ((paramString2 != null) && (paramString3 != null) && (Integer.parseInt(paramString3) > 0) && (Integer.parseInt(paramString2) > 0)) {
      str1 = str1 + " WHERE  (TO_CHAR(sld_date_from,'mm')=? OR TO_CHAR(sld_date_to,'mm')=? )" + " AND (TO_CHAR(sld_date_from,'yyyy')=? OR TO_CHAR(sld_date_to,'yyyy')=?) " + " AND sld_staff_id=? ";
    }
    else if ((paramString2 != null) && (Integer.parseInt(paramString2) > 0)) {
      str1 = str1 + " WHERE ( TO_CHAR(sld_date_from,'yyyy')=? OR TO_CHAR(sld_date_to,'yyyy')=? )" + " AND sld_staff_id= ? ";
    }
    else if ((paramString3 != null) && (Integer.parseInt(paramString3) > 0))
      str1 = str1 + " WHERE  (TO_CHAR(sld_date_from,'mm')=? OR TO_CHAR(sld_date_to,'mm')=? )" + " AND (TO_CHAR(sld_date_from,'yyyy')=? OR TO_CHAR(sld_date_to,'yyyy')=?) " + " AND sld_staff_id=? ";
    else
      str1 = str1 + " WHERE ( TO_CHAR(sld_date_from,'yyyy')=? OR TO_CHAR(sld_date_to,'yyyy')=? )" + " AND sld_staff_id= ? ";
    if ((paramString1 != null) && (!(paramString1.equals("0"))) && (!(paramString1.equals(""))))
      str1 = str1 + " AND sld_leave_type='" + paramString1 + "'";
    str1 = str1 + " ORDER BY sld_apply_date";
    try
    {
      if ((paramString2 != null) && (paramString3 != null) && (Integer.parseInt(paramString3) > 0) && (Integer.parseInt(paramString2) > 0))
      {
        localPreparedStatement = localConnection.prepareStatement(str1);
        localPreparedStatement.setString(1, paramString3);
        localPreparedStatement.setString(2, paramString3);
        localPreparedStatement.setString(3, paramString2);
        localPreparedStatement.setString(4, paramString2);
        localPreparedStatement.setString(5, paramString4);
      }
      else if ((paramString2 != null) && (Integer.parseInt(paramString2) > 0))
      {
        localPreparedStatement = localConnection.prepareStatement(str1);
        localPreparedStatement.setString(1, paramString2);
        localPreparedStatement.setString(2, paramString2);
        localPreparedStatement.setString(3, paramString4);
      }
      else if ((paramString3 != null) && (Integer.parseInt(paramString3) > 0))
      {
        localPreparedStatement = localConnection.prepareStatement(str1);
        localPreparedStatement.setString(1, paramString3);
        localPreparedStatement.setString(2, paramString3);
        localPreparedStatement.setString(3, str2);
        localPreparedStatement.setString(4, str2);
        localPreparedStatement.setString(5, paramString4);
      }
      else {
        localPreparedStatement = localConnection.prepareStatement(str1);
        localPreparedStatement.setString(1, str2);
        localPreparedStatement.setString(2, str2);
        localPreparedStatement.setString(3, paramString4);
      }
      LeaveDB localLeaveDB;
      for (localResultSet = localPreparedStatement.executeQuery(); localResultSet.next(); localVector.add(localLeaveDB))
      {
        localLeaveDB = new LeaveDB();
        localLeaveDB.setLeaveID(localResultSet.getString(1));
        localLeaveDB.setApplyDate(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(2).substring(0, 10)));
        localLeaveDB.setDateFrom(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(3).substring(0, 10)));
        localLeaveDB.setDateTo(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(4).substring(0, 10)));
        localLeaveDB.setTotalDays(localResultSet.getInt(5));
        localLeaveDB.setLeaveType(getLeaveType(localResultSet.getString(6)));
        localLeaveDB.setStatus(localResultSet.getString(7));
      }

    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getAppliedDays):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (localConnection == null);
        localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
    }
    return localVector;
  }

  public Vector getAppliedOverTime(String paramString1, String paramString2)
  {
    Calendar localCalendar = Calendar.getInstance();
    String str = "" + localCalendar.get(1);
    Vector localVector = null;
    localVector = getAppliedOverTime(str, paramString1, paramString2);
    return localVector;
  }

  public Vector getAppliedOverTime(String paramString1, String paramString2, String paramString3)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    String str1 = "";
    Calendar localCalendar = Calendar.getInstance();
    String str2 = "" + localCalendar.get(1);
    Vector localVector = new Vector(1, 1);
    localConnection = getConnection();
    if ((paramString1 != null) && (paramString2 != null) && (Integer.parseInt(paramString2) > 0) && (Integer.parseInt(paramString1) > 0)) {
      str1 = "SELECT slo_date,slo_total_hours,slo_status  FROM staff_leave_overtime  WHERE TO_CHAR(slo_date,'mm')=? AND TO_CHAR(slo_date,'yyyy')= ?  AND slo_staff_id=? ORDER BY slo_date";
    }
    else if ((paramString1 != null) && (Integer.parseInt(paramString1) > 0)) {
      str1 = "SELECT slo_date,slo_total_hours,slo_status  FROM staff_leave_overtime  WHERE TO_CHAR(slo_date,'yyyy')= ?  AND slo_staff_id=? ORDER BY slo_date";
    }
    else if ((paramString2 != null) && (Integer.parseInt(paramString2) > 0))
      str1 = "SELECT slo_date,slo_total_hours,slo_status  FROM staff_leave_overtime  WHERE TO_CHAR(slo_date,'mm')=? AND TO_CHAR(slo_date,'yyyy')= ?  AND slo_staff_id=? ORDER BY slo_date";
    else
      str1 = "SELECT slo_date,slo_total_hours,slo_status  FROM staff_leave_overtime  WHERE TO_CHAR(slo_date,'yyyy')= ?  AND slo_staff_id=? ORDER BY slo_date";
    try
    {
      if ((paramString1 != null) && (paramString2 != null) && (Integer.parseInt(paramString2) > 0) && (Integer.parseInt(paramString1) > 0))
      {
        localPreparedStatement = localConnection.prepareStatement(str1);
        localPreparedStatement.setString(1, paramString2);
        localPreparedStatement.setString(2, paramString1);
        localPreparedStatement.setString(3, paramString3);
      }
      else if ((paramString1 != null) && (Integer.parseInt(paramString1) > 0))
      {
        localPreparedStatement = localConnection.prepareStatement(str1);
        localPreparedStatement.setString(1, paramString1);
        localPreparedStatement.setString(2, paramString3);
      }
      else if ((paramString2 != null) && (Integer.parseInt(paramString2) > 0))
      {
        localPreparedStatement = localConnection.prepareStatement(str1);
        localPreparedStatement.setString(1, paramString2);
        localPreparedStatement.setString(2, str2);
        localPreparedStatement.setString(3, paramString3);
      }
      else {
        localPreparedStatement = localConnection.prepareStatement(str1);
        localPreparedStatement.setString(1, str2);
        localPreparedStatement.setString(2, paramString3);
      }
      OvertimeDB localOvertimeDB;
      for (localResultSet = localPreparedStatement.executeQuery(); localResultSet.next(); localVector.add(localOvertimeDB))
      {
        localOvertimeDB = new OvertimeDB();
        localOvertimeDB.setOvertimeDate(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(1).substring(0, 10)));
        localOvertimeDB.setTotalHours(formatTime(localResultSet.getDouble(2)));
        localOvertimeDB.setStatus(localResultSet.getString(3));
      }

    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getAppliedOvertime):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (localConnection == null);
        localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
    }
    return localVector;
  }

  public LeaveDB getLeaveDetails(String paramString1, String paramString2)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    String str = getLeaveSQL(paramString1, paramString2);
    localConnection = getConnection();
    LeaveDB localLeaveDB = new LeaveDB();
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localLeaveDB.setContactNo(localResultSet.getString(11)))
      {
        localLeaveDB.setStaffID(localResultSet.getString(1));
        localLeaveDB.setStaffName(getStaffName(localResultSet.getString(1)));
        localLeaveDB.setApplyDate(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(2).substring(0, 10)));
        localLeaveDB.setDateFrom(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(3).substring(0, 10)));
        localLeaveDB.setDateTo(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(4).substring(0, 10)));
        localLeaveDB.setTotalDays(localResultSet.getInt(5));
        localLeaveDB.setLeaveCode(localResultSet.getString(6));
        localLeaveDB.setLeaveType(getLeaveType(localResultSet.getString(6)));
        localLeaveDB.setStatus(localResultSet.getString(7));
        if (localResultSet.getString(8) != null)
        {
          localLeaveDB.setSubstitute(CommonFunction.restrictNameLength(getStaffName(localResultSet.getString(8)), 20));
          localLeaveDB.setSubstituteID(localResultSet.getString(8));
        }
        else {
          localLeaveDB.setSubstitute("");
          localLeaveDB.setSubstituteID("");
        }
        localLeaveDB.setReason(localResultSet.getString(9));
        localLeaveDB.setAddress(localResultSet.getString(10));
        localLeaveDB.setLeaveTypeDet(localResultSet.getString("sld_leavetype_conn"));
      }

    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getLeaveDetails):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
        if (localConnection == null);
        localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
    }
    return localLeaveDB;
  }

  public Vector getRecommendLeaveDetails(String paramString1, String paramString2)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    String str = getLeaveSQL(paramString1, paramString2);
    Vector localVector = new Vector(1, 1);
    try
    {
      localConnection = getConnection();
      localStatement = localConnection.createStatement();
      LeaveDB localLeaveDB;
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(localLeaveDB))
      {
        localLeaveDB = new LeaveDB();
        localLeaveDB.setLeaveID(localResultSet.getString(1));
        localLeaveDB.setStaffID(localResultSet.getString(2));
        localLeaveDB.setStaffName(CommonFunction.restrictNameLength(getStaffName(localResultSet.getString(2)), 20));
        localLeaveDB.setApplyDate(CommonFunction.getDate("yyyy-mm-dd", "dd/mm", localResultSet.getString(3).substring(0, 10)));
        localLeaveDB.setDateFrom(CommonFunction.getDate("yyyy-mm-dd", "dd/mm", localResultSet.getString(4).substring(0, 10)));
        localLeaveDB.setDateTo(CommonFunction.getDate("yyyy-mm-dd", "dd/mm", localResultSet.getString(5).substring(0, 10)));
        localLeaveDB.setTotalDays(localResultSet.getInt(6));
        localLeaveDB.setLeaveCode(localResultSet.getString(7));
        localLeaveDB.setLeaveType(getLeaveType(localResultSet.getString(7)));
        localLeaveDB.setStatus(localResultSet.getString(8));
        if (localResultSet.getString(9) != null)
          localLeaveDB.setSubstitute(CommonFunction.restrictNameLength(getStaffName(localResultSet.getString(9)), 20));
        else {
          localLeaveDB.setSubstitute("-----");
        }
      }
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getRecommendLeaveDetails):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return localVector;
  }

  public OvertimeDB getOvertimeDetails(String paramString1, String paramString2)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    localConnection = getConnection();
    String str = getOvertimeSQL(paramString1, paramString2);
    OvertimeDB localOvertimeDB = new OvertimeDB();
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); setWorkOrderDetails(localResultSet.getString(4), localOvertimeDB))
      {
        localOvertimeDB.setStaffName(getStaffName(localResultSet.getString(1)));
        localOvertimeDB.setOvertimeDate(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(2).substring(0, 10)));
        localOvertimeDB.setTotalHours(formatTime(localResultSet.getDouble(3)));
      }

    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getLeaveDetails):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return localOvertimeDB;
  }

  public Vector getRecommedOvertimeDetails(String paramString1, String paramString2)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    localConnection = getConnection();
    String str = getOvertimeSQL(paramString1, paramString2);
    Vector localVector = new Vector(1, 1);
    try
    {
      localStatement = localConnection.createStatement();
      OvertimeDB localOvertimeDB;
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(localOvertimeDB))
      {
        localOvertimeDB = new OvertimeDB();
        localOvertimeDB.setOvertimeID(localResultSet.getString(1));
        localOvertimeDB.setStaffName(CommonFunction.restrictNameLength(getStaffName(localResultSet.getString(2)), 20));
        localOvertimeDB.setOvertimeDate(CommonFunction.getDate("yyyy-mm-dd", "dd/mm", localResultSet.getString(3).substring(0, 10)));
        localOvertimeDB.setTotalHours(formatTime(localResultSet.getDouble(4)));
      }

    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getRecommendLeaveDetails):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return localVector;
  }

  public Vector getDeptWorkOrders(String paramString)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    Vector localVector = new Vector(1, 1);
    String str = "SELECT WOD_WORKORDER_ID FROM CMSADMIN.WORK_ORDER_HEAD, CMSADMIN.WORK_ORDER_DETL " +
    				"WHERE WOD_WORKORDER_ID = WOH_WORKORDER_ID AND WOD_STAFF_ID = '" + paramString + "'" + 
    				"AND WOH_APPROVE_BY IS NOT NULL AND SYSDATE >= WOH_DATE_FROM " + 
    				"AND TO_CHAR(WOH_DATE_FROM,'YYYY') = TO_CHAR(sysdate,'YYYY') " +
    				"ORDER BY WOH_DATE_FROM, WOH_WORKORDER_ID";
    
    localConnection = getConnection();
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(localResultSet.getString(1)));
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getRecommendLeaveDetails):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return localVector;
  }

  public String getWorkOrderDesc(String paramString)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    String str1 = "";
    String str2 = "SELECT woh_desc FROM WORK_ORDER_HEAD  WHERE woh_workorder_id='" + paramString + "'";
    localConnection = getConnection();
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str2); localResultSet.next(); ) {
        str1 = localResultSet.getString(1);
      }
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getWorkOrderDesc):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return str1;
  }

  public void setWorkOrderDetails(String paramString, OvertimeDB paramOvertimeDB)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    String str = "SELECT woh_desc,woh_date_from,woh_date_To FROM WORK_ORDER_HEAD  WHERE woh_workorder_id='" + paramString + "'";
    localConnection = getConnection();
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); paramOvertimeDB.setWorkOrderDateTo(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(3).substring(0, 10))))
      {
        paramOvertimeDB.setWorkOrderDesc(localResultSet.getString(1));
        paramOvertimeDB.setWorkOrderDateFrom(CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", localResultSet.getString(2).substring(0, 10)));
      }

    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(setWorkOrderDetails):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
  }

  public int isTopHierachy(String paramString)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    String str = "SELECT count(1) FROM STAFF_HIERARCHY,STAFF_MAIN  WHERE sh_report_to='" + paramString + "' AND sh_sys_id='ADM_AL'";
    localConnection = getConnection();
    int i = 0;
    try
    {
      localStatement = localConnection.createStatement();
      localResultSet = localStatement.executeQuery(str);
      if (localResultSet.next())
        i = localResultSet.getInt(1);
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(isTopHierachy):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
        if (localConnection == null);
        localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
    }
    return i;
  }

  public int isDeptDirector(String paramString)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    String str = "SELECT count(1) FROM DEPARTMENT_MAIN WHERE DM_DIRECTOR='" + paramString + "' and dm_level='1' ";
    localConnection = getConnection();
    int i = 0;
    try
    {
      localStatement = localConnection.createStatement();
      localResultSet = localStatement.executeQuery(str);
      if (localResultSet.next())
        i = localResultSet.getInt(1);
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(isDeptDirector):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
        if (localConnection == null);
        localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
    }
    return i;
  }

  public Vector getHierarchyStaff(String paramString)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    String str = "SELECT sh_staff_id,sm_staff_name FROM STAFF_HIERARCHY,STAFF_MAIN  WHERE sm_staff_id = sh_staff_id AND sh_report_to='" + paramString + "' AND sh_sys_id='ADM_AL' AND sm_staff_status='ACTIVE' ";
    localConnection = getConnection();
    Vector localVector = new Vector(1, 1);
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(CommonFunction.restrictNameLength(localResultSet.getString(2), 20))) {
        localVector.add(localResultSet.getString(1));
      }
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getHierarchyStaff):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return localVector;
  }

  public Vector getDepartmentStaff(String paramString)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    String str = "SELECT sm_staff_id,sm_staff_name FROM STAFF_MAIN WHERE sm_dept_code='" + paramString + "' AND sm_staff_status='ACTIVE' ";
    localConnection = getConnection();
    Vector localVector = new Vector(1, 1);
    try
    {
      localStatement = localConnection.createStatement();
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(CommonFunction.restrictNameLength(localResultSet.getString(2), 20))) {
        localVector.add(localResultSet.getString(1));
      }
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getDepartmentStaff):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return localVector;
  }

  public EntitlementDB getCompleteLeaveEntitlement(String paramString)
  {
    Statement stmt = null;
    ResultSet rset = null;
    Connection conn = null;
    Calendar localCalendar = Calendar.getInstance();
    int i = localCalendar.get(1);
    int j = i - 1;
    int k = i - 2;
    
    EntitlementDB localEntitlementDB = new EntitlementDB();
    String str = "SELECT slh_carry_forward_days FROM staff_leave_head WHERE slh_staff_id='" + paramString + 
    				"' AND (slh_year ='" + j + "' OR  slh_year='" + k + "')";
    
    conn = getConnection();
    
    try {
    	stmt = conn.createStatement();
    	for (rset = stmt.executeQuery(str); rset.next();) {
    		localEntitlementDB.setPrevYearCarryForward(rset.getInt(1));
    		if (rset.next()) {
    			localEntitlementDB.setBeforeYearCarryForward(rset.getInt(1));
    		}
    	}
    	rset.close();
    	stmt.close();
      
    	String[] arrayOfString = getLeaveEntitlement(paramString);
    	localEntitlementDB.setAnnualLeaveEntitlement(Integer.parseInt(arrayOfString[0]));
      
    	str = "SELECT slh_annual_balance_days,slh_replacement_balance_hours,slh_annual_taken_days " +
      			"FROM staff_leave_head WHERE slh_staff_id = '" + paramString + "' AND slh_year = '" + i + "'";
      
    	stmt = conn.createStatement();
    	rset = stmt.executeQuery(str);
    	if (rset.next()) {
    		localEntitlementDB.setAnnualBalance(rset.getInt(1));
    		if (rset.getString(2) != null)
    			localEntitlementDB.setReplacementBalance(formatTime(rset.getDouble(2)));
    		localEntitlementDB.setTakenBalance(rset.getInt(3));
    	}    	
    	stmt.close();
    	rset.close();
    	
    	str = "SELECT sum(nvl(SLH_GOLDEN_HANDSHAKE_DAYS,0)) FROM  staff_leave_head WHERE slh_staff_id='" + paramString + "'";
    	stmt = conn.createStatement();
    	rset = stmt.executeQuery(str);
    	if (rset.next())
    		localEntitlementDB.setGoldenHandshakeDays(rset.getInt(1));
    }
    catch (SQLException sqle) {
    	System.out.println("LeaveLeave(getCompleteLeaveEntitlement): " + sqle);
    }
    finally {
    	try {
	        if (rset != null) rset.close();
	        if (stmt != null) stmt.close();
	        if (conn == null); conn.close();
    	}
    	catch (SQLException sqle) {  }
    }
    return localEntitlementDB;
  }

  public String[] getLeaveEntitlement(String paramString)
  {
    Statement localStatement = null;
    ResultSet localResultSet = null;
    Connection localConnection = null;
    Calendar localCalendar = Calendar.getInstance();
    String str1 = "" + localCalendar.get(1);
    String[] arrayOfString = new String[3];
    
    String str2 = "SELECT SLH_ANNUAL_ENTITLED_DAYS,SLH_GOLDEN_HANDSHAKE_DAYS,SLH_CARRY_FORWARD_DAYS " +
    				"FROM STAFF_LEAVE_HEAD WHERE SLH_STAFF_ID = '" + paramString + "' AND SLH_YEAR = '" + str1 + "'";
       
    
    localConnection = getConnection();
    try
    {
      localStatement = localConnection.createStatement();
      localResultSet = localStatement.executeQuery(str2);
      if (localResultSet.next())
      {
        for (int i = 1; i <= 3; ++i) {
          if (localResultSet.getString(i) != null)
            arrayOfString[(i - 1)] = localResultSet.getString(i);
          else
            arrayOfString[(i - 1)] = "0";
        }
      }
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getLeaveEntitlement):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return arrayOfString;
  }

  private int countRecommedLeaves(String paramString1, String paramString2)
  {
    Statement localStatement = null;
    ResultSet localResultSet = null;
    Connection localConnection = null;
    String str = getUserStatusSQL(paramString1, paramString2);
    localConnection = getConnection();
    int i = 0;
    try
    {
      localStatement = localConnection.createStatement();
      localResultSet = localStatement.executeQuery(str);
      localResultSet.next();
      i = localResultSet.getInt(1);
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(countRecommedLeaves):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return i;
  }

  public String getUserStatus(String paramString)
  {
    String str = "";
    int i = 0;
    int j = 0;
    int k = 0;
    int l = 0;
    i = countRecommedLeaves(paramString, "RL");
    j = countRecommedLeaves(paramString, "RO");
    k = countRecommedLeaves(paramString, "AL");
    l = countRecommedLeaves(paramString, "AO");
    if ((k > 0) || (l > 0))
      str = "A";
    if ((((i > 0) || (j > 0))) && (k == 0))
      str = "R";
    if ((((i > 0) || (j > 0))) && (((k > 0) || (l > 0))))
      str = "B";
    return str;
  }

  public String getRecommendationStatus(String paramString)
  {
    Statement stmt = null;
    ResultSet rset = null;
    Connection conn = getConnection();
    
    String str1 = "SELECT SH.SH_RECOMMENDER_STATUS FROM STAFF_HIERARCHY SH " +
    				"WHERE SH.SH_STAFF_ID = '" + paramString + "' and SH_SYS_ID='ADM_AL' ";
    String str2 = "N";
    
    try {
    	stmt = conn.createStatement();
    	rset = stmt.executeQuery(str1);
    	if (rset.isBeforeFirst()) {
    		if (rset.next())
    			str2 = rset.getString(1);
    	}
    }
    catch (SQLException sqle) {
    	System.out.println("LeaveLeave(getRecommendationStatus):" + sqle);
    }
    finally {
      try
      {
        if (rset != null) rset.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close(); 
      }
      catch (SQLException localSQLException2) { }
    }
    return str2;
  }

  public Vector getCarryForwardRecommedLeaves(String paramString1, String paramString2)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    String str = "SELECT slcf_staff_id,slcf_apply_date,slcf_apply_carry_forward,slcf_apply_handshake FROM staff_leave_carry_forward WHERE slcf_recommend_by='" + paramString1 + "' AND slcf_leave_year='" + paramString2 + "'";
    Vector localVector = new Vector(1, 1);
    try
    {
      localConnection = getConnection();
      localStatement = localConnection.createStatement();
      CarryForwardDB localCarryForwardDB;
      for (localResultSet = localStatement.executeQuery(str); localResultSet.next(); localVector.add(localCarryForwardDB))
      {
        localCarryForwardDB = new CarryForwardDB();
        localCarryForwardDB.setStaffID(localResultSet.getString(1));
        localCarryForwardDB.setStaffName(getStaffName(localResultSet.getString(1)));
        localCarryForwardDB.setApplyDate(localResultSet.getString(2));
        localCarryForwardDB.setCarryForwardDays(localResultSet.getInt(3));
        localCarryForwardDB.setHandShakeDays(localResultSet.getInt(4));
      }

    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getCarryForwardRecommedLeaves):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
      finally
      {
        try
        {
          if (localConnection == null);
          localConnection.close();
        }
        catch (Exception localException)
        {
          System.out.println(localException);
        }
      }
    }
    return localVector;
  }

  public int hadGoldenHandShakeService(String paramString)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    int i = 0;
    String str = "SELECT count(1) FROM staff_main WHERE sm_staff_id='" + paramString + "' AND UPPER(sm_job_status) in ('TPERCUBAAN', 'TETAP', 'TPENCEN')";
    try
    {
      localConnection = getConnection();
      localStatement = localConnection.createStatement();
      localResultSet = localStatement.executeQuery(str);
      if (localResultSet.next())
        i = localResultSet.getInt(1);
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(hadGoldenHandShakeService):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
        if (localConnection == null);
        localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
    }
    return i;
  }

  public int isCarryForwardApplied(String paramString)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    int i = 0;
    Calendar localCalendar = Calendar.getInstance();
    String str = "SELECT count(1) FROM staff_leave_carry_forward WHERE slcf_staff_id='" + paramString + "' AND slcf_leave_year ='" + localCalendar.get(1) + "' AND SLCF_STATUS = 'APPLY'";
    try
    {
      localConnection = getConnection();
      localStatement = localConnection.createStatement();
      localResultSet = localStatement.executeQuery(str);
      if (localResultSet.next())
        i = localResultSet.getInt(1);
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(isCarryForwardApplied):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
        if (localConnection == null);
        localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
    }
    return i;
  }

  public CarryForwardDB getCarryForwardDetails(String paramString)
  {
    Connection localConnection = null;
    Statement localStatement = null;
    ResultSet localResultSet = null;
    CarryForwardDB localCarryForwardDB = new CarryForwardDB();
    Calendar localCalendar = Calendar.getInstance();
    String str = "SELECT slcf_status,slcf_apply_carry_forward,slcf_apply_handshake,slcf_approve_carry_forward,slcf_approve_handshake FROM staff_leave_carry_forward WHERE slcf_staff_id='" + paramString + "' AND slcf_leave_year ='" + localCalendar.get(1) + "'";
    try
    {
      localConnection = getConnection();
      localStatement = localConnection.createStatement();
      localResultSet = localStatement.executeQuery(str);
      if (localResultSet.next())
      {
        localCarryForwardDB.setStatus(localResultSet.getString(1));
        localCarryForwardDB.setCarryForwardDays(localResultSet.getInt(2));
        localCarryForwardDB.setHandShakeDays(localResultSet.getInt(3));
        localCarryForwardDB.setApprovedCarryForwarDays(localResultSet.getInt(4));
        localCarryForwardDB.setApprovedHandShakeDays(localResultSet.getInt(5));
      }
    }
    catch (SQLException localSQLException1)
    {
      System.out.println("LeaveLeave(getCarryForwardDetails):" + localSQLException1);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localStatement != null)
          localStatement.close();
        if (localConnection == null);
        localConnection.close();
      }
      catch (SQLException localSQLException2)
      {
        System.out.println(localSQLException2);
      }
    }
    return localCarryForwardDB;
  }

  public int isValidCFPeriod()
  {
    Connection localConnection = null;
    CallableStatement localCallableStatement = null;
    int i = 0;
    localConnection = getConnection();
    try
    {
      localCallableStatement = localConnection.prepareCall("{? =call cmsadmin.leave.isvalidcfperiod() }");
      localCallableStatement.registerOutParameter(1, 2);
      localCallableStatement.execute();
      i = localCallableStatement.getInt(1);
    }
    catch (Exception localException)
    {
      System.out.println("LeaveLeave(isValidCFPeriod):" + localException);
    }
    finally
    {
      try
      {
        if (localCallableStatement != null)
          localCallableStatement.close();
        if (localConnection == null);
        localConnection.close();
      }
      catch (SQLException localSQLException)
      {
        System.out.println(localSQLException);
      }
    }
    return i;
  }
  
  //new added function - ikcm
  public int getLeaveOccurance(String dateFrom, String staffID, String leaveType)
  {
    Connection conn = getConnection();
    PreparedStatement pstmt = null;
    ResultSet rset = null;
    int count = 0;

    try {
    	StringBuilder sb = new StringBuilder("");
    	sb.append("SELECT count(*) FROM staff_leave_detl ");
    	sb.append("WHERE sld_staff_id = ? AND sld_status = 'APPROVE' AND to_char(sld_date_from,'YYYY') = ? ");
    	sb.append("AND sld_leave_type = ?");
    	
    	pstmt = conn.prepareStatement(sb.toString());
    	pstmt.setString(1, staffID);
    	pstmt.setString(2, dateFrom.substring(6, 10));
    	pstmt.setString(3, leaveType);
    	
    	rset = pstmt.executeQuery();
    	if (rset.isBeforeFirst()) {
    		if (rset.next())
    			count = rset.getInt(1);
    	}
    }
    catch (Exception e) {
      System.out.println("LeaveLeave(getLeaveOccurance):" + e.toString());
    }
    finally {
      try {
    	  if (rset != null) rset.close();
    	  if (pstmt != null) pstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException sqle) { }
    }
    return count;
  }

  public int getYearService(String dateFrom, String staffID)
  {
    Connection conn = getConnection();
    PreparedStatement pstmt = null;
    ResultSet rset = null;
    int year = 0;
    
    try {
    	StringBuilder sb = new StringBuilder("");
    	sb.append("SELECT months_between(to_date(?,'dd/mm/yyyy'),sm_join_date)/12 ");
    	sb.append("FROM staff_main WHERE sm_staff_id = ? ");
    	
    	pstmt = conn.prepareStatement(sb.toString());
    	pstmt.setString(1, dateFrom);
    	pstmt.setString(2, staffID);
    	
    	rset = pstmt.executeQuery();
    	if (rset.isBeforeFirst()) {
    		if (rset.next())
    			year = rset.getInt(1);
    	}
    }
    catch (Exception e) {
      System.out.println("LeaveLeave(getLeaveOccurance):" + e.toString());
    }
    finally {
      try {
    	  if (rset != null) rset.close();
    	  if (pstmt != null) pstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException sqle) { }
    }
    return year;
  }

  public boolean isStaffShift(String staffID)
  {
    Connection conn = getConnection();
    PreparedStatement pstmt = null;
    ResultSet rset = null;
    boolean staffShift = false;

    try {
    	StringBuilder sb = new StringBuilder("");
    	sb.append("SELECT count(1) FROM staff_main,service_scheme ");
    	sb.append("WHERE sm_job_code = ss_service_code AND sm_staff_id = ? ");
    	sb.append("AND ss_service_code like 'KP%' AND ss_assessment_category = 'SOKONGAN2'");
    	    		
    	pstmt = conn.prepareStatement(sb.toString());
    	pstmt.setString(1, staffID);
    	
    	rset = pstmt.executeQuery();
    	if (rset.isBeforeFirst()) {
    		if (rset.next())
    			if (rset.getInt(1) > 0)
    				staffShift = true;
    	}
    }
    catch (Exception e) {
    	System.out.println("LeaveLeave(isStaffShift): " + e.toString());
    }
    finally {
      try {
    	  if (rset != null) rset.close();
    	  if (pstmt != null) pstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException sqle) { }
    }
    return staffShift;
  }
/*
  public int calculateWorkingDay_StaffShift(String staffID, String dateFrom, String dateTo)
  {
    Connection conn = getConnection();
    PreparedStatement pstmt = null;
    ResultSet rset = null;
    int noDay = 0;

    try {
    	StringBuilder sb = new StringBuilder("");
    	sb.append("SELECT count(1) FROM security_timetable ");
    	sb.append("WHERE st_staff_id = ? ");
    	sb.append("AND sld_date BETWEEN ");
    	    		
    	pstmt = conn.prepareStatement(sb.toString());
    	pstmt.setString(1, staffID);
    	
    	rset = pstmt.executeQuery();
    	if (rset.isBeforeFirst()) {
    		if (rset.next())
    			noDay = true;
    	}
    }
    catch (Exception e) {
    	System.out.println("LeaveLeave(calculateWorkingDay_StaffShift): " + e.toString());
    }
    finally {
      try {
    	  if (rset != null) rset.close();
    	  if (pstmt != null) pstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException sqle) { }
    }
    return noDay;
  }*/
  
  public List<String> getPanelClinic()
  {
    Connection conn = getConnection();
    PreparedStatement pstmt = null;
    ResultSet rset = null;
    List<String> clinic = new ArrayList<String>();

    try {
    	StringBuilder sb = new StringBuilder("SELECT upper(mc_clinic_desc) FROM medical_clinic ");
    	sb.append("ORDER BY mc_clinic_desc ");
    	    		
    	pstmt = conn.prepareStatement(sb.toString());    	
    	rset = pstmt.executeQuery();
    	if (rset.isBeforeFirst()) {
    		while (rset.next())
    			clinic.add(rset.getString(1));
    	}
    }
    catch (Exception e) {
    	System.out.println("LeaveLeave(getPanelClinic): " + e.toString());
    }
    finally {
      try {
    	  if (rset != null) rset.close();
    	  if (pstmt != null) pstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException sqle) { }
    }
    return clinic;
  }

  public boolean hasLeave(String staffID, String dateFrom, String dateTo)
  {
    Connection conn = getConnection();
    PreparedStatement pstmt = null;
    ResultSet rset = null;
    boolean isExist = false;

    try {
    	StringBuilder sb = new StringBuilder("");
    	sb.append("select count(*) from staff_leave_detl where sld_staff_id = ? ");
    	sb.append("and (to_date(?,'DD/MM/YYYY') between sld_date_from AND sld_date_to ");
    	sb.append("or to_date(?,'DD/MM/YYYY') between sld_date_from AND sld_date_to) ");
    	sb.append("and sld_status NOT IN ('REJECT','CANCEL')");
    	
    	pstmt = conn.prepareStatement(sb.toString());
    	pstmt.setString(1, staffID);
    	pstmt.setString(2, dateFrom);
    	pstmt.setString(3, dateTo);
    	rset = pstmt.executeQuery();
    	if (rset.isBeforeFirst()) {
    		if (rset.next())
    			if (rset.getInt(1) > 0)
    				isExist = true;
    	}
    }
    catch (Exception e) {
    	System.out.println("LeaveLeave(hasLeave): " + e.toString());
    }
    finally {
      try {
    	  if (rset != null) rset.close();
    	  if (pstmt != null) pstmt.close();
    	  if (conn != null) conn.close();
      }
      catch (SQLException sqle) { }
    }
    return isExist;
  }

}