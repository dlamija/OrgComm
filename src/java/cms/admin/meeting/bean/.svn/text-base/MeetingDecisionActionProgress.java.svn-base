package cms.admin.meeting.bean;

import java.io.PrintStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import common.CommonFunction;

import utilities.QueryUtil;

public class MeetingDecisionActionProgress
  implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String progressSeq;
    protected String actionBy;
    protected String dateKeyIn;
    protected String progressDate;
    protected String progress;
    protected String actionSeq;
    protected String mtgCode;
    protected String refNo;

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

    public void setProgressSeq(String s)
    {
        progressSeq = s;
    }

    public String getProgressSeq()
    {
        return progressSeq;
    }

    public void setActionBy(String s)
    {
        actionBy = s;
    }

    public String getActionBy()
    {
        return actionBy;
    }

    public void setDateKeyIn(String s)
    {
        dateKeyIn = s;
    }

    public String getDateKeyIn()
    {
        return dateKeyIn;
    }

    public void setActionSeq(String s)
    {
        actionSeq = s;
    }

    public String getActionSeq()
    {
        return actionSeq;
    }

    public void setMeetingCode(String s)
    {
        mtgCode = s;
    }

    public String getMeetingCode()
    {
        return mtgCode;
    }

    public void setProgress(String s)
    {
        progress = s;
    }

    public String getProgress()
    {
        return progress;
    }

    public void setProgressDate(String s)
    {
        progressDate = s;
    }

    public String getProgressDate()
    {
        return progressDate;
    }

    public void setRefNo(String s)
    {
        refNo = s;
    }

    public String getRefNo()
    {
        return refNo;
    }

    public boolean queryMtgDecisionActionProgress(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT mdap_progress_seq, mdap_action_seq,mdap_date_keyin,  mdap_progress_date, mdap_progress, mdap_ref_no FROM meeting_dec_action_progress WHERE mdap_action_seq = '" + s + "'" + " ORDER BY mdap_progress_seq";
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

    public boolean nextMtgDecisionActionProgress()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    progressSeq = rset.getString(1);
                    actionSeq = rset.getString(2);
                    String s = rset.getString(3);
                    dateKeyIn = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s);
                    String s1 = rset.getString(4);
                    progressDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s1);
                    String s2 = new String(CommonFunction.stream2String(rset.getAsciiStream(5)));
                    progress = CommonFunction.ln2br(s2);
                    refNo = rset.getString(6);
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

    public boolean addMtgDecisionActionProgress(String s)
    {
        boolean flag = true;
        errmsg = "";
        Object obj = null;
        Object obj1 = null;
        ResultSet resultset1 = null;
        Object obj2 = null;
        Object obj3 = null;
        try
        {
            boolean flag1 = true;
            if(s != null && s.length() > 0)
            {
                sql = "SELECT MAX (mdap_ref_no) maxID FROM meeting_dec_action_progress WHERE mdap_action_seq = '" + s + "'";
                Statement statement1 = conn.createStatement();
                resultset1 = statement1.executeQuery(sql);
                if(resultset1.next())
                {
                    int k = resultset1.getInt("maxID");
                    int i = k + 1;
                    refNo = "" + i;
                } else
                {
                    int j = 1;
                    refNo = "" + j;
                }
                resultset1.close();
                resultset1 = null;
                statement1.close();
            }
            Statement statement = conn.createStatement();
            String s1 = "SELECT  'M' || lpad( mdap_progress_seq.nextval, 9, '0' ) FROM DUAL";
            ResultSet resultset = statement.executeQuery(s1);
            if(resultset.next())
                progressSeq = resultset.getString(1);
            resultset.close();
            statement.close();
            sql = "INSERT INTO meeting_dec_action_progress( mdap_progress_seq, mdap_action_seq, mdap_date_keyin, mdap_progress_date, mdap_progress,mdap_ref_no) VALUES (?, ?, to_date( ?, 'DD-MM-YYYY' ), to_date( ?, 'DD-MM-YYYY' ), ? , ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, progressSeq);
            pstmt.setString(2, s);
            pstmt.setString(3, dateKeyIn);
            pstmt.setString(4, progressDate);
            pstmt.setString(5, progress);
            pstmt.setString(6, refNo);
            int l = pstmt.executeUpdate();
            pstmt.close();
            if(l > 0)
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
                if(resultset1 != null)
                {
                    resultset1.close();
                    resultset1 = null;
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

    public boolean updateMtgDecisionActionProgress()
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_dec_action_progress SET mdap_progress = ?,  mdap_progress_date = to_date( ?, 'DD-MM-YYYY' ) WHERE mdap_progress_seq = ?";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, progress);
            pstmt.setString(2, progressDate);
            pstmt.setString(3, progressSeq.trim());
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
                QueryUtil.updateCLOB(conn, "meeting_dec_action_progress", "mdap_progress", progress, "mdap_progress_seq = '" + progressSeq.trim() + "'");
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

    public boolean removeMtgDecisionActionProgress(String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "DELETE meeting_dec_action_progress WHERE mdap_progress_seq = ?";
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

    public boolean removeMtgDecisionActionProgressA(String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "DELETE meeting_dec_action_progress WHERE mdap_action_seq = ?";
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

    public boolean isMax(String s, String s1)
    {
        Statement statement = null;
        ResultSet resultset = null;
        boolean flag = false;
        try
        {
            sql = "SELECT MAX (mdap_ref_no) maxID FROM meeting_dec_action_progress WHERE mdap_action_seq = '" + actionSeq + "'";
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset.next())
            {
                int i = resultset.getInt("maxID");
                int j = Integer.parseInt(s1);
                if(j >= i)
                    flag = true;
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
        return flag;
    }
}