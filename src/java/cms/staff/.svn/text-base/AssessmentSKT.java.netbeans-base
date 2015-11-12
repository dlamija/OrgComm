package cms.staff;

import java.sql.*;

public class AssessmentSKT
{
    private Connection dbConn;
    private String sql;
    private String errorMsg;

    public AssessmentSKT()
    {
        dbConn = null;
        sql = null;
        errorMsg = null;
    }

    public void setDbConnection(Connection connection)
    {
        dbConn = connection;
    }

    public String getErrorMsg()
    {
        return errorMsg;
    }

    public boolean MemoApplySKT(String s, int i)
    {
        boolean flag = true;
        String s1 = null;
        String s2 = null;
        String s3 = null;
        sql = "SELECT STAH_STAFF_ID,SM_STAFF_NAME,STAH_YEAR,STAH_APPROVE_BY FROM STAFF_TARGET_ACTIVITY_HEAD,STAFF_MAIN WHERE SM_STAFF_ID = STAH_STAFF_ID AND STAH_STAFF_ID = ? AND TO_CHAR(STAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                s2 = resultset.getString(4);
                s3 = s;
                s1 = "Please take note that there is a new SKT waiting to be approved :<br><br>";
                s1 = s1 + "Details : <br><br>";
                s1 = s1 + "Staff ID : " + resultset.getString(1) + "<br>";
                s1 = s1 + "Staff Name : " + resultset.getString(2) + "<br>";
                s1 = s1 + "SKT Year : " + resultset.getString(3) + "<br>";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error during getting SKT info: " + sqlexception.toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            java.sql.CallableStatement callablestatement = dbConn.prepareCall(s4);
            callablestatement.setString(1, s3);
            callablestatement.setString(2, s2);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "New SKT To Be Approved");
            callablestatement.setString(5, s1);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errorMsg = "Error during sending memo to approver : " + exception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean MemoApproveSKT(String s, int i)
    {
        boolean flag = true;
        String s1 = null;
        String s2 = null;
        String s3 = null;
        sql = "SELECT STAH_YEAR,STAH_APPROVE_BY,SM_STAFF_NAME, TO_CHAR(STAH_APPROVE_DATE,'DD/MM/YYYY') FROM STAFF_TARGET_ACTIVITY_HEAD,STAFF_MAIN WHERE SM_STAFF_ID = STAH_APPROVE_BY AND STAH_STAFF_ID = ? AND TO_CHAR(STAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                s2 = resultset.getString(2);
                s3 = s;
                s1 = "Please take note your SKT has been approved :<br><br>";
                s1 = s1 + "Details : <br><br>";
                s1 = s1 + "SKT Year : " + resultset.getString(1) + "<br>";
                s1 = s1 + "Approved By : " + resultset.getString(2) + " - " + resultset.getString(3) + "<br>";
                s1 = s1 + "Approved Date : " + resultset.getString(4) + "<br>";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error during getting SKT info: " + sqlexception.toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            java.sql.CallableStatement callablestatement = dbConn.prepareCall(s4);
            callablestatement.setString(1, s2);
            callablestatement.setString(2, s3);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "SKT Approved");
            callablestatement.setString(5, s1);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errorMsg = "Error during sending memo to applicant : " + exception.toString();
            flag = false;
        }
        return flag;
    }

    public int getCurrentYear()
    {
        int i = 0;
        sql = "SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) FROM DUAL";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                i = resultset.getInt(1);
            else
                i = 0;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error : " + sqlexception.toString();
            i = 0;
        }
        return i;
    }

    public int getSKTYear()
    {
        int i = 0;
        sql = "SELECT TO_NUMBER(HP_PARM_DESC) FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'ASSESSMENT_YEAR'";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                i = resultset.getInt(1);
            else
                i = 0;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error : " + sqlexception.toString();
            i = 0;
        }
        return i;
    }

    public boolean IsSKTTargetExists(String s, int i)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_TARGET_ACTIVITY_HEAD WHERE STAH_STAFF_ID = ? AND TO_NUMBER(STAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                flag = false;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean IsValidSKTTime()
    {
        boolean flag = true;
        String s = null;
        String s1 = null;
        sql = "SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'ASSESSMENT_SKT_DATE_FROM'";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s = resultset.getString(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        if(!flag)
            return flag;
        sql = "SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'ASSESSMENT_SKT_DATE_TO'";
        try
        {
            PreparedStatement preparedstatement1 = dbConn.prepareStatement(sql);
            ResultSet resultset1 = preparedstatement1.executeQuery();
            if(resultset1.next())
                s1 = resultset1.getString(1);
            preparedstatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errorMsg = "Error : " + sqlexception1.toString();
            flag = false;
        }
        if(!flag)
            return flag;
        sql = "SELECT 1 FROM DUAL WHERE SYSDATE BETWEEN TO_DATE('" + s + ":00:00','DD/MM/YYYY:HH24:MI') " + "AND TO_DATE('" + s1 + ":23:59','DD/MM/YYYY:HH24:MI')";
        try
        {
            PreparedStatement preparedstatement2 = dbConn.prepareStatement(sql);
            ResultSet resultset2 = preparedstatement2.executeQuery();
            if(resultset2.next())
                flag = true;
            else
                flag = false;
            preparedstatement2.close();
        }
        catch(SQLException sqlexception2)
        {
            errorMsg = "Error : " + sqlexception2.toString();
            flag = false;
        }
        return flag;
    }

    public boolean CreateNewSKTTarget(String s, int i)
    {
        boolean flag = true;
        String s1 = "INSERT INTO STAFF_TARGET_ACTIVITY_HEAD (STAH_STAFF_ID,STAH_YEAR,STAH_STATUS,STAH_ENTER_DATE) VALUES (?,LTRIM(TO_CHAR(?,'9999')),'ENTRY',SYSDATE)";
        if(IsSKTTargetExists(s, i))
            return true;
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to create new SKT target";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error during new SKT target creation : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean AddSKTTargetDetail(String s, int i, int j, String s1, double d)
    {
        boolean flag = true;
        String s2 = "INSERT INTO STAFF_TARGET_ACTIVITY_DETL (STAD_STAFF_ID,STAD_YEAR,STAD_REF_ID,STAD_ACTIVITY,STAD_PERCENTAGE) VALUES (?,LTRIM(TO_CHAR(?,'9999')),LTRIM(TO_CHAR(?)),?,?)";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s2);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            preparedstatement.setInt(3, j);
            preparedstatement.setString(4, s1);
            preparedstatement.setDouble(5, d);
            int k = preparedstatement.executeUpdate();
            if(k < 1)
            {
                flag = false;
                errorMsg = "Unable to save SKT target detail";
                dbConn.rollback();
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error during saving SKT target detail : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean DeleteSKTTargetDetail(String s, int i)
    {
        boolean flag = true;
        String s1 = "DELETE STAFF_TARGET_ACTIVITY_DETL WHERE STAD_STAFF_ID = ? AND TO_NUMBER(STAD_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to delete SKT target detail";
                dbConn.rollback();
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error during deleting SKT target detail : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean IsSKTResourceExists(String s, int i)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_TARGET_RESOURCE_HEAD WHERE STRH_STAFF_ID = ? AND TO_NUMBER(STRH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                flag = false;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean CreateNewSKTResource(String s, int i)
    {
        boolean flag = true;
        String s1 = "INSERT INTO STAFF_TARGET_RESOURCE_HEAD (STRH_STAFF_ID,STRH_YEAR,STRH_STATUS,STRH_ENTER_DATE) VALUES (?,LTRIM(TO_CHAR(?,'9999')),'ENTRY',SYSDATE)";
        if(IsSKTResourceExists(s, i))
            return true;
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to create new SKT resource";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error during new SKT resource creation : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean AddSKTResourceDetail(String s, int i, String s1)
    {
        boolean flag = true;
        String s2 = "INSERT INTO STAFF_TARGET_RESOURCE_DETL (STRD_STAFF_ID,STRD_YEAR,STRD_RESOURCE) VALUES (?,LTRIM(TO_CHAR(?,'9999')),?)";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s2);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            preparedstatement.setString(3, s1);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save SKT resource detail";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error during saving SKT resource detail : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean DeleteSKTResourceDetail(String s, int i)
    {
        boolean flag = true;
        String s1 = "DELETE STAFF_TARGET_RESOURCE_DETL WHERE STRD_STAFF_ID = ? AND TO_NUMBER(STRD_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to delete SKT resource detail";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error during deleting SKT resource detail : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean SubmitSKT(String s, int i, String s1)
    {
        boolean flag = true;
        String s2 = "UPDATE STAFF_TARGET_ACTIVITY_HEAD SET STAH_APPROVE_BY = ?, STAH_STATUS = 'APPLY' WHERE STAH_STAFF_ID = ? AND TO_NUMBER(STAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s2);
            preparedstatement.setString(1, s1);
            preparedstatement.setString(2, s);
            preparedstatement.setInt(3, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to submit SKT";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Unable to submit SKT : " + sqlexception.toString();
        }
        if(!flag)
            return flag;
        s2 = "UPDATE STAFF_TARGET_RESOURCE_HEAD SET STRH_APPROVE_BY = ?, STRH_STATUS = 'APPLY' WHERE STRH_STAFF_ID = ? AND TO_NUMBER(STRH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement1 = dbConn.prepareStatement(s2);
            preparedstatement1.setString(1, s1);
            preparedstatement1.setString(2, s);
            preparedstatement1.setInt(3, i);
            int k = preparedstatement1.executeUpdate();
            if(k < 1)
            {
                flag = false;
                errorMsg = "Unable to submit SKT";
            }
            preparedstatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errorMsg = "Unable to submit SKT : " + sqlexception1.toString();
        }
        if(flag)
            MemoApplySKT(s, i);
        return flag;
    }

    public boolean ApproveSKT(String s, int i)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_TARGET_ACTIVITY_HEAD SET STAH_STATUS = 'APPROVE', STAH_APPROVE_DATE = SYSDATE WHERE STAH_STAFF_ID = ? AND TO_NUMBER(STAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to approve SKT";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Unable to approve SKT : " + sqlexception.toString();
        }
        if(!flag)
            return flag;
        s1 = "UPDATE STAFF_TARGET_RESOURCE_HEAD SET STRH_STATUS = 'APPROVE', STRH_APPROVE_DATE = SYSDATE WHERE STRH_STAFF_ID = ? AND TO_NUMBER(STRH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement1 = dbConn.prepareStatement(s1);
            preparedstatement1.setString(1, s);
            preparedstatement1.setInt(2, i);
            int k = preparedstatement1.executeUpdate();
            if(k < 1)
            {
                flag = false;
                errorMsg = "Unable to approve SKT";
            }
            preparedstatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errorMsg = "Unable to approve SKT : " + sqlexception1.toString();
        }
        if(flag)
            MemoApproveSKT(s, i);
        return flag;
    }

    public String getSKTTargetStatus(String s, int i)
    {
        String s1 = "ENTRY";
        sql = "SELECT STAH_STATUS FROM STAFF_TARGET_ACTIVITY_HEAD WHERE STAH_STAFF_ID = ? AND TO_NUMBER(STAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            else
                s1 = "ENTRY";
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error : " + sqlexception.toString();
            s1 = "ENTRY";
        }
        return s1;
    }

    public String getSKTResourceStatus(String s, int i)
    {
        String s1 = "ENTRY";
        sql = "SELECT STRH_STATUS FROM STAFF_TARGET_RESOURCE_HEAD WHERE STRH_STAFF_ID = ? AND TO_NUMBER(STRH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            else
                s1 = "ENTRY";
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = "Error : " + sqlexception.toString();
            s1 = "ENTRY";
        }
        return s1;
    }
}