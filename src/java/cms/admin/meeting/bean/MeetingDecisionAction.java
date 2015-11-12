package cms.admin.meeting.bean;

import cms.admin.meeting.EMeetingTask;
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

import tvo.TvoBean;
import utilities.QueryUtil;

public class MeetingDecisionAction implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String decisionSeq;
    protected String actionDesc;
    protected String dueDate;
    protected String actionSeq;
    protected String mtgCode;
    protected String actionBy;
    protected String actionByName;

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

    public void setDecisionSeq(String s)
    {
        decisionSeq = s;
    }

    public String getDecisionSeq()
    {
        return decisionSeq;
    }

    public void setActionSeq(String s)
    {
        actionSeq = s;
    }

    public String getActionSeq()
    {
        return actionSeq;
    }

    public void setActionDesc(String s)
    {
        actionDesc = s;
    }

    public String getActionDesc()
    {
        return actionDesc;
    }

    public void setDueDate(String s)
    {
        dueDate = s;
    }

    public String getDueDate()
    {
        return dueDate;
    }

    public void setMeetingCode(String s)
    {
        mtgCode = s;
    }

    public String getMeetingCode()
    {
        return mtgCode;
    }

    public void setActionBy(String s)
    {
        actionBy = s;
    }

    public String getActionBy()
    {
        return actionBy;
    }

    public void setActionByName(String s)
    {
        actionByName = s;
    }

    public String getActionByName()
    {
        return actionByName;
    }

    public boolean queryMtgDecisionAction(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT mda_action_seq, mda_decision_seq, mda_action_desc, mda_due_date, mda_action_by,  sm_staff_name  FROM meeting_dec_action, CMSADMIN.staff_main  WHERE mda_decision_seq = '" + s + "'" + " ORDER BY mda_decision_seq";
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

    public boolean nextMtgDecisionAction()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    actionSeq = rset.getString(1);
                    decisionSeq = rset.getString(2);
                    actionDesc = new String(CommonFunction.stream2String(rset.getAsciiStream(3)));
                    String s = rset.getString(4);
                    dueDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s);
                    actionBy = rset.getString(5);
                    actionByName = rset.getString(6);
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

    public boolean queryMtgDecisionActionA(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT mda_action_seq, mda_decision_seq, mda_action_desc, mda_due_date, mda_action_by,  sm_staff_name  FROM meeting_dec_action, CMSADMIN.staff_main  WHERE sm_staff_id = mda_action_by AND mda_mtg_code ='" + s + "'" + " ORDER BY mda_decision_seq";
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

    public boolean nextMtgDecisionActionA()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    actionSeq = rset.getString(1);
                    decisionSeq = rset.getString(2);
                    actionDesc = new String(CommonFunction.stream2String(rset.getAsciiStream(3)));
                    String s = rset.getString(4);
                    dueDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s);
                    actionBy = rset.getString(5);
                    actionByName = rset.getString(6);
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

    public boolean addMtgDecisionAction(String s)
    {
        boolean flag = true;
        errmsg = "";
        Object obj = null;
        Object obj1 = null;
        Object obj2 = null;
        try
        {
            Statement statement = conn.createStatement();
            String s1 = "SELECT  'M' || lpad( mda_action_seq.nextval, 9, '0' ) FROM DUAL";
            ResultSet resultset = statement.executeQuery(s1);
            if(resultset.next())
                actionSeq = resultset.getString(1);
            resultset.close();
            statement.close();
            sql = "INSERT INTO meeting_dec_action( mda_action_seq, mda_decision_seq, mda_action_desc, mda_due_date, mda_mtg_code , mda_action_by ) VALUES (?, ?, ?, to_date( ?, 'DD-MM-YYYY' ), ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, actionSeq);
            pstmt.setString(2, s);
            pstmt.setString(3, actionDesc);
            pstmt.setString(4, dueDate);
            pstmt.setString(5, mtgCode);
            pstmt.setString(6, actionBy);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
                QueryUtil.updateCLOB(conn, "meeting_dec_action", "mda_action_desc", actionDesc, "mda_action_seq = '" + actionSeq.trim() + "'");
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

    public boolean updateMtgDecisionAction()
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_dec_action SET mda_action_desc = ?,  mda_due_date = to_date( ?, 'DD-MM-YYYY' ) , mda_action_by = ? WHERE mda_action_seq = ?";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, actionDesc);
            pstmt.setString(2, dueDate);
            pstmt.setString(3, actionBy);
            pstmt.setString(4, actionSeq);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
                QueryUtil.updateCLOB(conn, "meeting_dec_action", "mda_action_desc", actionDesc, "mda_action_seq = '" + actionSeq.trim() + "'");
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

    public boolean removeMtgDecisionAction(HttpServletRequest httpservletrequest, ServletContext servletcontext, String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            MeetingDecisionActionProgress meetingdecisionactionprogress = new MeetingDecisionActionProgress();
            meetingdecisionactionprogress.setDBConnection(conn);
            if(!meetingdecisionactionprogress.removeMtgDecisionActionProgressA(s))
                flag = false;
            if(flag)
            {
                EMeetingTask emeetingtask = new EMeetingTask();
                emeetingtask.initTVO(httpservletrequest);
                String s1 = EMeetingTask.getMeetingCode_From_DecisionSeq(conn, decisionSeq);
                String s2 = s;
                emeetingtask.deleteTask(servletcontext, s1, s2);
                sql = "DELETE MEETING_Dec_ActionBy WHERE MDAB_ACTION_SEQ = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, s);
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

    public String queryActionSeq(String s)
    {
        return s;
    }
}