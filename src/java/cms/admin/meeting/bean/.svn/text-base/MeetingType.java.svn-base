package cms.admin.meeting.bean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MeetingType
  implements Serializable
{
    protected String mtgTypeCode;
    protected String mtgTypeDept;
    protected String mtgTypeDesc;
    protected String mtgTypeTitle;
    protected String mtgTypeParent;
    protected String mtgTypeLevel;
    protected Connection conn;
    protected String sql;
    protected String sql2;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected Statement stmt2;
    protected ResultSet rset;
    protected ResultSet rset2;
    protected String mtgCode;
    protected String deptCode;
    protected String agendaTemplate;

    public void setMtgTypeCode(String s)
    {
        mtgTypeCode = s;
    }

    public void setMtgTypeDept(String s)
    {
        mtgTypeDept = s;
    }

    public void setMtgTypeDesc(String s)
    {
        mtgTypeDesc = s;
    }

    public void setMtgTypeParent(String s)
    {
        mtgTypeParent = s;
    }

    public void setMtgTypeLevel(String s)
    {
        mtgTypeLevel = s;
    }

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public void setMtgTypeTitle(String s)
    {
        mtgTypeTitle = s;
    }

    public void setDeptCode(String s)
    {
        deptCode = s;
    }

    public void setAgendaTemplate(String s)
    {
        agendaTemplate = s;
    }

    public String getMtgTypeTitle()
    {
        return mtgTypeTitle;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public String getSQL()
    {
        return sql;
    }

    public String getMtgTypeDept()
    {
        return mtgTypeDept;
    }

    public String getMtgTypeDesc()
    {
        return mtgTypeDesc;
    }

    public String getMtgTypeCode()
    {
        return mtgTypeCode;
    }

    public String getMtgTypeParent()
    {
        return mtgTypeParent;
    }

    public String getMtgTypeLevel()
    {
        return mtgTypeLevel;
    }

    public String getDeptCode()
    {
        return deptCode;
    }

    public String getAgendaTemplate()
    {
        return agendaTemplate;
    }

    public boolean queryMeetingTypeInfo()
    {
        boolean flag = true;
        errmsg = "";
        String s = "SELECT mt_mtgtype_code, mt_mtgtype_desc , mt_mtgtype_dept, mt_mtgtype, mt_mtgtype_agenda_template FROM meeting_type ORDER BY mt_mtgtype_code";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(s);
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

    public boolean nextMeetingTypeInfo()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    mtgTypeCode = rset.getString(1);
                    mtgTypeDesc = rset.getString(2);
                    String s = rset.getString(3);
                    mtgTypeDept = queryMeetingTypeDept(s);
                    mtgTypeTitle = rset.getString(4);
                    agendaTemplate = rset.getString(5);
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

    public String queryMeetingTypeDept(String s)
    {
        ResultSet resultset = null;
        String s1 = null;
        String s2 = "SELECT DM_DEPT_CODE, DM_DEPT_DESC FROM CMSADMIN.DEPARTMENT_MAIN  WHERE DM_DEPT_CODE = '" + s + "'";
        Statement statement = null;
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
                s1 = resultset.getString(2);
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
                statement.close();
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public String queryMeetingDesc(String s)
    {
        ResultSet resultset = null;
        String s1 = null;
        String s2 = "SELECT MM_MTG_DESC FROM MEETING_MAIN WHERE MM_MTG_CODE = '" + s + "'";
        Statement statement = null;
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
                statement.close();
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public boolean queryMeetingTypeDesc(String s)
    {
        boolean flag = false;
        ResultSet resultset = null;
        Object obj = null;
        String s2 = "SELECT MT_MTGTYPE FROM MEETING_TYPE";
        try
        {
            Statement statement = conn.createStatement();
            resultset = statement.executeQuery(s2);
            if(!resultset.isBeforeFirst())
            {
                resultset.close();
                resultset = null;
                statement.close();
                statement = null;
                flag = true;
            } else
            {
                for(; resultset.next(); flag = true)
                {
                    String s1 = resultset.getString(1);
                    if(!s1.equalsIgnoreCase(s))
                        continue;
                    flag = false;
                    break;
                }

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
                stmt.close();
            }
            catch(Exception exception1) { }
        }
        return flag;
    }

    public boolean queryMeetingTypeInfo(String s)
    {
        boolean flag = false;
        errmsg = "";
        sql = "SELECT mt_mtgtype_code, mt_mtgtype_desc, mt_mtgtype_dept, mt_mtgtype, mt_mtgtype_agenda_template, mt_parent, mt_level FROM meeting_type WHERE mt_mtgtype_code = '" + s + "'";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                s = rset.getString(1);
                mtgTypeDesc = rset.getString(2);
                deptCode = rset.getString(3);
                mtgTypeTitle = rset.getString(4);
                agendaTemplate = rset.getString(5);
                mtgTypeParent = rset.getString(6);
                mtgTypeLevel = rset.getString(7);
                sql2 = "SELECT dm_dept_desc FROM CMSADMIN.department_main WHERE  dm_dept_code = '" + deptCode + "'";
                stmt2 = conn.createStatement();
                rset2 = stmt2.executeQuery(sql2);
                if(rset2.next())
                    mtgTypeDept = rset2.getString(1);
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
            catch(Exception exception1)
            {
                exception1.printStackTrace();
            }
        }
        return flag;
    }

    public boolean addMeetingType()
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "SELECT 'M' || lpad( mm_mtgtype_code.nextval, 9, '0' ) FROM dual";
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
                mtgTypeCode = rset.getString(1);
            rset.close();
            stmt.close();
            if(mtgTypeCode != null && mtgTypeCode.length() > 0)
            {
                if(queryMeetingTypeDesc(mtgTypeDesc))
                {
                    sql = "INSERT INTO meeting_type( mt_mtgtype_code, mt_mtgtype_dept, mt_mtgtype_desc, mt_mtgtype, mt_parent, mt_level)VALUES( ? , ? , ? , ? , ? , ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, mtgTypeCode);
                    pstmt.setString(2, mtgTypeDept);
                    pstmt.setString(3, mtgTypeDesc);
                    pstmt.setString(4, mtgTypeTitle);
                    pstmt.setString(5, mtgTypeParent);
                    pstmt.setString(6, mtgTypeLevel);
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
                    errmsg = "The description is not unique";
                    flag = false;
                }
            } else
            {
                errmsg = "Fail to generate unique sequence number for the meeting type";
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

    public boolean updateMeetingType(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_type SET mt_mtgtype_dept = ?, mt_mtgtype_desc = ?, mt_mtgtype = ? , mt_mtgtype_agenda_template = ?, mt_parent = ?, mt_level = ? WHERE mt_mtgtype_code = ? ";
        try
        {
            if(queryMeetingTypeDesc(mtgTypeDesc))
            {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, mtgTypeDept);
                pstmt.setString(2, mtgTypeDesc);
                pstmt.setString(3, mtgTypeTitle);
                pstmt.setString(4, agendaTemplate);
                pstmt.setString(5, mtgTypeParent);
                pstmt.setString(6, mtgTypeLevel);
                pstmt.setString(7, s);
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
            } else
            {
                errmsg = "The description is not unique";
                flag = false;
            }
        }
        catch(SQLException sqlexception)
        {
            flag = false;
            sqlexception.printStackTrace();
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

    public boolean updateAgendaTemplate(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_type  SET mt_mtgtype_agenda_template = null  WHERE mt_mtgtype_agenda_template = ? ";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s.trim());
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

    public boolean removeMtgType(String s)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "DELETE MEETING_TYPE WHERE MT_MTGTYPE_CODE = ?";
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

    public int countMeetingSetup()
    {
        int i = 0;
        errmsg = "";
        String s = "SELECT count(1) FROM meeting_type";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(s);
            if(rset.next())
                i = rset.getInt(1);
            rset.close();
            rset = null;
            stmt.close();
            stmt = null;
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
            i = 0;
        }
        return i;
    }
}