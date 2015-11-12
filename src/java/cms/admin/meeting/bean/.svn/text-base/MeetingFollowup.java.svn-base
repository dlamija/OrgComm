package cms.admin.meeting.bean;

import java.io.PrintStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MeetingFollowup
  implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String followupSeq;
    protected String decisionSeq;
    protected String mtgCode;
    protected String followup;

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

    public void setFollowupSeq(String s)
    {
        followupSeq = s;
    }

    public String getFollowupSeq()
    {
        return followupSeq;
    }

    public void setDecisionSeq(String s)
    {
        decisionSeq = s;
    }

    public String getDecisionSeq()
    {
        return decisionSeq;
    }

    public void setMtgCode(String s)
    {
        mtgCode = s;
    }

    public String getMtgCode()
    {
        return mtgCode;
    }

    public void setFollowup(String s)
    {
        followup = s;
    }

    public String getFollowup()
    {
        return followup;
    }

    public boolean queryMtgFollowup(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT mf_followup_seq, mf_decision_seq, mf_followup FROM meeting_followup WHERE mf_decision_seq = '" + s + "'" + "ORDER BY mf_followup_seq ";
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

    public boolean nextMtgFollowup()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    followupSeq = rset.getString(1);
                    decisionSeq = rset.getString(2);
                    followup = rset.getString(3);
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

    public boolean addMtgFollowup(String s)
    {
        boolean flag = true;
        errmsg = "";
        Object obj = null;
        Object obj1 = null;
        try
        {
            sql = "INSERT INTO meeting_followup(mf_followup_seq, mf_decision_seq, mf_followup )SELECT  'M' || lpad( mf_followup_seq.nextval, 9, '0' ), ?, ? FROM dual";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, followup);
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
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return flag;
    }

    public boolean updateMtgFollowup()
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_followup SET mf_followup = ? WHERE mf_followup_seq = ?";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, followup);
            pstmt.setString(2, followupSeq);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
            } else
            {
                errmsg = "No matched record is updated.";
                flag = false;
                System.out.println("errmsg" + errmsg);
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

    public boolean removeMtgFollowup(String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "DELETE meeting_followup WHERE mf_followup_seq = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
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

    public boolean removeMtgFollowupA(String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            if(s != null)
            {
                sql = "DELETE meeting_followup WHERE MF_DECISION_SEQ = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, s.trim());
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
}