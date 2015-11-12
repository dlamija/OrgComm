package cms.leave;

import common.*;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import javax.servlet.GenericServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tvo.TvoDBConnectionPoolFactory;
import tvo.TvoDebug;

/**
 * @web.servlet name = "Leave_upload"
 * @web.servlet-mapping url-pattern = "/Leave_upload"
 */
public class Leave_upload extends HttpServlet
{

    private DBConnectionPool dbPool;
    private Messages messages;
    private HttpSession session;

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
        System.out.println("Leave.init()");
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        doPost(httpservletrequest, httpservletresponse);
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        String s = null;
        messages = Messages.getMessages(httpservletrequest);
        session = httpservletrequest.getSession(true);
        if(httpservletrequest.getParameter("action").equals("approveSubmit"))
            s = approve(httpservletrequest, httpservletresponse);
        else
        if(httpservletrequest.getParameter("action").equals("rejectSubmit"))
            s = reject(httpservletrequest, httpservletresponse);
        else
        if(httpservletrequest.getParameter("action").equals("approveOvertime"))
            s = approveOvertime(httpservletrequest, httpservletresponse);
        if(s != "")
            CommonFunction.printAlert(httpservletrequest, httpservletresponse, s, httpservletrequest.getHeader("Referer"));
        else
            CommonFunction.printAlert(httpservletrequest, httpservletresponse, "", httpservletrequest.getHeader("Referer"));
    }

    private String getD(java.sql.Date date)
    {
        int i = date.getYear() + 1900;
        int j = date.getMonth() + 1;
        int k = date.getDate();
        String s = k >= 10 ? Integer.toString(k) : "0" + Integer.toString(k);
        String s1 = s + "/" + j + "/" + i;
        return s1;
    }

    public synchronized String approve(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
        Connection connection = null;
        PreparedStatement preparedstatement = null;
        PreparedStatement preparedstatement1 = null;
        Statement statement = null;
        ResultSet resultset = null;
        ResultSet resultset1 = null;
        ResultSet resultset2 = null;
        CallableStatement callablestatement = null;
        String s = "";
        String as[] = httpservletrequest.getParameterValues("approve");
        boolean flag = false;
        String s1 = "";
        String s3 = "";
        String s5 = "";
        String as1[] = new String[1];
        String s7 = "Select userid from CMSUSERS_VIEW where cmsid=?";
        String s8 = (String)session.getAttribute("staffid");
        if(as == null)
        {
            s = "None selected.";
            return s;
        }
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(httpservletrequest);
            connection = dbPool.getConnection();
            preparedstatement = connection.prepareStatement(s7);
            preparedstatement.setString(1, s8);
            resultset = preparedstatement.executeQuery();
            resultset.next();
            String s2 = resultset.getString(1);
            preparedstatement.close();
            resultset.close();
            if(s.equals(""))
            {
                for(int k = 0; k < as.length; k++)
                {
                    String s9 = "select * from cmsadmin.staff_leave_detl where sld_ref_id='" + as[k] + "'";
                    statement = connection.createStatement();
                    resultset1 = statement.executeQuery(s9);
                    resultset1.next();
                    String s4 = resultset1.getString("sld_staff_id");
                    preparedstatement1 = connection.prepareStatement(s7);
                    preparedstatement1.setString(1, s4);
                    resultset2 = preparedstatement1.executeQuery();
                    resultset2.next();
                    String s6 = resultset2.getString(1);
                    as1[0] = s6;
                    preparedstatement1.close();
                    resultset2.close();
                    if(resultset1.getString("sld_status") != null && (resultset1.getString("sld_status").equals("RECOMMEND") || resultset1.getString("sld_status").equals("APPLY")))
                    {
                        callablestatement = connection.prepareCall("{? = call cmsadmin.leave.approveleave(?,?,?)}");
                        callablestatement.registerOutParameter(1, 2);
                        callablestatement.setString(2, as[k]);
                        callablestatement.setString(3, resultset1.getString("SLD_SUBSTITUTE"));
                        callablestatement.registerOutParameter(4, 12);
                        callablestatement.executeUpdate();
                        int i = callablestatement.getInt(1);
                        String s10 = callablestatement.getString(4);
                        if(i == 0)
                        {
                            s = s10;
                            String s12 = s;
                            return s12;
                        }
                        String s13 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                        String s16 = "Your Leave Approved From " + getD(resultset1.getDate("sld_date_from")) + " To " + getD(resultset1.getDate("sld_date_to"));
                        String s18 = "Leave Approve";
                        CommonFunction.writeToMemo(connection, as1, s2, s16, s13, "FYI,", s18);
                    } else
                    {
                        callablestatement = connection.prepareCall("{? = call cmsadmin.leave.ApproveCancelAnnualLeave(?,?)}");
                        callablestatement.registerOutParameter(1, 2);
                        callablestatement.setString(2, as[k]);
                        callablestatement.registerOutParameter(3, 12);
                        callablestatement.executeUpdate();
                        int j = callablestatement.getInt(1);
                        String s11 = callablestatement.getString(3);
                        if(j == 0)
                        {
                            s = s11;
                            String s14 = s;
                            return s14;
                        }
                        String s15 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                        String s17 = "Your Leave Canceled From " + getD(resultset1.getDate("sld_date_from")) + " To " + getD(resultset1.getDate("sld_date_to"));
                        String s19 = "Leave Cancel";
                        CommonFunction.writeToMemo(connection, as1, s2, s17, s15, "FYI,", s19);
                    }
                }

            }
        }
        catch(Exception exception)
        {
            s = s + messages.getString("error.console.window");
            System.out.println("Leave.Approve():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally
        {
            try
            {
                if(resultset1 != null)
                    resultset1.close();
                if(resultset != null)
                    resultset.close();
                if(resultset2 != null)
                    resultset2.close();
                if(preparedstatement != null)
                    preparedstatement.close();
                if(preparedstatement1 != null)
                    preparedstatement1.close();
                if(statement != null)
                    statement.close();
                if(callablestatement != null)
                    callablestatement.close();
                dbPool.returnConnection(connection);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String reject(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
        Connection connection = null;
        PreparedStatement preparedstatement = null;
        PreparedStatement preparedstatement1 = null;
        Statement statement = null;
        ResultSet resultset = null;
        ResultSet resultset1 = null;
        ResultSet resultset2 = null;
        Object obj = null;
        String s = "";
        String as[] = httpservletrequest.getParameterValues("approve");
        boolean flag = false;
        String s1 = "";
        String s3 = "";
        String s5 = "";
        String as1[] = new String[1];
        String s7 = "Select userid from CMSUSERS_VIEW where cmsid=?";
        String s8 = (String)session.getAttribute("staffid");
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(httpservletrequest);
            connection = dbPool.getConnection();
            preparedstatement = connection.prepareStatement(s7);
            preparedstatement.setString(1, s8);
            resultset = preparedstatement.executeQuery();
            resultset.next();
            String s2 = resultset.getString(1);
            preparedstatement.close();
            resultset.close();
            if(s.equals(""))
            {
                for(int j = 0; j < as.length; j++)
                {
                    String s9 = "select * from cmsadmin.staff_leave_detl where sld_ref_id='" + as[j] + "'";
                    statement = connection.createStatement();
                    resultset1 = statement.executeQuery(s9);
                    resultset1.next();
                    String s4 = resultset1.getString("sld_staff_id");
                    preparedstatement1 = connection.prepareStatement(s7);
                    preparedstatement1.setString(1, s4);
                    resultset2 = preparedstatement1.executeQuery();
                    resultset2.next();
                    String s6 = resultset2.getString(1);
                    as1[0] = s6;
                    preparedstatement1.close();
                    resultset2.close();
                    CallableStatement callablestatement = connection.prepareCall("{? = call CMSADMIN.Leave.rejectleave(?,?,?)}");
                    callablestatement.registerOutParameter(1, 2);
                    callablestatement.setString(2, as[j]);
                    callablestatement.setString(3, "");
                    callablestatement.registerOutParameter(4, 12);
                    callablestatement.executeUpdate();
                    int i = callablestatement.getInt(1);
                    if(i == 0)
                    {
                        s = callablestatement.getString(4);
                        String s10 = s;
                        return s10;
                    }
                    String s11 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                    String s12 = "Your Leave Rejected From " + getD(resultset1.getDate("sld_date_from")) + " To " + getD(resultset1.getDate("sld_date_to"));
                    String s13 = "Leave Reject";
                    CommonFunction.writeToMemo(connection, as1, s2, s12, s11, "FYI,", s13);
                }

                resultset1.close();
                statement.close();
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
        }
        catch(Exception exception)
        {
            s = s + messages.getString("error.console.window");
            System.out.println("Leave.Reject():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally
        {
            try
            {
                if(resultset1 != null)
                    resultset1.close();
                if(resultset != null)
                    resultset.close();
                if(resultset2 != null)
                    resultset2.close();
                if(preparedstatement != null)
                    preparedstatement.close();
                if(preparedstatement1 != null)
                    preparedstatement1.close();
                if(statement != null)
                    statement.close();
                dbPool.returnConnection(connection);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String approveOvertime(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
        Connection connection = null;
        PreparedStatement preparedstatement = null;
        PreparedStatement preparedstatement1 = null;
        Statement statement = null;
        ResultSet resultset = null;
        ResultSet resultset1 = null;
        ResultSet resultset2 = null;
        Object obj = null;
        String s = "";
        String as[] = httpservletrequest.getParameterValues("approve");
        boolean flag = false;
        String s1 = "";
        String s3 = "";
        String s5 = "";
        String as1[] = new String[1];
        String s7 = "Select userid from CMSUSERS_VIEW where cmsid=?";
        String s8 = (String)session.getAttribute("staffid");
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(httpservletrequest);
            connection = dbPool.getConnection();
            preparedstatement = connection.prepareStatement(s7);
            preparedstatement.setString(1, s8);
            resultset = preparedstatement.executeQuery();
            resultset.next();
            String s2 = resultset.getString(1);
            preparedstatement.close();
            resultset.close();
            if(s.equals(""))
            {
                for(int j = 0; j < as.length; j++)
                {
                    String s9 = "select * from cmsadmin.staff_leave_overtime where slo_ref_id='" + as[j] + "'";
                    statement = connection.createStatement();
                    resultset1 = statement.executeQuery(s9);
                    resultset1.next();
                    String s4 = resultset1.getString("slo_staff_id");
                    preparedstatement1 = connection.prepareStatement(s7);
                    preparedstatement1.setString(1, s4);
                    resultset2 = preparedstatement1.executeQuery();
                    resultset2.next();
                    String s6 = resultset2.getString(1);
                    as1[0] = s6;
                    preparedstatement1.close();
                    resultset2.close();
                    CallableStatement callablestatement = connection.prepareCall("{? = call cmsadmin.leave.approveStaffLeaveOvertime(?,?)}");
                    callablestatement.registerOutParameter(1, 2);
                    callablestatement.setString(2, as[j]);
                    callablestatement.registerOutParameter(3, 12);
                    callablestatement.executeUpdate();
                    int i = callablestatement.getInt(1);
                    String s10 = callablestatement.getString(3);
                    if(i == 0)
                    {
                        s = s10;
                        String s11 = s;
                        return s11;
                    }
                    String s12 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                    String s13 = "Your Overtime Approved For :" + getD(resultset1.getDate("slo_date"));
                    String s14 = "Overtime Approve";
                    CommonFunction.writeToMemo(connection, as1, s2, s13, s12, "FYI,", s14);
                }

            }
        }
        catch(Exception exception)
        {
            s = s + messages.getString("error.console.window");
            System.out.println("Leave.approveOvertime():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally
        {
            try
            {
                if(preparedstatement != null)
                    preparedstatement.close();
                if(preparedstatement1 != null)
                    preparedstatement1.close();
                if(statement != null)
                    statement.close();
                if(resultset1 != null)
                    resultset1.close();
                if(resultset != null)
                    resultset.close();
                if(resultset2 != null)
                    resultset2.close();
            }
            catch(Exception exception2)
            {
                TvoDebug.printStackTrace(exception2);
            }
            finally
            {
                dbPool.returnConnection(connection);
            }
        }
        return s;
    }

}