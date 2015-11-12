package cms.admin.meeting.bean;

import java.io.PrintStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import common.CommonFunction;

public class MeetingAgenda implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String agendaSeq;
    protected String mtgCode;
    protected String agendaDesc;
    protected String agendaLevel;
    protected String agendaSeqno;
    protected String parentAgenda;
    protected String sortSeq;
    protected String numbering;
    protected String attachDept;

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public String getAttachDept() {
		return attachDept;
	}

	public void setAttachDept(String attachDept) {
		this.attachDept = attachDept;
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

    public void setMtgCode(String s)
    {
        mtgCode = s;
    }

    public String getMtgCode()
    {
        return mtgCode;
    }

    public void setAgendaDesc(String s)
    {
        agendaDesc = s;
    }

    public String getAgendaDesc()
    {
        return agendaDesc;
    }

    public void setAgendaLevel(String s)
    {
        agendaLevel = s;
    }

    public String getAgendaLevel()
    {
        return agendaLevel;
    }

    public void setAgendaSeqno(String s)
    {
        agendaSeqno = s;
    }

    public String getAgendaSeqno()
    {
        return agendaSeqno;
    }

    public void setParentAgenda(String s)
    {
        if(s != null && s.equals("null"))
            s = null;
        parentAgenda = s;
    }

    public String getParentAgenda()
    {
        return parentAgenda;
    }

    public void setSortSeq(String s)
    {
        sortSeq = s;
    }

    public String getSortSeq()
    {
        return sortSeq;
    }

    public void setNumbering(String s)
    {
        if(s != null && s.equals("null"))
            s = null;
        numbering = s;
    }

    public String getNumbering()
    {
        return numbering;
    }

    public boolean queryMtgAgenda(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT ma_agenda_seq, ma_mtg_code, ma_agenda_desc, ma_agenda_level, ma_agenda_seqno, ma_parent_agenda, " +
        		"ma_sort_seq, ma_numbering, ma_attach_dept " +
        		"FROM meeting_agenda WHERE ma_mtg_code = '" + s + "' " + 
        		"ORDER BY ma_sort_seq";
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
            errmsg = sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean nextMtgAgenda()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    agendaSeq = rset.getString(1);
                    mtgCode = rset.getString(2);
                    String s = rset.getString(3);
                    agendaDesc = CommonFunction.ln2br(s);
                    agendaLevel = rset.getString(4);
                    agendaSeqno = rset.getString(5);
                    parentAgenda = rset.getString(6);
                    sortSeq = rset.getString(7);
                    numbering = rset.getString(8);
                    attachDept = rset.getString(9);
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

    public int getSortSeq(String s, String s1, String s2)
    {
        int i = getSortSeq0(s, s1, s2);
        if(i == -1)
            i = getSortSeqA(s, s1, s2);
        if(i == -1)
            i = getSortSeqB(s, s1, s2);
        return i;
    }

    private int getSortSeq0(String s, String s1, String s2)
    {
        Statement statement = null;
        ResultSet resultset = null;
        int i = -1;
        try
        {
            if(s.equals("") && s1.equals("0"))
                i = 1;
            else
            if(s1.equals("0"))
            {
                sql = "SELECT ma_sort_seq FROM meeting_agenda  WHERE ma_agenda_seq = '" + s + "'";
                statement = conn.createStatement();
                resultset = statement.executeQuery(sql);
                if(resultset.next())
                    i = resultset.getInt(1) + 1;
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
                if(resultset != null)
                    resultset.close();
                if(statement != null)
                    statement.close();
            }
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return i;
    }

    private int getSortSeqA(String s, String s1, String s2)
    {
        Statement statement = null;
        ResultSet resultset = null;
        int i = -1;
        try
        {
            sql = "SELECT Min(ma_sort_seq) FROM meeting_agenda  WHERE ma_parent_agenda " + (s.equals("") ? "is null" : " = '" + s + "'") + " AND ma_agenda_seqno > '" + s1 + "' AND ma_mtg_code = '" + s2 + "'";
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset.next() && resultset.getString(1) != null)
                i = resultset.getInt(1);
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
                    resultset.close();
                if(statement != null)
                    statement.close();
            }
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return i;
    }

    private int getSortSeqB(String s, String s1, String s2)
    {
        Statement statement = null;
        Statement statement1 = null;
        Statement statement2 = null;
        ResultSet resultset = null;
        ResultSet resultset1 = null;
        ResultSet resultset2 = null;
        int i = -1;
        boolean flag = true;
        try
        {
            String s3 = s.equals("") ? "is null" : "= '" + s + "'";
            sql = " SELECT ma_agenda_level, ma_sort_seq  FROM meeting_agenda WHERE ma_mtg_code = '" + s2 + "'" + " AND ma_parent_agenda " + s3 + " AND ma_agenda_seqno = " + s1 + " ORDER BY ma_sort_seq ";
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset.next())
            {
                int k = resultset.getInt(1);
                int l = resultset.getInt(2);
                sql = "SELECT ma_agenda_level, ma_sort_seq  FROM meeting_agenda  WHERE ma_mtg_code = '" + s2 + "'" + " AND ma_agenda_level < " + k + " AND ma_sort_seq     > " + l + " ORDER BY ma_sort_seq";
                statement1 = conn.createStatement();
                resultset1 = statement1.executeQuery(sql);
                if(resultset1.next())
                {
                    int j = resultset1.getInt(1);
                    i = resultset1.getInt(2);
                } else
                {
                    sql = "SELECT max(ma_sort_seq) FROM meeting_agenda  WHERE ma_mtg_code = '" + s2 + "'";
                    statement2 = conn.createStatement();
                    resultset2 = statement2.executeQuery(sql);
                    i = 1;
                    if(resultset2.next() && resultset2.getString(1) != null)
                        i = resultset2.getInt(1) + 1;
                }
            } else
            {
                System.out.println("Oops: condition not handled.");
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
                if(resultset != null)
                    resultset.close();
                if(resultset1 != null)
                    resultset1.close();
                if(resultset2 != null)
                    resultset2.close();
                if(statement != null)
                    statement.close();
                if(statement1 != null)
                    statement1.close();
                if(statement2 != null)
                    statement2.close();
            }
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return i;
    }

    public boolean addMtgAgenda(String s)
    {
        boolean flag = true;
        errmsg = "";
        Object obj = null;
        Object obj1 = null;
        Object obj2 = null;
        String s2 = "";
        try
        {
            sql = "SELECT 1 FROM meeting_agenda WHERE ma_sort_seq = " + sortSeq + " AND ma_mtg_code =  '" + s + "'";
            stmt = conn.createStatement();
            Statement statement = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                sql = "UPDATE meeting_agenda SET ma_sort_seq = ma_sort_seq + 1 WHERE ma_sort_seq >= " + sortSeq + " AND ma_mtg_code = '" + s + "'";
                stmt.executeUpdate(sql);
            }
            rset.close();
            String s3;
            if(numbering.trim().length() > 0)
                s3 = " AND ma_numbering = '" + numbering + "'";
            else
                s3 = " AND ma_numbering IS NULL";
            sql = "SELECT 1 FROM meeting_agenda WHERE ma_agenda_seqno = " + agendaSeqno + " AND ma_agenda_level = " + agendaLevel + " AND ma_mtg_code = '" + s + "'";
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                sql = "UPDATE meeting_agenda SET ma_agenda_seqno = ma_agenda_seqno + 1 WHERE ma_agenda_seqno >= " + agendaSeqno + " AND ma_agenda_level = " + agendaLevel + " AND ma_mtg_code = '" + s + "' " + s3;
                stmt.executeUpdate(sql);
            }
            rset.close();
            stmt.close();
            String s1 = "SELECT  'M' || lpad( ma_agenda_seq.nextval, 9, '0' )\tFROM DUAL";
            ResultSet resultset = statement.executeQuery(s1);
            if(resultset.next())
                agendaSeq = resultset.getString(1);
            resultset.close();
            statement.close();
            sql = "INSERT INTO meeting_agenda( ma_agenda_seq, ma_mtg_code, ma_agenda_desc, ma_agenda_level,  ma_agenda_seqno, ma_parent_agenda, ma_sort_seq, ma_numbering ) VALUES (?, ?, ?, ?, ?, ?, ?, ?) ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, agendaSeq);
            pstmt.setString(2, s);
            pstmt.setString(3, agendaDesc);
            pstmt.setString(4, agendaLevel);
            pstmt.setString(5, agendaSeqno);
            pstmt.setString(6, parentAgenda);
            pstmt.setString(7, sortSeq);
            pstmt.setString(8, numbering);
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

    public boolean updateMtgAgenda(String s, String s1, String s2)
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_agenda SET ma_agenda_desc = '" + s + "'" + " WHERE ma_agenda_seq = '" + s1 + "' AND ma_mtg_code = '" + s2 + "'";
        try
        {
            pstmt = conn.prepareStatement(sql);
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

    public boolean hasChild(String s, String s1)
    {
        PreparedStatement preparedstatement = null;
        ResultSet resultset = null;
        boolean flag = true;
        try
        {
            String s2 = " SELECT  * FROM meeting_agenda WHERE ma_parent_agenda = ? AND ma_mtg_code = ? ";
            preparedstatement = conn.prepareStatement(s2);
            preparedstatement.setString(1, s1.trim());
            preparedstatement.setString(2, s.trim());
            resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                flag = false;
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
                preparedstatement.close();
                preparedstatement = null;
            }
            catch(Exception exception1)
            {
                exception1.printStackTrace();
            }
        }
        return flag;
    }

    public boolean removeMtgAgenda(HttpServletRequest httpservletrequest, ServletContext servletcontext, String s, String s1, String s2, String s3, String s4)
    {
        boolean flag = true;
        errmsg = "";
        Statement statement = null;
        Statement statement1 = null;
        String s5 = s4;
        String s6 = s3;
        if(s6 != null && s6.equals("null"))
            s6 = null;
        String s7 = s1;
        try
        {
            MeetingNotes meetingnotes = new MeetingNotes();
            meetingnotes.setDBConnection(conn);
            if(flag && !meetingnotes.removeMtgNotes_agenda(s.trim()))
                flag = false;
            MeetingAgendaAttachment meetingagendaattachment = new MeetingAgendaAttachment();
            meetingagendaattachment.setDBConnection(conn);
            if(flag && !meetingagendaattachment.removeAttachment(s.trim()))
                flag = false;
            MeetingDecision meetingdecision = new MeetingDecision();
            meetingdecision.setDBConnection(conn);
            if(flag && !meetingdecision.removeMtgDecision(httpservletrequest, servletcontext, s.trim()))
                flag = false;
            if(flag)
            {
                sql = "DELETE meeting_agenda WHERE ma_agenda_seq = ? AND ma_mtg_code = ? ";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, s.trim());
                pstmt.setString(2, s1.trim());
                pstmt.executeUpdate();
            }
            if(flag)
            {
                sql = "UPDATE meeting_agenda SET ma_sort_seq = ma_sort_seq - 1 WHERE ma_sort_seq >= '" + s2 + "' AND ma_mtg_code = '" + s1 + "'";
                statement = conn.createStatement();
                statement.executeUpdate(sql);
                if(s6 != null)
                    sql = " UPDATE meeting_agenda  SET ma_agenda_seqno = ma_agenda_seqno - 1  WHERE ma_mtg_code = '" + s7 + "'" + " AND ma_parent_agenda = '" + s6 + "'" + " AND ma_agenda_seqno > '" + s5 + "'";
                else
                    sql = " UPDATE meeting_agenda  SET ma_agenda_seqno = ma_agenda_seqno - 1  WHERE ma_mtg_code = '" + s7 + "'" + " AND ma_parent_agenda is null " + " AND ma_agenda_seqno > '" + s5 + "'";
                statement1 = conn.createStatement();
                statement1.executeUpdate(sql);
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
                if(statement != null)
                {
                    statement.close();
                    statement = null;
                }
                if(statement1 != null)
                {
                    statement1.close();
                    statement1 = null;
                }
            }
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return flag;
    }

    public boolean removeMtgAgenda(String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            String s1 = queryMeetingAgendaCode(s.trim());
            MeetingAgendaAttachment meetingagendaattachment = new MeetingAgendaAttachment();
            meetingagendaattachment.setDBConnection(conn);
            if(!s1.equals("null") && !meetingagendaattachment.removeAttachment(s1.trim()))
                flag = false;
            boolean flag1 = false;
            if(flag)
            {
                sql = "DELETE meeting_agenda WHERE ma_mtg_code = ? ";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, s.trim());
                int i = pstmt.executeUpdate();
                pstmt.close();
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

    public String queryMeetingAgendaCode(String s)
    {
        String s1 = null;
        PreparedStatement preparedstatement = null;
        ResultSet resultset = null;
        sql = "SELECT  MA_AGENDA_SEQ FROM MEETING_AGENDA WHERE MA_MTG_CODE = '" + s + "'";
        try
        {
            preparedstatement = conn.prepareStatement(sql);
            resultset = preparedstatement.executeQuery();
            if(resultset != null)
            {
                if(resultset.next())
                    s1 = resultset.getString(1);
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
                resultset.close();
                preparedstatement.close();
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public void updateAgendaNumbering(String s)
    {
        PreparedStatement preparedstatement = null;
        ResultSet resultset = null;
        Object obj = null;
        sql = "SELECT ma_agenda_seq, ma_mtg_code FROM MEETING_AGENDA WHERE ma_mtg_code = '" + s + "'" + " AND ma_parent_agenda is null" + " ORDER by ma_sort_seq";
        try
        {
            int i = 1;
            preparedstatement = conn.prepareStatement(sql);
            for(resultset = preparedstatement.executeQuery(); resultset.next();)
            {
                String s1 = resultset.getString(1);
                updateAgendaNumberingA(s, s1.trim(), i + ".");
                i++;
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
    }

    public void updateAgendaNumberingA(String s, String s1, String s2)
    {
        PreparedStatement preparedstatement = null;
        Object obj = null;
        ResultSet resultset = null;
        Object obj1 = null;
        Object obj2 = null;
        sql = "SELECT ma_agenda_seq, ma_mtg_code FROM MEETING_AGENDA WHERE ma_mtg_code = '" + s + "'" + " AND ma_parent_agenda ='" + s1 + "'" + " ORDER BY ma_sort_seq ";
        try
        {
            int i = 1;
            preparedstatement = conn.prepareStatement(sql);
            resultset = preparedstatement.executeQuery();
            if(resultset != null)
                while(resultset.next()) 
                {
                    String s3 = resultset.getString(1);
                    String s5 = s2;
                    String s4 = " UPDATE meeting_agenda SET ma_numbering= ? WHERE ma_agenda_seq = ? AND ma_mtg_Code = ?";
                    PreparedStatement preparedstatement1 = conn.prepareStatement(s4);
                    preparedstatement1.setString(1, s5);
                    preparedstatement1.setString(2, s3);
                    preparedstatement1.setString(3, s);
                    preparedstatement1.executeUpdate();
                    updateAgendaNumberingA(s, s3, s2 + i + ".");
                    i++;
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
    }

    public void copyMtgAgendaMain(String s, String s1)
    {
        PreparedStatement preparedstatement = null;
        ResultSet resultset = null;
        Object obj = null;
        sql = "SELECT ma_agenda_seq, ma_mtg_code, ma_agenda_desc, ma_agenda_level,  ma_agenda_seqno, ma_parent_agenda, ma_sort_seq, ma_numbering  FROM MEETING_AGENDA WHERE ma_mtg_code = '" + s + "'" + " AND ma_parent_agenda is null" + " ORDER by ma_sort_seq";
        try
        {
            int i = 1;
            preparedstatement = conn.prepareStatement(sql);
            for(resultset = preparedstatement.executeQuery(); resultset.next();)
            {
                agendaDesc = resultset.getString(3);
                agendaLevel = resultset.getString(4);
                agendaSeqno = resultset.getString(5);
                parentAgenda = resultset.getString(6);
                sortSeq = resultset.getString(7);
                numbering = resultset.getString(8);
                copyMtgAgendaA(s1);
                String s2 = resultset.getString(1);
                copyMtgAgendaB(s, s1, s2.trim(), i + ".");
                i++;
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
    }

    public void copyMtgAgendaB(String s, String s1, String s2, String s3)
    {
        PreparedStatement preparedstatement = null;
        Object obj = null;
        ResultSet resultset = null;
        Object obj1 = null;
        Object obj2 = null;
        sql = "SELECT ma_agenda_seq, ma_mtg_code, ma_agenda_desc, ma_agenda_level,  ma_agenda_seqno, ma_parent_agenda, ma_sort_seq, ma_numbering  FROM MEETING_AGENDA WHERE ma_mtg_code = '" + s + "'" + " AND ma_parent_agenda ='" + s2 + "'" + " ORDER BY ma_sort_seq ";
        try
        {
            int i = 1;
            preparedstatement = conn.prepareStatement(sql);
            resultset = preparedstatement.executeQuery();
            if(resultset != null)
                while(resultset.next()) 
                {
                    agendaDesc = resultset.getString(3);
                    agendaLevel = resultset.getString(4);
                    agendaSeqno = resultset.getString(5);
                    parentAgenda = resultset.getString(6);
                    sortSeq = resultset.getString(7);
                    numbering = resultset.getString(8);
                    copyMtgAgendaA(s1);
                    String s4 = resultset.getString(1);
                    String s5 = s3;
                    copyMtgAgendaB(s, s1, s4, s3 + i + ".");
                    i++;
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
    }

    public boolean copyMtgAgendaA(String s)
    {
        boolean flag = true;
        errmsg = "";
        Object obj = null;
        Object obj1 = null;
        Object obj2 = null;
        try
        {
            Statement statement = conn.createStatement();
            String s1 = "SELECT  'M' || lpad( ma_agenda_seq.nextval, 9, '0' )\tFROM DUAL";
            ResultSet resultset = statement.executeQuery(s1);
            if(resultset.next())
                agendaSeq = resultset.getString(1);
            resultset.close();
            statement.close();
            sql = "INSERT INTO meeting_agenda( ma_agenda_seq, ma_mtg_code, ma_agenda_desc, ma_agenda_level,  ma_agenda_seqno, ma_parent_agenda, ma_sort_seq, ma_numbering ) VALUES (?, ?, ?, ?, ?, ?, ?, ?) ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, agendaSeq);
            pstmt.setString(2, s);
            pstmt.setString(3, agendaDesc);
            pstmt.setString(4, agendaLevel);
            pstmt.setString(5, agendaSeqno);
            pstmt.setString(6, parentAgenda);
            pstmt.setString(7, sortSeq);
            pstmt.setString(8, numbering);
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

    public boolean updateAttachmentDept(String dept, String agendaSeq, String meetingCode)
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_agenda SET ma_attach_dept = '" + dept + "'" + 
        		" WHERE ma_agenda_seq = '" + agendaSeq + "' AND ma_mtg_code = '" + meetingCode + "'";
        try
        {
            pstmt = conn.prepareStatement(sql);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
                flag = true;
            else {
                errmsg = "No matched record is updated.";
                flag = false;
            }
            conn.commit();
        }
        catch(SQLException sqle) {
        	sqle.printStackTrace();
            flag = false;
            errmsg = sqle.toString();
            try {
                conn.rollback();
            }
            catch(Exception ex) {
                ex.printStackTrace();
            }
        }
        finally {
            try {
                if (rset != null) rset.close();
                if (pstmt != null) pstmt.close();
            }
            catch(Exception ex) { }
        }
        return flag;
    }

}