package cms.staff;

import common.*;
import java.io.PrintStream;
import java.sql.*;
import java.util.Properties;
import java.util.Vector;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import tvo.TvoDBConnectionPoolFactory;

public class WorkOrderBean
{
    protected Connection conn;
    private DBConnectionPool dbPool;
    protected String errmsg;
    protected String sql;
    protected String staff_id;
    protected String dept_code;
    protected String type;
    protected int work_order_id;
    protected String description;
    protected String date_from;
    protected String date_to;
    protected String approver;

    public WorkOrderBean()
    {
        conn = null;
        errmsg = null;
        sql = null;
        staff_id = null;
        dept_code = null;
        type = null;
        work_order_id = -1;
        description = null;
        date_from = null;
        date_to = null;
        approver = null;
    }

    public void setDBConnection(Connection arg)
    {
        conn = arg;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public int getWorkId()
    {
        return work_order_id;
    }

    public void setStaffId(String theStaffId)
    {
        staff_id = theStaffId;
    }

    public void setType(String theType)
    {
        type = theType;
    }

    public void setDeptCode(String theDeptCode)
    {
        dept_code = theDeptCode;
    }

    public void setDescription(String theDescription)
    {
        description = theDescription;
    }

    public void setDateFrom(String theDateFrom)
    {
        date_from = theDateFrom;
    }

    public void setDateTo(String theDateTo)
    {
        date_to = theDateTo;
    }

    public void setApprover(String theApprover)
    {
        approver = theApprover;
    }

    public String getStaffDeptCode(String StaffId)
    {
        String dept_code = null;
        sql = "SELECT sm_dept_code FROM staff_main WHERE sm_staff_id = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, staff_id);
            ResultSet rset = pstmt.executeQuery(sql);
            if(rset.next())
                dept_code = rset.getString(1);
            pstmt.close();
        }
        catch(SQLException sqlexception) { }
        return dept_code;
    }

