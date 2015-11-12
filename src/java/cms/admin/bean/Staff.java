package cms.admin.bean;

import java.io.Serializable;
import java.sql.*;

public class Staff implements Serializable
{
 	private static final long serialVersionUID = 1L;

 	protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String staffId;
    protected String staffName;
    protected String staffStatus;
    protected String deptCode;
    protected String staffGender;
    protected String telnoWork;
    protected String telnoHome;
    protected String handphoneNo;
    protected String faxNo;
    protected String jobCode;
    protected String emailAddr;
    protected String executive;
    protected String address;
    protected String icno;
    protected String birthdate;
    protected String birthplace;
    protected String birthstate;
    protected String marital;
    protected String childno;
    protected String race;
    protected String religion;
    protected String citizen;
    protected String currentstate;
    protected String currentpcode;
    protected String permanentaddress;
    protected String permanentstate;
    protected String permanentcountry;
    protected String permanentpcode;
    protected String bumi;
    protected String drivingLisence;
    protected String wardClass;
    protected String passport;
    protected String staffPosition;
    protected String deptDesc;
    protected String joinDate;
    protected String confirmDate;
    protected String pensionDate;
    protected String pensionNo;
    protected String jobStatus;
    protected String staffCategory;
    protected String incomeTaxNo;
    protected String incomeTaxBranch;
    protected String epfNo;
    protected String socsoNo;
    protected String luthNo;
    protected String asbNo;
    protected String bankNo;
    protected String bankName;
    protected String angkasaNo;
    protected String homeLoan;

