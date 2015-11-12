package cms.staff;

import java.sql.*;

public class StaffValidator
{
    protected String staff_id;
    protected Connection conn;
    protected String sql;
    protected String errmsg;

    public StaffValidator() {
        staff_id = null;
        conn = null;
        sql = null;
        errmsg = null;
    }

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public void setStaffId(String s)
    {
        staff_id = s;
    }

    public String getStaffEmail(String s)
    {
        String s1 = null;
        sql = "SELECT SM_EMAIL_ADDR FROM STAFF_MAIN WHERE SM_STAFF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            
            if(resultset.next())
                s1 = resultset.getString(1);
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return s1;
    }

    public boolean isDirector()
    {
        boolean flag = false;
        sql = "SELECT DM_DIRECTOR FROM DEPARTMENT_MAIN WHERE DM_LEVEL='1' AND DM_DIRECTOR = ? ";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean isExec()
    {
        boolean flag = false;
        sql = "SELECT SM_STAFF_ID FROM STAFF_MAIN,JOB_MAIN WHERE JM_JOB_CODE = SM_JOB_CODE AND NVL(JM_JOB_EXEC,'Y') = 'Y' AND SM_STAFF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean isSupportStaff()
    {
        boolean flag = false;
        sql = "select 1 from service_scheme,staff_main where ss_service_code = sm_job_code and sm_staff_id = ? and upper(ss_service_group) like '%SOKONGAN%'";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean isAuthorized(String staffID, String formID, String version)
    {
        boolean flag = false;
        String username = getUsername(staffID);
        sql = "{ call isAuthorized ( ?, ?, ?, ?, ?) }";
        try
        {
            CallableStatement callablestatement = conn.prepareCall(sql);
            callablestatement.setString(1, username);
            callablestatement.setString(2, formID);
            callablestatement.setString(3, version);
            callablestatement.registerOutParameter(4, 2);
            callablestatement.registerOutParameter(5, 12);
            callablestatement.execute();
            errmsg = callablestatement.getString(5);

            if(callablestatement.getInt(4) == 1)
                flag = true;
            else
                flag = false;
            callablestatement.close();
        }
        catch(SQLException sqlexception) {
            errmsg = "Error during checking user authorization : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean hasSubordinate()
    {
        boolean flag = false;
        String s = "{ ? = call HIERARCHY.GetSubordinate( ?, ?, ?) }";
        try
        {
            CallableStatement callablestatement = conn.prepareCall(s);
            callablestatement.registerOutParameter(1, 12);
            callablestatement.setString(2, staff_id);
            callablestatement.setString(3, "ADM_AL");
            callablestatement.setInt(4, 1);
            callablestatement.execute();
            if(callablestatement.getString(1) != null)
                flag = true;
            callablestatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public String getStaffName(String s)
    {
        String s1 = null;
        sql = "SELECT SM_STAFF_NAME FROM STAFF_MAIN WHERE SM_STAFF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return s1;
    }

    public String getUsername(String s)
    {
        String s1 = null;
        sql = "SELECT SM_APPS_USERNAME FROM STAFF_MAIN WHERE SM_STAFF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error during getting username : " + sqlexception.toString();
        }
        return s1;
    }

    public String getStaffName()
    {
        String s = null;
        sql = "SELECT SM_STAFF_NAME FROM STAFF_MAIN WHERE SM_STAFF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s = resultset.getString(1);
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return s;
    }

    public boolean isManager()
    {
        boolean flag = false;
        sql = "SELECT AS_STAFF_ID FROM ACTION_STATUS_SETUP WHERE AS_STAFF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean isClinic()
    {
        boolean flag = false;
        sql = "SELECT EU_USER_ID FROM EXTERNAL_USER WHERE EU_USERNAME IN (SELECT MC_USERNAME FROM MEDICAL_CLINIC) AND EU_USER_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean isStaffProfile()
    {
        boolean flag = false;
        sql = "select sm_staff_id from staff_main where sm_staff_status = 'ACTIVE'  and sm_job_status in ('KONTRAK', 'TETAP', 'TPERCUBAAN','TPENCEN', 'PINJAMAN', 'SEMENTARA') and (sm_birth_state is null or sm_current_address is null or sm_current_state is null or sm_current_country is null or sm_permanent_address is null or sm_marital_status is null or sm_child_no is null or sm_birth_place is null or sm_birth_date is null) and sm_staff_id = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean isSpouseProfile()
    {
        boolean flag = false;
        sql = "select sm_staff_id from staff_main where sm_staff_status = 'ACTIVE' and sm_job_status in ('KONTRAK', 'TETAP', 'TPERCUBAAN', 'TPENCEN', 'PINJAMAN', 'SEMENTARA') and SM_MARITAL_STATUS = 'MARRIED' AND (sm_spouse_name is null or sm_spouse_off_address is null or sm_spouse_off_state is null or sm_spouse_off_country is null or sm_spouse_off_pcode is null or sm_spouse_job is null or sm_spouse_ic_no is null or sm_marriage_date is null) and sm_staff_id = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean isQualification()
    {
        boolean flag = false;
        sql = "select sm_staff_id from staff_main where sm_staff_id not in (select SQ_STAFF_ID from staff_qualification) and sm_staff_status = 'ACTIVE' and sm_job_status in ('TETAP', 'TPERCUBAAN', 'TPENCEN', 'PINJAMAN', 'KONTRAK') and sm_staff_id = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                errmsg = "Not found";
            resultset.close();
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }
    
    public boolean isAcademicStaff(String staffID)
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder("");
        sb.append("SELECT count(1) FROM service_scheme,staff_main ");
        sb.append("WHERE sm_job_code = ss_service_code AND sm_staff_id = ? ");
        sb.append("AND ss_grouping = 'ACADEMIC'");
        
        try
        {
            PreparedStatement pstmt = conn.prepareStatement(sb.toString());
            pstmt.setString(1, staffID);
            ResultSet rset = pstmt.executeQuery();
            if (rset.isBeforeFirst()) {
	            if (rset.next()) {
	            	if (rset.getInt(1) > 0)
	            		flag = true;
	            }
            }
            rset.close();
            pstmt.close();
        }
        catch(SQLException sqlexception) {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

}