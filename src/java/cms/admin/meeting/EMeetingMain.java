package cms.admin.meeting;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Vector;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.DBConnectionPool;
import common.Messages;

import tvo.TvoDBConnectionPoolFactory;
import tvo.TvoDebug;

public class EMeetingMain extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	private DBConnectionPool dbPool;
	private Messages messages;
	private String userType;
	boolean isSecretary;
	String errorMsg;
	
	static final String SECRETARIAT_CODE = "MR0008";
	static final String SECRETARY_CODE = "MR0002";
  	static final String CHAIRMAN_CODE = "MR0001";
  	static final String MEMBER_CODE = "MR0003";

  public void init(ServletConfig paramServletConfig)
    throws ServletException
  {
    super.init(paramServletConfig);
    System.out.println("EMeetingMain.inti()");
  }

  public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
    doPost(paramHttpServletRequest, paramHttpServletResponse);
  }

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
  }

  public static Hashtable getSingleRole(Connection paramConnection, String paramString1, String paramString2)
  {
    PreparedStatement localPreparedStatement1 = null;
    PreparedStatement localPreparedStatement2 = null;
    ResultSet localResultSet1 = null;
    ResultSet localResultSet2 = null;
    Hashtable localHashtable1 = null;
    String str1 = "SELECT USERID, CMSID, PERSON_NAME, USERTYPE FROM MEETING_ATTENDANCE, CMSUSERS_VIEW WHERE MEETING_ATTENDANCE.MA_STAFF_ID = CMSUSERS_VIEW.CMSID AND MA_MTG_CODE = ? AND MA_ATTD_POSITION = ?";
    String str2 = "SELECT USERID, CMSID, PERSON_NAME, USERTYPE FROM MEETING_ATTENDANCE_OTHER, CMSUSERS_VIEW WHERE MEETING_ATTENDANCE_OTHER.MA_USER_ID = CMSUSERS_VIEW.USERID AND MA_MTG_CODE = ? AND MA_ATTD_POSITION = ?";
    try
    {
      localPreparedStatement1 = paramConnection.prepareStatement(str1);
      localPreparedStatement1.setString(1, paramString1);
      localPreparedStatement1.setString(2, paramString2);
      localResultSet1 = localPreparedStatement1.executeQuery();
      localPreparedStatement2 = paramConnection.prepareStatement(str2);
      localPreparedStatement2.setString(1, paramString1);
      localPreparedStatement2.setString(2, paramString2);
      localResultSet2 = localPreparedStatement2.executeQuery();
      Vector localVector = new Vector();
      Hashtable localHashtable2;
      for (; localResultSet1.next(); localVector.add(localHashtable2))
      {
        localHashtable2 = new Hashtable();
        localHashtable2.put("USERID", localResultSet1.getString("USERID"));
        localHashtable2.put("CMSID", localResultSet1.getString("CMSID"));
        localHashtable2.put("PERSON_NAME", localResultSet1.getString("PERSON_NAME"));
        localHashtable2.put("USERTYPE", localResultSet1.getString("USERTYPE"));
      }
      Hashtable localHashtable3;
      for (; localResultSet2.next(); localVector.add(localHashtable3))
      {
        localHashtable3 = new Hashtable();
        localHashtable3.put("USERID", localResultSet2.getString("USERID"));
        localHashtable3.put("CMSID", localResultSet2.getString("CMSID"));
        localHashtable3.put("PERSON_NAME", localResultSet2.getString("PERSON_NAME"));
        localHashtable3.put("USERTYPE", localResultSet2.getString("USERTYPE"));
      }

      if (localVector.size() == 1)
        localHashtable1 = (Hashtable)localVector.get(0);
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localResultSet1 != null)
          localResultSet1.close();
        if (localResultSet2 != null)
          localResultSet2.close();
        if (localPreparedStatement1 != null)
          localPreparedStatement1.close();
        if (localPreparedStatement2 != null)
          localPreparedStatement2.close();
      } catch (Exception localException2) {
      }
    }
    return localHashtable1;
  }

  public static Hashtable getChairman(Connection paramConnection, String paramString)
  {
    Hashtable localHashtable = getSingleRole(paramConnection, paramString, "MR0001");
    return localHashtable;
  }

  public static Hashtable getSecretary(Connection paramConnection, String paramString)
  {
    return getSingleRole(paramConnection, paramString, "MR0002");
  }

  public static boolean getSecretariat(Connection paramConnection, String paramString)
  {
    return getSecretariat(paramConnection, paramString, "MR0008");
  }

  public static boolean getSecretariatOther(Connection paramConnection, String paramString)
  {
    return getSecretariatOther(paramConnection, paramString, "MR0008");
  }

  public static boolean getSecretariat(Connection paramConnection, String paramString1, String paramString2)
  {
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    boolean flag = false;

    String str = "SELECT count(1) FROM meeting_members WHERE mm_member_mtgtype = 'M000000241' AND mm_member_id = ? AND mm_position = 'MR0008'";
    try
    {
      localPreparedStatement = paramConnection.prepareStatement(str);
      localPreparedStatement.setString(1, paramString1);
      localResultSet = localPreparedStatement.executeQuery();
      if (localResultSet.next())
    	  flag = localResultSet.getInt(1) != 0;
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
      } catch (Exception localException2) {
      }
    }
    return flag;
  }

  public static boolean getSecretariatOther(Connection paramConnection, String paramString1, String paramString2)
  {
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    boolean flag = false;

    String str = "SELECT count(1) FROM meeting_members WHERE mm_member_mtgtype = 'M000000141' AND mm_member_id = ? AND mm_position = 'MR0008'";
    try
    {
      localPreparedStatement = paramConnection.prepareStatement(str);
      localPreparedStatement.setString(1, paramString1);
      localResultSet = localPreparedStatement.executeQuery();
      if (localResultSet.next())
    	  flag = localResultSet.getInt(1) != 0;
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
      } catch (Exception localException2) {
      }
    }
    return flag;
  }

  public boolean checkIfSecretariat(HttpServletRequest paramHttpServletRequest, String paramString1, String paramString2)
  {
    Connection localConnection = null;
    boolean bool = false;
    try
    {
      this.dbPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
      localConnection = this.dbPool.getConnection();
      bool = getSecretariat(localConnection, paramString2);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      this.errorMsg += this.messages.getString("error.console.window");
    }
    finally
    {
      if (this.dbPool != null)
        this.dbPool.returnConnection(localConnection);
    }
    return bool;
  }

  public boolean checkIfSecretariatOther(HttpServletRequest paramHttpServletRequest, String meetingCode, String staffID)
  {
    Connection localConnection = null;
    boolean bool = false;
    try
    {
      this.dbPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
      localConnection = this.dbPool.getConnection();
      bool = getSecretariatOther(localConnection, meetingCode, staffID);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      this.errorMsg += this.messages.getString("error.console.window");
    }
    finally
    {
      if (this.dbPool != null)
        this.dbPool.returnConnection(localConnection);
    }
    return bool;
  }

  public boolean checkIfMeetingSecretariat(HttpServletRequest paramHttpServletRequest, String meetingCode, String staffID)
  {
    Connection localConnection = null;
    boolean bool = false;
    try
    {
      this.dbPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
      localConnection = this.dbPool.getConnection();
      bool = getMeetingSecretariat(localConnection, meetingCode, staffID);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      this.errorMsg += this.messages.getString("error.console.window");
    }
    finally
    {
      if (this.dbPool != null)
        this.dbPool.returnConnection(localConnection);
    }
    return bool;
  }

  public static boolean getMeetingSecretariat(Connection paramConnection, String meetingCode, String memberID)
  {
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    boolean flag = false;

    String str = "SELECT count(1) FROM meeting_attendance WHERE ma_mtg_code = ? AND ma_staff_id = ? AND ma_attd_position = 'MR0008'";
    try
    {
      localPreparedStatement = paramConnection.prepareStatement(str);
      localPreparedStatement.setString(1, meetingCode);
      localPreparedStatement.setString(2, memberID);
      localResultSet = localPreparedStatement.executeQuery();
      if (localResultSet.next())
    	  flag = localResultSet.getInt(1) != 0;
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
      } catch (Exception localException2) {
      }
    }
    return flag;
  }

  public boolean checkIfSecretary(HttpServletRequest paramHttpServletRequest, String meetingCode, String paramString2)
  {
    Connection localConnection = null;
    boolean flag = false;

    try
    {
      this.dbPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
      localConnection = this.dbPool.getConnection();
      Hashtable localHashtable = getSecretary(localConnection, meetingCode);
      if (localHashtable != null)
      {
        String str = (String)localHashtable.get("USERID");
        if (paramString2.equals(str))
        	flag = true;

      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      //this.errorMsg += this.messages.getString("error.console.window");
    }
    finally
    {
      if (this.dbPool != null)
        this.dbPool.returnConnection(localConnection);
    }
    return flag;
  }

  public boolean checkIfSecretary(HttpServletRequest request, HttpServletResponse response, String staffID)
  {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean status = false;
	String sql = null;

	 try
	 {
		  dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
	      con = dbPool.getConnection();
	      con.setAutoCommit(false);
		 
		  sql = "SELECT * FROM MEETING_ATTENDANCE WHERE MA_STAFF_ID = ? AND MA_ATTD_POSITION = ?" ;
		  pstmt = con.prepareStatement(sql);
		  pstmt.clearParameters();
		  pstmt.setString(1,staffID);
		  pstmt.setString(2,"MR0002");	  
		  rs = pstmt.executeQuery();
		  if (rs!=null)
		  {
		     if ( rs.next())
			 {
			  status = true;
			  
			 }
		  
		  	else
		  	{
			  status = false;
		      
			
		  	}	
		  }

	  }
	  
	  catch (SQLException e)
	  {	  e.printStackTrace();
	      // Catch any SQL errors and print a message.
	      errorMsg += messages.getString("error.console.window");
		  System.out.println("Users.add():SQLException: " + e.getMessage() );
	      tvo.TvoDebug.printStackTrace(e);
	   }
		
	   finally
	   {
	      try
	      {
	        if (dbPool != null)
	        	dbPool.returnConnection(con);
	      }
	      catch (Exception e)
	      {
	        // Catch any SQL errors and print a message.
	        tvo.TvoDebug.printStackTrace(e);
	      }
	    }
	    
  
 
  return status;
 
 
  }

  public boolean checkIfArchive(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse, String paramString)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    boolean flag = false;

    Object localObject1 = null;
    try
    {
      if (paramString != null)
      {
        this.dbPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localConnection = this.dbPool.getConnection();
        String str1 = "SELECT MM_MTG_ARCHIVE FROM MEETING_MAIN WHERE MM_MTG_CODE = ?";
        localPreparedStatement = localConnection.prepareStatement(str1);
        localPreparedStatement.clearParameters();
        localPreparedStatement.setString(1, paramString.trim());
        localResultSet = localPreparedStatement.executeQuery();
        if (localResultSet.next())
        {
          String str2 = localResultSet.getString(1);
          if ((str2 != null) && (str2.equals("Y")))
        	  flag = true;
          else
        	  flag = false;
        }
      }
    }
    catch (SQLException localSQLException)
    {
      localSQLException.printStackTrace();
      this.errorMsg += this.messages.getString("error.console.window");
      TvoDebug.printStackTrace(localSQLException);
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (this.dbPool != null)
          this.dbPool.returnConnection(localConnection);
      }
      catch (Exception localException)
      {
        TvoDebug.printStackTrace(localException);
      }
    }
    return flag;
  }
}