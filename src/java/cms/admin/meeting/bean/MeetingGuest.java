package cms.admin.meeting.bean;

import java.io.PrintStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MeetingGuest
  implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String guestId;
    protected String mtgCode;
    protected String guestName;
    protected String guestTitle;
    protected String guestFrom;
    protected String guestRemark;
    protected String passwd;
    protected String guestEmail;

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public String getSQL()
    {
        return sql;
    }

    public void setGuestId(String s)
    {
        guestId = s;
    }

    public String getGuestId()
    {
        return guestId;
    }

    public void setMtgCode(String s)
    {
        mtgCode = s;
    }

    public String getMtgCode()
    {
        return mtgCode;
    }

    public void setGuestName(String s)
    {
        guestName = s;
    }

    public String getGuestName()
    {
        return guestName;
    }

    public void setGuestTitle(String s)
    {
        guestTitle = s;
    }

    public String getGuestTitle()
    {
        return guestTitle;
    }

    public void setGuestFrom(String s)
    {
        guestFrom = s;
    }

    public String getGuestFrom()
    {
        return guestFrom;
    }

    public void setGuestRemark(String s)
    {
        guestRemark = s;
    }

    public String getGuestRemark()
    {
        return guestRemark;
    }

    public void setPasswd(String s)
    {
        passwd = s;
    }

    public String getPasswd()
    {
        return passwd;
    }

    public void setGuestEmail(String s)
    {
        guestEmail = s;
    }

    public String getGuestEmail()
    {
        return guestEmail;
    }

    public boolean queryMeetingGuest(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT mg_guest_id, mg_mtg_code, mg_guest_name, mg_guest_title, mg_guest_from, mg_guest_remark, mg_passwd,mg_guest_email FROM meeting_guest WHERE mg_mtg_code = '" + s + "'";
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
            flag = false;
        }
        return flag;
    }

    public boolean nextMeetingGuest()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    guestId = rset.getString(1);
                    mtgCode = rset.getString(2);
                    guestName = rset.getString(3);
                    guestTitle = rset.getString(4);
                    guestFrom = rset.getString(5);
                    guestRemark = rset.getString(6);
                    passwd = rset.getString(7);
                    guestEmail = rset.getString(8);
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

    public boolean queryMeetingGuestA(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT mg_guest_id, mg_mtg_code, mg_guest_name, mg_guest_title, mg_guest_from, mg_guest_remark, mg_passwd,mg_guest_email FROM meeting_guest WHERE mg_mtg_code = '" + s + "'" + "AND mg_guest_id = '" + s1 + "'";
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
            flag = false;
        }
        return flag;
    }

    public boolean nextMeetingGuestA()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    guestId = rset.getString(1);
                    mtgCode = rset.getString(2);
                    guestName = rset.getString(3);
                    guestTitle = rset.getString(4);
                    guestFrom = rset.getString(5);
                    guestRemark = rset.getString(6);
                    passwd = rset.getString(7);
                    guestEmail = rset.getString(8);
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

    public boolean addGuest(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "INSERT INTO meeting_guest( mg_guest_id, mg_mtg_code, mg_guest_name, mg_guest_title, mg_guest_from, mg_guest_remark, mg_passwd, mg_guest_email ) SELECT 'G' || lpad( mg_guest_id.nextval, 9, '0' ), ?, ?, ?, ?, ?, ?, ? FROM dual";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, guestName);
            pstmt.setString(3, guestTitle);
            pstmt.setString(4, guestFrom);
            pstmt.setString(5, guestRemark);
            pstmt.setString(6, passwd);
            pstmt.setString(7, guestEmail);
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

    public boolean updateGuest(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_guest SET mg_guest_name = ?, mg_guest_title = ?, mg_guest_from = ?, mg_guest_remark = ?, mg_passwd = ? , mg_guest_email = ? WHERE mg_mtg_code = ? AND mg_guest_id = ?";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, guestName);
            pstmt.setString(2, guestTitle);
            pstmt.setString(3, guestFrom);
            pstmt.setString(4, guestRemark);
            pstmt.setString(5, passwd);
            pstmt.setString(6, guestEmail);
            pstmt.setString(7, s1);
            pstmt.setString(8, s);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
            } else
            {
                errmsg = "No matched record is updated.";
                flag = false;
            }
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            flag = false;
            sqlexception.printStackTrace();
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

    public boolean removeGuest(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        System.out.println("removeGuest");
        sql = "DELETE meeting_guest WHERE mg_mtg_code = ? AND mg_guest_id = ?";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s1.trim());
            pstmt.setString(2, s.trim());
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
            } else
            {
                System.out.println("testing");
                errmsg = "No matched record is removed.";
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
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return flag;
    }

    public boolean removeGuest(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "DELETE meeting_guest WHERE mg_mtg_code = ?";
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