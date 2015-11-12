package cms.staff;

import java.sql.*;

public class SKTBean
{
    private Connection dbConn = null;
    private String sql = null;
    private String errorMsg = null;

    public void setDbConnection(Connection connection) {
        dbConn = connection;
    }

    public String getErrorMsg()
    {
        return errorMsg;
    }

    public String getSKTYear()
    {
        String s = null;
        sql = "SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'SKT_YEAR'";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            ResultSet rset = pstmt.executeQuery();
            if (rset.next())
                s = rset.getString(1);
            
            rset.close();
            pstmt.close();
        }
        catch(SQLException sqle) {
            errorMsg = "Error : " + sqle.toString();
            s = null;
        }
        return s;
    }

    public boolean IsPYD(String s, String s1)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_SKT_HEAD WHERE SSH_STAFF_ID = ? AND SSH_YEAR = ? ";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
                flag = true;
            else
                flag = false;
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error : " + sqle.toString();
            flag = false;
        }
        return flag;
    }

    public boolean IsPPP(String s, String s1)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_SKT_HEAD WHERE SSH_PPP = ? AND SSH_YEAR = ? ";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
                flag = true;
            else
                flag = false;
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error : " + sqle.toString();
            flag = false;
        }
        return flag;
    }

    public boolean IsValidSKTTime(String skt_type_from, String skt_type_to)
    {
        boolean flag = true;
        String date_from = null;
        String date_to = null;
        sql = "SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = ?";
        try {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setString(1, skt_type_from);
            ResultSet rset = pstmt.executeQuery();
            if (rset.next())
            	date_from = rset.getString(1);
            rset.close();
            pstmt.close();
        }
        catch(SQLException sqle) {
            errorMsg = "Error : " + sqle.toString();
            flag = false;
        }
        if(!flag)
            return flag;
        
        sql = "SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = ?";
        try {
            PreparedStatement pstmt1 = dbConn.prepareStatement(sql);
            pstmt1.setString(1, skt_type_to);
            ResultSet rset1 = pstmt1.executeQuery();
            if(rset1.next())
            	date_to = rset1.getString(1);
            rset1.close();
            pstmt1.close();
        }
        catch(SQLException sqle1) {
            errorMsg = "Error : " + sqle1.toString();
            flag = false;
        }
        if(!flag)
            return flag;
        
        sql = "SELECT 1 FROM DUAL WHERE SYSDATE BETWEEN TO_DATE('" + date_from + ":00:00','DD/MM/YYYY:HH24:MI') " + 
        		"AND TO_DATE('" + date_to + ":23:59','DD/MM/YYYY:HH24:MI')";
        
        try {
            PreparedStatement pstmt2 = dbConn.prepareStatement(sql);
            ResultSet rset2 = pstmt2.executeQuery();
            if (rset2.next())
                flag = true;
            else
                flag = false;
            pstmt2.close();
        }
        catch(SQLException sqle2) {
            errorMsg = "Error : " + sqle2.toString();
            flag = false;
        }
        return flag;
    }

    public String getSKTStatus(String s, String s1, int i)
    {
        String s2 = "ENTRY";
        if(i == 1)
            sql = "SELECT SSH_PART1_STATUS ";
        else
        if(i == 2)
            sql = "SELECT SSH_PART2_STATUS ";
        else
        if(i == 3)
            sql = "SELECT SSH_PART3_STATUS ";
        sql = sql + "FROM STAFF_SKT_HEAD WHERE SSH_STAFF_ID = ? " + "AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
                s2 = rset.getString(1);
            else
                s2 = "ENTRY";
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error : " + sqle.toString();
            s2 = "ENTRY";
        }
        return s2;
    }

    public String getSKTRemark(String s, String s1, String s2)
    {
        String s3 = null;
        if(s2.equals("pyd"))
            sql = "SELECT SSH_PYD_REMARK ";
        else
        if(s2.equals("ppp"))
            sql = "SELECT SSH_PPP_REMARK ";
        sql = sql + "FROM STAFF_SKT_HEAD WHERE SSH_STAFF_ID = ? " + "AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
                s3 = rset.getString(1);
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error : " + sqle.toString();
            s3 = null;
        }
        return s3;
    }

    public String getPPP(String s, String s1)
    {
        String s2 = null;
        sql = "SELECT SSH_PPP FROM STAFF_SKT_HEAD WHERE SSH_STAFF_ID = ? AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
                s2 = rset.getString(1);
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error : " + sqle.toString();
            s2 = null;
        }
        return s2;
    }

    public boolean DeleteSKT(String s, String s1, double d)
    {
        boolean flag = true;
        String s2 = null;
        if(d == 1.0D)
            s2 = "DELETE STAFF_SKT_1 WHERE SS1_STAFF_ID = ? AND SS1_YEAR = ?";
        else
        if(d == 2.1000000000000001D)
            s2 = "DELETE STAFF_SKT_21 WHERE SS21_STAFF_ID = ? AND SS21_YEAR = ?";
        else
        if(d == 2.2000000000000002D)
            s2 = "DELETE STAFF_SKT_22 WHERE SS22_STAFF_ID = ? AND SS22_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(s2);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            int i = pstmt.executeUpdate();
            if(i < 1)
            {
                flag = false;
                dbConn.rollback();
                errorMsg = "Unable to delete SKT detail";
            } else
            {
                dbConn.commit();
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during deleting SKT detail : " + sqle.toString();
        }
        return flag;
    }

    public boolean AddSKT1(String s, String s1, int i, String s2, String s3)
    {
        boolean flag = true;
        String s4 = "INSERT INTO STAFF_SKT_1 (SS1_STAFF_ID,SS1_YEAR,SS1_REFID,SS1_ACTIVITY,SS1_PERFORMANCE_INDICATOR) VALUES (?,?,?,?,?)";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(s4);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            pstmt.setInt(3, i);
            pstmt.setString(4, s2);
            pstmt.setString(5, s3);
            int j = pstmt.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save SKT";
            } else
            {
                dbConn.commit();
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during saving SKT : " + sqle.toString();
        }
        return flag;
    }

    public boolean AddSKT21(String s, String s1, int i, String s2, String s3)
    {
        boolean flag = true;
        String s4 = "INSERT INTO STAFF_SKT_21 (SS21_STAFF_ID,SS21_YEAR,SS21_REFID,SS21_ACTIVITY,SS21_PERFORMANCE_INDICATOR) VALUES (?,?,?,?,?)";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(s4);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            pstmt.setInt(3, i);
            pstmt.setString(4, s2);
            pstmt.setString(5, s3);
            int j = pstmt.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save SKT";
            } else
            {
                dbConn.commit();
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during saving SKT : " + sqle.toString();
        }
        return flag;
    }

    public boolean AddSKT22(String s, String s1, int i, String s2)
    {
        boolean flag = true;
        String s3 = "INSERT INTO STAFF_SKT_22 (SS22_STAFF_ID,SS22_YEAR,SS22_REFID,SS22_ACTIVITY) VALUES (?,?,?,?)";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(s3);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            pstmt.setInt(3, i);
            pstmt.setString(4, s2);
            int j = pstmt.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save SKT";
            } else
            {
                dbConn.commit();
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during saving SKT : " + sqle.toString();
        }
        return flag;
    }

    public boolean UpdatePYDRemark(String s, String s1, String s2)
    {
        boolean flag = true;
        String s3 = "UPDATE STAFF_SKT_HEAD SET SSH_PYD_REMARK = ? WHERE SSH_STAFF_ID = ? AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(s3);
            pstmt.setString(1, s2);
            pstmt.setString(2, s);
            pstmt.setString(3, s1);
            int i = pstmt.executeUpdate();
            if(i < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save SKT remark";
            } else
            {
                dbConn.commit();
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during saving SKT remark : " + sqle.toString();
        }
        return flag;
    }

    public boolean UpdatePPPRemark(String s, String s1, String s2)
    {
        boolean flag = true;
        String s3 = "UPDATE STAFF_SKT_HEAD SET SSH_PPP_REMARK = ? WHERE SSH_STAFF_ID = ? AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(s3);
            pstmt.setString(1, s2);
            pstmt.setString(2, s);
            pstmt.setString(3, s1);
            int i = pstmt.executeUpdate();
            if(i < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save SKT remark";
            } else
            {
                dbConn.commit();
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during saving SKT remark : " + sqle.toString();
        }
        return flag;
    }

    public boolean SubmitSKT(String s, String s1, int i)
    {
        boolean flag = true;
        String s2 = "UPDATE STAFF_SKT_HEAD SET ";
        if(i == 1)
            s2 = s2 + "SSH_PART1_STATUS = 'APPLY', SSH_PART1_PYD_DATE = SYSDATE ";
        else
        if(i == 2)
            s2 = s2 + "SSH_PART2_STATUS = 'APPLY', SSH_PART2_PYD_DATE = SYSDATE ";
        if(i == 3)
            s2 = s2 + "SSH_PART3_STATUS = 'APPLY', SSH_PART3_PYD_DATE = SYSDATE ";
        s2 = s2 + "WHERE SSH_STAFF_ID = ? AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(s2);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            int j = pstmt.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to submit SKT";
            } else
            {
                dbConn.commit();
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during submitting SKT : " + sqle.toString();
        }
        if(flag)
            MemoSubmitSKT(s, s1, i);
        return flag;
    }

    public boolean MemoSubmitSKT(String s, String s1, int i)
    {
        boolean flag = true;
        String s2 = null;
        Object obj = null;
        String s3 = null;
        sql = "SELECT SSH_STAFF_ID,SM_STAFF_NAME,SSH_PPP FROM STAFF_SKT_HEAD,STAFF_MAIN WHERE SM_STAFF_ID = SSH_STAFF_ID AND SSH_STAFF_ID = ? AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
            {
                s3 = rset.getString(3);
                s2 = "Please take note that there is a new SKT waiting to be edited/approved :<br><br>";
                s2 = s2 + "Details : <br><br>";
                s2 = s2 + "Staff ID : " + rset.getString(1) + "<br>";
                s2 = s2 + "Staff Name : " + rset.getString(2) + "<br>";
                s2 = s2 + "SKT Year : " + s1 + "<br>";
                s2 = s2 + "Bahagian : " + i + "<br>";
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during getting SKT info: " + sqle.toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            java.sql.CallableStatement callablestatement = dbConn.prepareCall(s4);
            callablestatement.setString(1, s);
            callablestatement.setString(2, s3);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "New SKT To Be Approved");
            callablestatement.setString(5, s2);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errorMsg = "Error during sending memo to Pegawai Penilai Pertama : " + exception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean ApproveSKT(String s, String s1, int i)
    {
        boolean flag = true;
        String s2 = "UPDATE STAFF_SKT_HEAD SET ";
        if(i == 1)
            s2 = s2 + "SSH_PART1_STATUS = 'APPROVE', SSH_PART1_PPP_DATE = SYSDATE ";
        else
        if(i == 2)
            s2 = s2 + "SSH_PART2_STATUS = 'APPROVE', SSH_PART2_PPP_DATE = SYSDATE ";
        if(i == 3)
            s2 = s2 + "SSH_PART3_STATUS = 'APPROVE', SSH_PART3_PPP_DATE = SYSDATE ";
        s2 = s2 + "WHERE SSH_STAFF_ID = ? AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(s2);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            int j = pstmt.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to approve SKT";
            } else
            {
                dbConn.commit();
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during approving SKT : " + sqle.toString();
        }
        if(flag)
            MemoApproveSKT(s, s1, i);
        return flag;
    }

    public boolean RejectSKT(String s, String s1, int i)
    {
        boolean flag = true;
        String s2 = "UPDATE STAFF_SKT_HEAD SET ";
        if(i == 1)
            s2 = s2 + "SSH_PART1_STATUS = 'ENTRY', SSH_PART1_PPP_DATE = SYSDATE ";
        else
        if(i == 2)
            s2 = s2 + "SSH_PART2_STATUS = 'ENTRY', SSH_PART2_PPP_DATE = SYSDATE ";
        if(i == 3)
            s2 = s2 + "SSH_PART3_STATUS = 'ENTRY', SSH_PART3_PPP_DATE = SYSDATE ";
        s2 = s2 + "WHERE SSH_STAFF_ID = ? AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(s2);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            int j = pstmt.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to reject SKT";
            } else
            {
                dbConn.commit();
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during rejecting SKT : " + sqle.toString();
        }
        if(flag)
            MemoRejectSKT(s, s1, i);
        return flag;
    }

    public boolean MemoApproveSKT(String s, String s1, int i)
    {
        boolean flag = true;
        String s2 = null;
        Object obj = null;
        String s3 = null;
        sql = "SELECT SSH_STAFF_ID,SM_STAFF_NAME,SSH_PPP FROM STAFF_SKT_HEAD,STAFF_MAIN WHERE SM_STAFF_ID = SSH_PPP AND SSH_STAFF_ID = ? AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
            {
                s3 = rset.getString(3);
                s2 = "Please take note that your SKT has been approved :<br><br>";
                s2 = s2 + "Details : <br><br>";
                s2 = s2 + "SKT Year : " + s1 + "<br>";
                s2 = s2 + "Bahagian : " + i + "<br>";
                s2 = s2 + "Approved By : " + s3 + " - " + rset.getString(2) + "<br>";
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during getting SKT info: " + sqle.toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            java.sql.CallableStatement callablestatement = dbConn.prepareCall(s4);
            callablestatement.setString(1, s3);
            callablestatement.setString(2, s);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "SKT Approved");
            callablestatement.setString(5, s2);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errorMsg = "Error during sending memo to Subordinate : " + exception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean MemoRejectSKT(String s, String s1, int i)
    {
        boolean flag = true;
        String s2 = null;
        Object obj = null;
        String s3 = null;
        sql = "SELECT SSH_STAFF_ID,SM_STAFF_NAME,SSH_PPP FROM STAFF_SKT_HEAD,STAFF_MAIN WHERE SM_STAFF_ID = SSH_PPP AND SSH_STAFF_ID = ? AND SSH_YEAR = ?";
        try
        {
            PreparedStatement pstmt = dbConn.prepareStatement(sql);
            pstmt.setString(1, s);
            pstmt.setString(2, s1);
            ResultSet rset = pstmt.executeQuery();
            if(rset.next())
            {
                s3 = rset.getString(3);
                s2 = "Please take note that your SKT has been rejected :<br><br>";
                s2 = s2 + "Details : <br><br>";
                s2 = s2 + "SKT Year : " + s1 + "<br>";
                s2 = s2 + "Bahagian : " + i + "<br>";
                s2 = s2 + "Rejected By : " + s3 + " - " + rset.getString(2) + "<br><br>";
                s2 = s2 + "Please correct your SKT as necessary and re-submit.";
            }
            pstmt.close();
        }
        catch(SQLException sqle)
        {
            errorMsg = "Error during getting SKT info: " + sqle.toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            java.sql.CallableStatement callablestatement = dbConn.prepareCall(s4);
            callablestatement.setString(1, s3);
            callablestatement.setString(2, s);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "SKT Rejected");
            callablestatement.setString(5, s2);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errorMsg = "Error during sending memo to Subordinate : " + exception.toString();
            flag = false;
        }
        return flag;
    }
}