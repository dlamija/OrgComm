package cms.admin.meeting.bean;

import java.io.PrintStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

public class MeetingMember
  implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String memberMtgType;
    protected String memberID;
    protected String position;
    protected String remark;
    protected String memberName;
    protected String positionName;
    protected String roleCode;
    protected String staffID;
    protected String staffjob = "";

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public String getStaffjob() {
		return staffjob;
	}

	public void setStaffjob(String staffjob) {
		this.staffjob = staffjob;
	}

	public void setMemberMtgType(String s)
    {
        memberMtgType = s;
    }

    public void setMemberID(String s)
    {
        memberID = s;
    }

    public void setPosition(String s)
    {
        position = s;
        System.out.println("position" + position);
    }

    public void setRemark(String s)
    {
        remark = s;
    }

    public void setMemberName(String s)
    {
        memberName = s;
    }

    public void setPositionName(String s)
    {
        positionName = s;
    }

    public String getMemberMtgType()
    {
        return memberMtgType;
    }

    public String getMemberID()
    {
        return memberID;
    }

    public String getPosition()
    {
        return position;
    }

    public String getRemark()
    {
        return remark;
    }

    public String getSQL()
    {
        return sql;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public String getMemberName()
    {
        return memberName;
    }

    public String getPositionName()
    {
        return positionName;
    }

    public String[] queryMtgMembersA(String s)
    {
        boolean flag = true;
        errmsg = "";
        Statement statement = null;
        ResultSet resultset = null;
        String as[] = new String[50];
        sql = "SELECT mm_member_mtgtype, mm_member_id, mm_position, mm_remark, sm_staff_name, mr_mtgroles_code, mr_mtgroles_desc " +
        		"FROM meeting_members, CMSADMIN.staff_main, meeting_roles " +
        		"WHERE mm_member_mtgtype = '" + s + "'" + " AND mm_position = mr_mtgroles_code " + 
        		"AND sm_staff_id = mm_member_id ORDER BY mm_position";
        try
        {
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset != null)
            {
                for(int i = 0; resultset.next(); i++)
                    as[i] = resultset.getString(2);

            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
            boolean flag1 = false;
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
            catch(Exception exception1) { }
        }
        return as;
    }

    public boolean queryMtgMembers(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT mm_member_mtgtype, mm_member_id, mm_position, mm_remark,  sm_staff_name, mr_mtgroles_code, mr_mtgroles_desc, ss_service_desc " +
        		"FROM meeting_members, CMSADMIN.staff_main, meeting_roles, CMSADMIN.service_scheme " +
        		"WHERE mm_member_mtgtype = '" + s + "' AND mm_position = mr_mtgroles_code " + 
        		" AND sm_staff_id = mm_member_id AND sm_job_code = ss_service_code " + " ORDER BY mm_position";
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

    public boolean nextMtgMember()
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            if(rset != null)
            {
                if(rset.next()) {
                    memberMtgType = rset.getString(1);
                    memberID = rset.getString(2);
                    position = rset.getString(3);
                    remark = rset.getString(4);
                    memberName = rset.getString(5);
                    positionName = rset.getString(7);
                    staffjob = rset.getString(8);
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

    public boolean addMember(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "INSERT INTO meeting_members( mm_member_mtgtype, mm_member_id, mm_position) VALUES( ?,?,?)";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, memberID);
            pstmt.setString(3, position);
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

    public boolean removeMember(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        sql = "DELETE meeting_members WHERE mm_member_id = ? AND mm_member_mtgtype = ? ";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
            } else
            {
                System.out.println(" No matched record is removed");
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

    public boolean removeMember(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "DELETE meeting_members WHERE mm_member_mtgtype = ? ";
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

    public static void updateMember(Connection connection, String s, String s1, String s2)
    {
        PreparedStatement preparedstatement = null;
        try
        {
            preparedstatement = connection.prepareStatement("UPDATE meeting_members SET mm_position = ? WHERE mm_member_mtgtype = ? AND mm_member_id = ?");
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            preparedstatement.executeUpdate();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        finally
        {
            try
            {
                if(preparedstatement != null)
                    preparedstatement.close();
            }
            catch(Exception exception2) { }
        }
    }

    public Vector viewStaffListing(int i, int j, String s, String s1, String s2, String mtgGrp)
    {
        Statement statement = null;
        Object obj = null;
        Vector vector = null;
        Object obj1 = null;
        Object obj2 = null;
        Object obj3 = null;
        boolean flag = false;
        String s3 = "";
        String s4 = "";
        Object obj4 = null;
        int k = 0;
        try
        {
            statement = conn.createStatement();
            String s5 = "select sm_staff_id, sm_staff_name, dm_dept_desc from cmsadmin.staff_main, cmsadmin.department_main " +
            			"where sm_staff_status = 'ACTIVE' and sm_dept_code = dm_dept_code ";
            if(s != null && !s.equals(""))
                s5 = s5 + "and sm_dept_code = '" + s + "' ";
            if(s1 != null && !s1.equals(""))
                s5 = s5 + "and sm_staff_id LIKE UPPER('%" + s1 + "%') ";
            if(s2 != null && !s2.equals(""))
                s5 = s5 + "and sm_staff_name LIKE UPPER('%" + s2 + "%') ";
            
            s5 += "and sm_staff_id NOT IN (SELECT mm_member_id FROM meeting_members WHERE mm_member_mtgtype = '" + mtgGrp + "') ";
            s5 += " order by sm_staff_name";
            
            ResultSet resultset = statement.executeQuery(s5);
            vector = new Vector();
            if(resultset.isBeforeFirst())
            {
                Vector vector1 = new Vector();
                Vector vector2 = new Vector();
                Vector vector3 = new Vector();
                while(resultset.next()) 
                    if(++k >= j && k < j + i)
                    {
                        if(resultset.getString(1) != null)
                            vector1.add(resultset.getString(1));
                        else
                            vector1.add("");
                        if(resultset.getString(2) != null)
                            vector2.add(resultset.getString(2));
                        else
                            vector2.add("");
                        if(resultset.getString(3) != null)
                            vector3.add(resultset.getString(3));
                        else
                            vector3.add("");
                    }
                vector.add(vector1);
                vector.add(vector2);
                vector.add(vector3);
                if(k > 0)
                    vector.add(new Integer(k));
            }
            resultset.close();
            statement.close();
        }
        catch(Exception exception)
        {
            flag = true;
            s3 = s3 + exception.toString();
            exception.printStackTrace();
        }
        finally
        {
            try
            {
                if(statement != null)
                    statement.close();
            }
            catch(Exception exception2) { }
        }
        if(flag)
        {
            s3 = "MeetingMember.viewStaffListing(): " + s3;
            System.out.println(s3);
            vector = new Vector();
            vector.add("An error occured: " + s3);
        }
        return vector;
    }

    public String escapeQuote(String s)
    {
        String s1 = "";
        for(int i = 0; i < s.length(); i++)
            if(s.charAt(i) != '\'')
                s1 = s1 + s.charAt(i);

        return s1;
    }
}