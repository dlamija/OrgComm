package cms.admin.meeting.bean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MeetingAgendaAttachment implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String agendaSeq;
    protected String attcSeqNo;
    protected String originalFileName;
    protected String physicalFileName;

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

    public void setAgendaSeq(String s)
    {
        agendaSeq = s;
    }

    public String getAgendaSeq()
    {
        return agendaSeq;
    }

    public void setAttcSeqNo(String s)
    {
        attcSeqNo = s;
    }

    public String getAttcSeqNo()
    {
        return attcSeqNo;
    }

    public void setOriginalFileName(String s)
    {
        originalFileName = s;
    }

    public String getOriginalFileName()
    {
        return originalFileName;
    }

    public void setPhysicalFileName(String s)
    {
        physicalFileName = s;
    }

    public String getPhysicalFileName()
    {
        return physicalFileName;
    }

    public boolean queryAttachment(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT maa_agenda_seq, maa_attc_seqno, maa_original_file_name, maa_physical_file_name  FROM meeting_agenda_attc WHERE maa_agenda_seq = '" + s + "'";
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

    public boolean nextAttachment()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    agendaSeq = rset.getString(1);
                    attcSeqNo = rset.getString(2);
                    originalFileName = rset.getString(3);
                    physicalFileName = rset.getString(4);
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

    public String queryPhysicalFileName(String s, String s1)
    {
        PreparedStatement preparedstatement = null;
        ResultSet resultset = null;
        String s2 = null;
        try
        {
            String s3 = " SELECT MAA_PHYSICAL_FILE_NAME FROM MEETING_AGENDA_ATTC WHERE  MAA_AGENDA_SEQ = '" + s.trim() + "' AND MAA_ATTC_SEQNO = '" + s1.trim() + "'";
            preparedstatement = conn.prepareStatement(s3);
            resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s2 = resultset.getString(1);
            preparedstatement = conn.prepareStatement(s3);
            resultset = preparedstatement.executeQuery();
            if(resultset != null)
            {
                if(resultset.next())
                    s2 = resultset.getString(1);
                resultset.close();
                resultset = null;
                preparedstatement.close();
                preparedstatement = null;
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
                if(resultset != null)
                    resultset.close();
                if(preparedstatement != null)
                    preparedstatement.close();
            }
            catch(Exception exception1)
            {
                exception1.printStackTrace();
            }
        }
        return s2;
    }

    public boolean removeAttachment(String s, String s1, String s2)
    {
        boolean flag = true;
        errmsg = "";
        Object obj = null;
        Statement statement = null;
        ResultSet resultset = null;
        Object obj1 = null;
        try
        {
            sql = "DELETE meeting_agenda_attc WHERE maa_agenda_seq = ? AND maa_attc_seqno = ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s.trim());
            pstmt.setString(2, s1.trim());
            pstmt.executeUpdate();
            pstmt.close();
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
                if(resultset != null)
                {
                    resultset.close();
                    resultset = null;
                }
                if(pstmt != null)
                {
                    pstmt.close();
                    pstmt = null;
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
        return flag;
    }

    public boolean removeAttachment(String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "DELETE meeting_agenda_attc WHERE maa_agenda_seq = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s.trim());
            pstmt.executeUpdate();
            pstmt.close();
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