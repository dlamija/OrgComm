package cms.admin.meeting.bean;

import cms.admin.meeting.EMeetingMain;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;

public class MeetingAttendanceOther implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String attdSeq;
    protected String userID;
    protected String attdPosition;
    protected String attdStatus;
    protected String attdRemark;
    protected String userName;
    protected String deptCode;
    protected String roleDesc;

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public void setUserId(String s)
    {
        userID = s;
    }

    public void setAttdPosition(String s)
    {
        attdPosition = s;
    }

    public void setAttdStatus(String s)
    {
        attdStatus = s;
    }

    public void setAttdRemark(String s)
    {
        attdRemark = s;
    }

    public void setRoleDesc(String s)
    {
        roleDesc = s;
    }

    public String getAttdSeq()
    {
        return attdSeq;
    }

    public String getUserId()
    {
        return userID;
    }

    public String getAttdPosition()
    {
        return attdPosition;
    }

    public String getAttdStatus()
    {
        return attdStatus;
    }

    public String getAttdRemark()
    {
        return attdRemark;
    }

    public String getUserName()
    {
        return userName;
    }

    public String getDeptCode()
    {
        return deptCode;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public String getSQL()
    {
        return sql;
    }

    public String getRoleDesc()
    {
        return roleDesc;
    }

    public String queryMeetingRole(String s)
    {
        ResultSet resultset = null;
        String s1 = null;
        String s2 = " SELECT MR_MTGROLES_DESC FROM MEETING_ROLES  WHERE MR_MTGROLES_CODE = '" + s + "'";
        Statement statement = null;
        try
        {
            statement = conn.createStatement();
            resultset = statement.executeQuery(s2);
            if(!resultset.isBeforeFirst())
            {
                resultset.close();
                resultset = null;
                statement.close();
                statement = null;
            } else
            if(resultset.next())
                s1 = resultset.getString(1);
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        finally
        {
            try
            {
                resultset.close();
                resultset = null;
                statement.close();
                statement = null;
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public String[] queryMtgAttendeesOtherA(String s)
    {
        boolean flag = true;
        errmsg = "";
        Statement statement = null;
        ResultSet resultset = null;
        String as[] = new String[50];
        sql = "SELECT ma_attd_seq, ma_user_id, person_name, ma_attd_position, ma_attd_status, ma_attd_remark FROM meeting_attendance, cmsusers_view WHERE userid = ma_user_id AND ma_mtg_code = '" + s + "'";
        try
        {
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset != null)
            {
                for(int i = 0; resultset.next(); i++)
                    as[i] = resultset.getString(2);

            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
            boolean flag1 = false;
        }
        finally
        {
            try
            {
                if(resultset != null)
                {
                    resultset.close();
                    resultset = null;
                }
                if(statement != null)
                {
                    statement.close();
                    statement = null;
                }
            }
            catch(Exception exception1) { }
        }
        return as;
    }

    public boolean queryMtgAttendeesOther(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT ma_attd_seq, ma_user_id, person_name, ma_attd_position, ma_attd_status, ma_attd_remark FROM meeting_attendance_other, cmsusers_view WHERE userid = ma_user_id AND ma_mtg_code = '" + s + "'";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(!rset.isBeforeFirst())
            {
                flag = false;
                rset.close();
                rset = null;
                stmt.close();
                stmt = null;
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean nextMtgAttendeeOther()
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    attdSeq = rset.getString(1);
                    userID = rset.getString(2);
                    userName = rset.getString(3);
                    attdPosition = rset.getString(4);
                    attdStatus = rset.getString(5);
                    attdRemark = rset.getString(6);
                } else
                {
                    rset.close();
                    rset = null;
                    stmt.close();
                    stmt = null;
                    flag = false;
                }
            } else
            {
                flag = false;
                errmsg = "Result Set is NULL.";
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
            try
            {
                if(rset != null)
                {
                    rset.close();
                    rset = null;
                }
                if(stmt != null)
                {
                    stmt.close();
                    stmt = null;
                }
            }
            catch(Exception exception)
            {
                exception.printStackTrace();
            }
            flag = false;
        }
        return flag;
    }

    public static String updateAttendeeOtherNow(Connection connection, String s)
    {
        java.util.Hashtable hashtable = EMeetingMain.getChairman(connection, s);
        java.util.Hashtable hashtable1 = EMeetingMain.getSecretary(connection, s);
        String s1;
        if(hashtable == null)
            s1 = "Only 1 chairman allowed";
        else
        if(hashtable1 == null)
            s1 = "Only 1 secretary allowed";
        else
            s1 = "";
        try
        {
            if(s1.equals(""))
                connection.commit();
            else
                connection.rollback();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        return s1;
    }

    public boolean queryExternalUsers()
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT USERID,PERSON_NAME FROM CMSUSERS_VIEW WHERE USERTYPE = 'EXTERNAL'";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(!rset.isBeforeFirst())
            {
                flag = false;
                rset.close();
                rset = null;
                stmt.close();
                stmt = null;
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean nextExternalUsers()
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    userID = rset.getString(1);
                    userName = rset.getString(2);
                } else
                {
                    rset.close();
                    rset = null;
                    stmt.close();
                    stmt = null;
                    flag = false;
                }
            } else
            {
                flag = false;
                errmsg = "Result Set is NULL.";
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
            try
            {
                if(rset != null)
                {
                    rset.close();
                    rset = null;
                }
                if(stmt != null)
                {
                    stmt.close();
                    stmt = null;
                }
            }
            catch(Exception exception)
            {
                exception.printStackTrace();
            }
            flag = false;
        }
        return flag;
    }

    public boolean addAttendeeOther(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "INSERT INTO meeting_attendance_other( ma_attd_seq, ma_mtg_code, ma_user_id, ma_attd_position ) SELECT ma_attd_other_seq.nextval, ?, ? ,? FROM dual";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, userID);
            pstmt.setString(3, "MR0001");
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
            } else
            {
                errmsg = "No new record is created.";
                flag = false;
            }
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();
            try
            {
                conn.rollback();
            }
            catch(Exception exception)
            {
                exception.printStackTrace();
            }
        }
        finally
        {
            try
            {
                if(rset != null)
                {
                    rset.close();
                    rset = null;
                }
                if(pstmt != null)
                {
                    pstmt.close();
                    pstmt = null;
                }
            }
            catch(Exception exception2) { }
        }
        return flag;
    }

    public boolean addAttendeeOther(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        sql = "INSERT INTO meeting_attendance_other( ma_attd_seq, ma_mtg_code, ma_user_id, ma_attd_position ) SELECT ma_attd_seq.nextval, ?, ? ,? FROM dual";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, userID);
            pstmt.setString(3, s1);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
            } else
            {
                errmsg = "No new record is created.";
                flag = false;
            }
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();
            try
            {
                conn.rollback();
            }
            catch(Exception exception)
            {
                exception.printStackTrace();
            }
        }
        finally
        {
            try
            {
                if(rset != null)
                {
                    rset.close();
                    rset = null;
                }
                if(pstmt != null)
                {
                    pstmt.close();
                    pstmt = null;
                }
            }
            catch(Exception exception2) { }
        }
        return flag;
    }

    public static void updateAttendeeOther(Connection connection, String s, String s1, String s2, String s3, String s4)
    {
        PreparedStatement preparedstatement = null;
        try
        {
            preparedstatement = connection.prepareStatement("UPDATE meeting_attendance_other SET ma_attd_position = ?, ma_attd_status = ?, ma_attd_remark = ? WHERE ma_mtg_code = ? AND ma_attd_seq = ?");
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            preparedstatement.setString(4, s3);
            preparedstatement.setString(5, s4);
            preparedstatement.executeUpdate();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        finally
        {
            try
            {
                if(preparedstatement != null)
                    preparedstatement.close();
            }
            catch(Exception exception2) { }
        }
    }

    public static void removeAttendeeOther(Connection connection, String s, String s1)
    {
        PreparedStatement preparedstatement = null;
        try
        {
            preparedstatement = connection.prepareStatement("DELETE meeting_attendance_other WHERE ma_attd_seq = ? AND ma_mtg_code = ?");
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.executeUpdate();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        finally
        {
            try
            {
                if(preparedstatement != null)
                    preparedstatement.close();
            }
            catch(Exception exception2) { }
        }
    }

    public boolean removeAttendeeOther(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        sql = "DELETE meeting_attendance_other WHERE ma_attd_seq = ? AND ma_mtg_code = ? ";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
            } else
            {
                errmsg = "No matched record is removed.";
                flag = false;
            }
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            flag = false;
            errmsg = sqlexception.toString();
            try
            {
                conn.rollback();
            }
            catch(Exception exception) { }
        }
        finally
        {
            try
            {
                if(rset != null)
                {
                    rset.close();
                    rset = null;
                }
                if(pstmt != null)
                {
                    pstmt.close();
                    pstmt = null;
                }
            }
            catch(Exception exception2) { }
        }
        return flag;
    }

    public boolean removeAttendeeOther(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "DELETE meeting_attendance_other WHERE ma_mtg_code = ? ";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
                flag = true;
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            flag = false;
            errmsg = sqlexception.toString();
            try
            {
                conn.rollback();
            }
            catch(Exception exception) { }
        }
        finally
        {
            try
            {
                if(rset != null)
                {
                    rset.close();
                    rset = null;
                }
                if(pstmt != null)
                {
                    pstmt.close();
                    pstmt = null;
                }
            }
            catch(Exception exception2) { }
        }
        return flag;
    }

}