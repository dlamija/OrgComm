package cms.admin.bean;

import java.io.Serializable;
import java.sql.*;

public class Department implements Serializable
{
	private static final long serialVersionUID = 1L;

	protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String deptCode;
    protected String deptDesc;
    protected String level;
    protected String parentDeptCode;
    protected String bdgtDept;
    protected String type;

    public Department()
    {
        conn = null;
        sql = null;
        errmsg = null;
        pstmt = null;
        stmt = null;
        rset = null;
        deptCode = null;
        deptDesc = null;
        level = null;
        parentDeptCode = null;
        bdgtDept = null;
        type = null;
    }

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

    public void setDeptCode(String s)
    {
        deptCode = s;
    }

    public String getDeptCode()
    {
        return deptCode;
    }

    public void setDeptDesc(String s)
    {
        deptDesc = s;
    }

    public String getDeptDesc()
    {
        return deptDesc;
    }

    public void setLevel(String s)
    {
        level = s;
    }

    public String getLevel()
    {
        return level;
    }

    public void setParentDeptCode(String s)
    {
        parentDeptCode = s;
    }

    public String getParentDeptCode()
    {
        return parentDeptCode;
    }

    public void setBdgtDept(String s)
    {
        bdgtDept = s;
    }

    public String getBdgtDept()
    {
        return bdgtDept;
    }

    public void setType(String s)
    {
        type = s;
    }

    public String getType()
    {
        return type;
    }

    public boolean queryDeptDtl(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT dm_dept_code, dm_dept_desc, dm_level, dm_parent_dept_code, dm_bdgt_dept, dm_type FROM CMSADMIN.department_main WHERE dm_dept_code = '" + s + "'";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                s = rset.getString(1);
                deptDesc = rset.getString(2);
                level = rset.getString(3);
                parentDeptCode = rset.getString(4);
                bdgtDept = rset.getString(5);
                type = rset.getString(6);
            }
        }
        catch(SQLException sqlexception)
        {
            errmsg = sqlexception.toString();
            flag = false;
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
            catch(Exception exception1) { }
        }
        return flag;
    }

    public boolean queryAllDepartment()
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT dm_dept_code, dm_dept_desc, dm_level, dm_parent_dept_code, dm_bdgt_dept, dm_type FROM CMSADMIN.department_main";
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

    public boolean queryDepartmentLevel()
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT dm_dept_code, dm_dept_desc, dm_level, dm_parent_dept_code, dm_bdgt_dept, dm_type FROM CMSADMIN.department_main where dm_level='1' AND DM_DEPT_CODE <>'AK000' order by dm_dept_desc ";
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

    public boolean nextDepartment()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    deptCode = rset.getString(1);
                    deptDesc = rset.getString(2);
                    level = rset.getString(3);
                    parentDeptCode = rset.getString(4);
                    bdgtDept = rset.getString(5);
                    type = rset.getString(6);
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

}