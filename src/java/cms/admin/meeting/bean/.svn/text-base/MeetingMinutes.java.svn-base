package cms.admin.meeting.bean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import common.CommonFunction;

public class MeetingMinutes
  implements Serializable
{
    protected String createdBy;
    protected String minutesCode;
    protected String minutes;
    protected String meetingCode;
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;

    public String getErrorMessage()
    {
        return errmsg;
    }

    public String getSQL()
    {
        return sql;
    }

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public Connection getDBConnection()
    {
        return conn;
    }

    public void setMinutesCode(String s)
    {
        minutesCode = s;
    }

    public String getMinutesCode()
    {
        return minutesCode;
    }

    public void setMeetingCode(String s)
    {
        meetingCode = s;
    }

    public String getMeetingCode()
    {
        return meetingCode;
    }

    public void setMinutes(String s)
    {
        minutes = s;
    }

    public String getMinutes()
    {
        return minutes;
    }

    public void setCreatedBy(String s)
    {
        createdBy = s;
    }

    public String getCreatedBy()
    {
        return createdBy;
    }

    public boolean queryMinutes(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = " SELECT MM_MINUTES FROM MEETING_MINUTES WHERE MM_MINUTES_MTG_CODE = '" + s + "'";
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

    public boolean nextMinutes()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    minutes = CommonFunction.clob2String(rset.getClob(1));
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
            catch(Exception exception) { }
            flag = false;
        }
        return flag;
    }

    public boolean addMinutes()
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "SELECT 'M' || lpad( MM_MINUTES_CODE.nextval, 9, '0' ) FROM dual";
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
                minutesCode = rset.getString(1);
            rset.close();
            stmt.close();
            if(minutesCode != null && minutesCode.length() > 0)
            {
                sql = "INSERT INTO MEETING_MINUTES (MM_MINUTES_CODE, MM_MINUTES_MTG_CODE, MM_MINUTES, MM_CREATED_BY) VALUES (?,?,?,?)\t";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, minutesCode);
                pstmt.setString(2, meetingCode);
                pstmt.setString(3, minutes);
                pstmt.setString(4, createdBy);
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
            } else
            {
                errmsg = "Fail to generate unique sequence number for the meeting minutes code";
                flag = false;
            }
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
                if(stmt != null)
                {
                    stmt.close();
                    stmt = null;
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

    public boolean updateMinutes()
    {
        boolean flag = false;
        errmsg = "";
        try
        {
            sql = "UPDATE meeting_minutes SET mm_minutes = ? WHERE mm_minutes_mtg_code = ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, minutes);
            pstmt.setString(2, meetingCode);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
                flag = true;
            else
                errmsg = "No matched record is updated.";
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
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
                if(stmt != null)
                {
                    stmt.close();
                    stmt = null;
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