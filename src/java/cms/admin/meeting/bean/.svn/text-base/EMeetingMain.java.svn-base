package cms.admin.meeting.bean;

import java.io.IOException;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.GenericServlet;
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
  private DBConnectionPool dbPool;
  private Messages messages;
  private String userType;
  boolean isSecretary;
  String errorMsg;

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

  public boolean checkIfSecretary(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse, String paramString)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    boolean flag = false;

    String str = null;
    try
    {
      this.dbPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
      localConnection = this.dbPool.getConnection();
      localConnection.setAutoCommit(false);

      str = "SELECT * FROM MEETING_ATTENDANCE WHERE MA_STAFF_ID = ?  AND MA_ATTD_POSITION = ? ";

      localPreparedStatement = localConnection.prepareStatement(str);
      localPreparedStatement.clearParameters();
      localPreparedStatement.setString(1, paramString);
      localPreparedStatement.setString(2, "MR0002");
      localResultSet = localPreparedStatement.executeQuery();
      if (localResultSet != null)
      {
        if (localResultSet.next())
        	flag = true;
        else
        	flag = false;
      }

    }
    catch (SQLException localSQLException)
    {
      this.errorMsg += this.messages.getString("error.console.window");
      System.out.println("Users.add():SQLException: " + localSQLException.getMessage());
      TvoDebug.printStackTrace(localSQLException);
    }
    finally
    {
      try
      {
        if (this.dbPool != null) {
          this.dbPool.returnConnection(localConnection);
        }
      }
      catch (Exception localException)
      {
        TvoDebug.printStackTrace(localException);
      }
    }

    return flag;
  }
}