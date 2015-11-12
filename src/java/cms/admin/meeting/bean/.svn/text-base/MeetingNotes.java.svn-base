package cms.admin.meeting.bean;

import java.io.PrintStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import common.CommonFunction;

public class MeetingNotes
  implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String noteSeq;
    protected String agendaSeq;
    protected String mtgCode;
    protected String notes;
    protected String attendeeID;
    protected String attendeeOtherID;

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

    public void setNotesSeq(String s)
    {
        noteSeq = s;
    }

    public String getNotesSeq()
    {
        return noteSeq;
    }

    public void setAttendeeID(String s)
    {
        attendeeID = s;
    }

    public String getAttendeeID()
    {
        return attendeeID;
    }

    public void setAttendeeOtherID(String s)
    {
        attendeeOtherID = s;
    }

    public String getAttendeeOtherID()
    {
        return attendeeOtherID;
    }

    public void setMtgCode(String s)
    {
        mtgCode = s;
    }

    public String getMtgCode()
    {
        return mtgCode;
    }

    public void setNotes(String s)
    {
        notes = s;
    }

    public String getNotes()
    {
        return notes;
    }

    public void setAgendaSeq(String s)
    {
        agendaSeq = s;
    }

    public String getAgendaSeq()
    {
        return agendaSeq;
    }

    public boolean queryMtgNotes(String s, String s1, String s2)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT mmn_note_seq, mmn_attendee_seq_id, mmn_attendee_other_seq_id, mmn_agenda_seq,mmn_notes FROM meeting_member_notes WHERE mmn_agenda_seq = '" + s + "'" + " AND " + s2 + "='" + s1 + "'";
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

    public boolean nextMtgNotes()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    noteSeq = rset.getString(1);
                    attendeeID = rset.getString(2);
                    attendeeOtherID = rset.getString(3);
                    agendaSeq = rset.getString(4);
                    String s = new String(CommonFunction.stream2String(rset.getAsciiStream(5)));
                    notes = CommonFunction.ln2br(s);
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

    public boolean addMtgNotes(String s, String s1, String s2)
    {
        boolean flag = true;
        errmsg = "";
        Object obj = null;
        Object obj1 = null;
        Object obj2 = null;
        Object obj3 = null;
        Object obj4 = null;
        try
        {
            Statement statement = conn.createStatement();
            String s3 = "SELECT  'M' || lpad( mmn_note_seq.nextval, 9, '0' ) FROM DUAL";
            ResultSet resultset = statement.executeQuery(s3);
            if(resultset.next())
                noteSeq = resultset.getString(1);
            resultset.close();
            statement.close();
            sql = "INSERT INTO meeting_member_notes(mmn_note_seq, " + s1 + " , mmn_agenda_seq, mmn_notes )" + " VALUES (?,?,?,?) ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, noteSeq);
            pstmt.setString(2, s2);
            pstmt.setString(3, s);
            pstmt.setString(4, notes);
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

    public boolean updateMtgNotes()
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_member_notes SET mmn_notes = ? WHERE mmn_note_seq = ?";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, notes);
            pstmt.setString(2, noteSeq);
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

    public boolean removeMtgNotes(String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "DELETE meeting_member_notes WHERE mmn_note_seq = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
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

    public boolean removeMtgNotes_agenda(String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "DELETE meeting_member_notes WHERE mmn_agenda_seq = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.executeUpdate();
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

    public String getAttendeeSeq(String s)
    {
        Statement statement = null;
        ResultSet resultset = null;
        String s1 = null;
        try
        {
            sql = "SELECT MA_ATTD_SEQ FROM MEETING_ATTENDANCE WHERE MA_STAFF_ID = '" + s + "'";
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset.next())
                s1 = resultset.getString(1);
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
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
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return s1;
    }

    public String getAttendeeOtherSeq(String s)
    {
        Statement statement = null;
        ResultSet resultset = null;
        String s1 = null;
        try
        {
            sql = "SELECT MA_ATTD_SEQ FROM MEETING_ATTENDANCE_OTHER WHERE MA_USER_ID = '" + s + "'";
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset.next())
                s1 = resultset.getString(1);
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
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
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return s1;
    }
}