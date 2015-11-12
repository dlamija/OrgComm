package cms.admin.meeting.bean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

public class MeetingActionBy implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String actionSeq;
    protected String actionBy;
    protected String userType;
    protected String personName;

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public void setActionSeq(String s)
    {
        actionSeq = s;
    }

    public void setActionBy(String s)
    {
        actionBy = s;
    }

    public void setUserType(String s)
    {
        userType = s;
    }

    public void setPersonName(String s)
    {
        personName = s;
    }

    public String getActionSeq()
    {
        return actionSeq;
    }

    public String getActionBy()
    {
        return actionBy;
    }

    public String getUserType()
    {
        return userType;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public String getPersonName()
    {
        return personName;
    }

    public Vector querySelectedActionBy(String s, String s1)
    {
        Statement statement = null;
        Vector vector = new Vector();
        Object obj = null;
        String s2 = "SELECT USERTYPE, STAFFID, USERID, PERSON_NAME FROM MEETINGATTENDEES_VIEW, MEETING_DEC_ACTIONBY  WHERE MEETINGCODE = '" + s + "'" + " AND MDAB_ACTION_SEQ = '" + s1 + "'" + " AND MDAB_USER_TYPE = USERTYPE " + " AND ((MDAB_USER_TYPE = 'STAFF' AND MDAB_ACTION_BY = STAFFID) " + " OR (MDAB_USER_TYPE = 'OTHER' AND MDAB_ACTION_BY = USERID)) ";
        try
        {
            statement = conn.createStatement();
            MeetingActionBy meetingactionby;
            for(rset = statement.executeQuery(s2); rset.next(); vector.addElement(meetingactionby))
            {
                meetingactionby = new MeetingActionBy();
                String s3 = rset.getString(1);
                if(s3.equals("STAFF"))
                {
                    meetingactionby.setActionBy(rset.getString(2));
                    meetingactionby.setPersonName(rset.getString(4));
                } else
                {
                    meetingactionby.setActionBy(rset.getString(3));
                    meetingactionby.setPersonName(rset.getString(4));
                }
            }

        }
        catch(Exception exception)
        {
            exception.printStackTrace();
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
                if(statement != null)
                {
                    statement.close();
                    statement = null;
                }
            }
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return vector;
    }

    public Vector queryUnselectedActionBy(String s, String s1)
    {
        Statement statement = null;
        Vector vector = new Vector();
        Object obj = null;
        String s2 = "SELECT USERTYPE, STAFFID, USERID, PERSON_NAME FROM MEETINGATTENDEES_VIEW MV WHERE MEETINGCODE= '" + s + "'" + " AND NOT EXISTS ( " + " SELECT USERID,STAFFID " + " FROM MEETINGATTENDEES_VIEW, MEETING_DEC_ACTIONBY " + " WHERE MEETINGCODE = MV.MEETINGCODE " + " AND MDAB_ACTION_SEQ = '" + s1 + "'" + " AND MDAB_USER_TYPE = USERTYPE " + " AND MV.USERTYPE = USERTYPE " + " AND (" + " (MDAB_USER_TYPE = 'STAFF' AND MDAB_ACTION_BY = STAFFID AND STAFFID = MV.STAFFID) " + " OR " + " (MDAB_USER_TYPE = 'OTHER' AND MDAB_ACTION_BY = USERID AND USERID = MV.USERID) " + ") " + ")";
        try
        {
            statement = conn.createStatement();
            MeetingActionBy meetingactionby;
            for(rset = statement.executeQuery(s2); rset.next(); vector.addElement(meetingactionby))
            {
                meetingactionby = new MeetingActionBy();
                String s3 = rset.getString(1);
                if(s3.equals("STAFF"))
                {
                    meetingactionby.setActionBy(rset.getString(2));
                    meetingactionby.setPersonName(rset.getString(4));
                } else
                {
                    meetingactionby.setActionBy(rset.getString(3));
                    meetingactionby.setPersonName(rset.getString(4));
                }
            }

        }
        catch(Exception exception)
        {
            exception.printStackTrace();
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
                if(statement != null)
                {
                    statement.close();
                    statement = null;
                }
            }
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return vector;
    }

    public String queryDueDate(String s)
    {
        ResultSet resultset = null;
        Statement statement = null;
        String s1 = null;
        String s2 = "SELECT md_due_date  FROM meeting_decision WHERE md_decision_seq = '" + s + "'";
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

    public boolean queryIsActionBy(String s, String s1)
    {
        ResultSet resultset = null;
        Statement statement = null;
        boolean flag = false;
        String s2 = "SELECT MDAB_ACTION_BY  FROM MEETING_DEC_ACTIONBY WHERE MDAB_ACTION_BY = '" + s + "'" + " AND MDAB_ACTION_SEQ = '" + s1 + "'";
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
                flag = false;
            } else
            {
                flag = true;
            }
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
        return flag;
    }

    public boolean queryActionBy(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT MDAB_ACTION_SEQ, MDAB_ACTION_BY, MDAB_USER_TYPE  FROM MEETING_DEC_ACTIONBY  WHERE MDAB_ACTION_SEQ = '" + s + "'";
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

    public boolean nextActionBy()
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    actionSeq = rset.getString(1);
                    actionBy = rset.getString(2);
                    userType = rset.getString(3);
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

    public boolean addActionBy()
    {
        boolean flag = true;
        errmsg = "";
        sql = "INSERT INTO meeting_dec_actionby(  MDAB_ACTION_SEQ, MDAB_ACTION_BY, MDAB_USER_TYPE )  VALUES( ?,?,?)";
        try
        {
            int i = actionBy.indexOf("-");
            if(i != -1)
                userType = "OTHER";
            else
                userType = "STAFF";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, actionSeq);
            pstmt.setString(2, actionBy);
            pstmt.setString(3, userType);
            int j = pstmt.executeUpdate();
            pstmt.close();
            if(j > 0)
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
            sqlexception.printStackTrace();
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

    public boolean removeActionBy(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "DELETE meeting_dec_actionby WHERE mdab_action_seq = ? ";
        try
        {
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
}