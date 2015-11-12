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

import utilities.QueryUtil;

public class MeetingDecision
  implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String decisionSeq;
    protected String agendaSeq;
    protected String mtgCode;
    protected String decision;
    protected String decisionLevel;
    protected String decisionSeqno;
    protected String parentDecision;
    protected String sortSeq;
    protected String numbering;
    protected String dueDate;
    protected String decisionCategory;

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public String getDecisionCategory() {
		return decisionCategory;
	}

	public void setDecisionCategory(String decisionCategory) {
		this.decisionCategory = decisionCategory;
	}

	public String getErrorMessage()
    {
        return errmsg;
    }

    public String getSQL()
    {
        return sql;
    }

    public void setDecisionSeq(String s)
    {
        decisionSeq = s;
    }

    public String getDecisionSeq()
    {
        return decisionSeq;
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

    public void setDecision(String s)
    {
        decision = s;
    }

    public String getDecision()
    {
        return decision;
    }

    public void setDecisionLevel(String s)
    {
        decisionLevel = s;
    }

    public String getDecisionLevel()
    {
        return decisionLevel;
    }

    public void setDecisionSeqno(String s)
    {
        decisionSeqno = s;
    }

    public String getDecisionSeqno()
    {
        return decisionSeqno;
    }

    public void setParentDecision(String s)
    {
        if(s != null && s.equals("null"))
            s = null;
        parentDecision = s;
    }

    public String getParentDecision()
    {
        return parentDecision;
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

    public void setDueDate(String s)
    {
        dueDate = s;
    }

    public String getDueDate()
    {
        return dueDate;
    }

    public boolean queryMtgDecision(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT md_decision_seq, md_agenda_seq, md_decision, md_decision_level, md_decision_seqno, md_parent_decision, " +
        		"md_sort_seq, md_numbering, md_due_date, md_decision_category  FROM meeting_decision " +
        		"WHERE md_mtg_code = '" + s + "'" + "ORDER BY md_decision_seq ASC ";
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

    public boolean queryMtgDecisionA(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT md_decision_seq, md_agenda_seq, md_decision, md_decision_level, md_decision_seqno, md_parent_decision, " +
        		"md_sort_seq, md_numbering, md_due_date, md_decision_category " +
        		"FROM meeting_decision WHERE md_agenda_seq = '" + s + "'" + 
        		" ORDER BY md_decision_seq ASC ";
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

    public boolean nextMtgDecisionA()
    {
        boolean flag = true;
        String s = null;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    decisionSeq = rset.getString(1);
                    agendaSeq = rset.getString(2);
                    String s1 = new String(CommonFunction.stream2String(rset.getAsciiStream(3)));
                    decision = CommonFunction.ln2br(s1);
                    decisionLevel = rset.getString(4);
                    decisionSeqno = rset.getString(5);
                    parentDecision = rset.getString(6);
                    sortSeq = rset.getString(7);
                    numbering = rset.getString(8);
                    if(rset.getString(9) != null)
                        s = rset.getString(9).substring(0, 10);
                    if(s != null)
                        dueDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s);
                    else
                        dueDate = null;
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
            sqlexception.printStackTrace();
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

    public boolean nextMtgDecision()
    {
        boolean flag = true;
        String s = null;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    decisionSeq = rset.getString(1);
                    agendaSeq = rset.getString(2);
                    String s1 = new String(CommonFunction.stream2String(rset.getAsciiStream(3)));
                    decision = CommonFunction.ln2br(s1);
                    decisionSeqno = rset.getString(5);
                    parentDecision = rset.getString(6);
                    sortSeq = rset.getString(7);
                    numbering = rset.getString(8);
                    if(rset.getString(9) != null)
                        s = rset.getString(9).substring(0, 10);
                    if(s != null)
                        dueDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s);
                    else
                        dueDate = null;
                    decisionCategory = rset.getString(10);
                } 
                else {
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
            sqlexception.printStackTrace();
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

    public boolean addMtgDecision(String s)
    {
        boolean flag = true;
        errmsg = "";
        Object obj = null;
        Object obj1 = null;
        Object obj2 = null;
        try
        {
            sql = "SELECT 1 FROM meeting_decision WHERE md_sort_seq = " + sortSeq;
            stmt = conn.createStatement();
            Statement statement = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                sql = "UPDATE meeting_decision SET md_sort_seq = md_sort_seq + 1 WHERE md_sort_seq >= " + sortSeq;
                stmt.executeUpdate(sql);
            }
            rset.close();
            sql = "SELECT 1 FROM meeting_decision WHERE md_decision_seqno = " + decisionSeqno + " AND md_decision_level = " + decisionLevel;
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                sql = "UPDATE meeting_decision SET md_decision_seqno = md_decision_seqno + 1WHERE md_decision_seqno >= " + decisionSeqno + " AND md_decision_level = " + decisionLevel;
                stmt.executeUpdate(sql);
            }
            rset.close();
            stmt.close();
            String s1 = "SELECT  'M' || lpad( md_decision_seq.nextval, 9, '0' )FROM DUAL";
            ResultSet resultset = statement.executeQuery(s1);
            if(resultset.next())
                decisionSeq = resultset.getString(1);
            resultset.close();
            statement.close();
            sql = "INSERT INTO meeting_decision( md_decision_seq, md_agenda_seq, md_decision, md_decision_level, md_decision_seqno, md_parent_decision, md_sort_seq, md_numbering, md_mtg_code ,md_due_date )VALUES (?, ?, ?, ?, ?, ?, ?, ? ,?, to_date( ?, 'DD-MM-YYYY' ))";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, decisionSeq.trim());
            pstmt.setString(2, agendaSeq.trim());
            pstmt.setString(3, decision);
            pstmt.setString(4, decisionLevel);
            pstmt.setString(5, decisionSeqno);
            pstmt.setString(6, parentDecision);
            pstmt.setString(7, sortSeq);
            pstmt.setString(8, numbering);
            pstmt.setString(9, mtgCode);
            pstmt.setString(10, dueDate);
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

    public boolean updateMtgDecision()
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_decision SET md_decision = ?, md_due_date = to_date( ?, 'DD-MM-YYYY' )  WHERE md_decision_seq = ?";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, decision);
            pstmt.setString(2, dueDate);
            pstmt.setString(3, decisionSeq.trim());
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

    public boolean updateDecisionCategory()
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_decision SET md_decision_category = ? WHERE md_decision_seq = ?";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, decisionCategory);
            pstmt.setString(2, decisionSeq.trim());
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0) {
                flag = true;
            } 
            else {
                errmsg = "No matched record is updated.";
                flag = false;                
            }
            conn.commit();
        }
        catch(SQLException sqlexception) {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();
            try {
                conn.rollback();
            }
            catch(Exception exception) {
                exception.printStackTrace();
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

    public static void updateMtgDecisionDueDate(Connection connection, String s, String s1)
    {
        QueryUtil.runUpdate(connection, "UPDATE MEETING_Decision SET MD_DUE_DATE = to_date('" + s1 + "', 'DD-MM-YYYY') " + "WHERE MD_DECISION_SEQ = '" + s + "'");
    }

    public boolean removeMtgDecision(HttpServletRequest httpservletrequest, ServletContext servletcontext, String s)
    {
        boolean flag = true;
        errmsg = "";
        String s1 = null;
        try
        {
            String s2 = queryMeetingDecisionCode(s.trim());
            MeetingDecisionAttachment meetingdecisionattachment = new MeetingDecisionAttachment();
            meetingdecisionattachment.setDBConnection(conn);
            MeetingDecisionAction meetingdecisionaction = new MeetingDecisionAction();
            meetingdecisionaction.setDBConnection(conn);
            if(s2 != null)
            {
                s2 = s2.trim();
                s1 = meetingdecisionaction.queryActionSeq(s2);
            }
            if(s1 != null)
                if(meetingdecisionaction.removeMtgDecisionAction(httpservletrequest, servletcontext, s1))
                    flag = true;
                else
                    flag = false;
            if(s2 != null && flag)
                if(meetingdecisionattachment.removeAttachment(s2))
                    flag = true;
                else
                    flag = false;
            if(s1 != null && flag)
            {
                sql = "DELETE meeting_decision WHERE md_agenda_seq = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, s.trim());
                pstmt.executeUpdate();
                pstmt.close();
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

    public String queryMeetingDecisionCode(String s)
    {
        String s1 = null;
        PreparedStatement preparedstatement = null;
        ResultSet resultset = null;
        sql = "SELECT  MD_DECISION_SEQ FROM MEETING_DECISION WHERE MD_AGENDA_SEQ = '" + s + "'";
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
}