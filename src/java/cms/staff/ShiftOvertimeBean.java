package cms.staff;

import java.sql.*;

public class ShiftOvertimeBean
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected String staff_id;
    protected double total_hours_daily;
    protected double total_rm_daily;
    protected String claim_month;
    protected int work_order_id;
    int max_monthly_hours;
    int max_daily_hours;
    int formula_param_1;
    int formula_param_2;
    int formula_param_3;
    String claim_due_date;
    int backdate_claim_due;
    protected Statement stmt;
    protected ResultSet rset;

    public ShiftOvertimeBean()
    {
        conn = null;
        sql = null;
        errmsg = null;
        staff_id = null;
        total_hours_daily = 0.0D;
        total_rm_daily = 0.0D;
        claim_month = null;
        work_order_id = -1;
        max_monthly_hours = -1;
        max_daily_hours = -1;
        formula_param_1 = -1;
        formula_param_2 = -1;
        formula_param_3 = -1;
        claim_due_date = null;
        backdate_claim_due = 0;
        stmt = null;
        rset = null;
    }

    public void setDBConnection(Connection connection)
    {
        conn = connection;
        getOvertimeParameters();
    }

    public void setStaffId(String s)
    {
        staff_id = s;
    }

    public void setClaimMonth(String s)
    {
        claim_month = s;
    }

    public void setWorkOrderId(int i)
    {
        work_order_id = i;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public int getMaxDailyHours()
    {
        return max_daily_hours;
    }

    public int getMaxMonthlyHours()
    {
        return max_monthly_hours;
    }

    public String getClaimDueDate()
    {
        return claim_due_date;
    }

    public double getTotalHoursDaily()
    {
        return total_hours_daily;
    }

    public double getTotalRMDaily()
    {
        return total_rm_daily;
    }

    public void getOvertimeParameters()
    {
        sql = "SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, "OT_MAX_MONTHLY_HOURS");
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                max_monthly_hours = Integer.parseInt(resultset.getString(1));
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        try
        {
            PreparedStatement preparedstatement1 = conn.prepareStatement(sql);
            preparedstatement1.setString(1, "OT_MAX_DAILY_HOURS");
            ResultSet resultset1 = preparedstatement1.executeQuery();
            if(resultset1.next())
                max_daily_hours = Integer.parseInt(resultset1.getString(1));
            preparedstatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errmsg = "Error : " + sqlexception1.toString();
        }
        try
        {
            PreparedStatement preparedstatement2 = conn.prepareStatement(sql);
            preparedstatement2.setString(1, "OT_CLAIM_DUE_DATE");
            ResultSet resultset2 = preparedstatement2.executeQuery();
            if(resultset2.next())
                claim_due_date = resultset2.getString(1);
            preparedstatement2.close();
        }
        catch(SQLException sqlexception2)
        {
            errmsg = "Error : " + sqlexception2.toString();
        }
        try
        {
            PreparedStatement preparedstatement3 = conn.prepareStatement(sql);
            preparedstatement3.setString(1, "OT_CLAIM_MONTH");
            ResultSet resultset3 = preparedstatement3.executeQuery();
            if(resultset3.next())
                claim_month = resultset3.getString(1);
            preparedstatement3.close();
        }
        catch(SQLException sqlexception3)
        {
            errmsg = "Error : " + sqlexception3.toString();
        }
        try
        {
            PreparedStatement preparedstatement4 = conn.prepareStatement(sql);
            preparedstatement4.setString(1, "OT_BACKDATED_CLAIM_DUE");
            ResultSet resultset4 = preparedstatement4.executeQuery();
            if(resultset4.next())
                backdate_claim_due = Integer.parseInt(resultset4.getString(1));
            preparedstatement4.close();
        }
        catch(SQLException sqlexception4)
        {
            errmsg = "Error : " + sqlexception4.toString();
        }
        sql = "SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = ? AND HP_PARM_NO = ?";
        try
        {
            PreparedStatement preparedstatement5 = conn.prepareStatement(sql);
            preparedstatement5.setString(1, "OT_CALCULATE_FORMULA");
            preparedstatement5.setInt(2, 1);
            ResultSet resultset5 = preparedstatement5.executeQuery();
            if(resultset5.next())
                formula_param_1 = Integer.parseInt(resultset5.getString(1));
            preparedstatement5.close();
        }
        catch(SQLException sqlexception5)
        {
            errmsg = "Error : " + sqlexception5.toString();
        }
        try
        {
            PreparedStatement preparedstatement6 = conn.prepareStatement(sql);
            preparedstatement6.setString(1, "OT_CALCULATE_FORMULA");
            preparedstatement6.setInt(2, 2);
            ResultSet resultset6 = preparedstatement6.executeQuery();
            if(resultset6.next())
                formula_param_2 = Integer.parseInt(resultset6.getString(1));
            preparedstatement6.close();
        }
        catch(SQLException sqlexception6)
        {
            errmsg = "Error : " + sqlexception6.toString();
        }
        try
        {
            PreparedStatement preparedstatement7 = conn.prepareStatement(sql);
            preparedstatement7.setString(1, "OT_CALCULATE_FORMULA");
            preparedstatement7.setInt(2, 3);
            ResultSet resultset7 = preparedstatement7.executeQuery();
            if(resultset7.next())
                formula_param_3 = Integer.parseInt(resultset7.getString(1));
            preparedstatement7.close();
        }
        catch(SQLException sqlexception7)
        {
            errmsg = "Error : " + sqlexception7.toString();
        }
    }

    public boolean isAdmin(String s)
    {
        boolean flag = false;
        sql = "SELECT 1 FROM SECURITY_ASSIGNER_SETUP WHERE SAS_STAFF_ID = '" + s + "' AND SAS_TYPE = 'OT_APPROVER'";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
                flag = rset.getInt(1) != 0;
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
        }
        finally
        {
            try
            {
                if(rset != null)
                    rset.close();
                if(stmt != null)
                    stmt.close();
            }
            catch(Exception exception1)
            {
                exception1.printStackTrace();
            }
        }
        return flag;
    }

    public boolean CheckWorkOrderId(int i)
    {
        sql = "SELECT 1 FROM SECURITY_WORK_ORDER_DETL WHERE swod_workorder_id = ? AND SWOD_STAFF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setInt(1, i);
            ResultSet resultset = preparedstatement.executeQuery();
            if(!resultset.next())
            {
                errmsg = "Invalid Work Order Ref ID";
                preparedstatement.close();
                return false;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            return false;
        }
        return true;
    }

    public boolean isAlreadyExists()
    {
        sql = "SELECT 1 FROM staff_overtime_head WHERE SOH_STAFF_ID = ? AND SOH_CLAIM_MONTH = TO_DATE(?,'MM/YYYY')";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            preparedstatement.setString(2, claim_month);
            ResultSet resultset = preparedstatement.executeQuery();
            if(!resultset.next())
            {
                errmsg = "Overtime claim exists";
                preparedstatement.close();
                return false;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            return false;
        }
        return true;
    }

    public boolean hasTravel(String s, String s1)
    {
        sql = "select tt_date_from,tt_date_to from staff_travel_request,travel_trip where str_staff_id = ?and str_trip_id = tt_trip_id and to_date(?,'DD/MM/YYYY') between to_date(to_char(tt_date_from,'DD/MM/YYYY'),'DD/MM/YYYY') and to_date(to_char(tt_date_to,'DD/MM/YYYY'),'DD/MM/YYYY') and tt_status = 'APPROVE'";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                errmsg = "Staff has travelling at the same time with overtime claim date";
                preparedstatement.close();
                return true;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            return false;
        }
        return false;
    }

    public boolean isDateValid(String s)
    {
        boolean flag = false;
        if(s == null)
            return true;
        if(s.compareTo("") == 0)
            return true;
        sql = "SELECT TO_DATE(?,'DD/MM/YYYY') FROM DUAL";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                flag = true;
            } else
            {
                flag = false;
                errmsg = "Invalid date";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            flag = false;
            errmsg = "Invalid date";
        }
        return flag;
    }

    public boolean isTimeValid(String s)
    {
        boolean flag = false;
        if(s == null)
            return true;
        if(s.compareTo("") == 0)
            return true;
        sql = "SELECT TO_DATE(?,'HH24:MI') FROM DUAL";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                flag = true;
            } else
            {
                flag = false;
                errmsg = "Invalid time";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            flag = false;
            errmsg = "Invalid time";
        }
        return flag;
    }

    public boolean date_isLess(String s, String s1)
    {
        boolean flag = false;
        sql = "SELECT TO_DATE(?,'DD/MM/YYYY') - TO_DATE(?,'DD/MM/YYYY') FROM DUAL";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s1);
            preparedstatement.setString(2, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                if(resultset.getDouble(1) >= 0.0D)
                    flag = true;
                else
                    flag = false;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public boolean time_isLess(String s, String s1)
    {
        boolean flag = false;
        sql = "SELECT TO_DATE(?,'HH24:MI') - TO_DATE(?,'HH24:MI') FROM DUAL";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s1);
            preparedstatement.setString(2, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                if(resultset.getDouble(1) >= 0.0D)
                    flag = true;
                else
                    flag = false;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public double getHourDifference(String s, String s1)
    {
        double d = 0.0D;
        sql = "SELECT TO_DATE(?,'HH24:MI') - TO_DATE(?,'HH24:MI') FROM DUAL";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s1);
            preparedstatement.setString(2, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                d = resultset.getDouble(1) * 24D;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return d;
    }

    public boolean isTimeBetween(String s, String s1, String s2)
    {
        boolean flag = false;
        sql = "SELECT 1 FROM DUAL WHERE TO_DATE(?,'HH24:MI') BETWEEN TO_DATE(?,'HH24:MI') AND TO_DATE(?,'HH24:MI') AND TO_DATE(?,'HH24:MI') <> TO_DATE(?,'HH24:MI') AND TO_DATE(?,'HH24:MI') <> TO_DATE(?,'HH24:MI')";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            preparedstatement.setString(4, s);
            preparedstatement.setString(5, s1);
            preparedstatement.setString(6, s);
            preparedstatement.setString(7, s2);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return flag;
    }

    public double getStaffSalary(String s)
    {
        double d = 0.0D;
        sql = "SELECT MPDH_PAID_AMT FROM MONTHLY_PAYROLL_DETL_HIS WHERE SUBSTR(MPDH_PAY_MONTH,5,2) = (SELECT SUBSTR(HP_PARM_DESC,1,2) FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'OT_CLAIM_MONTH') AND SUBSTR(MPDH_PAY_MONTH,1,4) = (SELECT SUBSTR(HP_PARM_DESC,4,4) FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'OT_CLAIM_MONTH') AND MPDH_STAFF_ID = ? AND MPDH_INCOME_CODE = 'A001'";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                d = resultset.getDouble(1);
            else
                d = -1D;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            d = -1D;
        }
        if(d > 0.0D)
            return d;
        sql = "select ss_basic_salary from staff_salary where ss_staff_id = ?";
        try
        {
            PreparedStatement preparedstatement1 = conn.prepareStatement(sql);
            preparedstatement1.setString(1, s);
            ResultSet resultset1 = preparedstatement1.executeQuery();
            if(resultset1.next())
                d = resultset1.getDouble(1);
            else
                d = -1D;
            preparedstatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errmsg = "Error : " + sqlexception1.toString();
            d = -1D;
        }
        return d;
    }

    public double getRate(String s, String s1)
    {
        double d = 0.0D;
        sql = "select orm_rate from overtime_rate_main where ORM_CALENDAR_TYPE = ? and ORM_INTERVAL_TYPE = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                d = resultset.getDouble(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            return 0.0D;
        }
        return d;
    }

    public String RoundTime(String s)
    {
        int i = 0;
        int j = 0;
        if(s == null || s != null && s.compareTo("") == 0)
            return "";
        sql = "select to_char(to_date(?,'HH24:MI'),'HH24'),to_char(to_date(?,'HH24:MI'),'MI') from dual";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                i = resultset.getInt(1);
                j = resultset.getInt(2);
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        if(i == 23 && j >= 45)
            j = 59;
        else
        if(j >= 0 && j <= 14)
            j = 0;
        else
        if(j >= 15 && j <= 44)
            j = 30;
        else
            j = 59;
        return (Integer.toString(i).length() == 1 ? "0" + Integer.toString(i) : Integer.toString(i)) + ":" + (Integer.toString(j).length() == 1 ? "0" + Integer.toString(j) : Integer.toString(j));
    }

    public double getDayDifference(String s)
    {
        double d = 0.0D;
        sql = "SELECT TO_DATE(TO_CHAR(SYSDATE,'DD/MM/YYYY')||':00:01','DD/MM/YYYY:HH24:MI') - TO_DATE(?,'DD/MM/YYYY:HH24:MI') FROM DUAL";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s + ":00:01");
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                d = resultset.getDouble(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return d;
    }

    public String getDayType(String s)
    {
        String s1 = null;
        sql = "SELECT CM_TYPE FROM CALENDAR_MAIN WHERE TO_CHAR(CM_DATE, 'DD/MM/YYYY') = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            return null;
        }
        return s1;
    }

    public String getInterval(String s)
    {
        String s1 = null;
        sql = "select OIM_INTERVAL_TYPE from overtime_interval_main where to_date(?,'HH24:MI') between OIM_TIME_FROM and OIM_TIME_TO";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            resultset.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            return null;
        }
        return s1;
    }

    public String getIntervalDetail(String s, String s1, String s2)
    {
        String s3 = null;
        String s4 = "{ ?= call security.getIntervalDetail (?, ?, ?) }";
        try
        {
            CallableStatement callablestatement = conn.prepareCall(s4);
            callablestatement.registerOutParameter(1, 12);
            callablestatement.setString(2, s);
            callablestatement.registerOutParameter(3, 12);
            callablestatement.registerOutParameter(4, 12);
            callablestatement.execute();
            s3 = callablestatement.getString(1);
            s1 = callablestatement.getString(3);
            s2 = callablestatement.getString(4);
            callablestatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return s3;
    }

    public double getTotalHours(String s, String s1)
    {
        double d = 0.0D;
        sql = "SELECT NVL(SUM(NVL(SOD_TOTAL_DAILY_HOURS,0)),0) FROM STAFF_OVERTIME_DETL WHERE SOD_STAFF_ID = ? AND TO_CHAR(SOD_CLAIM_MONTH,'MM/YYYY') = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                d = resultset.getDouble(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return d;
    }

    public double getTotalRM(String s, String s1)
    {
        double d = 0.0D;
        sql = "SELECT NVL(SUM(NVL(SOD_TOTAL_DAILY_RM,0)),0) FROM STAFF_OVERTIME_DETL WHERE SOD_STAFF_ID = ? AND TO_CHAR(SOD_CLAIM_MONTH,'MM/YYYY') = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                d = resultset.getDouble(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return d;
    }

    public double DeductHours(String s, String s1)
    {
        double d = 0.0D;
        String s2 = "{ ?= call security.DeductHours( ?, ?) }";
        try
        {
            CallableStatement callablestatement = conn.prepareCall(s2);
            callablestatement.registerOutParameter(1, 2);
            callablestatement.setString(2, s);
            callablestatement.setString(3, s1);
            callablestatement.execute();
            d = callablestatement.getDouble(1);
            callablestatement.close();
        }
        catch(SQLException sqlexception)
        {
            d = 0.0D;
        }
        return d;
    }

    public double calculateRate(String s, String s1, String s2)
    {
        double d = 0.0D;
        double d1 = 0.0D;
        double d2 = 0.0D;
        double d3 = 0.0D;
        double d4 = 0.0D;
        double d5 = 0.0D;
        double d6 = 0.0D;
        double d7 = 0.0D;
        Object obj = null;
        Object obj1 = null;
        Object obj2 = null;
        Object obj3 = null;
        Object obj4 = null;
        Object obj5 = null;
        Object obj6 = null;
        String s3 = "{ ?= call security.calculateRate (?, ?, ?, ?) }";
        try
        {
            CallableStatement callablestatement = conn.prepareCall(s3);
            callablestatement.registerOutParameter(1, 2);
            callablestatement.setString(2, staff_id);
            callablestatement.setString(3, s);
            callablestatement.setString(4, s1);
            callablestatement.setString(5, s2);
            callablestatement.execute();
            d = callablestatement.getDouble(1);
            callablestatement.close();
        }
        catch(SQLException sqlexception)
        {
            d = 0.0D;
        }
        return d;
    }

    public boolean AddApplicationMain()
    {
        boolean flag = false;
        if(staff_id == null || claim_month == null)
        {
            errmsg = "Staff ID or Claim month is not given.";
            return false;
        }
        sql = "INSERT INTO staff_overtime_head (SOH_STAFF_ID, SOH_CLAIM_MONTH, SOH_STATUS) VALUES (?, TO_DATE(?, 'MM/YYYY'), 'ENTRY')";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            preparedstatement.setString(2, claim_month);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to create new claim.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error during insert: " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean UpdateApplicationMain(double d, double d1, String s)
    {
        boolean flag = false;
        sql = "UPDATE staff_overtime_head SET SOH_TOTAL_HOURS = ?, ";
        if(s.compareTo("Y") == 0)
            sql = sql + "SOH_RECOMMEND_RM = ?, SOH_APPROVE_RM = ? ";
        else
            sql = sql + "SOH_TOTAL_RM = ?, SOH_RECOMMEND_RM = ? ";
        sql = sql + "WHERE SOH_STAFF_ID = ? AND TO_CHAR(SOH_CLAIM_MONTH,'MM/YYYY') = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setDouble(1, d);
            preparedstatement.setDouble(2, d1);
            preparedstatement.setDouble(3, d1);
            preparedstatement.setString(4, staff_id);
            preparedstatement.setString(5, claim_month);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to update claim.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error during insert: " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean ProcessApplicationDetail(String s, String s1, String s2, String s3, String s4, String s5, String s6, 
            String s7, String s8)
    {
        double d = 0.0D;
        double d1 = 0.0D;
        double d2 = 0.0D;
        double d3 = 0.0D;
        double d4 = 0.0D;
        double d5 = 0.0D;
        String s9 = null;
        String s10 = null;
        Object obj = null;
        String s11 = null;
        String s12 = null;
        Object obj1 = null;
        if(s == null || s != null && s.compareTo("") == 0)
        {
            errmsg = "Date must not be empty";
            return false;
        }
        if(!isDateValid(s))
        {
            errmsg = "Invalid date";
            return false;
        }
        getOvertimeParameters();
        if(getDayDifference(s) > (double)backdate_claim_due)
        {
            errmsg = "Claim is older than " + backdate_claim_due + " days";
            return false;
        }
        if(s1 == null || s2 == null || s1 != null && s1.compareTo("") == 0 || s2 != null && s2.compareTo("") == 0)
        {
            errmsg = "First entry must not be empty";
            return false;
        }
        if(s3 == null && s4 != null || s3 != null && s4 == null)
        {
            errmsg = "Incomplete time entry";
            return false;
        }
        if(s5 == null && s6 != null || s5 != null && s6 == null)
        {
            errmsg = "Incomplete time entry";
            return false;
        }
        if(!isTimeValid(s1) || !isTimeValid(s3) || !isTimeValid(s5))
        {
            errmsg = "Invalid start time";
            return false;
        }
        if(!isTimeValid(s2) || !isTimeValid(s4) || !isTimeValid(s6))
        {
            errmsg = "Invalid end time";
            return false;
        }
        if(!date_isLess(s, claim_due_date))
        {
            errmsg = "Cannot have claim date after monthly due date";
            return false;
        }
        if(!time_isLess(s1, s2))
        {
            errmsg = "Start time must be before end time";
            return false;
        }
        if(s3 != null && s3.compareTo("") != 0 && !time_isLess(s3, s4))
        {
            errmsg = "Start time must be before end time";
            return false;
        }
        if(s5 != null && s5.compareTo("") != 0 && !time_isLess(s5, s6))
        {
            errmsg = "Start time must be before end time";
            return false;
        }
        if(s1 != null && s1.compareTo("") != 0)
        {
            if(s3 != null && s3.compareTo("") != 0)
            {
                if(isTimeBetween(s1, s3, s4))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s2, s3, s4))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
            if(s5 != null && s5.compareTo("") != 0)
            {
                if(isTimeBetween(s1, s5, s6))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s2, s5, s6))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
        }
        if(s3 != null && s3.compareTo("") != 0)
        {
            if(s1 != null && s1.compareTo("") != 0)
            {
                if(isTimeBetween(s3, s1, s2))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s4, s1, s2))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
            if(s5 != null && s5.compareTo("") != 0)
            {
                if(isTimeBetween(s3, s5, s6))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s4, s5, s6))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
        }
        if(s5 != null && s5.compareTo("") != 0)
        {
            if(s1 != null && s1.compareTo("") != 0)
            {
                if(isTimeBetween(s5, s1, s2))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s6, s1, s2))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
            if(s5 != null && s5.compareTo("") != 0)
            {
                if(isTimeBetween(s5, s3, s4))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s6, s3, s4))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
        }
        String s13 = "{ ?= call security.getIntervalDetail (?, ?, ?) }";
        try
        {
            CallableStatement callablestatement = conn.prepareCall(s13);
            callablestatement.registerOutParameter(1, 12);
            callablestatement.setString(2, s1);
            callablestatement.registerOutParameter(3, 12);
            callablestatement.registerOutParameter(4, 12);
            callablestatement.execute();
            s9 = callablestatement.getString(1);
            String s14 = callablestatement.getString(3);
            s11 = callablestatement.getString(4);
            callablestatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        s13 = "{ ?= call security.getIntervalDetail (?, ?, ?) }";
        try
        {
            CallableStatement callablestatement1 = conn.prepareCall(s13);
            callablestatement1.registerOutParameter(1, 12);
            callablestatement1.setString(2, s2);
            callablestatement1.registerOutParameter(3, 12);
            callablestatement1.registerOutParameter(4, 12);
            callablestatement1.execute();
            s10 = callablestatement1.getString(1);
            s12 = callablestatement1.getString(3);
            String s15 = callablestatement1.getString(4);
            callablestatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errmsg = "Error : " + sqlexception1.toString();
        }
        if(s9.compareTo(s10) != 0)
        {
            if(s3 == null || s3.compareTo("") == 0)
                return ProcessApplicationDetail(s, s1, s11, s12, s2, s5, s6, s7, s8);
            if(s5 == null || s5.compareTo("") == 0)
                return ProcessApplicationDetail(s, s1, s11, s12, s2, s3, s4, s7, s8);
        }
        s13 = "{ ?= call security.getIntervalDetail (?, ?, ?) }";
        try
        {
            CallableStatement callablestatement2 = conn.prepareCall(s13);
            callablestatement2.registerOutParameter(1, 12);
            callablestatement2.setString(2, s3);
            callablestatement2.registerOutParameter(3, 12);
            callablestatement2.registerOutParameter(4, 12);
            callablestatement2.execute();
            s9 = callablestatement2.getString(1);
            String s16 = callablestatement2.getString(3);
            s11 = callablestatement2.getString(4);
            callablestatement2.close();
        }
        catch(SQLException sqlexception2)
        {
            errmsg = "Error : " + sqlexception2.toString();
        }
        s13 = "{ ?= call security.getIntervalDetail (?, ?, ?) }";
        try
        {
            CallableStatement callablestatement3 = conn.prepareCall(s13);
            callablestatement3.registerOutParameter(1, 12);
            callablestatement3.setString(2, s4);
            callablestatement3.registerOutParameter(3, 12);
            callablestatement3.registerOutParameter(4, 12);
            callablestatement3.execute();
            s10 = callablestatement3.getString(1);
            s12 = callablestatement3.getString(3);
            String s17 = callablestatement3.getString(4);
            callablestatement3.close();
        }
        catch(SQLException sqlexception3)
        {
            errmsg = "Error : " + sqlexception3.toString();
        }
        if(s9.compareTo(s10) != 0 && (s5 == null || s5.compareTo("") == 0))
            return ProcessApplicationDetail(s, s1, s2, s3, s11, s12, s4, s7, s8);
        total_hours_daily = 0.0D;
        if(s1 != null && s1.compareTo("") != 0)
        {
//            s1 = s1;
//            s2 = s2;
            d = DeductHours(s1, s2);
            // added by osman to deduct 1 hour for each continuous 9 hour
            if (d >= 9) {
            	d = d - 1;
            }
            total_hours_daily += d;
        }
        if(s3 != null && s3.compareTo("") != 0)
        {
//            s3 = s3;
//            s4 = s4;
            d1 = DeductHours(s3, s4);
            // added by osman to deduct 1 hour for each continuous 9 hour
            if (d1 >= 9) {
            	d1 = d1 - 1;
            }
            total_hours_daily += d1;
        }
        if(s5 != null && s5.compareTo("") != 0)
        {
//            s5 = s5;
//            s6 = s6;
            d2 = DeductHours(s5, s6);
            // added by osman to deduct 1 hour for each continuous 9 hour
            if (d2 >= 9) {
            	d2 = d2 - 1;
            }
            total_hours_daily += d2;
        }
        
        if(total_hours_daily > (double)max_daily_hours)
        {
            errmsg = "Total claim hours per day must not exceed " + max_daily_hours + " hours";
            return false;
        }

        // added by Osman to prevent overtime application less than one hour / day.
        if (total_hours_daily < 1.0D) {
            errmsg = "Total claim hours per day must be more than one hour";
            return false;
        }
        
        total_rm_daily = 0.0D;
        double d6 = 0.0D;
        d3 = calculateRate(s, s1, s2);
        total_rm_daily += d3;
        if(s3 != null && s3.compareTo("") != 0)
        {
            d4 = calculateRate(s, s3, s4);
            total_rm_daily += d4;
        }
        if(s5 != null && s5.compareTo("") != 0)
        {
            d5 = calculateRate(s, s5, s6);
            total_rm_daily += d5;
        }
        boolean flag = false;
        sql = "INSERT INTO STAFF_OVERTIME_DETL (SOD_STAFF_ID, SOD_CLAIM_MONTH, SOD_WORKORDER_ID, SOD_DATE, SOD_TIME1_START, SOD_TIME1_END, SOD_TIME2_START, SOD_TIME2_END, SOD_TIME3_START, SOD_TIME3_END, SOD_TOTAL_DAILY_HOURS, ";
        if(s8.compareTo("Y") == 0)
            sql = sql + "SOD_TOTAL_DAILY_RECOMMEND_RM, SOD_TOTAL_DAILY_APPROVE_RM, ";
        else
            sql = sql + "SOD_TOTAL_DAILY_RM, SOD_TOTAL_DAILY_RECOMMEND_RM, ";
        sql = sql + " SOD_REMARK, SOD_TIME1_HOURS, SOD_TIME1_RM, " + "SOD_TIME2_HOURS, SOD_TIME2_RM, " + "SOD_TIME3_HOURS, SOD_TIME3_RM) " + "VALUES (?, TO_DATE(?,'MM/YYYY'), ?, TO_DATE(?,'DD/MM/YYYY'), " + "TO_DATE (?,'HH24:MI'), TO_DATE (?,'HH24:MI'), TO_DATE (?,'HH24:MI'), " + "TO_DATE (?,'HH24:MI'), TO_DATE (?,'HH24:MI'), TO_DATE (?,'HH24:MI'), ?, ?, ?, ?, " + "?, ?, ?, ?, ?, ?)";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, staff_id);
            preparedstatement.setString(2, claim_month);
            preparedstatement.setInt(3, work_order_id);
            preparedstatement.setString(4, s);
            preparedstatement.setString(5, s1);
            preparedstatement.setString(6, s2);
            preparedstatement.setString(7, s3);
            preparedstatement.setString(8, s4);
            preparedstatement.setString(9, s5);
            preparedstatement.setString(10, s6);
            preparedstatement.setDouble(11, total_hours_daily);
            preparedstatement.setDouble(12, total_rm_daily);
            preparedstatement.setDouble(13, total_rm_daily);
            preparedstatement.setString(14, s7);
            preparedstatement.setDouble(15, d);
            preparedstatement.setDouble(16, d3);
            preparedstatement.setDouble(17, d1);
            preparedstatement.setDouble(18, d4);
            preparedstatement.setDouble(19, d2);
            preparedstatement.setDouble(20, d5);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to create new record.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception4)
        {
            errmsg = "Error : " + sqlexception4.toString();
            flag = false;
        }
        if(flag)
            UpdateTotalClaim(staff_id, claim_month);
        return flag;
    }

    public boolean UpdateApplicationDetail(String s, String s1, String s2, String s3, String s4, String s5, String s6, 
            String s7, String s8)
    {
        double d = 0.0D;
        double d1 = 0.0D;
        double d2 = 0.0D;
        double d3 = 0.0D;
        double d4 = 0.0D;
        double d5 = 0.0D;
        String s9 = null;
        String s10 = null;
        Object obj = null;
        String s11 = null;
        String s12 = null;
        Object obj1 = null;
        if(s == null || s != null && s.compareTo("") == 0)
        {
            errmsg = "Date must not be empty";
            return false;
        }
        if(!isDateValid(s))
        {
            errmsg = "Invalid date";
            return false;
        }
        getOvertimeParameters();
        if(getDayDifference(s) > (double)backdate_claim_due)
        {
            errmsg = "Claim is older than " + backdate_claim_due + " days";
            return false;
        }
        if(s1 == null || s2 == null || s1 != null && s1.compareTo("") == 0 || s2 != null && s2.compareTo("") == 0)
        {
            errmsg = "First entry must not be empty";
            return false;
        }
        if(s3 == null && s4 != null || s3 != null && s4 == null)
        {
            errmsg = "Incomplete time entry";
            return false;
        }
        if(s5 == null && s6 != null || s5 != null && s6 == null)
        {
            errmsg = "Incomplete time entry";
            return false;
        }
        if(!isTimeValid(s1) || !isTimeValid(s3) || !isTimeValid(s5))
        {
            errmsg = "Invalid start time";
            return false;
        }
        if(!isTimeValid(s2) || !isTimeValid(s4) || !isTimeValid(s6))
        {
            errmsg = "Invalid end time";
            return false;
        }
        if(!date_isLess(s, claim_due_date))
        {
            errmsg = "Cannot have claim date after monthly due date";
            return false;
        }
        if(!time_isLess(s1, s2))
        {
            errmsg = "Start time must be before end time";
            return false;
        }
        if(s3 != null && s3.compareTo("") != 0 && !time_isLess(s3, s4))
        {
            errmsg = "Start time must be before end time";
            return false;
        }
        if(s5 != null && s5.compareTo("") != 0 && !time_isLess(s5, s6))
        {
            errmsg = "Start time must be before end time";
            return false;
        }
        if(s1 != null && s1.compareTo("") != 0)
        {
            if(s3 != null && s3.compareTo("") != 0)
            {
                if(isTimeBetween(s1, s3, s4))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s2, s3, s4))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
            if(s5 != null && s5.compareTo("") != 0)
            {
                if(isTimeBetween(s1, s5, s6))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s2, s5, s6))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
        }
        if(s3 != null && s3.compareTo("") != 0)
        {
            if(s1 != null && s1.compareTo("") != 0)
            {
                if(isTimeBetween(s3, s1, s2))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s4, s1, s2))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
            if(s5 != null && s5.compareTo("") != 0)
            {
                if(isTimeBetween(s3, s5, s6))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s4, s5, s6))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
        }
        if(s5 != null && s5.compareTo("") != 0)
        {
            if(s1 != null && s1.compareTo("") != 0)
            {
                if(isTimeBetween(s5, s1, s2))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s6, s1, s2))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
            if(s5 != null && s5.compareTo("") != 0)
            {
                if(isTimeBetween(s5, s3, s4))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
                if(isTimeBetween(s6, s3, s4))
                {
                    errmsg = "Overlapping time between entries not allowed.";
                    return false;
                }
            }
        }
        String s13 = "{ ?= call security.getIntervalDetail (?, ?, ?) }";
        try
        {
            CallableStatement callablestatement = conn.prepareCall(s13);
            callablestatement.registerOutParameter(1, 12);
            callablestatement.setString(2, s1);
            callablestatement.registerOutParameter(3, 12);
            callablestatement.registerOutParameter(4, 12);
            callablestatement.execute();
            s9 = callablestatement.getString(1);
            String s14 = callablestatement.getString(3);
            s11 = callablestatement.getString(4);
            callablestatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        s13 = "{ ?= call security.getIntervalDetail (?, ?, ?) }";
        try
        {
            CallableStatement callablestatement1 = conn.prepareCall(s13);
            callablestatement1.registerOutParameter(1, 12);
            callablestatement1.setString(2, s2);
            callablestatement1.registerOutParameter(3, 12);
            callablestatement1.registerOutParameter(4, 12);
            callablestatement1.execute();
            s10 = callablestatement1.getString(1);
            s12 = callablestatement1.getString(3);
            String s15 = callablestatement1.getString(4);
            callablestatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errmsg = "Error : " + sqlexception1.toString();
        }
        if(s9.compareTo(s10) != 0)
        {
            if(s3 == null || s3.compareTo("") == 0)
                return UpdateApplicationDetail(s, s1, s11, s12, s2, s5, s6, s7, s8);
            if(s5 == null || s5.compareTo("") == 0)
                return UpdateApplicationDetail(s, s1, s11, s12, s2, s3, s4, s7, s8);
        }
        s13 = "{ ?= call security.getIntervalDetail (?, ?, ?) }";
        try
        {
            CallableStatement callablestatement2 = conn.prepareCall(s13);
            callablestatement2.registerOutParameter(1, 12);
            callablestatement2.setString(2, s3);
            callablestatement2.registerOutParameter(3, 12);
            callablestatement2.registerOutParameter(4, 12);
            callablestatement2.execute();
            s9 = callablestatement2.getString(1);
            String s16 = callablestatement2.getString(3);
            s11 = callablestatement2.getString(4);
            callablestatement2.close();
        }
        catch(SQLException sqlexception2)
        {
            errmsg = "Error : " + sqlexception2.toString();
        }
        s13 = "{ ?= call security.getIntervalDetail (?, ?, ?) }";
        try
        {
            CallableStatement callablestatement3 = conn.prepareCall(s13);
            callablestatement3.registerOutParameter(1, 12);
            callablestatement3.setString(2, s4);
            callablestatement3.registerOutParameter(3, 12);
            callablestatement3.registerOutParameter(4, 12);
            callablestatement3.execute();
            s10 = callablestatement3.getString(1);
            s12 = callablestatement3.getString(3);
            String s17 = callablestatement3.getString(4);
            callablestatement3.close();
        }
        catch(SQLException sqlexception3)
        {
            errmsg = "Error : " + sqlexception3.toString();
        }
        if(s9.compareTo(s10) != 0 && (s5 == null || s5.compareTo("") == 0))
            return ProcessApplicationDetail(s, s1, s2, s3, s11, s12, s4, s7, s8);
        total_hours_daily = 0.0D;
        if(s1 != null && s1.compareTo("") != 0)
        {
            s1 = s1;
            s2 = s2;
            d = DeductHours(s1, s2);
            total_hours_daily += d;
        }
        if(s3 != null && s3.compareTo("") != 0)
        {
            s3 = s3;
            s4 = s4;
            d1 = DeductHours(s3, s4);
            total_hours_daily += d1;
        }
        if(s5 != null && s5.compareTo("") != 0)
        {
            s5 = s5;
            s6 = s6;
            d2 = DeductHours(s5, s6);
            total_hours_daily += d2;
        }
        if(total_hours_daily > (double)max_daily_hours)
        {
            errmsg = "Total claim hours per day must not exceed " + max_daily_hours + " hours";
            return false;
        }
        total_rm_daily = 0.0D;
        double d6 = 0.0D;
        d3 = calculateRate(s, s1, s2);
        total_rm_daily += d3;
        if(s3 != null && s3.compareTo("") != 0)
        {
            d4 = calculateRate(s, s3, s4);
            total_rm_daily += d4;
        }
        if(s5 != null && s5.compareTo("") != 0)
        {
            d5 = calculateRate(s, s5, s6);
            total_rm_daily += d5;
        }
        boolean flag = false;
        sql = "UPDATE STAFF_OVERTIME_DETL SET SOD_WORKORDER_ID = ?, SOD_TIME1_START = TO_DATE (?,'HH24:MI'), SOD_TIME1_END = TO_DATE (?,'HH24:MI'), SOD_TIME2_START = TO_DATE (?,'HH24:MI'), SOD_TIME2_END = TO_DATE (?,'HH24:MI'), SOD_TIME3_START = TO_DATE (?,'HH24:MI'), SOD_TIME3_END = TO_DATE (?,'HH24:MI'), SOD_TOTAL_DAILY_HOURS = ?, ";
        if(s8.compareTo("Y") == 0)
            sql = sql + "SOD_TOTAL_DAILY_RECOMMEND_RM = ?, SOD_TOTAL_DAILY_APPROVE_RM = ?, ";
        else
            sql = sql + "SOD_TOTAL_DAILY_RM = ?, SOD_TOTAL_DAILY_RECOMMEND_RM = ?, ";
        sql = sql + " SOD_REMARK = ?, " + "SOD_TIME1_HOURS = ?, " + "SOD_TIME1_RM = ?, " + "SOD_TIME2_HOURS = ?, " + "SOD_TIME2_RM = ?, " + "SOD_TIME3_HOURS = ?, " + "SOD_TIME3_RM = ? " + "WHERE SOD_STAFF_ID = ? " + "AND TO_CHAR(SOD_CLAIM_MONTH,'MM/YYYY') = ? " + "AND TO_CHAR(SOD_DATE,'DD/MM/YYYY') = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setInt(1, work_order_id);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            preparedstatement.setString(4, s3);
            preparedstatement.setString(5, s4);
            preparedstatement.setString(6, s5);
            preparedstatement.setString(7, s6);
            preparedstatement.setDouble(8, total_hours_daily);
            preparedstatement.setDouble(9, total_rm_daily);
            preparedstatement.setDouble(10, total_rm_daily);
            preparedstatement.setString(11, s7);
            preparedstatement.setDouble(12, d);
            preparedstatement.setDouble(13, d3);
            preparedstatement.setDouble(14, d1);
            preparedstatement.setDouble(15, d4);
            preparedstatement.setDouble(16, d2);
            preparedstatement.setDouble(17, d5);
            preparedstatement.setString(18, staff_id);
            preparedstatement.setString(19, claim_month);
            preparedstatement.setString(20, s);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to create new record.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception4)
        {
            errmsg = "Error : " + sqlexception4.toString();
            flag = false;
        }
        if(flag)
            UpdateTotalClaim(staff_id, claim_month);
        return flag;
    }

    public boolean DeleteApplicationDetail(String s, String s1)
    {
        boolean flag = false;
        sql = "DELETE STAFF_OVERTIME_DETL WHERE SOD_STAFF_ID = ? AND SOD_CLAIM_MONTH = TO_DATE(?,'MM/YYYY')";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            int i = preparedstatement.executeUpdate();
            conn.commit();
            flag = true;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        UpdateTotalClaim(s, s1);
        return flag;
    }

    public boolean DeleteApplicationDetail(String s, String s1, String s2)
    {
        boolean flag = false;
        sql = "DELETE STAFF_OVERTIME_DETL WHERE SOD_STAFF_ID = ? AND SOD_CLAIM_MONTH = TO_DATE(?,'MM/YYYY') AND SOD_DATE = TO_DATE(?,'DD/MM/YYYY') ";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to delete claim details.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error during delete: " + sqlexception.toString();
            flag = false;
        }
        UpdateTotalClaim(s, s1);
        return flag;
    }

    public boolean UpdateTotalClaim(String s, String s1)
    {
        boolean flag = false;
        double d = getTotalHours(s, s1);
        double d1 = getTotalRM(s, s1);
        sql = "UPDATE STAFF_OVERTIME_HEAD SET SOH_TOTAL_HOURS = ?, SOH_TOTAL_RM = ?, SOH_RECOMMEND_RM = ? WHERE SOH_STAFF_ID = ? AND TO_CHAR(SOH_CLAIM_MONTH,'MM/YYYY') = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setDouble(1, d);
            preparedstatement.setDouble(2, d1);
            preparedstatement.setDouble(3, d1);
            preparedstatement.setString(4, s);
            preparedstatement.setString(5, s1);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to delete claim details.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error during delete: " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean SubmitApplication(String s, String s1, String s2)
    {
        boolean flag = false;
        if(getDayDifference(claim_due_date) > 0.0D)
        {
            errmsg = "Due date for submitting claims has passed (" + claim_due_date + ")";
            return false;
        }
        sql = "UPDATE staff_overtime_head SET SOH_STATUS = 'APPLY', SOH_RECOMMEND_BY = ?, SOH_APPLY_DATE = SYSDATE WHERE SOH_STAFF_ID = ? AND SOH_CLAIM_MONTH = TO_DATE(?,'MM/YYYY')";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s2);
            preparedstatement.setString(2, s);
            preparedstatement.setString(3, s1);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to submit";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean RecommendApplication(String s, String s1, String s2)
    {
        boolean flag = false;
        sql = "UPDATE staff_overtime_head SET SOH_STATUS = 'RECOMMEND', SOH_RECOMMEND_BY = ?, SOH_RECOMMEND_DATE = SYSDATE, SOH_APPROVE_RM = SOH_RECOMMEND_RM WHERE SOH_STAFF_ID = ? AND SOH_CLAIM_MONTH = TO_DATE(?,'MM/YYYY')";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to Recommend";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        sql = "UPDATE STAFF_OVERTIME_DETL SET SOD_TOTAL_DAILY_APPROVE_RM = SOD_TOTAL_DAILY_RECOMMEND_RM WHERE SOD_STAFF_ID = ? AND SOD_CLAIM_MONTH = TO_DATE(?,'MM/YYYY')";
        try
        {
            PreparedStatement preparedstatement1 = conn.prepareStatement(sql);
            preparedstatement1.setString(1, s1);
            preparedstatement1.setString(2, s2);
            int j = preparedstatement1.executeUpdate();
            if(j == 0)
            {
                conn.rollback();
                errmsg = "Unable to Recommend";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errmsg = "Error : " + sqlexception1.toString();
            flag = false;
        }
        return flag;
    }

    public boolean NotRecommendApplication(String s, String s1, String s2)
    {
        boolean flag = false;
        sql = "UPDATE staff_overtime_head SET SOH_STATUS = 'ENTRY', SOH_RECOMMEND_BY = ?, SOH_RECOMMEND_DATE = SYSDATE WHERE SOH_STAFF_ID = ? AND SOH_CLAIM_MONTH = TO_DATE(?,'MM/YYYY')";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to Recommend";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean validOvertimeAttendance(String sDate, String sTime1Start, String sTime1End, 
    		String sTime2Start, String sTime2End, String sTime3Start, String sTime3End) {
    	
    	System.out.print("data : " + sDate + "|");
    	System.out.print(sTime1Start + "|" + sTime1End + "|");
    	System.out.print(sTime2Start + "|" + sTime2End + "|");
    	System.out.print(sTime3Start + "|" + sTime3End + "\n");
    	// first check whether staff is a driver or not.
    	StringBuffer sql1 = new StringBuffer();
    	sql1.append("select sm_job_code from staff_main")
    			.append(" where sm_staff_id = ?");
    	
    	try {
			PreparedStatement pstmt1 = conn.prepareStatement(sql1.toString());
			pstmt1.setString(1, staff_id);
			ResultSet rs1 = pstmt1.executeQuery();
			if (rs1.next()) {
				String jobCode = rs1.getString("sm_job_code");
				if (jobCode != null && jobCode.equals("R03")) {
					// just return true for the driver
					return true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// this piece of code will introduce bug, but we don't have other option
		// other than to include it here, or facing error when editing time
		if (sTime2Start.equals("00:01")) {
			sTime2Start = null;
		}
		if (sTime2End.equals("00:01")) {
			sTime2End = null;
		}
		if (sTime3Start.equals("00:01")) {
			sTime3Start = null;
		}
		if (sTime3End.equals("00:01")) {
			sTime3End = null;
		}
    	
    	// then validate the date and time with records in database
		boolean valid = false;
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		StringBuffer sql2 = new StringBuffer();
		/*
		sql2.append("select * from staff_attendance_head")
				.append(" where sah_staff_id = ?")
				.append(" and sah_type = ?")
				.append(" and sah_date = to_date(?, 'DD/MM/YYYY')")
				.append(" and to_char(sah_time_from,'hh24:mi') = ?")
				.append(" and to_char(sah_time_to,'hh24:mi') = ?");
		*/
		sql2.append("select * from staff_attendance_head")
				.append(" where sah_staff_id = ?")
				.append(" and sah_type = ?")
				.append(" and sah_date = to_date(?, 'DD/MM/YYYY')")
				.append(" and (to_date(?,'hh24:mi')")
				.append(" between to_date(to_char(sah_time_from,'hh24:mi'),'hh24:mi')")
				.append(" and to_date(to_char(sah_time_to,'hh24:mi'),'hh24:mi'))")
				.append(" and (to_date(?,'hh24:mi')")
				.append(" between to_date(to_char(sah_time_from,'hh24:mi'),'hh24:mi')") 
				.append(" and to_date(to_char(sah_time_to,'hh24:mi'),'hh24:mi'))");

		try {
			if (sTime1Start != null && !sTime1Start.isEmpty()) {
				pstmt2 = conn.prepareStatement(sql2.toString());
				pstmt2.setString(1, staff_id);
				pstmt2.setString(2, "OVERTIME");
				pstmt2.setString(3, sDate);
				pstmt2.setString(4, sTime1Start);
				pstmt2.setString(5, sTime1End);
				rs2 = pstmt2.executeQuery();
				if (rs2.next()) {
					valid = true;
				}
				rs2.close();
			}
			
			if (valid && sTime2Start != null && !sTime2Start.isEmpty() 
					&& sTime2End != null && !sTime2End.isEmpty()) {
				pstmt2.setString(4, sTime2Start);
				pstmt2.setString(5, sTime2End);
				rs2 = pstmt2.executeQuery();
				if (!rs2.next()) {
					valid = false;
				}
				rs2.close();
			}
			
			if (valid && sTime3Start != null && !sTime3Start.isEmpty() 
					&& sTime3End != null && !sTime3End.isEmpty()) {
				pstmt2.setString(4, sTime3Start);
				pstmt2.setString(5, sTime3End);
				rs2 = pstmt2.executeQuery();
				if (!rs2.next()) {
					valid = false;
				}
				rs2.close();
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt2.close();
			} catch (SQLException e) {
				// do nothing
			}
		}
    	
		if (!valid) {
			// notify the error caused
			errmsg = "Date and time specified does not have a valid " +
					"check-in and check-out overtime attendance";
		}
    	return valid;
    }
}