    public double getDayDifference(String time1, String time2)
    {
        double diff = 0.0D;
        sql = "SELECT TO_DATE(?,'DD/MM/YYYY') - TO_DATE(?,'DD/MM/YYYY') FROM DUAL";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, time2);
            pstmt.setString(2, time1);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
                diff = rset.getDouble(1);
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error : " + e.toString();
        }
        return diff;
    }

    public double getDayDifference(String time1)
    {
        double diff = 0.0D;
        sql = "SELECT TO_DATE('" + time1 + ":23:59','DD/MM/YYYY:HH24:MI') - SYSDATE FROM DUAL";
        try
        {
            Statement pstmt = conn.createStatement();
            ResultSet rset = pstmt.executeQuery(sql);
            if(rset.next())
                diff = rset.getDouble(1);
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error : " + e.toString();
        }
        return diff;
    }

    public boolean AddNewWork()
    {
        boolean status = false;
        if(date_from == null || date_from != null && date_from.length() == 0)
        {
            errmsg = "Date from must not be empty";
            return false;
        }
        if(getDayDifference(date_from, date_to) < 0.0D)
        {
            errmsg = "Date to must be after date from";
            return false;
        }
        sql = "INSERT INTO WORK_ORDER_HEAD (WOH_WORKORDER_ID, WOH_TYPE, WOH_DEPT_CODE, WOH_ENTER_BY, WOH_ENTER_DATE, WOH_DATE_FROM, WOH_DATE_TO, WOH_DESC, WOH_STATUS, WOH_APPROVE_BY) values (work_order_main_id.NEXTVAL, ?, ?, ?, SYSDATE, TO_DATE(?, 'DD/MM/YYYY'), TO_DATE(?, 'DD/MM/YYYY'), ?, 'ENTRY', ?)";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, type);
            pstmt.setString(2, dept_code);
            pstmt.setString(3, staff_id);
            pstmt.setString(4, date_from);
            pstmt.setString(5, date_to);
            pstmt.setString(6, description);
            pstmt.setString(7, approver);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "Unable to create new record.";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
        }
        catch(SQLException e)
        {
            errmsg += "Error : " + e.toString();
            System.out.println(errmsg);
            status = false;
        }
        sql = "SELECT work_order_main_id.CURRVAL from dual";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rset = pstmt.executeQuery(sql);
            if(rset.next())
                work_order_id = rset.getInt(1);
            pstmt.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Unable to get Work Order Ref ID";
        }
        return status;
    }

    public boolean EditWork(int work_id, String woh_desc, String woh_date_from, String woh_date_to)
    {
        work_order_id = work_id;
        description = woh_desc;
        date_from = null;
        date_to = null;
        if(getDayDifference(date_from) < 0.0D)
        {
            errmsg = "Date from must be before or during entry date";
            return false;
        }
        boolean status = false;
        sql = "UPDATE WORK_ORDER_HEAD SET WOH_DESC = ?, WOH_DATE_FROM = TO_DATE(?,'DD/MM/YYYY'), WOH_DATE_TO = TO_DATE(?,'DD/MM/YYYY') WHERE WOH_WORKORDER_ID = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, woh_desc);
            pstmt.setString(2, woh_date_from);
            pstmt.setString(3, woh_date_to);
            pstmt.setInt(4, work_id);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "Unable to save changes.";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error : " + e.toString();
            status = false;
        }
        return status;
    }

    public boolean ApproveWork(String approver, int work_id)
    {
        boolean status = false;
        sql = "UPDATE WORK_ORDER_HEAD SET WOH_APPROVE_BY = ?, WOH_APPROVE_DATE = SYSDATE, WOH_STATUS = 'APPROVE' WHERE WOH_WORKORDER_ID = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, approver);
            pstmt.setInt(2, work_id);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "Unable to create new record.";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error : " + e.toString();
            status = false;
        }
        return status;
    }

    public boolean CancelWork(String canceller, int work_id, String cancel_reason)
    {
        boolean status = false;
        sql = "UPDATE WORK_ORDER_HEAD SET WOH_CANCEL_BY = ?, WOH_CANCEL_DATE = SYSDATE, WOH_CANCEL_REASON = ?, WOH_STATUS = 'CANCEL' WHERE WOH_WORKORDER_ID = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, canceller);
            pstmt.setString(2, cancel_reason);
            pstmt.setInt(3, work_id);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "Unable to cancel work order.";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error : " + e.toString();
            status = false;
        }
        return status;
    }

    public boolean assignStaff(int work_id, String staffid)
    {
        boolean status = false;
        sql = "INSERT INTO WORK_ORDER_DETL VALUES (?, ?)";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, work_id);
            pstmt.setString(2, staffid);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "Unable to create new record.";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
            pstmt.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Staff already assigned";
            status = false;
        }
        return status;
    }

    public boolean assignNonStaff(int work_id, String staff)
    {
        boolean status = false;
        sql = "INSERT INTO WORK_ORDER_DETL_MISC VALUES (?, ?)";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, work_id);
            pstmt.setString(2, staff);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "Unable to create new record.";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
            pstmt.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Staff already assigned";
            status = false;
        }
        return status;
    }

    public boolean unassignStaff(int work_id, String staffid)
    {
        boolean status = false;
        sql = "DELETE WORK_ORDER_DETL WHERE WOD_WORKORDER_ID = ? AND WOD_STAFF_ID = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, work_id);
            pstmt.setString(2, staffid);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "Staff already un-assigned";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
            pstmt.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Unable to un-assign. Travel request/claim exists";
            status = false;
        }
        return status;
    }

    public boolean unassignNonStaff(int work_id, String id)
    {
        boolean status = false;
        sql = "DELETE WORK_ORDER_DETL_MISC WHERE WODM_WORKORDER_ID = ? AND WODM_DESC = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, work_id);
            pstmt.setString(2, id);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "Non-staff already un-assigned";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Unable to un-assign. " + e.toString();
            status = false;
        }
        return status;
    }

    public boolean assignAllStaff(int work_id, String department)
    {
        boolean status = false;
        sql = "INSERT INTO WORK_ORDER_DETL SELECT ?, SM_STAFF_ID FROM STAFF_MAIN WHERE SM_DEPT_CODE = ? AND SM_STAFF_ID NOT IN (SELECT WOD_STAFF_ID FROM WORK_ORDER_DETL WHERE WOD_WORKORDER_ID = ?)";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, work_id);
            pstmt.setString(2, department);
            pstmt.setInt(3, work_id);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "Staff already assigned";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error : " + e.toString();
            status = false;
        }
        return status;
    }

    private String tmsUserId(String staffid, Connection con)
    {
        Statement st = null;
        ResultSet rs = null;
        String result = "";
        String sql = "Select userid from CMSUSERS_VIEW where cmsid='" + staffid + "'";
        try
        {
            st = con.createStatement();
            rs = st.executeQuery(sql);
            rs.next();
            result = rs.getString(1);
            st.close();
            rs.close();
        }
        catch(Exception e)
        {
            System.out.println("WorkorderBeanTmsUserId" + e);
        }
        return result;
    }

    public boolean memoWorkorderApprove(int workorder_id, HttpServletRequest request, int approveStatus)
    {
        boolean status = true;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        String woh_desc = "";
        String woh_date_from = "";
        String woh_date_to = "";
        String woh_enter_by = "";
        String woh_approve_by = "";
        String woh_approver_name = "";
        String creatorUserId = "";
        String userTo = "";
        String usersTo[] = new String[1];
        String users[] = null;
        Vector vUserIDs = null;
        Connection con = null;
        sql = "select woh_desc,to_char(woh_date_from,'DD/MM/YYYY'),NVL(to_char(woh_date_to,'DD/MM/YYYY'),' '), woh_enter_by,woh_approve_by,sm_staff_name from work_order_head,staff_main where sm_staff_id = woh_approve_by and woh_workorder_id = ?";
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            con = dbPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, workorder_id);
            rset = pstmt.executeQuery();
            rset.next();
            woh_desc = rset.getString(1);
            woh_date_from = rset.getString(2);
            woh_date_to = rset.getString(3);
            woh_enter_by = rset.getString(4);
            woh_approve_by = rset.getString(5);
            woh_approver_name = rset.getString(6);
            creatorUserId = tmsUserId(woh_approve_by, con);
            userTo = tmsUserId(woh_enter_by, con);
            usersTo[0] = userTo;
            vUserIDs = workorderStaff(workorder_id);
            if(vUserIDs != null)
            {
                int cnt = vUserIDs.size();
                users = new String[cnt];
                for(int i = 0; i < vUserIDs.size(); i++)
                    users[i] = tmsUserId((String)vUserIDs.get(i), con);

            }
            String datePosted = CommonFunction.getDate("yyyy-MM-dd HH:mm");
            String body = "Workorder has been Approved : <br><br>";
            body = body + "Details : <br>";
            body = body + "Ref ID : " + workorder_id + "<br>";
            body = body + "Description : " + woh_desc + "<br>";
            body = body + "Date From : " + woh_date_from + "<br>";
            body = body + "Date To : " + woh_date_to + "<br>";
            body = body + "Approved by : " + woh_approver_name + "<br>";
            String subject = "Workorder Approved";
            if(approveStatus == 0)
                CommonFunction.writeToMemo(con, usersTo, creatorUserId, body, datePosted, "FYI,", subject);
            body = "New Workorder has been Set For You.Please See the Details Below: <br><br>";
            body = body + "Details : <br>";
            body = body + "Ref ID : " + workorder_id + "<br>";
            body = body + "Description : " + woh_desc + "<br>";
            body = body + "Date From : " + woh_date_from + "<br>";
            body = body + "Date To : " + woh_date_to + "<br>";
            body = body + "Approved by : " + woh_approver_name + "<br>";
            subject = "New Workorder";
            CommonFunction.writeToMemo(con, users, creatorUserId, body, datePosted, "FYI,", subject);
            status = true;
            pstmt.close();
            rset.close();
            dbPool.returnConnection(con);
        }
        catch(Exception e)
        {
            System.out.println("Error (WorkorderBean.memoWorkorderApprove()):" + e);
            status = false;
        }
        return true;
    }

    private boolean isApproverWorkOrder(int id, String staffid)
    {
        Statement st = null;
        ResultSet rs = null;
        boolean result = false;
        String sql = "SELECT COUNT(*) FROM WORK_ORDER_HEAD WHERE WOH_ENTER_BY='" + staffid + "' AND WOH_APPROVE_BY='" + staffid + "'";
        try
        {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            rs.next();
            if(rs.getInt(1) > 0)
                result = true;
        }
        catch(Exception e)
        {
            System.out.println("WorkOrderBeanIsApproverWorkOrder" + e);
        }
        return result;
    }

    public boolean memoWorkorderCancel(int workorder_id, HttpServletRequest request, String staffid)
    {
        boolean status = true;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        String woh_desc = "";
        String woh_date_from = "";
        String woh_date_to = "";
        String woh_enter_by = "";
        String woh_approve_by = "";
        String woh_approver_name = "";
        String creatorUserId = "";
        String userTo = "";
        String usersTo[] = new String[1];
        String users[] = null;
        Vector vUserIDs = null;
        Connection con = null;
        sql = "select woh_desc,to_char(woh_date_from,'DD/MM/YYYY'),NVL(to_char(woh_date_to,'DD/MM/YYYY'),' '), woh_enter_by,woh_approve_by,sm_staff_name from work_order_head,staff_main where sm_staff_id = woh_approve_by and woh_workorder_id = ?";
        try
        {
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            con = dbPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, workorder_id);
            rset = pstmt.executeQuery();
            rset.next();
            woh_desc = rset.getString(1);
            woh_date_from = rset.getString(2);
            woh_date_to = rset.getString(3);
            woh_enter_by = rset.getString(4);
            woh_approve_by = rset.getString(5);
            woh_approver_name = rset.getString(6);
            creatorUserId = tmsUserId(woh_approve_by, con);
            userTo = tmsUserId(woh_enter_by, con);
            usersTo[0] = userTo;
            vUserIDs = workorderStaff(workorder_id);
            if(vUserIDs != null)
            {
                int cnt = vUserIDs.size();
                users = new String[cnt];
                for(int i = 0; i < vUserIDs.size(); i++)
                    users[i] = tmsUserId((String)vUserIDs.get(i), con);

            }
            String datePosted = CommonFunction.getDate("yyyy-MM-dd HH:mm");
            String body = "Workorder has been Canceled : <br><br>";
            body = body + "Details : <br>";
            body = body + "Ref ID : " + workorder_id + "<br>";
            body = body + "Description : " + woh_desc + "<br>";
            body = body + "Date From : " + woh_date_from + "<br>";
            body = body + "Date To : " + woh_date_to + "<br>";
            body = body + "Approved by : " + woh_approver_name + "<br>";
            String subject = "Workorder Canceled";
            if(!isApproverWorkOrder(workorder_id, staffid))
                CommonFunction.writeToMemo(con, usersTo, creatorUserId, body, datePosted, "FYI,", subject);
            body = "This Workorder has been Canceled .Please See the Details Below: <br><br>";
            body = body + "Details : <br>";
            body = body + "Ref ID : " + workorder_id + "<br>";
            body = body + "Description : " + woh_desc + "<br>";
            body = body + "Date From : " + woh_date_from + "<br>";
            body = body + "Date To : " + woh_date_to + "<br>";
            body = body + "Approved by : " + woh_approver_name + "<br>";
            subject = "Canceled Workorder";
            CommonFunction.writeToMemo(con, users, creatorUserId, body, datePosted, "FYI,", subject);
            status = true;
            pstmt.close();
            rset.close();
            dbPool.returnConnection(con);
        }
        catch(Exception e)
        {
            System.out.println("Error (WorkorderBean.memoWorkorderApprove()):" + e);
            status = false;
        }
        return true;
    }

    private Vector workorderStaff(int id)
    {
        Statement st = null;
        ResultSet rs = null;
        Vector outVector = new Vector(1, 1);
        String sql = "SELECT WOD_STAFF_ID FROM WORK_ORDER_DETL WHERE WOD_WORKORDER_ID ='" + id + "'";
        try
        {
            st = conn.createStatement();
            for(rs = st.executeQuery(sql); rs.next(); outVector.add(rs.getString(1)));
            st.close();
            rs.close();
        }
        catch(Exception e)
        {
            System.out.println("WorkOrderBeanStaff" + e);
        }
        return outVector;
    }

    public boolean EmailWorkorderApprove(int workorder_id)
    {
        boolean status = true;
        String woh_desc = null;
        String woh_date_from = null;
        String woh_date_to = null;
        String woh_approve_by = null;
        String woh_approve_date = null;
        String body = null;
        Session mailSession = null;
        Transport transport = null;
        Properties props = null;
        this.sql = "select woh_desc,to_char(woh_date_from,'DD/MM/YYYY'),NVL(to_char(woh_date_to,'DD/MM/YYYY'),' '), sm_staff_name,nvl(to_char(woh_approve_date,'DD/MM/YYYY'),' ') from work_order_head,staff_main where sm_staff_id = woh_approve_by and woh_workorder_id = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(this.sql);
            pstmt.setInt(1, workorder_id);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
            {
                woh_desc = rset.getString(1);
                woh_date_from = rset.getString(2);
                woh_date_to = rset.getString(3);
                woh_approve_by = rset.getString(4);
                woh_approve_date = rset.getString(5);
            }
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error during getting work_order info: " + e.toString();
        }
        try
        {
            body = "Please note that you have been assigned a new work order : <br><br>";
            body = body + "Details : <br>";
            body = body + "Ref ID : " + workorder_id + "<br>";
            body = body + "Description : " + woh_desc + "<br>";
            body = body + "Date From : " + woh_date_from + "<br>";
            body = body + "Date To : " + woh_date_to + "<br>";
            body = body + "Approved By : " + woh_approve_by + "<br>";
            body = body + "Approved Date : " + woh_approve_date + "<br><br>";
            body = body + "You can apply for travel request at ";
            body = body + "<a href=\"http://community.kuktem.edu.my\">E-Community</a><br>";
            props = new Properties();
            props.setProperty("mail.transport.protocol", "smtp");
            props.setProperty("mail.host", "202.184.251.5");
            props.setProperty("mail.user", "cmsadmin");
            props.setProperty("mail.password", "kuktem");
            mailSession = Session.getDefaultInstance(props, null);
            transport = mailSession.getTransport();
            transport.connect("202.184.251.5", "cmsadmin", "kuktem");
        }
        catch(Exception e)
        {
            errmsg = "Error : " + e.toString();
            status = false;
        }
        String sql = "SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_EMAIL_ADDR FROM WORK_ORDER_DETL,STAFF_MAIN WHERE SM_STAFF_ID = WOD_STAFF_ID AND WOD_WORKORDER_ID = ? ORDER BY SM_STAFF_ID ";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, workorder_id);
            for(ResultSet rset = pstmt.executeQuery(); rset.next();)
                try
                {
                    MimeMessage message = new MimeMessage(mailSession);
                    message.setContent(body, "text/html");
                    message.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(rset.getString(3)));
                    InternetAddress from = new InternetAddress("cmsadmin@kuktem.edu.my");
                    message.setFrom(from);
                    message.setSubject("Travelling & Transport - Work Order Approval - DO NOT REPLY");
                    transport.sendMessage(message, message.getRecipients(javax.mail.Message.RecipientType.TO));
                }
                catch(Exception e)
                {
                    errmsg = "Error : " + e.toString();
                    status = false;
                }

            transport.close();
            pstmt.close();
        }
        catch(Exception e)
        {
            errmsg = "Error during sending email : " + e.toString();
            status = false;
        }
        return status;
    }

    public boolean EmailWorkorderCancel(int workorder_id)
    {
        boolean status = true;
        String woh_desc = null;
        String woh_date_from = null;
        String woh_date_to = null;
        String woh_cancel_by = null;
        String woh_cancel_date = null;
        String body = null;
        Session mailSession = null;
        Transport transport = null;
        Properties props = null;
        this.sql = "select woh_desc,to_char(woh_date_from,'DD/MM/YYYY'),NVL(to_char(woh_date_to,'DD/MM/YYYY'),' '), sm_staff_name,nvl(to_char(woh_cancel_date,'DD/MM/YYYY'),' ') from work_order_head,staff_main where sm_staff_id = woh_cancel_by and woh_workorder_id = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(this.sql);
            pstmt.setInt(1, workorder_id);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
            {
                woh_desc = rset.getString(1);
                woh_date_from = rset.getString(2);
                woh_date_to = rset.getString(3);
                woh_cancel_by = rset.getString(4);
                woh_cancel_date = rset.getString(5);
            }
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error during getting work_order info: " + e.toString();
        }
        try
        {
            body = "Please note that this particular work order has been cancelled : <br><br>";
            body = body + "Details : <br>";
            body = body + "Ref ID : " + workorder_id + "<br>";
            body = body + "Description : " + woh_desc + "<br>";
            body = body + "Date From : " + woh_date_from + "<br>";
            body = body + "Date To : " + woh_date_to + "<br>";
            body = body + "Cancelled By : " + woh_cancel_by + "<br>";
            body = body + "Cancelled Date : " + woh_cancel_date + "<br><br>";
            props = new Properties();
            props.setProperty("mail.transport.protocol", "smtp");
            props.setProperty("mail.host", "202.184.251.5");
            props.setProperty("mail.user", "cmsadmin");
            props.setProperty("mail.password", "kuktem");
            mailSession = Session.getDefaultInstance(props, null);
            transport = mailSession.getTransport();
            transport.connect("202.184.251.5", "cmsadmin", "kuktem");
        }
        catch(Exception e)
        {
            errmsg = "Error : " + e.toString();
            status = false;
        }
        String sql = "SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_EMAIL_ADDR FROM WORK_ORDER_DETL,STAFF_MAIN WHERE SM_STAFF_ID = WOD_STAFF_ID AND WOD_WORKORDER_ID = ? ORDER BY SM_STAFF_ID ";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, workorder_id);
            for(ResultSet rset = pstmt.executeQuery(); rset.next();)
                try
                {
                    MimeMessage message = new MimeMessage(mailSession);
                    message.setContent(body, "text/html");
                    message.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(rset.getString(3)));
                    InternetAddress from = new InternetAddress("cmsadmin@kuktem.edu.my");
                    message.setFrom(from);
                    message.setSubject("Travelling & Transport - Work Order Cancellation - DO NOT REPLY");
                    transport.sendMessage(message, message.getRecipients(javax.mail.Message.RecipientType.TO));
                }
                catch(Exception e)
                {
                    errmsg = "Error : " + e.toString();
                    status = false;
                }

            transport.close();
            pstmt.close();
        }
        catch(Exception e)
        {
            errmsg = "Error during sending email : " + e.toString();
            status = false;
        }
        return status;
    }

    public boolean EmailWorkorderEdit(int workorder_id)
    {
        boolean status = true;
        String woh_desc = null;
        String woh_date_from = null;
        String woh_date_to = null;
        String body = null;
        Session mailSession = null;
        Transport transport = null;
        Properties props = null;
        this.sql = "select woh_desc,to_char(woh_date_from,'DD/MM/YYYY'),NVL(to_char(woh_date_to,'DD/MM/YYYY'),' ') from work_order_head where woh_workorder_id = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(this.sql);
            pstmt.setInt(1, workorder_id);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
            {
                woh_desc = rset.getString(1);
                woh_date_from = rset.getString(2);
                woh_date_to = rset.getString(3);
            }
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error during getting work_order info: " + e.toString();
        }
        try
        {
            body = "Please note that the details of this particular work order has been changed : <br><br>";
            body = body + "Details : <br>";
            body = body + "Ref ID : " + workorder_id + "<br>";
            body = body + "Description : " + woh_desc + "<br>";
            body = body + "Date From : " + woh_date_from + "<br>";
            body = body + "Date To : " + woh_date_to + "<br>";
            props = new Properties();
            props.setProperty("mail.transport.protocol", "smtp");
            props.setProperty("mail.host", "202.184.251.5");
            props.setProperty("mail.user", "cmsadmin");
            props.setProperty("mail.password", "kuktem");
            mailSession = Session.getDefaultInstance(props, null);
            transport = mailSession.getTransport();
            transport.connect("202.184.251.5", "cmsadmin", "kuktem");
        }
        catch(Exception e)
        {
            errmsg = "Error : " + e.toString();
            status = false;
        }
        String sql = "SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_EMAIL_ADDR FROM WORK_ORDER_DETL,STAFF_MAIN WHERE SM_STAFF_ID = WOD_STAFF_ID AND WOD_WORKORDER_ID = ? ORDER BY SM_STAFF_ID ";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, workorder_id);
            InternetAddress from;
            for(ResultSet rset = pstmt.executeQuery(); rset.next();)
                try
                {
                	MimeMessage message = new MimeMessage(mailSession);
                    message.setContent(body, "text/html");
                    message.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(rset.getString(3)));
                    from = new InternetAddress("cmsadmin@kuktem.edu.my");
                    message.setFrom(from);
                    message.setSubject("Travelling & Transport - Work Order Changes - DO NOT REPLY");
                    transport.sendMessage(message, message.getRecipients(javax.mail.Message.RecipientType.TO));
                }
                catch(Exception e)
                {
                    errmsg = "Error : " + e.toString();
                    status = false;
                }

            MimeMessage message = new MimeMessage(mailSession);
            message.setContent(body, "text/html");
            message.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress("aluwi@kuktem.edu.my\t"));
            from = new InternetAddress("cmsadmin@kuktem.edu.my");
            message.setFrom(from);
            message.setSubject("Travelling & Transport - Work Order Changes - DO NOT REPLY");
            transport.sendMessage(message, message.getRecipients(javax.mail.Message.RecipientType.TO));
            transport.close();
            pstmt.close();
        }
        catch(Exception e)
        {
            errmsg = "Error during sending email : " + e.toString();
            status = false;
        }
        return status;
    }

    public boolean memoWorkorderAdd(int workorder_id, String approver, HttpServletRequest request)
    {
        boolean status = true;
        Connection con = null;
        PreparedStatement ps_userId = null;
        PreparedStatement ps_userTo = null;
        ResultSet rs_userId = null;
        ResultSet rs_userTo = null;
        String woh_desc = null;
        String woh_date_from = null;
        String woh_date_to = null;
        String woh_enter_by = null;
        String woh_enter_name = null;
        String creatorUserId = "";
        String userTo = "";
        String usersTo[] = new String[1];
        String sql_userId = "Select userid from CMSUSERS_VIEW where cmsid=?";
        sql = "select woh_desc,to_char(woh_date_from,'DD/MM/YYYY'),NVL(to_char(woh_date_to,'DD/MM/YYYY'),' '), woh_enter_by, sm_staff_name from work_order_head,staff_main where sm_staff_id = woh_enter_by and woh_workorder_id = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, workorder_id);
            ResultSet rset = pstmt.executeQuery();
            rset.next();
            woh_desc = rset.getString(1);
            woh_date_from = rset.getString(2);
            woh_date_to = rset.getString(3);
            woh_enter_by = rset.getString(4);
            woh_enter_name = rset.getString(5);
            dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
            con = dbPool.getConnection();
            ps_userId = con.prepareStatement(sql_userId);
            ps_userId.setString(1, woh_enter_by);
            rs_userId = ps_userId.executeQuery();
            rs_userId.next();
            creatorUserId = rs_userId.getString(1);
            ps_userTo = con.prepareStatement(sql_userId);
            ps_userTo.setString(1, approver);
            rs_userTo = ps_userTo.executeQuery();
            rs_userTo.next();
            userTo = rs_userTo.getString(1);
            usersTo[0] = userTo;
            String datePosted = CommonFunction.getDate("yyyy-MM-dd HH:mm");
            String body = "Please note that a new work order has been entered : <br><br>";
            body = body + "Details : <br>";
            body = body + "Ref ID : " + workorder_id + "<br>";
            body = body + "Description : " + woh_desc + "<br>";
            body = body + "Date From : " + woh_date_from + "<br>";
            body = body + "Date To : " + woh_date_to + "<br>";
            body = body + "Entered by : " + woh_enter_name + "<br>";
            String subject = "New Workorder To Approve";
            CommonFunction.writeToMemo(con, usersTo, creatorUserId, body, datePosted, "FYI,", subject);
            status = true;
            dbPool.returnConnection(con);
        }
        catch(Exception e)
        {
            System.out.println("Error (WorkorderBean.memoWorkorderAdd()):" + e);
            status = false;
        }
        return true;
    }

    public boolean EmailWorkorderAdd(int workorder_id, String approver)
    {
        boolean status = true;
        String woh_desc = null;
        String woh_date_from = null;
        String woh_date_to = null;
        String woh_enter_by = null;
        String woh_enter_name = null;
        String body = null;
        Session mailSession = null;
        Transport transport = null;
        Properties props = null;
        this.sql = "select woh_desc,to_char(woh_date_from,'DD/MM/YYYY'),NVL(to_char(woh_date_to,'DD/MM/YYYY'),' '), woh_enter_by, sm_staff_name from work_order_head,staff_main where sm_staff_id = woh_enter_by and woh_workorder_id = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(this.sql);
            pstmt.setInt(1, workorder_id);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
            {
                woh_desc = rset.getString(1);
                woh_date_from = rset.getString(2);
                woh_date_to = rset.getString(3);
                woh_enter_by = rset.getString(4);
                woh_enter_name = rset.getString(5);
            }
            pstmt.close();
        }
        catch(SQLException e)
        {
            errmsg = "Error during getting work_order info: " + e.toString();
        }
        try
        {
            body = "Please note that a new work order has been entered : <br><br>";
            body = body + "Details : <br>";
            body = body + "Ref ID : " + workorder_id + "<br>";
            body = body + "Description : " + woh_desc + "<br>";
            body = body + "Date From : " + woh_date_from + "<br>";
            body = body + "Date To : " + woh_date_to + "<br>";
            body = body + "Entered by : " + woh_enter_name + "<br>";
            props = new Properties();
            props.setProperty("mail.transport.protocol", "smtp");
            props.setProperty("mail.host", "202.184.251.5");
            props.setProperty("mail.user", "cmsadmin");
            props.setProperty("mail.password", "kuktem");
            mailSession = Session.getDefaultInstance(props, null);
            transport = mailSession.getTransport();
            transport.connect("202.184.251.5", "cmsadmin", "kuktem");
        }
        catch(Exception e)
        {
            errmsg = "Error : " + e.toString();
            status = false;
        }
        String sql = "SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_EMAIL_ADDR FROM STAFF_MAIN WHERE SM_STAFF_ID = ?";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, approver);
            for(ResultSet rset = pstmt.executeQuery(); rset.next();)
                try
                {
                    MimeMessage message = new MimeMessage(mailSession);
                    message.setContent(body, "text/html");
                    message.addRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(rset.getString(3)));
                    InternetAddress from = new InternetAddress("cmsadmin@kuktem.edu.my");
                    message.setFrom(from);
                    message.setSubject("Travelling & Transport - New Work Order Entry - DO NOT REPLY");
                    transport.sendMessage(message, message.getRecipients(javax.mail.Message.RecipientType.TO));
                }
                catch(Exception e)
                {
                    errmsg = "Error : " + e.toString();
                    status = false;
                }

            transport.close();
            pstmt.close();
        }
        catch(Exception e)
        {
            errmsg = "Error during sending email : " + e.toString();
            status = false;
        }
        return status;
    }

    public boolean deleteWork(int work_id)
    {
        boolean status = false;
        sql = "DELETE WORK_ORDER_HEAD WHERE WOH_WORKORDER_ID = ? AND WOH_WORKORDER_ID NOT IN (SELECT WOD_WORKORDER_ID WHERE WORK_ORDER_DETL)";
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, work_id);
            int count = pstmt.executeUpdate();
            if(count == 0)
            {
                conn.rollback();
                errmsg = "There are staffs assigned to this work order";
                status = false;
            } else
            {
                conn.commit();
                status = true;
            }
            pstmt.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Record exists";
            status = false;
        }
        return status;
    }
}