    public Staff()
    {
        conn = null;
        sql = null;
        errmsg = null;
        pstmt = null;
        stmt = null;
        rset = null;
        staffId = null;
        staffName = null;
        staffStatus = null;
        deptCode = null;
        staffGender = null;
        telnoWork = null;
        telnoHome = null;
        handphoneNo = null;
        faxNo = null;
        jobCode = null;
        emailAddr = null;
        executive = null;
        address = null;
        icno = null;
        birthdate = null;
        birthplace = null;
        birthstate = null;
        marital = null;
        childno = null;
        race = null;
        religion = null;
        citizen = null;
        currentstate = null;
        currentpcode = null;
        permanentaddress = null;
        permanentstate = null;
        permanentcountry = null;
        permanentpcode = null;
        bumi = null;
        drivingLisence = null;
        wardClass = null;
        passport = null;
        staffPosition = null;
        deptDesc = null;
        joinDate = null;
        confirmDate = null;
        pensionDate = null;
        pensionNo = null;
        jobStatus = null;
        staffCategory = null;
        incomeTaxNo = null;
        incomeTaxBranch = null;
        epfNo = null;
        socsoNo = null;
        luthNo = null;
        asbNo = null;
        bankNo = null;
        bankName = null;
        angkasaNo = null;
        homeLoan = null;
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

    public String getStaffId()
    {
        return staffId;
    }

    public String getStaffName()
    {
        return staffName;
    }

    public String getStaffStatus()
    {
        return staffStatus;
    }

    public String getDeptCode()
    {
        return deptCode;
    }

    public String getStaffGender()
    {
        return staffGender;
    }

    public String getTelnoWork()
    {
        return telnoWork;
    }

    public String getTelnoHome()
    {
        return telnoHome;
    }

    public String getHandphoneNo()
    {
        return handphoneNo;
    }

    public String getFaxNo()
    {
        return faxNo;
    }

    public String getJobCode()
    {
        return jobCode;
    }

    public String getEmailAddr()
    {
        return emailAddr;
    }

    public String getExecutive()
    {
        return executive;
    }

    public String getAddress()
    {
        return address;
    }

    public String getICNo()
    {
        return icno;
    }

    public String getBirthDate()
    {
        return birthdate;
    }

    public String getBirthPlace()
    {
        return birthplace;
    }

    public String getBirthState()
    {
        return birthstate;
    }

    public String getMarital()
    {
        return marital;
    }

    public String getChildno()
    {
        return childno;
    }

    public String getRace()
    {
        return race;
    }

    public String getReligion()
    {
        return religion;
    }

    public String getCitizen()
    {
        return citizen;
    }

    public String getCurrentstate()
    {
        return currentstate;
    }

    public String getCurrentpcode()
    {
        return currentpcode;
    }

    public String getPermanentaddress()
    {
        return permanentaddress;
    }

    public String getPermanentstate()
    {
        return permanentstate;
    }

    public String getPermanentcountry()
    {
        return permanentcountry;
    }

    public String getPermanentpcode()
    {
        return permanentpcode;
    }

    public String getBumi()
    {
        return bumi;
    }

    public String getDrivingLisence()
    {
        return drivingLisence;
    }

    public String getWardClass()
    {
        return wardClass;
    }

    public String getPassport()
    {
        return passport;
    }

    public String getStaffPosition()
    {
        return staffPosition;
    }

    public String getDeptDesc()
    {
        return deptDesc;
    }

    public String getJoinDate()
    {
        return joinDate;
    }

    public String getConfirmDate()
    {
        return confirmDate;
    }

    public String getPensionDate()
    {
        return pensionDate;
    }

    public String getPensionNo()
    {
        return pensionNo;
    }

    public String getJobStatus()
    {
        return jobStatus;
    }

    public String getStaffCategory()
    {
        return staffCategory;
    }

    public String getIncomeTaxNo()
    {
        return incomeTaxNo;
    }

    public String getIncomeTaxBranch()
    {
        return incomeTaxBranch;
    }

    public String getEpfNo()
    {
        return epfNo;
    }

    public String getSocsoNo()
    {
        return socsoNo;
    }

    public String getLuthNo()
    {
        return luthNo;
    }

    public String getAsbNo()
    {
        return asbNo;
    }

    public String getBankNo()
    {
        return bankNo;
    }

    public String getBankName()
    {
        return bankName;
    }

    public String getAngkasaNo()
    {
        return angkasaNo;
    }

    public String getHomeLoan()
    {
        return homeLoan;
    }

    public boolean queryStaffBasicProfile(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT sm_staff_id, sm_staff_name, sm_staff_status, sm_dept_code, sm_telno_work, sm_telno_home, sm_handphone_no, sm_fax_no, sm_job_code, sm_email_addr, sm_executive,sm_current_address, sm_gender FROM CMSADMIN.staff_main WHERE sm_staff_id = '" + s + "'";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                s = rset.getString(1);
                staffName = rset.getString(2);
                staffStatus = rset.getString(3);
                deptCode = rset.getString(4);
                telnoWork = rset.getString(5);
                telnoHome = rset.getString(6);
                handphoneNo = rset.getString(7);
                faxNo = rset.getString(8);
                jobCode = rset.getString(9);
                emailAddr = rset.getString(10);
                executive = rset.getString(11);
                address = rset.getString(12);
                staffGender = rset.getString(13);
                rset.close();
                stmt.close();
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

    public boolean queryDeptStaffs(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT sm_staff_id, sm_staff_name, sm_staff_status, sm_dept_code, sm_telno_work, sm_telno_home, sm_handphone_no, sm_fax_no, sm_job_code, sm_email_addr, sm_executive  FROM CMSADMIN.staff_main WHERE sm_dept_code = '" + s + "' AND sm_staff_status = 'ACTIVE' " + " and sm_job_status in ('SEMENTARA', 'SAMBILAN', 'TPERCUBAAN', 'TETAP', 'TPENCEN', 'PINJAMAN', 'KONTRAK')";
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

    public boolean querySubstituteStaffs(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT sm_staff_id, sm_staff_name FROM CMSADMIN.staff_main WHERE sm_dept_code = '" + s + "' AND sm_staff_status = 'ACTIVE' " + " and sm_job_status in ('SEMENTARA', 'SAMBILAN', 'TPERCUBAAN', 'TETAP', 'TPENCEN', 'PINJAMAN', 'KONTRAK') order by sm_staff_name ";
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

    public boolean nextDeptStaff()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    staffId = rset.getString(1);
                    staffName = rset.getString(2);
                    staffStatus = rset.getString(3);
                    deptCode = rset.getString(4);
                    telnoWork = rset.getString(5);
                    telnoHome = rset.getString(6);
                    handphoneNo = rset.getString(7);
                    faxNo = rset.getString(8);
                    jobCode = rset.getString(9);
                    emailAddr = rset.getString(10);
                    executive = rset.getString(11);
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

    public boolean nextSubstituteStaff()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    staffId = rset.getString(1);
                    staffName = rset.getString(2);
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

    public boolean queryStaff(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT sm_staff_id, sm_staff_name, sm_staff_status, sm_dept_code, sm_telno_work, sm_telno_home, sm_handphone_no, " +
        		"sm_fax_no, sm_job_code, sm_email_addr, sm_executive FROM CMSADMIN.staff_main " +
        		"WHERE sm_dept_code = '" + s + "' AND sm_staff_status = 'ACTIVE'" + "AND sm_staff_id NOT IN (" + s1 + ") " +
        		"ORDER BY sm_staff_name";
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

    public boolean nextStaff()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    staffId = rset.getString(1);
                    staffName = rset.getString(2);
                    staffStatus = rset.getString(3);
                    deptCode = rset.getString(4);
                    telnoWork = rset.getString(5);
                    telnoHome = rset.getString(6);
                    handphoneNo = rset.getString(7);
                    faxNo = rset.getString(8);
                    jobCode = rset.getString(9);
                    emailAddr = rset.getString(10);
                    executive = rset.getString(11);
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

    public boolean queryStaffDetailProfile(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT SM.SM_STAFF_ID, SM.SM_STAFF_NAME, SM.SM_STAFF_STATUS, DECODE(SM.SM_GENDER, 'M', 'MALE', 'L', 'LELAKI', 'F', 'FEMALE', 'P', 'PEREMPUAN', '-'), SM.SM_IC_NO, TO_CHAR(SM.SM_BIRTH_DATE, 'DD/MM/YYYY'), SM.SM_BIRTH_PLACE, STATE.SM_STATE_DESC, SM.SM_MARITAL_STATUS, SM.SM_CHILD_NO, RM.RM_RACE_DESC, RELIGION.RM_RELIGION_DESC, CM.CM_COUNTRY_DESC, SM.SM_CURRENT_ADDRESS, STATE2.SM_STATE_DESC, SM.SM_CURRENT_PCODE, SM.SM_PERMANENT_ADDRESS, STATE3.SM_STATE_DESC, CM2.CM_COUNTRY_DESC, SM.SM_PERMANENT_PCODE, SM.SM_TELNO_WORK, SM.SM_TELNO_HOME, SM.SM_HANDPHONE_NO, SM.SM_FAX_NO, SM.SM_EMAIL_ADDR, SM.SM_BUMIPUTERA, NVL(SM.SM_DRV_LICENCE_NO, '-'), SM.SM_WARD_CLASS, NVL(SM.SM_PASPORT_NO, '-') FROM CMSADMIN.STAFF_MAIN SM, CMSADMIN.STATE_MAIN STATE, CMSADMIN.RACE_MAIN RM, CMSADMIN.RELIGION_MAIN RELIGION, CMSADMIN.COUNTRY_MAIN CM, CMSADMIN.STATE_MAIN STATE2, CMSADMIN.STATE_MAIN STATE3, CMSADMIN.COUNTRY_MAIN CM2 WHERE SM.SM_BIRTH_STATE = STATE.SM_STATE_CODE AND SM.SM_RACE = RM.RM_RACE_CODE AND SM.SM_RELIGION = RELIGION.RM_RELIGION_CODE AND SM.SM_CITIZEN = CM.CM_COUNTRY_CODE AND SM.SM_CURRENT_STATE = STATE2.SM_STATE_CODE AND SM.SM_PERMANENT_STATE = STATE3.SM_STATE_CODE AND SM.SM_PERMANENT_COUNTRY = CM2.CM_COUNTRY_CODE AND SM_STAFF_ID = '" + s + "'";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                s = rset.getString(1);
                staffName = rset.getString(2);
                staffStatus = rset.getString(3);
                staffGender = rset.getString(4);
                icno = rset.getString(5);
                birthdate = rset.getString(6);
                birthplace = rset.getString(7);
                birthstate = rset.getString(8);
                marital = rset.getString(9);
                childno = rset.getString(10);
                race = rset.getString(11);
                religion = rset.getString(12);
                citizen = rset.getString(13);
                address = rset.getString(14);
                currentstate = rset.getString(15);
                currentpcode = rset.getString(16);
                permanentaddress = rset.getString(17);
                permanentstate = rset.getString(18);
                permanentcountry = rset.getString(19);
                permanentpcode = rset.getString(20);
                telnoWork = rset.getString(21);
                telnoHome = rset.getString(22);
                handphoneNo = rset.getString(23);
                faxNo = rset.getString(24);
                emailAddr = rset.getString(25);
                bumi = rset.getString(26);
                drivingLisence = rset.getString(27);
                wardClass = rset.getString(28);
                passport = rset.getString(29);
                rset.close();
                stmt.close();
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

    public boolean queryStaffDetailProfile2(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT SM.SM_STAFF_ID, SM.SM_JOB_CODE, SS.SS_SERVICE_DESC, SM.SM_DEPT_CODE, DM.DM_DEPT_DESC, TO_CHAR(SM.SM_JOIN_DATE, 'DD-MON-YYYY'), NVL(TO_CHAR(SM.SM_CONFIRM_DATE, 'DD-MON-YYYY'), '-'), NVL(TO_CHAR(SM.SM_PENSION_DATE, 'DD-MON-YYYY'), '-'), NVL(SM.SM_PENSION_NO, '-'), DECODE(SM.SM_JOB_STATUS, 'SAMBILAN', 'SAMBILAN', 'KONTRAK', 'KONTRAK', 'SEMENTARA', 'SEMENTARA', 'PINJAMAN', 'PINJAMAN', 'TETAP', 'TETAP', 'TPERCUBAAN', 'TETAP PERCUBAAN', 'TETAP', 'TETAP', 'TPENCEN', 'TETAP BERPENCEN'), DECODE(SM.SM_STAFF_CATEGORY, 'A', 'ACADEMIC', 'Y', 'NON ACADEMIC')FROM CMSADMIN.STAFF_MAIN SM, CMSADMIN.SERVICE_SCHEME SS, CMSADMIN.DEPARTMENT_MAIN DM WHERE SM.SM_JOB_CODE = SS.SS_SERVICE_CODE AND SM.SM_DEPT_CODE = DM.DM_DEPT_CODE AND SM.SM_STAFF_ID = '" + s + "' ";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                s = rset.getString(1);
                jobCode = rset.getString(2);
                staffPosition = rset.getString(3);
                deptCode = rset.getString(4);
                deptDesc = rset.getString(5);
                joinDate = rset.getString(6);
                confirmDate = rset.getString(7);
                pensionDate = rset.getString(8);
                pensionNo = rset.getString(9);
                jobStatus = rset.getString(10);
                staffCategory = rset.getString(11);
                rset.close();
                stmt.close();
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

    public boolean queryStaffDetailFinancial(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT SM.SM_STAFF_ID, NVL(SM.SM_INCOMETAX_NO, '-'), NVL(SM.SM_INCOMETAX_BRANCH, '-'), NVL(SM.SM_EPF_NO, '-'), NVL(SM.SM_SOCSO_NO, '-'), NVL(SM.SM_LUTH_NO, '-'), NVL(SM.SM_ASB_NO, '-'), NVL(SM.SM_BANK_ACC_NO, '-'), NVL(BM.BM_BANK_DESC, '-'), NVL(SM.SM_ANGKASA_NO, '-'), NVL(SM.SM_HOME_LOAN_NO, '-') FROM CMSADMIN.STAFF_MAIN SM, CMSADMIN.BANK_MAIN BM WHERE SM.SM_BANK_CODE = BM.BM_BANK_CODE AND SM.SM_STAFF_ID = '" + s + "' ";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                s = rset.getString(1);
                incomeTaxNo = rset.getString(2);
                incomeTaxBranch = rset.getString(3);
                epfNo = rset.getString(4);
                socsoNo = rset.getString(5);
                luthNo = rset.getString(6);
                asbNo = rset.getString(7);
                bankNo = rset.getString(8);
                bankName = rset.getString(9);
                angkasaNo = rset.getString(10);
                homeLoan = rset.getString(11);
                rset.close();
                stmt.close();
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
}