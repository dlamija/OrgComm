package cms.leave;

import common.*;
import hr.HRConstant;

import java.io.IOException;
import java.sql.*;
import java.util.Calendar;
import javax.servlet.*;
import javax.servlet.http.*;
import tvo.TvoDBConnectionPoolFactory;
import tvo.TvoDebug;
import cms.leave.LeaveLeave;

/**
 * @web.servlet name = "Leave"
 * @web.servlet-mapping url-pattern = "/Leave"
 */

public class Leave extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	private DBConnectionPool dbPool;
    private Messages messages;
    private HttpSession session;

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
        System.out.println("Leave.init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String errMsg = null;
        messages = Messages.getMessages(request);
        session = request.getSession(true);
        if(request.getParameter("action").equals("approveSubmit") || request.getParameter("action").equals("approve"))
        	errMsg = approve(request, response);
        else
        if (request.getParameter("action").equals("approveCancelSubmit") || request.getParameter("action").equals("approve_cancel"))
        	errMsg = approve_cancel(request, response);
        else
        if(request.getParameter("action").equals("rejectSubmit") || request.getParameter("action").equals("reject"))
        	errMsg = reject(request, response);
        else
        if(request.getParameter("action").equals("approveOvertime") || request.getParameter("action").equals("appovertime"))
        	errMsg = approveOvertime(request, response);
        else
        if(request.getParameter("action").equals("leaveApply"))
        	errMsg = applyLeave(request, response);
        else
        if(request.getParameter("action").equals("cancel"))
        	errMsg = cancelLeave(request, response);
        else
        if(request.getParameter("action").equals("overtimeApply"))
        	errMsg = applyOvertime(request, response);
        else
        if(request.getParameter("action").equals("recommend"))
        	errMsg = recommend(request, response);
        else
        if(request.getParameter("action").equals("rejectcancel"))
        	errMsg = rejectcancel(request, response);
        else
        if(request.getParameter("action").equals("recommend_reject"))
        	errMsg = recommend_reject(request, response);
        else
        if(request.getParameter("action").equals("recommendOvertime"))
        	errMsg = recommendOvertime(request, response);
        else
        if(request.getParameter("action").equals("rejectOvertime"))
        	errMsg = rejectOvertime(request, response);
        else
        if(request.getParameter("action").equals("applyCarryForward"))
        	errMsg = applyCarryForwardLeave(request, response);
        
        if(errMsg != "" && errMsg != null)
            CommonFunction.printAlert(request, response, errMsg, request.getHeader("Referer"));
        else
        if(request.getParameter("action").equals("approve"))
            CommonFunction.printAlert(request, response, "Leave Approved", "leaveMain.jsp?action=approvelist");
        else
        if(request.getParameter("action").equals("approve_cancel"))
            CommonFunction.printAlert(request, response, "Cancel Leave Approved", "leaveMain.jsp?action=approvelist");
        else
        if(request.getParameter("action").equals("approveCancelSubmit"))
            CommonFunction.printAlert(request, response, "Cancel Leave Approved", "leaveMain.jsp?action=approvelist&module=cancel");
        else
       	if(request.getParameter("action").equals("appovertime"))
            CommonFunction.printAlert(request, response, "Overtime Approved", "leaveMain.jsp?action=approvelist&module=overtime");
        else
       	if(request.getParameter("action").equals("approveOvertime"))
            CommonFunction.printAlert(request, response, "Overtime Approved", "leaveMain.jsp?action=approvelist&module=overtime");
        else
        if(request.getParameter("action").equals("reject"))
            CommonFunction.printAlert(request, response, "Leave Rejected", "leaveMain.jsp?action=approvelist&module=leave");
        else
        if(request.getParameter("action").equals("rejectcancel"))
            CommonFunction.printAlert(request, response, "Leave Rejected", "leaveMain.jsp?action=approvelist");
        else
        if(request.getParameter("action").equals("recommend_reject"))
            CommonFunction.printAlert(request, response, "Leave Rejected", "leaveMain.jsp?action=reclist");
        else
        if(request.getParameter("action").equals("leaveApply"))
            CommonFunction.printAlert(request, response, "Leave Forwarded!", "leaveMain.jsp?action=view");
        else
        if(request.getParameter("action").equals("overtimeApply"))
            CommonFunction.printAlert(request, response, "Overtime Details Forwarded!", "leaveMain.jsp?action=view");
        else
        if(request.getParameter("action").equals("cancel"))
            CommonFunction.printAlert(request, response, "Leave Canceled!", "leaveMain.jsp?action=view");
        else
        if(request.getParameter("action").equals("recommend"))
            CommonFunction.printAlert(request, response, "Leave Recommended!", "leaveMain.jsp?action=reclist");
        else
        if(request.getParameter("action").equals("recommendOvertime"))
            CommonFunction.printAlert(request, response, "Overtime Recommended!", "leaveMain.jsp?action=reclist");
        else
        if(request.getParameter("action").equals("rejectOvertime"))
            CommonFunction.printAlert(request, response, "Overtime Leave Rejected", "leaveMain.jsp?action=approvelist&module=overtime");
        else
            CommonFunction.printAlert(request, response, "", request.getHeader("Referer"));
    }

    private String getIntranetUserID(String s, HttpServletRequest request)
    {
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rset = null;
        String s1 = "";
        String s2 = "SELECT USERID FROM CMSUSERS_VIEW WHERE CMSID=?";
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            pstmt = conn.prepareStatement(s2);
            pstmt.setString(1, s);
            rset = pstmt.executeQuery();
            rset.next();
            s1 = rset.getString(1);
        }
        catch(Exception exception)
        {
            System.out.println("Leave(getTMSUserID):" + exception);
        }
        finally
        {
            try
            {
                if(rset != null)
                    rset.close();
                if(pstmt != null)
                    pstmt.close();
            }
            catch(Exception exception2)
            {
                System.out.println(exception2);
            }
            finally
            {
                dbPool.returnConnection(conn);
            }
        }
        return s1;
    }

    private String getCFApproverID(HttpServletRequest request)
    {
        Statement statement = null;
        Connection conn = null;
        ResultSet rset = null;
        String s = "";
        String s1 = "SELECT HP_PARM_DESC FROM CMSADMIN.HRADMIN_PARMS WHERE HP_PARM_CODE = 'LEAVE_CF_APPROVE_BY'";
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            statement = conn.createStatement();
            rset = statement.executeQuery(s1);
            if(rset.next())
                s = rset.getString(1);
        }
        catch(Exception exception)
        {
            System.out.println("Leave(getCFApproverID):" + exception);
        }
        finally
        {
            try
            {
                if(rset != null)
                    rset.close();
                if(statement != null)
                    statement.close();
            }
            catch(Exception exception2)
            {
                System.out.println(exception2);
            }
            finally
            {
                dbPool.returnConnection(conn);
            }
        }
        return s;
    }

    private String getHOD(String s, HttpServletRequest request)
    {
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rset = null;
        String s1 = "";
        String s2 = "SELECT DM_DIRECTOR FROM CMSADMIN.DEPARTMENT_MAIN, CMSADMIN.STAFF_MAIN WHERE SM_DEPT_CODE = DM_DEPT_CODE AND SM_STAFF_ID = ? ";
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            pstmt = conn.prepareStatement(s2);
            pstmt.setString(1, s);
            rset = pstmt.executeQuery();
            rset.next();
            s1 = rset.getString(1);
        }
        catch(Exception exception)
        {
            System.out.println("Leave(getHOD):" + exception);
        }
        finally
        {
            try
            {
                if(rset != null)
                    rset.close();
                if(pstmt != null)
                    pstmt.close();
            }
            catch(Exception exception2)
            {
                System.out.println(exception2);
            }
            finally
            {
                dbPool.returnConnection(conn);
            }
        }
        return s1;
    }

    public synchronized String approve(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        Statement statement = null;
        ResultSet rset = null;
        ResultSet rset1 = null;
        ResultSet rset2 = null;
        CallableStatement cstmt = null;
        String s = "";
        String as[] = request.getParameterValues("approve");

        String as1[] = new String[1];
        String as2[] = new String[1];
        String s4 = "Select userid from CMSUSERS_VIEW where cmsid=?";
        String s5 = (String)session.getAttribute("staffid");
        if(as == null)
        {
            s = "None selected.";
            return s;
        }
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            pstmt = conn.prepareStatement(s4);
            pstmt.setString(1, s5);
            rset = pstmt.executeQuery();
            rset.next();
            String s6 = rset.getString(1);
            pstmt.close();
            rset.close();
            if(s.equals(""))
            {
                for(int i = 0; i < as.length; i++)
                {
                    String s7 = "select * from cmsadmin.staff_leave_detl where sld_ref_id='" + as[i] + "'";
                    statement = conn.createStatement();
                    rset1 = statement.executeQuery(s7);
                    rset1.next();
                    String s8 = rset1.getString("sld_staff_id");
                    String s9 = getHOD(s8, request);
                    pstmt1 = conn.prepareStatement(s4);
                    pstmt1.setString(1, s8);
                    rset2 = pstmt1.executeQuery();
                    rset2.next();
                    String s10 = rset2.getString(1);
                    as2[0] = s10;
                    pstmt1.close();
                    rset2.close();
                    PreparedStatement pstmt2 = conn.prepareStatement(s4);
                    pstmt2.setString(1, s9);
                    ResultSet rset3 = pstmt2.executeQuery();
                    rset3.next();
                    String s11 = rset3.getString(1);
                    as1[0] = s11;
                    pstmt2.close();
                    rset3.close();
                    cstmt = conn.prepareCall("{? = call cmsadmin.leave.approveleave(?,?,?)}");
                    cstmt.registerOutParameter(1, 2);
                    cstmt.setString(2, as[i]);
                    cstmt.setString(3, rset1.getString("SLD_SUBSTITUTE"));
                    cstmt.registerOutParameter(4, 12);
                    cstmt.executeUpdate();
                    int j = cstmt.getInt(1);
                    String s12 = cstmt.getString(4);
                    if(j == 0)
                    {
                        s = s12;
                        String s13 = s;
                        String s15 = s13;
                        String s17 = s15;
                        String s19 = s17;
                        String s20 = s19;
                        String s21 = s20;
                        String s22 = s21;
                        String s23 = s22;
                        String s24 = s23;
                        return s24;
                    }
                    String s14 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                    String s16 = "Your Leave Approved From " + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("sld_date_from").substring(0, 10)) + " To " + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("sld_date_to").substring(0, 10));
                    String s18 = "Leave Approve";
                    CommonFunction.writeToMemoCc(conn, as2, as1, s6, s16, s14, "FYI,", s18);
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
                if(rset1 != null)
                    rset1.close();
                if(rset != null)
                    rset.close();
                if(rset2 != null)
                    rset2.close();
                if(pstmt != null)
                    pstmt.close();
                if(pstmt1 != null)
                    pstmt1.close();
                if(statement != null)
                    statement.close();
                if(cstmt != null)
                    cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String approve_cancel(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        Statement statement = null;
        ResultSet rset = null;
        ResultSet rset1 = null;
        ResultSet rset2 = null;
        CallableStatement cstmt = null;
        String s = "";
        String as[] = request.getParameterValues("approve");

        String as1[] = new String[1];
        String as2[] = new String[1];
        String s4 = "Select userid from CMSUSERS_VIEW where cmsid=?";
        String s5 = (String)session.getAttribute("staffid");
        if(as == null)
        {
            s = "None selected.";
            return s;
        }
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            pstmt = conn.prepareStatement(s4);
            pstmt.setString(1, s5);
            rset = pstmt.executeQuery();
            rset.next();
            String s6 = rset.getString(1);
            pstmt.close();
            rset.close();
            if(s.equals(""))
            {
                for(int i = 0; i < as.length; i++)
                {
                    String s7 = "select * from cmsadmin.staff_leave_detl where sld_ref_id='" + as[i] + "'";
                    statement = conn.createStatement();
                    rset1 = statement.executeQuery(s7);
                    rset1.next();
                    String s8 = rset1.getString("sld_staff_id");
                    String s9 = getHOD(s8, request);
                    pstmt1 = conn.prepareStatement(s4);
                    pstmt1.setString(1, s8);
                    rset2 = pstmt1.executeQuery();
                    rset2.next();
                    String s10 = rset2.getString(1);
                    as2[0] = s10;
                    pstmt1.close();
                    rset2.close();
                    PreparedStatement pstmt2 = conn.prepareStatement(s4);
                    pstmt2.setString(1, s9);
                    ResultSet rset3 = pstmt2.executeQuery();
                    rset3.next();
                    String s11 = rset3.getString(1);
                    as1[0] = s11;
                    pstmt2.close();
                    rset3.close();
                    cstmt = conn.prepareCall("{? = call cmsadmin.leave.ApproveCancelAnnualLeave(?,?)}");
                    cstmt.registerOutParameter(1, 2);
                    cstmt.setString(2, as[i]);
                    cstmt.registerOutParameter(3, 12);
                    cstmt.executeUpdate();
                    int j = cstmt.getInt(1);
                    String s12 = cstmt.getString(3);
                    if(j == 0)
                    {
                        s = s12;
                        String s13 = s;
                        String s15 = s13;
                        String s17 = s15;
                        String s19 = s17;
                        String s20 = s19;
                        String s21 = s20;
                        String s22 = s21;
                        String s23 = s22;
                        String s24 = s23;
                        return s24;
                    }
                    String s14 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                    String s16 = "Your Leave Canceled From " + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("sld_date_from").substring(0, 10)) + " To " + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("sld_date_to").substring(0, 10));
                    String s18 = "Leave Cancel";
                    CommonFunction.writeToMemo(conn, as2, s6, s16, s14, "FYI,", s18);
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
                if(rset1 != null)
                    rset1.close();
                if(rset != null)
                    rset.close();
                if(rset2 != null)
                    rset2.close();
                if(pstmt != null)
                    pstmt.close();
                if(pstmt1 != null)
                    pstmt1.close();
                if(statement != null)
                    statement.close();
                if(cstmt != null)
                    cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String reject(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        Statement statement = null;
        ResultSet rset = null;
        ResultSet rset1 = null;
        ResultSet rset2 = null;
        CallableStatement cstmt = null;
        String s = "";
        String as[] = request.getParameterValues("approve");
        String s1 = request.getParameter("reason");
        if(s1 == null)
            s1 = "";
        boolean flag = false;
        String s2 = "";
        String s3 = "";
        String s4 = "";
        String as1[] = new String[1];
        String s5 = "Select userid from CMSUSERS_VIEW where cmsid=?";
        String s6 = (String)session.getAttribute("staffid");
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            pstmt = conn.prepareStatement(s5);
            pstmt.setString(1, s6);
            rset = pstmt.executeQuery();
            rset.next();
            String s7 = rset.getString(1);
            pstmt.close();
            rset.close();
            if(s.equals(""))
            {
                for(int i = 0; i < as.length; i++)
                {
                    String s8 = "select * from cmsadmin.staff_leave_detl where sld_ref_id='" + as[i] + "'";
                    statement = conn.createStatement();
                    rset1 = statement.executeQuery(s8);
                    rset1.next();
                    String s9 = rset1.getString("sld_staff_id");
                    pstmt1 = conn.prepareStatement(s5);
                    pstmt1.setString(1, s9);
                    rset2 = pstmt1.executeQuery();
                    rset2.next();
                    String s10 = rset2.getString(1);
                    as1[0] = s10;
                    pstmt1.close();
                    rset2.close();
                    cstmt = conn.prepareCall("{? = call CMSADMIN.Leave.RejectLeave(?,?,?)}");
                    cstmt.registerOutParameter(1, 2);
                    cstmt.setString(2, as[i]);
                    cstmt.setString(3, s1);
                    cstmt.registerOutParameter(4, 12);
                    cstmt.executeUpdate();
                    int j = cstmt.getInt(1);
                    if(j == 0)
                    {
                        s = cstmt.getString(4);
                        String s11 = s;
                        String s13 = s11;
                        String s15 = s13;
                        String s17 = s15;
                        String s18 = s17;
                        String s19 = s18;
                        String s20 = s19;
                        String s21 = s20;
                        String s22 = s21;
                        return s22;
                    }
                    String s12 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                    String s14 = "Your Leave Rejected From " + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("sld_date_from").substring(0, 10)) + " To " + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("sld_date_to").substring(0, 10));
                    String s16 = "Leave Reject";
                    CommonFunction.writeToMemo(conn, as1, s7, s14, s12, "FYI,", s16);
                }

                rset1.close();
                statement.close();
                cstmt.close();
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
                if(rset1 != null)
                    rset1.close();
                if(rset != null)
                    rset.close();
                if(rset2 != null)
                    rset2.close();
                if(pstmt != null)
                    pstmt.close();
                if(pstmt1 != null)
                    pstmt1.close();
                if(statement != null)
                    statement.close();
                cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String rejectcancel(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        Statement statement = null;
        ResultSet rset = null;
        ResultSet rset1 = null;
        ResultSet rset2 = null;
        CallableStatement cstmt = null;
        String s = "";
        String as[] = request.getParameterValues("approve");
        String s1 = request.getParameter("reason");
        if(s1 == null)
            s1 = "";
        boolean flag = false;
        String s2 = "";
        String s3 = "";
        String s4 = "";
        String as1[] = new String[1];
        String s5 = "Select userid from CMSUSERS_VIEW where cmsid=?";
        String s6 = (String)session.getAttribute("staffid");
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            pstmt = conn.prepareStatement(s5);
            pstmt.setString(1, s6);
            rset = pstmt.executeQuery();
            rset.next();
            String s7 = rset.getString(1);
            pstmt.close();
            rset.close();
            if(s.equals(""))
            {
                for(int i = 0; i < as.length; i++)
                {
                    String s8 = "select * from cmsadmin.staff_leave_detl where sld_ref_id='" + as[i] + "'";
                    statement = conn.createStatement();
                    rset1 = statement.executeQuery(s8);
                    rset1.next();
                    String s9 = rset1.getString("sld_staff_id");
                    pstmt1 = conn.prepareStatement(s5);
                    pstmt1.setString(1, s9);
                    rset2 = pstmt1.executeQuery();
                    rset2.next();
                    String s10 = rset2.getString(1);
                    as1[0] = s10;
                    pstmt1.close();
                    rset2.close();
                    cstmt = conn.prepareCall("{? = call CMSADMIN.Leave.RejectCancelLeave(?,?,?)}");
                    cstmt.registerOutParameter(1, 2);
                    cstmt.setString(2, as[i]);
                    cstmt.setString(3, s1);
                    cstmt.registerOutParameter(4, 12);
                    cstmt.executeUpdate();
                    int j = cstmt.getInt(1);
                    if(j == 0)
                    {
                        s = cstmt.getString(4);
                        String s11 = s;
                        String s13 = s11;
                        String s15 = s13;
                        String s17 = s15;
                        String s18 = s17;
                        String s19 = s18;
                        String s20 = s19;
                        String s21 = s20;
                        String s22 = s21;
                        return s22;
                    }
                    String s12 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                    String s14 = "Your Leave Rejected From " + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("sld_date_from").substring(0, 10)) + " To " + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("sld_date_to").substring(0, 10));
                    String s16 = "Leave Reject";
                    CommonFunction.writeToMemo(conn, as1, s7, s14, s12, "FYI,", s16);
                }

                rset1.close();
                statement.close();
                cstmt.close();
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
                if(rset1 != null)
                    rset1.close();
                if(rset != null)
                    rset.close();
                if(rset2 != null)
                    rset2.close();
                if(pstmt != null)
                    pstmt.close();
                if(pstmt1 != null)
                    pstmt1.close();
                if(statement != null)
                    statement.close();
                cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String approveOvertime(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        Statement statement = null;
        ResultSet rset = null;
        ResultSet rset1 = null;
        ResultSet rset2 = null;
        Object obj = null;
        String s = "";
        String as[] = request.getParameterValues("approve");
        boolean flag = false;
        String s1 = "";
        String s2 = "";
        String s3 = "";
        String as1[] = new String[1];
        String s4 = "Select userid from CMSUSERS_VIEW where cmsid=?";
        String s5 = (String)session.getAttribute("staffid");
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            pstmt = conn.prepareStatement(s4);
            pstmt.setString(1, s5);
            rset = pstmt.executeQuery();
            rset.next();
            String s6 = rset.getString(1);
            pstmt.close();
            rset.close();
            if(s.equals(""))
            {
                for(int i = 0; i < as.length; i++)
                {
                    String s7 = "select * from cmsadmin.staff_leave_overtime where slo_ref_id='" + as[i] + "'";
                    statement = conn.createStatement();
                    rset1 = statement.executeQuery(s7);
                    rset1.next();
                    String s8 = rset1.getString("slo_staff_id");
                    pstmt1 = conn.prepareStatement(s4);
                    pstmt1.setString(1, s8);
                    rset2 = pstmt1.executeQuery();
                    rset2.next();
                    String s9 = rset2.getString(1);
                    as1[0] = s9;
                    pstmt1.close();
                    rset2.close();
                    CallableStatement cstmt = conn.prepareCall("{? = call cmsadmin.leave.approveStaffLeaveOvertime(?,?)}");
                    cstmt.registerOutParameter(1, 2);
                    cstmt.setString(2, as[i]);
                    cstmt.registerOutParameter(3, 12);
                    cstmt.executeUpdate();
                    int j = cstmt.getInt(1);
                    String s10 = cstmt.getString(3);
                    if(j == 0)
                    {
                        s = s10;
                        String s11 = s;
                        String s13 = s11;
                        String s15 = s13;
                        String s17 = s15;
                        String s18 = s17;
                        String s19 = s18;
                        String s20 = s19;
                        String s21 = s20;
                        String s22 = s21;
                        return s22;
                    }
                    String s12 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                    String s14 = "Your Overtime Approved For :" + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("slo_date").substring(0, 10));
                    String s16 = "Overtime Approve";
                    CommonFunction.writeToMemo(conn, as1, s6, s14, s12, "FYI,", s16);
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
                if(pstmt != null)
                    pstmt.close();
                if(pstmt1 != null)
                    pstmt1.close();
                if(statement != null)
                    statement.close();
                if(rset1 != null)
                    rset1.close();
                if(rset != null)
                    rset.close();
                if(rset2 != null)
                    rset2.close();
            }
            catch(Exception exception2)
            {
                TvoDebug.printStackTrace(exception2);
            }
            finally
            {
                dbPool.returnConnection(conn);
            }
        }
        return s;
    }

    public synchronized String applyLeave(HttpServletRequest request, HttpServletResponse response)
    {
        String staffID = (String)session.getAttribute("staffid");
        String s1 = (new LeaveLeave()).getRecommendationStatus(staffID);
        
        boolean flag = false;
        String s3 = null;
        Object obj = null;
        Connection conn = null;
        Statement statement = null;
        ResultSet rset = null;
        ResultSet rset1 = null;
        ResultSet rset2 = null;
        CallableStatement cstmt = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        String errMsg = "";
        String fromDate = request.getParameter("fromdate");
        String toDate = request.getParameter("todate");
        String leaveType = request.getParameter("leavetype");
        String reason = request.getParameter("reason");
        String s9 = request.getParameter("address");
        String s10 = request.getParameter("phone");
        String recommender = request.getParameter("recommender");
        String mcNo = request.getParameter("mc_no");
        
        int numberDay = 0, maxDayLeave = 0, totalTakenLeave = 0;
                
        String clinic = null;
        if (request.getParameter("panelClinic") != null) {
	        if (request.getParameter("panelClinic").equals("0"))
	        	clinic = request.getParameter("clinic");
	        else
	        	clinic = request.getParameter("panelClinic");
        }
        
        String s14 = request.getParameter("leavetypeconn");
        String s15 = request.getParameter("leavetypedetl");
        String substitute = request.getParameter("substitute");
        
        int i = 0;

        String memoTo[] = new String[1];
        String sql = "SELECT userid from CMSUSERS_VIEW where cmsid = ?";
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            
            boolean canProceed = true;           
            String strSQL = "SELECT count(1) FROM cmsadmin.staff_leave_head WHERE slh_staff_id = ? AND slh_year = ?";
            pstmt = conn.prepareStatement(strSQL);
            pstmt.setString(1, staffID);
            pstmt.setString(2, fromDate.substring(6,10));
            rset = pstmt.executeQuery();
            if (rset.isBeforeFirst()) {
            	if (rset.next()) {
            		if (rset.getInt(1) == 0)
            			canProceed = false;
            	}
            }
            rset.close();
            pstmt.close();
            
            if (canProceed) {
		            String leaveYear = fromDate.substring(6,10); 
		            pstmt = conn.prepareStatement(sql);
		            pstmt.setString(1, staffID);
		            rset1 = pstmt.executeQuery();
		            rset1.next();
		            String s19 = rset1.getString(1);
		            pstmt.close();
		            rset1.close();

		            //boolean isStaffShift = new LeaveLeave().isStaffShift(staffID);
		            boolean hasLeave = false;
		            if (errMsg.equals(""))
		            {
		            	LeaveLeave leaveBean = new LeaveLeave();
		            	hasLeave = leaveBean.hasLeave(staffID, fromDate, toDate);
		                if (!hasLeave) {

			                pstmt1 = conn.prepareStatement(sql);
			                pstmt1.setString(1, recommender);
			                rset2 = pstmt1.executeQuery();
			                rset2.next();
			                String s20 = rset2.getString(1);
			                memoTo[0] = s20;
			                pstmt1.close();
			                rset2.close();
			                
			                numberDay = leaveBean.getAppliedLeaveDays(fromDate, toDate);
			                maxDayLeave = leaveBean.getMaxDay_ByLeave(s14);
			                totalTakenLeave = leaveBean.getTakenLeaveDays(staffID, s14, leaveYear);

		                    if (leaveType.equals("001") || leaveType.equals("002")) {
		                        cstmt = conn.prepareCall("{? = call CMSADMIN.LEAVE.TAKEANNUALLEAVE(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		                        cstmt.registerOutParameter(1, 2);
		                        cstmt.setString(2, staffID);
		                        cstmt.setString(3, leaveYear);
		                        cstmt.setString(4, fromDate);
		                        cstmt.setString(5, toDate);
		                        cstmt.setString(6, s9);
		                        cstmt.setString(7, s10);
		                        cstmt.setString(8, reason);
		                        cstmt.setString(9, recommender);
		                        if(!substitute.equals("0"))
		                            cstmt.setString(10, substitute);
		                        else
		                            cstmt.setString(10, null);
		                        cstmt.setString(11, s1);
		                        cstmt.registerOutParameter(12, 2);
		                        cstmt.registerOutParameter(13, 12);
		                        cstmt.registerOutParameter(14, 12);
		                        cstmt.executeUpdate();
		                        i = cstmt.getInt(1);
		                        int k = cstmt.getInt(12);
		                        errMsg = cstmt.getString(14);
		                    } 
		                    else if(leaveType.equals("003")) {
		                        cstmt = conn.prepareCall("{? = call CMSADMIN.LEAVE.TAKEMEDICALLEAVENEW(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		                        cstmt.registerOutParameter(1, 2);
		                        cstmt.setString(2, staffID);
		                        cstmt.setString(3, leaveYear);
		                        cstmt.setString(4, fromDate);
		                        cstmt.setString(5, toDate);
		                        cstmt.setString(6, s9);
		                        cstmt.setString(7, s10);
		                        cstmt.setString(8, reason);
		                        cstmt.setString(9, recommender);
		                        if(!substitute.equals("0"))
		                            cstmt.setString(10, substitute);
		                        else
		                            cstmt.setString(10, null);
		                        cstmt.setString(11, s1);
		                        cstmt.setString(12, mcNo);
		                        cstmt.setString(13, clinic);
		                        cstmt.registerOutParameter(14, 2);
		                        cstmt.registerOutParameter(15, 12);
		                        cstmt.executeUpdate();
		                        i = cstmt.getInt(1);
		                        int l = cstmt.getInt(14);
		                        errMsg = cstmt.getString(15);
		                    }
		                    else if(leaveType.equals("004") && s14.equals("005")) {
		                        cstmt = conn.prepareCall("{? = call CMSADMIN.LEAVE.TAKEREPLACEMENTLEAVENEW(?,?,?,?,?,?,?,?,?,?,?,?)}");
		                        cstmt.registerOutParameter(1, 2);
		                        cstmt.setString(2, staffID);
		                        cstmt.setString(3, leaveYear);
		                        cstmt.setString(4, fromDate);
		                        cstmt.setString(5, toDate);
		                        cstmt.setString(6, s9);
		                        cstmt.setString(7, s10);
		                        cstmt.setString(8, reason);
		                        cstmt.setString(9, recommender);
		                        if(!substitute.equals("0"))
		                            cstmt.setString(10, substitute);
		                        else
		                            cstmt.setString(10, null);
		                        cstmt.setString(11, s1);
		                        cstmt.registerOutParameter(12, 2);
		                        cstmt.registerOutParameter(13, 12);
		                        cstmt.executeUpdate();
		                        i = cstmt.getInt(1);
		                        int i1 = cstmt.getInt(12);
		                        errMsg = cstmt.getString(13);
		                    }
		                    else if(leaveType.equals("007")) {
		                        cstmt = conn.prepareCall("{? = call CMSADMIN.LEAVE.TAKEMATERNITYLEAVENEW(?,?,?,?,?,?,?,?,?,?,?,?)}");
		                        cstmt.registerOutParameter(1, 2);
		                        cstmt.setString(2, staffID);
		                        cstmt.setString(3, leaveYear);
		                        cstmt.setString(4, fromDate);
		                        //cstmt.setString(5, CommonFunction.getDate("dd/MM/yyyy", "dd/MM/yyyy", fromDate, HRConstant.MATERNITY_MAXDAY));
		                        cstmt.setString(5, toDate);
		                        cstmt.setString(6, s9);
		                        cstmt.setString(7, s10);
		                        cstmt.setString(8, reason);
		                        cstmt.setString(9, recommender);
		                        if(!substitute.equals("0"))
		                            cstmt.setString(10, substitute);
		                        else
		                            cstmt.setString(10, null);
		                        cstmt.setString(11, s1);
		                        cstmt.registerOutParameter(12, 2);
		                        cstmt.registerOutParameter(13, 12);
		                        cstmt.executeUpdate();
		                        i = cstmt.getInt(1);
		                        int j1 = cstmt.getInt(12);
		                        errMsg = cstmt.getString(13);
		                    }
		                    else if(leaveType.equals("004") && (s14.equals("008") || s14.equals("019") || s14.equals("020") || s14.equals("014"))) {
		                    	/*
		                    	System.out.println("numberDay : " + numberDay);
		                    	System.out.println("totalTakenLeave : " + totalTakenLeave);
		                    	System.out.println("maxDayLeave : " + maxDayLeave);
		                    	*/
				                if ((numberDay + totalTakenLeave) > maxDayLeave && maxDayLeave > 0) {
				                	errMsg = "Submission failed.\\nTotal leave day(s) exceed max leave eligibility.\\n " +
				                				"Max Eligibility : " + maxDayLeave + " day(s).";
				                }
				                else {
			                    	cstmt = conn.prepareCall("{? = call CMSADMIN.LEAVE.TAKEUNRECORDEDLEAVENEW(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			                        cstmt.registerOutParameter(1, 2);
			                        cstmt.setString(2, staffID);
			                        cstmt.setString(3, leaveYear);
			                        cstmt.setString(4, fromDate);
			                        cstmt.setString(5, toDate);
			                        cstmt.setString(6, s9);
			                        cstmt.setString(7, s10);
			                        cstmt.setString(8, reason);
			                        cstmt.setString(9, recommender);
			                        if(!substitute.equals("0"))
			                            cstmt.setString(10, substitute);
			                        else
			                            cstmt.setString(10, null);
			                        cstmt.setString(11, s1);
			                        cstmt.setString(12, s14);
			                        cstmt.registerOutParameter(13, 2);
			                        cstmt.registerOutParameter(14, 12);
			                        cstmt.executeUpdate();
			                        i = cstmt.getInt(1);
			                        int k1 = cstmt.getInt(13);
			                        errMsg = cstmt.getString(14);
				                }
		                    }
		                    else if(leaveType.equals("004") && (s14.equals("009") || s14.equals("016") || s14.equals("017") 
		                    			|| s14.equals("018") || s14.equals("021") || s14.equals("022") || s14.equals("023") || s14.equals("024"))) {

				                if ((numberDay + totalTakenLeave) > maxDayLeave && maxDayLeave > 0) {
				                	errMsg = "Submission failed.\\nTotal leave day(s) exceed max leave eligibility.\\n " +
				                				"Max Eligibility : " + maxDayLeave + " day(s).";
				                }
				                else {
		                    	
			                    	cstmt = conn.prepareCall("{? = call CMSADMIN.LEAVE.TAKEUNRECORDEDLEAVENEWDETL(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			                        cstmt.registerOutParameter(1, 2);
			                        cstmt.setString(2, staffID);
			                        cstmt.setString(3, leaveYear);
			                        cstmt.setString(4, fromDate);
			                        cstmt.setString(5, toDate);
			                        cstmt.setString(6, s9);
			                        cstmt.setString(7, s10);
			                        cstmt.setString(8, reason);
			                        cstmt.setString(9, recommender);
			                        if(!substitute.equals("0"))
			                            cstmt.setString(10, substitute);
			                        else
			                            cstmt.setString(10, null);
			                        cstmt.setString(11, s1);
			                        cstmt.setString(12, s14);
			                        cstmt.setString(13, s15);
			                        cstmt.registerOutParameter(14, 2);
			                        cstmt.registerOutParameter(15, 12);
			                        cstmt.executeUpdate();
			                        i = cstmt.getInt(1);
			                        int l1 = cstmt.getInt(14);
			                        errMsg = cstmt.getString(15);
				                }
		                    }
		                    else if(leaveType.equals("010")) {
		                        cstmt = conn.prepareCall("{? = call CMSADMIN.LEAVE.TAKEHAJJLEAVENEW(?,?,?,?,?,?,?,?,?,?,?,?)}");
		                        cstmt.registerOutParameter(1, 2);
		                        cstmt.setString(2, staffID);
		                        cstmt.setString(3, leaveYear);
		                        cstmt.setString(4, fromDate);
		                        //cstmt.setString(5, CommonFunction.getDate("dd/MM/yyyy", "dd/MM/yyyy", fromDate, HRConstant.HAJJ_MAXDAY));
		                        cstmt.setString(5, toDate);
		                        cstmt.setString(6, s9);
		                        cstmt.setString(7, s10);
		                        cstmt.setString(8, reason);
		                        cstmt.setString(9, recommender);
		                        if(!substitute.equals("0"))
		                            cstmt.setString(10, substitute);
		                        else
		                            cstmt.setString(10, null);
		                        cstmt.setString(11, s1);
		                        cstmt.registerOutParameter(12, 2);
		                        cstmt.registerOutParameter(13, 12);
		                        cstmt.executeUpdate();
		                        i = cstmt.getInt(1);
		                        int i2 = cstmt.getInt(12);
		                        errMsg = cstmt.getString(13);
		                    }
			                String postedDate = CommonFunction.getDate("yyyy-MM-dd HH:mm");
			                String memoBody = " Leave Applied From " + fromDate + " To " + toDate;
			                String memoHeader = "Leave Application To Be Recommended";
			                CommonFunction.writeToMemo(conn, memoTo, s19, memoBody, postedDate, "FYI,", memoHeader);
		                }
		                else {
		                	errMsg = "Submission failed.\\nAlready has applied leave for selected Start & End Leave Date.";
		                }
		            }
            	//}
            }
            else {
            	errMsg = "Submission failed.\\nSelection year currently pending for Annual Entitlement process.";
            }	       
        }
        catch(Exception exception)
        {
        	errMsg += messages.getString("error.console.window");
            System.out.println("Leave.applyLeave():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally
        {
            try
            {
                if(pstmt != null) pstmt.close();
                if(pstmt1 != null) pstmt1.close();
                if(statement != null)  statement.close();
                if(rset != null) rset.close();
                if(rset1 != null) rset1.close();
                if(rset2 != null) rset2.close();
                if(cstmt != null) cstmt.close();
            }
            catch(Exception exception2) {
                TvoDebug.printStackTrace(exception2);
            }
            finally {
                dbPool.returnConnection(conn);
            }
        }
        return errMsg;
    }
   
    private int getLeaveBalance(Connection conn,String staffID, String leaveType, String leaveYear) throws Exception {
    	int totalDays = 0;
    	PreparedStatement pstmt = null;
    	ResultSet rset = null;
    	
    	StringBuffer sb = new StringBuffer("SELECT ");
    	if ("001".equals(leaveType))
    		sb.append("slh_annual_balance_days ");
    	else if ("004".equals(leaveType))
    		sb.append("slh_unrecorded_balance_days ");
    	
    	sb.append("FROM staff_leave_head ");
    	sb.append("WHERE slh_staff_id = ? AND slh_year = ?");
    		
    	pstmt = conn.prepareStatement(sb.toString());
    	pstmt.setString(1, staffID);
    	pstmt.setString(2, leaveYear);
    	rset = pstmt.executeQuery();
    	
    	if (rset.isBeforeFirst()) {
    		if (rset.next())
    			totalDays = rset.getInt(1);
    	}
    	rset.close();
    	pstmt.close();
    	return totalDays;
    }
    
    public synchronized String cancelLeave(HttpServletRequest request, HttpServletResponse response)
    {
        String errMsg = "";
        String memoTo[] = new String[1];
        Connection conn = null;
        CallableStatement cstmt = null;
        String staffID = (String)session.getAttribute("staffid");
        String leaveID = request.getParameter("refid");
        String recommender = request.getParameter("recommender");
        String reason = request.getParameter("reason");
        //String s7 = request.getParameter("leavetype");
        if(reason == null)
        	reason = "";
        LeaveLeave leaveleave = new LeaveLeave();
        LeaveDB leavedb = leaveleave.getLeaveDetails(leaveID, "view");
        String s8 = leaveleave.getRecommendationStatus(staffID);
        String senderID = "", receiverID = "", dateposted = "", msgSbj = "", msgBody = "";
        
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            
            //if(leavedb.getLeaveCode().equals("005") || leavedb.getLeaveTypeDet().equals("005")) //replacement leave
            if ("005".equals(leavedb.getLeaveCode()) || "005".equals(leavedb.getLeaveTypeDet())) //replacement leave
            {
                if(leavedb.getStatus().equals("APPLY") || leavedb.getStatus().equals("RECOMMEND"))
                {                	
                    cstmt = conn.prepareCall("{? = call cmsadmin.Leave.DeleteCancelReplacementLeave(?,?,?)}");
                    cstmt.registerOutParameter(1, 2);
                    cstmt.setString(2, leaveID);
                    cstmt.setString(3, staffID);
                    cstmt.setString(4, leavedb.getDateFrom().substring(6,10));
                    cstmt.executeUpdate();
                    int i = cstmt.getInt(1);
                } 
                else {
                    cstmt = conn.prepareCall("{? = call cmsadmin.Leave.ApplyCancelReplacementLeave(?,?,?,?,?)}");
                    cstmt.registerOutParameter(1, 2);
                    cstmt.setString(2, leaveID);
                    cstmt.setString(3, recommender);
                    cstmt.setString(4, reason);
                    cstmt.setString(5, s8);
                    cstmt.registerOutParameter(6, 12);
                    cstmt.executeUpdate();
                    int j = cstmt.getInt(1);
                    
                    if(j == 1)
                    {
                    	senderID = getIntranetUserID(staffID, request);
                    	receiverID = getIntranetUserID(recommender, request);
                        memoTo[0] = receiverID;
                        dateposted = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                        msgBody = "Please Cancel The Leave From " + leavedb.getDateFrom() + " To " + leavedb.getDateTo();
                        msgSbj = "Leave Cancel";
                        CommonFunction.writeToMemo(conn, memoTo, senderID, msgBody, dateposted, "FYI,", msgSbj);
                    } 
                    else {
                    	errMsg = cstmt.getString(6);
                        return errMsg;
                    }
                }
            } 
            else { //annual
            	if(leavedb.getStatus().equals("APPLY") || leavedb.getStatus().equals("RECOMMEND")) {
	                cstmt = conn.prepareCall("{? = call cmsadmin.Leave.DeleteCancelAnnualLeave(?,?)}");
	                cstmt.registerOutParameter(1, 2);
	                cstmt.setString(2, leaveID);
	                cstmt.setString(3, staffID);
	                cstmt.executeUpdate();
	                int k = cstmt.getInt(1);
	            } 
	            else {
	                cstmt = conn.prepareCall("{? = call cmsadmin.Leave.ApplyCancelAnnualLeave(?,?,?,?,?)}");
	                cstmt.registerOutParameter(1, 2);
	                cstmt.setString(2, leaveID);
	                cstmt.setString(3, recommender);
	                cstmt.setString(4, reason);
	                cstmt.setString(5, s8);
	                cstmt.registerOutParameter(6, 12);
	                cstmt.executeUpdate();
	                int l = cstmt.getInt(1);
	                if(l == 1)
	                {
	                	senderID = getIntranetUserID(staffID, request);
	                	receiverID = getIntranetUserID(recommender, request);
	                    memoTo[0] = receiverID;
	                    dateposted = CommonFunction.getDate("yyyy-MM-dd HH:mm");
	                    msgBody = "Please Cancel The Leave From " + leavedb.getDateFrom() + " To " + leavedb.getDateTo();
	                    msgSbj = "Leave Cancel";
	                    CommonFunction.writeToMemo(conn, memoTo, senderID, msgBody, dateposted, "FYI,", msgSbj);
	                } 
	                else {
	                	errMsg = cstmt.getString(6);
	                    return errMsg;
	                }
	            }
            }
        }
        catch(Exception exception) {
        	errMsg += messages.getString("error.console.window");
            System.out.println("Leave.cancelLeave():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally {
            try {
                if (cstmt != null) cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception ex) { }
        }
        return errMsg;
    }

    public synchronized String applyOvertime(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        String s = "";
        String s1 = "";
        String s2 = "";
        String as[] = new String[1];
        String s3 = (String)session.getAttribute("staffid");
        String s4 = (new LeaveLeave()).getRecommendationStatus(s3);
        String as1[] = null;
        String as2[] = null;
        String as3[] = null;
        String as4[] = null;
        String as5[] = null;
        String as6[] = null;
        String as7[] = null;
        String as8[] = null;
        as1 = request.getParameterValues("date");
        as2 = request.getParameterValues("wid");
        as3 = request.getParameterValues("time1_from");
        as4 = request.getParameterValues("time1_to");
        as5 = request.getParameterValues("time2_from");
        as6 = request.getParameterValues("time2_to");
        as7 = request.getParameterValues("time3_from");
        as8 = request.getParameterValues("time3_to");
        String s5 = request.getParameter("recommender");
        int ai[] = new int[8];
        String as9[] = new String[8];
        boolean flag = true;
        int i = 0;
        boolean flag1 = false;
        CallableStatement cstmt = null;
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            if(as1 != null)
            {
                for(int j = 0; j < 8; j++)
                    if(as1[j] != null && as1[j].length() > 0)
                    {
                        cstmt = conn.prepareCall("{? = call cmsadmin.leave.APPLYSTAFFLEAVEOVERTIME(?,?,?,?,?,?,?,?,?,?,?,?)}");
                        cstmt.registerOutParameter(1, 2);
                        cstmt.setString(2, s3);
                        if(as1[j] != null)
                            cstmt.setString(3, as1[j]);
                        if(as2[j] != null)
                            cstmt.setString(4, as2[j]);
                        if(as3[j] != null)
                            cstmt.setString(5, as3[j]);
                        if(as4[j] != null)
                            cstmt.setString(6, as4[j]);
                        if(as5[j] != null)
                            cstmt.setString(7, as5[j]);
                        if(as6[j] != null)
                            cstmt.setString(8, as6[j]);
                        if(as7[j] != null)
                            cstmt.setString(9, as7[j]);
                        if(as8[j] != null)
                            cstmt.setString(10, as8[j]);
                        cstmt.setString(11, s5);
                        cstmt.setString(12, s4);
                        cstmt.registerOutParameter(13, 12);
                        cstmt.executeUpdate();
                        ai[j] = cstmt.getInt(1);
                        if(ai[j] == 0)
                            i++;
                        as9[j] = cstmt.getString(13);
                        System.out.println("error : " + as9[j]);
                    }

            }
            for(int k = 0; k < 8; k++)
            {
                if(as1[k].length() <= 0 || ai[k] != 0)
                    continue;
                flag = false;
                break;
            }

            for(int l = 0; l < 8; l++)
            {
                if(ai[l] != 1)
                    continue;
                flag1 = true;
                break;
            }

            if(flag1)
            {
                String s6 = getIntranetUserID(s3, request);
                String s7 = getIntranetUserID(s5, request);
                as[0] = s7;
                String s8 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                String s9 = "Please approve my Overtime Application For Replacement Leave";
                String s10 = "Overtime Application For Replacement Leave";
                CommonFunction.writeToMemo(conn, as, s6, s9, s8, "FYI,", s10);
            }
            if(!flag && i > 0)
                s = s + i + " Overtime Details Not Submitted!Check Your Overtime Date";
        }
        catch(Exception exception)
        {
            s = s + messages.getString("error.console.window");
            System.out.println("Leave.applyLeave():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally
        {
            try
            {
                if(cstmt != null)
                    cstmt.close();
            }
            catch(Exception exception2)
            {
                TvoDebug.printStackTrace(exception2);
            }
            finally
            {
                dbPool.returnConnection(conn);
            }
        }
        return s;
    }

    public synchronized String recommend(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        Statement statement = null;
        ResultSet rset = null;
        CallableStatement cstmt = null;
        String s = "";
        String s1 = (String)session.getAttribute("staffid");
        String s2 = request.getParameter("refid");
        String s3 = request.getParameter("recommender");
        String s4 = request.getParameter("substitute");
        LeaveLeave leaveleave = new LeaveLeave();
        boolean flag = false;
        String s5 = "";
        String s6 = "";
        String s7 = "";
        String s8 = "";
        String s9 = "";
        String as[] = new String[1];
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            LeaveDB leavedb = leaveleave.getLeaveDetails(s2, "view");
            int i;
            String s10;
            String s11;
            if(leavedb.getStatus().equals("CANCEL_APPLY"))
            {
                cstmt = conn.prepareCall("{?= call CMSADMIN.LEAVE.RECOMMENDCANCELANNUALLEAVE(?,?,?)}");
                cstmt.registerOutParameter(1, 2);
                cstmt.setString(2, s2);
                cstmt.setString(3, s3);
                cstmt.registerOutParameter(4, 12);
                cstmt.executeUpdate();
                i = cstmt.getInt(1);
                s11 = cstmt.getString(4);
                if(i == 1)
                    s5 = "Please Approve The Cancelation Of Leave From " + leavedb.getDateFrom() + " To " + leavedb.getDateTo();
                s10 = "Leave Cancel";
            } else
            {
                cstmt = conn.prepareCall("{? = call cmsadmin.leave.RecommendLeave(?,?,?,?)}");
                cstmt.registerOutParameter(1, 2);
                cstmt.setString(2, s2);
                if(s4.equals("0"))
                    cstmt.setString(3, null);
                else
                    cstmt.setString(3, s4);
                cstmt.setString(4, s3);
                cstmt.registerOutParameter(5, 12);
                cstmt.executeUpdate();
                i = cstmt.getInt(1);
                s11 = cstmt.getString(5);
                if(i == 1)
                    s5 = "Please Approve The Leave From " + leavedb.getDateFrom() + " To " + leavedb.getDateTo();
                s10 = "Leave Application To Be Approved";
            }
            if(i == 1)
            {
                String s12 = getIntranetUserID(s1, request);
                String s14 = getIntranetUserID(s3, request);
                as[0] = s14;
                String s16 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                CommonFunction.writeToMemo(conn, as, s12, s5, s16, "FYI,", s10);
            } else
            {
                s = s11;
                String s13 = s;
                String s15 = s13;
                String s17 = s15;
                String s18 = s17;
                String s19 = s18;
                String s20 = s19;
                String s21 = s20;
                String s22 = s21;
                String s23 = s22;
                return s23;
            }
        }
        catch(Exception exception)
        {
            s = s + messages.getString("error.console.window");
            System.out.println("Leave.recommend():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally
        {
            try
            {
                if(rset != null)
                    rset.close();
                if(statement != null)
                    statement.close();
                if(cstmt != null)
                    cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String recommend_reject(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        Statement statement = null;
        ResultSet rset = null;
        CallableStatement cstmt = null;
        String s = "";
        String s1 = (String)session.getAttribute("staffid");
        String s2 = request.getParameter("refid");
        String s3 = request.getParameter("reason");
        String s4 = request.getParameter("staff_id");
        LeaveLeave leaveleave = new LeaveLeave();
        if(s1 == null)
            s1 = "";
        boolean flag = false;
        String s5 = "";
        String s6 = "";
        String s7 = "";
        String s8 = "";
        String s9 = "";
        String as[] = new String[1];
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            LeaveDB leavedb = leaveleave.getLeaveDetails(s2, "view");
            cstmt = conn.prepareCall("{?= call CMSADMIN.LEAVE.RejectRecommendLeave(?,?,?)}");
            cstmt.registerOutParameter(1, 2);
            cstmt.setString(2, s2);
            cstmt.setString(3, s3);
            cstmt.registerOutParameter(4, 12);
            cstmt.executeUpdate();
            int i = cstmt.getInt(1);
            String s10 = cstmt.getString(4);
            if(i == 1)
                s5 = "Leave Has Been Rejected From " + leavedb.getDateFrom() + " To " + leavedb.getDateTo();
            String s11 = "Leave Reject";
            if(i == 1)
            {
                String s12 = getIntranetUserID(s1, request);
                String s14 = getIntranetUserID(s4, request);
                as[0] = s14;
                String s16 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                CommonFunction.writeToMemo(conn, as, s12, s5, s16, "FYI,", s11);
            } else
            {
                s = s10;
                String s13 = s;
                String s15 = s13;
                String s17 = s15;
                String s18 = s17;
                String s19 = s18;
                String s20 = s19;
                String s21 = s20;
                String s22 = s21;
                String s23 = s22;
                return s23;
            }
        }
        catch(Exception exception)
        {
            s = s + messages.getString("error.console.window");
            System.out.println("Leave.recommend():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally
        {
            try
            {
                if(rset != null)
                    rset.close();
                if(statement != null)
                    statement.close();
                if(cstmt != null)
                    cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String recommendOvertime(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        Statement statement = null;
        ResultSet rset = null;
        CallableStatement cstmt = null;
        String s = "";
        String s1 = (String)session.getAttribute("staffid");
        String s2 = request.getParameter("refid");
        String s3 = request.getParameter("recommender");
        String s4 = request.getParameter("substitute");
        LeaveLeave leaveleave = new LeaveLeave();
        boolean flag = false;
        String s5 = "";
        String s6 = "";
        String s7 = "";
        String s8 = "";
        String s9 = "";
        String as[] = new String[1];
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            OvertimeDB overtimedb = new OvertimeDB();
            overtimedb = leaveleave.getOvertimeDetails(s2, "view");
            cstmt = conn.prepareCall("{? = call cmsadmin.leave.recommendStaffLeaveOvertime(?,?,?)}");
            cstmt.registerOutParameter(1, 2);
            cstmt.setString(2, s2);
            cstmt.setString(3, s3);
            cstmt.registerOutParameter(4, 12);
            cstmt.executeUpdate();
            int i = cstmt.getInt(1);
            String s10 = cstmt.getString(4);
            if(i == 1)
            {
                String s11 = getIntranetUserID(s1, request);
                String s13 = getIntranetUserID(s3, request);
                as[0] = s13;
                String s15 = "Please Approve The Overtime Application For Replacement Leave On " + overtimedb.getOvertimeDate();
                String s17 = "Overtime Application For Replacement Leave Approve";
                String s19 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                CommonFunction.writeToMemo(conn, as, s11, s15, s19, "FYI,", s17);
            } else
            {
                s = s10;
                String s12 = s;
                String s14 = s12;
                String s16 = s14;
                String s18 = s16;
                String s20 = s18;
                String s21 = s20;
                String s22 = s21;
                String s23 = s22;
                String s24 = s23;
                return s24;
            }
        }
        catch(Exception exception)
        {
            s = s + messages.getString("error.console.window");
            System.out.println("Leave.recommend():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally
        {
            try
            {
                if(rset != null)
                    rset.close();
                if(statement != null)
                    statement.close();
                if(cstmt != null)
                    cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String rejectOvertime(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        Statement statement = null;
        ResultSet rset = null;
        ResultSet rset1 = null;
        ResultSet rset2 = null;
        CallableStatement cstmt = null;
        String s = "";
        String as[] = request.getParameterValues("approve");
        String s1 = request.getParameter("reason");
        if(s1 == null)
            s1 = "";
        boolean flag = false;
        String s2 = "";
        String s3 = "";
        String s4 = "";
        String as1[] = new String[1];
        String s5 = "Select userid from CMSUSERS_VIEW where cmsid=?";
        String s6 = (String)session.getAttribute("staffid");
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            pstmt = conn.prepareStatement(s5);
            pstmt.setString(1, s6);
            rset = pstmt.executeQuery();
            rset.next();
            String s7 = rset.getString(1);
            pstmt.close();
            rset.close();
            if(s.equals(""))
            {
                for(int i = 0; i < as.length; i++)
                {
                    String s8 = "select * from cmsadmin.staff_leave_overtime where slo_ref_id='" + as[i] + "'";
                    statement = conn.createStatement();
                    rset1 = statement.executeQuery(s8);
                    rset1.next();
                    String s9 = rset1.getString("slo_staff_id");
                    pstmt1 = conn.prepareStatement(s5);
                    pstmt1.setString(1, s9);
                    rset2 = pstmt1.executeQuery();
                    rset2.next();
                    String s10 = rset2.getString(1);
                    as1[0] = s10;
                    pstmt1.close();
                    rset2.close();
                    cstmt = conn.prepareCall("{? = call CMSADMIN.Leave.rejectOvertime (?,?,?)}");
                    cstmt.registerOutParameter(1, 2);
                    cstmt.setString(2, as[i]);
                    cstmt.setString(3, s1);
                    cstmt.registerOutParameter(4, 12);
                    cstmt.executeUpdate();
                    int j = cstmt.getInt(1);
                    if(j == 0)
                    {
                        s = cstmt.getString(4);
                        String s11 = s;
                        String s13 = s11;
                        String s15 = s13;
                        String s17 = s15;
                        String s18 = s17;
                        String s19 = s18;
                        String s20 = s19;
                        String s21 = s20;
                        String s22 = s21;
                        return s22;
                    }
                    String s12 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                    String s14 = "Your Overtime For Replacement Application Has Been Rejected For : " + CommonFunction.getDate("yyyy-mm-dd", "dd/mm/yyyy", rset1.getString("SLO_DATE").substring(0, 10));
                    String s16 = "Overtime Application For Replacement Leave Reject";
                    CommonFunction.writeToMemo(conn, as1, s7, s14, s12, "FYI,", s16);
                }

                rset1.close();
                statement.close();
                cstmt.close();
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
                if(rset1 != null)
                    rset1.close();
                if(rset != null)
                    rset.close();
                if(rset2 != null)
                    rset2.close();
                if(pstmt != null)
                    pstmt.close();
                if(pstmt1 != null)
                    pstmt1.close();
                if(statement != null)
                    statement.close();
                cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception exception2) { }
        }
        return s;
    }

    public synchronized String applyCarryForwardLeave(HttpServletRequest request, HttpServletResponse response)
    {
        Connection conn = null;
        CallableStatement cstmt = null;
        String s = "";
        String s1 = (String)session.getAttribute("staffid");
        String s2 = request.getParameter("carry");
        String s3 = request.getParameter("golden");
        String s4 = request.getParameter("approver");
        if(s3 == null)
            s3 = "0";
        Calendar calendar = Calendar.getInstance();
        String s5 = "" + calendar.get(1);
        boolean flag = false;
        String s6 = "";
        String as[] = new String[1];
        String as1[] = new String[1];
        String s7 = getCFApproverID(request);
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            conn = dbPool.getConnection();
            cstmt = conn.prepareCall("{? =call cmsadmin.leave.applycarryforward(?,?,?,?,?,?) }");
            cstmt.registerOutParameter(1, 2);
            cstmt.setString(2, s1);
            cstmt.setString(3, s5);
            cstmt.setInt(4, Integer.parseInt(s2));
            cstmt.setInt(5, Integer.parseInt(s3));
            cstmt.setString(6, s7);
            cstmt.registerOutParameter(7, 12);
            cstmt.executeUpdate();
            int i = cstmt.getInt(1);
            String s8 = cstmt.getString(7);
            if(s8 != null)
                s = s8;
            if(i == 1)
            {
                String s9 = getIntranetUserID(s1, request);
                String s10 = getIntranetUserID(s4, request);
                String s11 = getIntranetUserID(s7, request);
                as[0] = s10;
                as1[0] = s11;
                String s12 = CommonFunction.getDate("yyyy-MM-dd HH:mm");
                String s13 = "Please Approve My CarryForward Days <br>";
                s13 = s13 + "Detalis:<br>";
                s13 = s13 + "CarryForwardDays Applied     :" + s2 + "<br>";
                s13 = s13 + "GoldenHandShake Days Applied :" + s3 + ".";
                String s14 = "Carry Forward Leave Application";
                CommonFunction.writeToMemoCc(conn, as, as1, s9, s13, s12, "FYI,", s14);
            }
        }
        catch(Exception exception)
        {
            s = s + messages.getString("error.console.window");
            System.out.println("Leave.applyCarryForwardLeave():" + exception.getMessage());
            TvoDebug.printStackTrace(exception);
        }
        finally
        {
            try
            {
                if(cstmt != null)
                    cstmt.close();
                dbPool.returnConnection(conn);
            }
            catch(Exception exception2) { }
        }
        return s;
    }
}