// Decompiled by DJ v3.10.10.93 Copyright 2007 Atanas Neshkov  Date: 10/11/2011 21:00:32
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   AssessmentBean.java

package cms.staff;

import java.sql.*;

public class AssessmentBean
{

    public AssessmentBean()
    {
        dbConn = null;
    }

    public void setDbConnection(Connection connection)
    {
        dbConn = connection;
    }

    public String getErrorMsg()
    {
        return errorMsg;
    }

    public boolean MemoApplyAssessment(String s, int i)
    {
        boolean flag = true;
        String s1 = null;
        String s2 = null;
        String s3 = null;
        sql = "SELECT SAH_STAFF_ID,SM_STAFF_NAME,SAH_YEAR,SAH_EVALUATOR1 FROM STAFF_ASSESSMENT_HEAD,STAFF_MAIN WHERE SM_STAFF_ID = SAH_STAFF_ID AND SAH_STAFF_ID = ? AND TO_CHAR(SAH_YEAR) = ?";
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
                s1 = "Please take note that there is a new Assessment (Penilaian Prestasi) waiting to be recommended :<br><br>";
                s1 = (new StringBuilder(String.valueOf(s1))).append("Details : <br><br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Staff ID : ").append(resultset.getString(1)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Staff Name : ").append(resultset.getString(2)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Assessment Year : ").append(resultset.getString(3)).append("<br>").toString();
            }
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during getting assessment info: ")).append(sqlexception.toString()).toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            CallableStatement callablestatement = dbConn.prepareCall(s4);
            callablestatement.setString(1, s3);
            callablestatement.setString(2, s2);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "New Assessment (Penilaian Prestasi) To Be Recommended");
            callablestatement.setString(5, s1);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errorMsg = (new StringBuilder("Error during sending memo to Pegawai Penilai Pertama : ")).append(exception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean MemoSubmitAssessmentToPPK(String s, int i)
    {
        boolean flag = true;
        String s1 = null;
        String s2 = null;
        String s3 = null;
        sql = "SELECT SAH_STAFF_ID,APPLICANT.SM_STAFF_NAME,SAH_YEAR, SAH_EVALUATOR1,EVALUATOR1.SM_STAFF_NAME, SAH_EVALUATOR2 FROM STAFF_ASSESSMENT_HEAD,STAFF_MAIN APPLICANT,STAFF_MAIN EVALUATOR1 WHERE APPLICANT.SM_STAFF_ID = SAH_STAFF_ID AND EVALUATOR1.SM_STAFF_ID = SAH_EVALUATOR1 AND SAH_STAFF_ID = ? AND TO_CHAR(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                s2 = resultset.getString(4);
                s3 = resultset.getString(6);
                s1 = "Please take note that there is a new Assessment (Penilaian Prestasi) waiting to be approved :<br><br>";
                s1 = (new StringBuilder(String.valueOf(s1))).append("Details : <br><br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Staff ID : ").append(resultset.getString(1)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Staff Name : ").append(resultset.getString(2)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Assessment Year : ").append(resultset.getString(3)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("PPP : ").append(resultset.getString(4)).append(" - ").append(resultset.getString(5)).append("<br>").toString();
            }
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during getting assessment info: ")).append(sqlexception.toString()).toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            CallableStatement callablestatement = dbConn.prepareCall(s4);
            callablestatement.setString(1, s2);
            callablestatement.setString(2, s3);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "New Assessment (Penilaian Prestasi) To Be Approved");
            callablestatement.setString(5, s1);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errorMsg = (new StringBuilder("Error during sending memo to Pegawai Penilai Pertama : ")).append(exception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean MemoRejectAssessmentToPYD(String s, int i)
    {
        boolean flag = true;
        String s1 = null;
        String s2 = null;
        String s3 = null;
        sql = "SELECT SAH_STAFF_ID,APPLICANT.SM_STAFF_NAME,SAH_YEAR, SAH_EVALUATOR1,EVALUATOR1.SM_STAFF_NAME, SAH_EVALUATOR2 FROM STAFF_ASSESSMENT_HEAD,STAFF_MAIN APPLICANT,STAFF_MAIN EVALUATOR1 WHERE APPLICANT.SM_STAFF_ID = SAH_STAFF_ID AND EVALUATOR1.SM_STAFF_ID = SAH_EVALUATOR1 AND SAH_STAFF_ID = ? AND TO_CHAR(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                s2 = resultset.getString(4);
                s3 = resultset.getString(1);
                s1 = "Please take note that your assessment (Penilaian Prestasi) has been rejected :<br><br>";
                s1 = (new StringBuilder(String.valueOf(s1))).append("Details : <br><br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Staff ID : ").append(resultset.getString(1)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Staff Name : ").append(resultset.getString(2)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Assessment Year : ").append(resultset.getString(3)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Rejected by : ").append(resultset.getString(4)).append(" - ").append(resultset.getString(5)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Please correct your assessment (Penilaian Prestasi) as necessary and re-submit.").toString();
            }
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during getting assessment info: ")).append(sqlexception.toString()).toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            CallableStatement callablestatement = dbConn.prepareCall(s4);
            callablestatement.setString(1, s2);
            callablestatement.setString(2, s3);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "Assessment Rejected");
            callablestatement.setString(5, s1);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errorMsg = (new StringBuilder("Error during sending memo to Subordinate : ")).append(exception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean MemoApproveAssessment(String s, int i)
    {
        boolean flag = true;
        String s1 = null;
        String s2 = null;
        String s3 = null;
        sql = "SELECT SAH_EVALUATOR1,EVALUATOR1.SM_STAFF_NAME,TO_CHAR(SAH_EVALUATOR1_DATE,'DD/MM/YYYY'),SAH_EVALUATOR1_MARK, SAH_EVALUATOR2,EVALUATOR2.SM_STAFF_NAME,TO_CHAR(SAH_EVALUATOR2_DATE,'DD/MM/YYYY'),SAH_EVALUATOR2_MARK FROM STAFF_ASSESSMENT_HEAD,STAFF_MAIN EVALUATOR1,STAFF_MAIN EVALUATOR2 WHERE EVALUATOR1.SM_STAFF_ID = SAH_EVALUATOR1 AND EVALUATOR2.SM_STAFF_ID = SAH_EVALUATOR2 AND SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
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
                s1 = "Please take note your Assessment (Penilaian Prestasi) has been approved :<br><br>";
                s1 = (new StringBuilder(String.valueOf(s1))).append("Details : <br><br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("Assessment Year : ").append(i).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("PPP : ").append(resultset.getString(1)).append(" - ").append(resultset.getString(2)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("PPP Recommend Date ").append(resultset.getString(3)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("PPK : ").append(resultset.getString(4)).append(" - ").append(resultset.getString(5)).append("<br>").toString();
                s1 = (new StringBuilder(String.valueOf(s1))).append("PPK Approved Date : ").append(resultset.getString(6)).append("<br>").toString();
            }
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during getting SKT info: ")).append(sqlexception.toString()).toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            CallableStatement callablestatement = dbConn.prepareCall(s4);
            callablestatement.setString(1, s2);
            callablestatement.setString(2, s3);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "Assessment (Penilaian Prestasi) Approved");
            callablestatement.setString(5, s1);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errorMsg = (new StringBuilder("Error during sending memo to applicant : ")).append(exception.toString()).toString();
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
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            i = 0;
        }
        return i;
    }

    public int getAssessmentYear()
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
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            i = 0;
        }
        return i;
    }

    public boolean IsAssessmentMiscExists(String s, int i, double d)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_ASSESSMENT_MISC WHERE SAM_STAFF_ID = ? AND TO_NUMBER(SAM_YEAR) = ? AND SAM_CATEGORY = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            preparedstatement.setDouble(3, d);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            else
                flag = false;
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean CheckActivity(String s, int i)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_ASSESSMENT_ACTIVITY WHERE SAA_STAFF_ID = ?  AND TO_NUMBER(SAA_YEAR) = ?";
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
            errorMsg = "Please insert required activities.";
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean CheckTraining(String s, int i)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_ASSESSMENT_TRAINING WHERE SAT_STAFF_ID = ?  AND TO_NUMBER(SAT_YEAR) = ?";
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
            errorMsg = "Please insert required training.";
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean CheckTna(String s, int i)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_ASSESSMENT_TNA WHERE SAT2_STAFF_ID = ?  AND TO_NUMBER(SAT2_YEAR) = ?";
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
            errorMsg = "Please insert required training.";
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            flag = false;
        }
        return flag;
    }

	public boolean CheckKra(String s, int i)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_ASSESSMENT_KRA WHERE SAK_STAFF_ID = ?  AND TO_NUMBER(SAK_YEAR) = ?";
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
            errorMsg = "Please insert KRA Contribution.";
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            flag = false;
        }
        return flag;
    }
    
    public boolean IsPYD(String s, int i)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_ASSESSMENT_HEAD WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ? ";
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
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean IsPPP(String s, int i)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_ASSESSMENT_HEAD WHERE SAH_EVALUATOR1 = ? AND TO_NUMBER(SAH_YEAR) = ? ";
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
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean IsPPK(String s, int i)
    {
        boolean flag = true;
        sql = "SELECT 1 FROM STAFF_ASSESSMENT_HEAD WHERE SAH_EVALUATOR2 = ? AND TO_NUMBER(SAH_YEAR) = ? ";
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
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean IsAPC(String s, int i)
    {
        boolean flag = true;
        sql = " select SSP_STAFF_id from staff_assessment_panel, STAFF_ASSESSMENT_PANEL_DATE  WHERE SSP_STAFF_id = ? AND TO_NUMBER(sapd_year) = ? AND SSP_ASSESSMENT_seq=SAPD_SEQ";
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
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            flag = false;
        }
        return flag;
    }

    public boolean CreateNewAssessmentMisc(String s, int i, double d)
    {
        boolean flag = true;
        String s1 = null;
        String s2 = "INSERT INTO STAFF_ASSESSMENT_MISC (SAM_STAFF_ID,SAM_YEAR,SAM_CATEGORY,SAM_REFID,SAM_EVALUATOR1_MARK,SAM_EVALUATOR2_MARK) SELECT ?,LTRIM(TO_CHAR(?)),?,AGQ_REFID,0,0 FROM ASSESSMENT_GRADING_QUESTION WHERE AGQ_CATEGORY = ? AND AGQ_CLASSIFICATION = ? AND AGQ_LANGUAGE = 'BM' ";
        if(IsAssessmentMiscExists(s, i, d))
            return true;
        s1 = getAssessmentClassification(s, i);
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s2);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            preparedstatement.setDouble(3, d);
            preparedstatement.setDouble(4, d);
            preparedstatement.setString(5, s1);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to create new assessment details";
            } else
            {
                flag = true;
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during new assessment details creation : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean SaveAssessmentMisc(String s, int i, double d, double d1, double d2, double d3)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_ASSESSMENT_MISC SET SAM_EVALUATOR1_MARK = ?, SAM_EVALUATOR2_MARK = ? WHERE SAM_STAFF_ID = ? AND SAM_YEAR = ? AND SAM_CATEGORY = ? AND SAM_REFID = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setDouble(1, d2);
            preparedstatement.setDouble(2, d3);
            preparedstatement.setString(3, s);
            preparedstatement.setInt(4, i);
            preparedstatement.setDouble(5, d);
            preparedstatement.setDouble(6, d1);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to save assessment details";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving assessment details : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean SaveRemarkPpp(String s, String s1, String s2, String s3, String s5, 
    String s6, String s7, String s8, String s9, String s10, int i)
    {
        boolean flag = true;
        String s4 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_EVALUATOR1_REMARK1 = ? ,SAH_EVALUATOR1_REMARK2 = ? ,SAH_EVALUATOR1_mth = ?, "+ 
        			"SAH_COMMENTPPP_ENHANCEMENT = ?, SAH_COMMENTPPP_NEWIDEA = ?, SAH_COMMENTPPP_OUTCOME = ?, "+
        			"SAH_COMMENTPPP_COST = ?, SAH_COMMENTPPP_CONTRIBUTION = ?, SAH_COMMENTPPP_OTHERS =? WHERE SAH_STAFF_ID = ? AND SAH_YEAR = ? ";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s4);
            preparedstatement.setString(1, s1);
            preparedstatement.setString(2, s2);
            preparedstatement.setString(3, s3);
            preparedstatement.setString(4, s5);
            preparedstatement.setString(5, s6);
            preparedstatement.setString(6, s7);
            preparedstatement.setString(7, s8);
            preparedstatement.setString(8, s9);
            preparedstatement.setString(9, s10);
            preparedstatement.setString(10, s);
            preparedstatement.setInt(11, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to save assessment remark - PPP";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving assessment remark - PPP : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }
    
    public boolean SaveRemarkPpp2(String s, String s1, String s2, String s3, int i)
    {
        boolean flag = true;
        String s4 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_EVALUATOR1_REMARK1 = ? ,SAH_EVALUATOR1_REMARK2 = ? ,SAH_EVALUATOR1_mth = ? "+ 
        			"WHERE SAH_STAFF_ID = ? AND SAH_YEAR = ? ";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s4);
            preparedstatement.setString(1, s1);
            preparedstatement.setString(2, s2);
            preparedstatement.setString(3, s3);
            preparedstatement.setString(4, s);
            preparedstatement.setInt(5, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to save assessment remark - PPP";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving assessment remark - PPP : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean SaveRemarkPpk(String s, String s1, String s2, String s4, String s5, 
    String s6, String s7, String s8, String s9, int i)
    {
        boolean flag = true;
        String s3 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_EVALUATOR2_REMARK = ? ,SAH_EVALUATOR2_mth = ?, "+  
       				 "SAH_COMMENTPPK_ENHANCEMENT = ?, SAH_COMMENTPPK_NEWIDEA = ?, SAH_COMMENTPPK_OUTCOME = ?, "+
        			"SAH_COMMENTPPK_COST = ?, SAH_COMMENTPPK_CONTRIBUTION = ?, SAH_COMMENTPPK_OTHERS =? WHERE SAH_STAFF_ID = ? AND SAH_YEAR = ? ";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s3);
            preparedstatement.setString(1, s1);
            preparedstatement.setString(2, s2);
            preparedstatement.setString(3, s4);
            preparedstatement.setString(4, s5);
            preparedstatement.setString(5, s6);
            preparedstatement.setString(6, s7);
            preparedstatement.setString(7, s8);
            preparedstatement.setString(8, s9);
            preparedstatement.setString(9, s);
            preparedstatement.setInt(10, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to save assessment remark - PPK";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving assessment remark - PPK : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean UpdateTotalAssessmentMark(String s, int i)
    {
        boolean flag = true;
        double d = 0.0D;
        double d1 = 0.0D;
        String s1 = "SELECT SAM_CATEGORY,SUM(SAM_EVALUATOR1_MARK),SUM(AGQ_MAX_MARK),AGH_MAX_MARK FROM ASSESSMENT_GRADING_HEAD,ASSESSMENT_GRADING_QUESTION,STAFF_ASSESSMENT_MISC,STAFF_ASSESSMENT_HEAD WHERE SAM_STAFF_ID = ? AND TO_NUMBER(SAM_YEAR) = ? AND SAH_STAFF_ID = SAM_STAFF_ID AND SAH_YEAR = SAM_YEAR AND AGQ_CLASSIFICATION = SAH_CLASSIFICATION AND AGQ_CATEGORY = SAM_CATEGORY AND AGH_CLASSIFICATION = SAH_CLASSIFICATION AND AGH_CATEGORY = SAM_CATEGORY GROUP BY SAM_CATEGORY,AGH_MAX_MARK";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            for(ResultSet resultset = preparedstatement.executeQuery(); resultset.next();)
                d += (resultset.getDouble(2) / resultset.getDouble(3)) * resultset.getDouble(4);

            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            d = 0.0D;
        }
        s1 = "SELECT SAM_CATEGORY,SUM(SAM_EVALUATOR2_MARK),SUM(AGQ_MAX_MARK),AGH_MAX_MARK FROM ASSESSMENT_GRADING_HEAD,ASSESSMENT_GRADING_QUESTION,STAFF_ASSESSMENT_MISC,STAFF_ASSESSMENT_HEAD WHERE SAM_STAFF_ID = ? AND TO_NUMBER(SAM_YEAR) = ? AND SAH_STAFF_ID = SAM_STAFF_ID AND SAH_YEAR = SAM_YEAR AND AGQ_CLASSIFICATION = SAH_CLASSIFICATION AND AGQ_CATEGORY = SAM_CATEGORY AND AGH_CLASSIFICATION = SAH_CLASSIFICATION AND AGH_CATEGORY = SAM_CATEGORY GROUP BY SAM_CATEGORY,AGH_MAX_MARK";
        try
        {
            PreparedStatement preparedstatement1 = dbConn.prepareStatement(s1);
            preparedstatement1.setString(1, s);
            preparedstatement1.setInt(2, i);
            for(ResultSet resultset1 = preparedstatement1.executeQuery(); resultset1.next();)
                d1 += (resultset1.getDouble(2) / resultset1.getDouble(3)) * resultset1.getDouble(4);

            preparedstatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception1.toString()).toString();
            d1 = 0.0D;
        }
        s1 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_EVALUATOR1_MARK = ?, SAH_EVALUATOR2_MARK = ? WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement2 = dbConn.prepareStatement(s1);
            preparedstatement2.setDouble(1, d);
            preparedstatement2.setDouble(2, d1);
            preparedstatement2.setString(3, s);
            preparedstatement2.setInt(4, i);
            int j = preparedstatement2.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to save assessment total marks";
            }
            preparedstatement2.close();
        }
        catch(SQLException sqlexception2)
        {
            errorMsg = (new StringBuilder("Error during saving assessment total marks : ")).append(sqlexception2.toString()).toString();
        }
        return flag;
    }

    public boolean AddAssessmentTraining(String s, int i, int j, String s1, String s2, String s3)
    {
        boolean flag = true;
        String s4 = "INSERT INTO STAFF_ASSESSMENT_TRAINING (SAT_STAFF_ID,SAT_YEAR,SAT_REFID,SAT_TRAINING_NAME,SAT_DATE_INTERVAL,SAT_VENUE) VALUES (?,LTRIM(TO_CHAR(?)),?,?,?,?)";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s4);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            preparedstatement.setInt(3, j);
            preparedstatement.setString(4, s1);
            preparedstatement.setString(5, s2);
            preparedstatement.setString(6, s3);
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
            errorMsg = (new StringBuilder("Error during saving SKT target detail : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean DeleteAssessmentTraining(String s, int i)
    {
        boolean flag = true;
        String s1 = "DELETE STAFF_ASSESSMENT_TRAINING WHERE SAT_STAFF_ID = ? AND TO_NUMBER(SAT_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to delete assessment training";
                dbConn.rollback();
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during deleting assessment training : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean DeleteAssessmentTNA(String s, int i)
    {
        boolean flag = true;
        String s1 = "DELETE STAFF_ASSESSMENT_TNA WHERE SAT2_STAFF_ID = ? AND TO_NUMBER(SAT2_YEAR) = ? AND SAT2_TYPE = 'DALAM' ";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to delete assessment TNA";
                dbConn.rollback();
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during deleting assessment TNA : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean DeleteAssessmentTNA2(String s, int i)
    {
        boolean flag = true;
        String s1 = "DELETE STAFF_ASSESSMENT_TNA WHERE SAT2_STAFF_ID = ? AND TO_NUMBER(SAT2_YEAR) = ? AND SAT2_TYPE = 'LUAR'";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to delete assessment TNA";
                dbConn.rollback();
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during deleting assessment TNA : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean AddAssessmentActivity(String s, int i, int j, String s1, String s2)
    {
        boolean flag = true;
        String s3 = "INSERT INTO STAFF_ASSESSMENT_ACTIVITY (SAA_STAFF_ID,SAA_YEAR,SAA_REFID,SAA_ACTIVITY,SAA_LEVEL) VALUES (?,LTRIM(TO_CHAR(?,'9999')),?,?,?)";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s3);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            preparedstatement.setInt(3, j);
            preparedstatement.setString(4, s1);
            preparedstatement.setString(5, s2);
            int k = preparedstatement.executeUpdate();
            if(k < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save assessment activity";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving SKT resource detail : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

	public boolean AddAssessmentKRA(String s, int i, int j, String s1, String s2)
    {
        boolean flag = true;
        String s3 = "INSERT INTO STAFF_ASSESSMENT_KRA (SAK_STAFF_ID,SAK_YEAR,SAK_REFID,SAK_DESC,SAK_KRA) VALUES (?,LTRIM(TO_CHAR(?,'9999')),?,?,?)";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s3);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            preparedstatement.setInt(3, j);
            preparedstatement.setString(4, s1);
            preparedstatement.setString(5, s2);
            int k = preparedstatement.executeUpdate();
            if(k < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save assessment KRA";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving SKT KRA resource detail : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }
    
    public boolean AddAssessmentTNA(String s, int i, int j, String s1, String s2, String s3)
    {
        boolean flag = true;
        String s4 = "INSERT INTO STAFF_ASSESSMENT_TNA (SAT2_STAFF_ID,SAT2_YEAR,SAT2_REFID,SAT2_TRAINING,SAT2_REASON,SAT2_TYPE) VALUES (?,LTRIM(TO_CHAR(?,'9999')),?,?,?,?)";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s4);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            preparedstatement.setInt(3, j);
            preparedstatement.setString(4, s1);
            preparedstatement.setString(5, s2);
            preparedstatement.setString(6, s3);
            int k = preparedstatement.executeUpdate();
            if(k < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save assessment TNA";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving assessment TNA : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean UpdateTNA(String s, String s1, String s2, String s3)
    {
        boolean flag = true;
        String s4 = "UPDATE TNA_STAFF_HEAD SET TSH_ASSESSMENT_REASON = ? WHERE TSH_REF_ID = ? AND TSH_TRAINING_ID = ? AND TSH_STAFF_ID = ? ";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s4);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            preparedstatement.setString(4, s3);
            int i = preparedstatement.executeUpdate();
            if(i < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save assessment TNA";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving assessment TNA : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean DeleteAssessmentActivity(String s, int i)
    {
        boolean flag = true;
        String s1 = "DELETE STAFF_ASSESSMENT_ACTIVITY WHERE SAA_STAFF_ID = ? AND TO_NUMBER(SAA_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to delete assessment activity";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during deleting SKT resource detail : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }
	
	public boolean DeleteAssessmentKRA(String s, int i)
    {
        boolean flag = true;
        String s1 = "DELETE STAFF_ASSESSMENT_KRA WHERE SAK_STAFF_ID = ? AND TO_NUMBER(SAK_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                flag = false;
                errorMsg = "Unable to delete assessment KRA";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during deleting SKT KRA resource detail : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }
    
    public boolean SubmitAssessment(String s, int i)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_STATUS = 'APPLY' WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to submit assessment";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Unable to submit assessment : ")).append(sqlexception.toString()).toString();
        }
        if(!flag)
            return flag;
        if(flag)
            MemoApplyAssessment(s, i);
        return flag;
    }

    public boolean SubmitAssessmentToPPK(String s, int i)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_STATUS = 'RECOMMEND1', SAH_EVALUATOR1_DATE = SYSDATE WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to submit assessment";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Unable to submit assessment : ")).append(sqlexception.toString()).toString();
        }
        if(!flag)
            return flag;
        if(flag)
            MemoSubmitAssessmentToPPK(s, i);
        return flag;
    }

    public boolean SubmitAssessmentApprove(String s, int i)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_STATUS = 'APPROVE', SAH_EVALUATOR1_DATE = SYSDATE WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to submit assessment";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Unable to submit assessment : ")).append(sqlexception.toString()).toString();
        }
        if(!flag)
            return flag;
        if(flag)
            MemoSubmitAssessmentToPPK(s, i);
        return flag;
    }

    public boolean RejectAssessmentToPYD(String s, int i)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_STATUS = 'ENTRY' WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to reject assessment";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Unable to reject assessment : ")).append(sqlexception.toString()).toString();
        }
        if(!flag)
            return flag;
        if(flag)
            MemoRejectAssessmentToPYD(s, i);
        return flag;
    }

    public boolean ApproveAssessment(String s, int i)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_STATUS = 'APPROVE', SAH_EVALUATOR2_DATE = SYSDATE WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to submit assessment";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Unable to submit assessment : ")).append(sqlexception.toString()).toString();
        }
        if(!flag)
            return flag;
        if(flag)
            MemoApproveAssessment(s, i);
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
            errorMsg = (new StringBuilder("Unable to approve SKT : ")).append(sqlexception.toString()).toString();
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
            errorMsg = (new StringBuilder("Unable to approve SKT : ")).append(sqlexception1.toString()).toString();
        }
        if(flag)
            MemoApproveAssessment(s, i);
        return flag;
    }

    public String getAssessmentStatus(String s, int i)
    {
        String s1 = "ENTRY";
        sql = "SELECT SAH_STATUS FROM STAFF_ASSESSMENT_HEAD WHERE SAH_STAFF_ID = ? AND SAH_YEAR = ?";
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
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            s1 = "ENTRY";
        }
        return s1;
    }

    public String getAssessmentClassification(String s, int i)
    {
        String s1 = "";
        sql = "SELECT SAH_CLASSIFICATION FROM STAFF_ASSESSMENT_HEAD WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            else
                s1 = "";
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            s1 = "";
        }
        return s1;
    }

    public String getAssessmentEvaluator1(String s, int i)
    {
        String s1 = "";
        sql = "SELECT SAH_EVALUATOR1 FROM STAFF_ASSESSMENT_HEAD WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            else
                s1 = "";
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            s1 = "";
        }
        return s1;
    }

    public String getAssessmentEvaluator2(String s, int i)
    {
        String s1 = "";
        sql = "SELECT SAH_EVALUATOR2 FROM STAFF_ASSESSMENT_HEAD WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            else
                s1 = "";
            preparedstatement.close();
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error : ")).append(sqlexception.toString()).toString();
            s1 = "";
        }
        return s1;
    }

    public boolean SaveFinalMark(String s, int i, double d, double d1)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_FINAL_MARK = ?, SAH_EVALUATOR1_MARK_FINAL = ? , SAH_EVALUATOR2_MARK_FINAL = ? , SAH_APPLICANT_MARK = ? , SAH_AVERAGE_MARK = ? WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setDouble(1, d);
            preparedstatement.setDouble(2, d);
            preparedstatement.setDouble(3, d);
            preparedstatement.setDouble(4, d);
            preparedstatement.setDouble(5, d1);
            preparedstatement.setString(6, s);
            preparedstatement.setInt(7, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save assessment final mark";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving assessment final mark : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean UpdateMark(String s, int i)
    {
        boolean flag = true;
        double d = 0.0D;
        double d1 = 0.0D;
        double d2 = 0.0D;
        double d3 = 0.0D;
        String s1 = null;
        String s2 = "SELECT SAH_FINAL_MARK, SAH_AVERAGE_MARK FROM STAFF_ASSESSMENT_HEAD WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s2);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                double d4 = resultset.getDouble(1);
                double d5 = resultset.getDouble(2);
                if(d4 > d5)
                {
                    double d6 = d4 - d5;
                    d3 = d6 / 100D;
                    s1 = "inc";
                } else
                if(d4 < d5)
                {
                    double d7 = d5 - d4;
                    d3 = d7 / 100D;
                    s1 = "dec";
                } else
                {
                    s1 = "nil";
                    d3 = 0.0D;
                }
            } else
            {
                preparedstatement.close();
                resultset.close();
            }
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving assessment final mark : ")).append(sqlexception.toString()).toString();
        }
        s2 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_PERCENT = ? , SAH_PERCENT_STATUS = ? WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement1 = dbConn.prepareStatement(s2);
            preparedstatement1.setDouble(1, d3);
            preparedstatement1.setString(2, s1);
            preparedstatement1.setString(3, s);
            preparedstatement1.setInt(4, i);
            int j = preparedstatement1.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save final mark";
            } else
            {
                dbConn.commit();
            }
            preparedstatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errorMsg = (new StringBuilder("Error during saving final mark : ")).append(sqlexception1.toString()).toString();
        }
        return flag;
    }

    public boolean SaveApc(String s, int i)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_APC = 'Y' WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to save APC";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving APC : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean DeleteApc(String s, int i)
    {
        boolean flag = true;
        String s1 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_APC = null WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
        try
        {
            PreparedStatement preparedstatement = dbConn.prepareStatement(s1);
            preparedstatement.setString(1, s);
            preparedstatement.setInt(2, i);
            int j = preparedstatement.executeUpdate();
            if(j < 1)
            {
                dbConn.rollback();
                flag = false;
                errorMsg = "Unable to reject APC";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during reject APC : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    public boolean SaveRemark(String s, int i, String s1)
    {
        boolean flag = true;
        String s2 = "UPDATE STAFF_ASSESSMENT_HEAD SET SAH_REMARK = ? WHERE SAH_STAFF_ID = ? AND TO_NUMBER(SAH_YEAR) = ?";
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
                errorMsg = "Unable to save assessment remark";
            } else
            {
                dbConn.commit();
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errorMsg = (new StringBuilder("Error during saving assessment remark : ")).append(sqlexception.toString()).toString();
        }
        return flag;
    }

    private Connection dbConn;
    private String sql;
    private String errorMsg;
}