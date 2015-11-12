package cms.staff;

import java.sql.*;

public class TNTClaim
{
    protected String staff_id;
    protected String trip_id;
    protected String destination_address;
    protected String country_code;
    protected String travel_type;
    protected String travel_range;
    protected String date_from;
    protected String date_to;
    protected String transport_type;
    protected String transport_choice;
    protected String is_mileage_claimable;
    protected String is_meal_claimable;
    protected String is_hotel_claimable;
    protected String is_misc_claimable;
    protected Connection conn;
    protected String sql;
    protected String errmsg;

    public TNTClaim()
    {
        staff_id = null;
        trip_id = null;
        destination_address = null;
        country_code = null;
        travel_type = null;
        travel_range = null;
        date_from = null;
        date_to = null;
        transport_type = null;
        transport_choice = null;
        is_mileage_claimable = null;
        is_meal_claimable = null;
        is_hotel_claimable = null;
        is_misc_claimable = null;
        conn = null;
        sql = null;
        errmsg = null;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public void setStaffId(String s)
    {
        staff_id = s;
    }

    public boolean isClaimExists(String s, String s1)
    {
        boolean flag = false;
        sql = "SELECT 1 FROM STAFF_TRAVEL_CLAIM_HEAD WHERE STCH_STAFF_ID = ? AND STCH_TRIP_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            preparedstatement.close();
        }
        catch(SQLException sqlexception) { }
        return flag;
    }

    public boolean isDetailClaimExists(String s, String s1, String s2)
    {
        boolean flag = false;
        sql = "SELECT 1 FROM STAFF_TRAVEL_CLAIM_DETL WHERE STCD_STAFF_ID = ? AND STCD_TRIP_ID = ? AND STCD_CLAIM_TYPE = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                flag = true;
            preparedstatement.close();
        }
        catch(SQLException sqlexception) { }
        return flag;
    }

    public String getAccomodationAddress(String s, String s1)
    {
        String s2 = "";
        sql = "SELECT STCH_ACCOMODATION_ADDRESS FROM STAFF_TRAVEL_CLAIM_HEAD WHERE STCH_STAFF_ID = ? AND STCH_TRIP_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s2 = resultset.getString(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception) { }
        return s2;
    }

    public String getClaimReceiptNumber(String s, String s1, String s2)
    {
        String s3 = "";
        sql = "SELECT STCD_RECEIPT_NUMBER FROM STAFF_TRAVEL_CLAIM_DETL WHERE STCD_STAFF_ID = ? AND STCD_TRIP_ID = ? AND STCD_CLAIM_TYPE = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s3 = resultset.getString(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception) { }
        return s3;
    }

    public String getStartDateFromTrip(String s, String s1)
    {
        String s2 = "";
        sql = "SELECT TO_CHAR(STCT_DATE,'DD/MM/YYYY'),TO_CHAR(STCT_TIME_FROM,'HH24:MI') FROM STAFF_TRAVEL_CLAIM_TRIP WHERE STCT_STAFF_ID = ? AND STCT_TRIP_ID = ? ORDER BY STCT_DATE,STCT_TIME_FROM";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s2 = resultset.getString(1) + ":" + resultset.getString(2);
            preparedstatement.close();
        }
        catch(SQLException sqlexception) { }
        return s2;
    }

    public String getEndDateFromTrip(String s, String s1)
    {
        String s2 = "";
        sql = "SELECT TO_CHAR(STCT_DATE,'DD/MM/YYYY'),TO_CHAR(STCT_TIME_TO,'HH24:MI') FROM STAFF_TRAVEL_CLAIM_TRIP WHERE STCT_STAFF_ID = ? AND STCT_TRIP_ID = ? ORDER BY STCT_DATE DESC,STCT_TIME_TO DESC";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s2 = resultset.getString(1) + ":" + resultset.getString(2);
            preparedstatement.close();
        }
        catch(SQLException sqlexception) { }
        return s2;
    }

    public double getVehicleCCFromProfile(String s)
    {
        double d = 0.0D;
        sql = "SELECT TO_NUMBER(ST_VEHICLE_CC) FROM STAFF_TRANSPORT WHERE ST_STAFF_ID = ? ORDER BY TO_NUMBER(ST_VEHICLE_CC) DESC";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                d = resultset.getDouble(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception) { }
        return d;
    }

    public double getMileageFromTrip(String s, String s1)
    {
        double d = 0.0D;
        sql = "SELECT SUM(STCT_KM) FROM STAFF_TRAVEL_CLAIM_TRIP WHERE STCT_STAFF_ID = ? AND STCT_TRIP_ID = ?";
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
        catch(SQLException sqlexception) { }
        return d;
    }

    public double getClaimAmount(String s, String s1, String s2)
    {
        double d = 0.0D;
        sql = "SELECT STCD_CLAIM_AMOUNT FROM STAFF_TRAVEL_CLAIM_DETL WHERE STCD_STAFF_ID = ? AND STCD_TRIP_ID = ? AND STCD_CLAIM_TYPE = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                d = resultset.getDouble(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception) { }
        return d;
    }

    public double getDayDifference(String s, String s1)
    {
        double d = 0.0D;
        sql = "SELECT TO_DATE(?,'DD/MM/YYYY:HH24:MI') - TO_DATE(?,'DD/MM/YYYY:HH24:MI') FROM DUAL";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s1);
            preparedstatement.setString(2, s);
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

    public double getClaimDay(String s, String s1)
    {
        double d = 0.0D;
        double d1 = 0.0D;
        for(d1 = getHourDifference(s, s1); d1 >= 24D; d1 -= 24D)
            d++;

        if(d1 >= 8D)
            d += 0.5D;
        return d;
    }

    public double getClaimDayFromTravelTrip(String s, String s1)
    {
        double d = 0.0D;
        double d1 = 0.0D;
        String s2 = null;
        String s3 = null;
        for(d1 = getHourDifference(s2, s3); d1 >= 24D; d1 -= 24D)
            d++;

        if(d1 >= 8D)
            d += 0.5D;
        return d;
    }

    public double getDayDifference(String s)
    {
        double d = 0.0D;
        sql = "SELECT TO_DATE(SYSDATE,'DD/MM/YYYY:HH24:MI') - TO_DATE(?,'DD/MM/YYYY:HH24:MI') FROM DUAL";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
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

    public double getHourDifference(String s, String s1)
    {
        double d = 0.0D;
        sql = "SELECT TO_DATE(?,'DD/MM/YYYY:HH24:MI') - TO_DATE(?,'DD/MM/YYYY:HH24:MI') FROM DUAL";
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

    public String getStaffSSB(String s)
    {
        String s1 = null;
        sql = "SELECT SG_CATEGORY_SSB FROM STAFF_SALARY,SALARY_GRADE WHERE SG_GRADE_CODE = SS_SALARY_GRADE AND SS_STAFF_ID = ?";
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
        }
        return s1;
    }

    public String getStaffJKK(String s)
    {
        String s1 = null;
        return s1;
    }

    public double getStaffSalary(String s)
    {
        double d = 0.0D;
        sql = "select ss_basic_salary from staff_salary where ss_staff_id = ?";
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
        return d;
    }

    public void getTravelTripInfo(String s, String s1, String s2, String s3, String s4, String s5, String s6, 
            String s7, String s8, String s9, String s10, String s11, String s12)
    {
        sql = "select tt_destination_address, TT_DESTINATION_COUNTRY_CODE,tt_travel_type, tt_travel_range,to_char(tt_date_from,'DD/MM/YYYY:HH24:MI'),to_char(tt_date_to,'DD/MM/YYYY:HH24:MI'), tt_transport_type,tt_transport_choice,tt_is_mileage_claimable, tt_is_meal_claimable,tt_is_hotel_claimable,tt_is_misc_claimable from travel_trip where tt_trip_id = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                s1 = resultset.getString(1);
                s2 = resultset.getString(2);
                s3 = resultset.getString(3);
                s4 = resultset.getString(4);
                s5 = resultset.getString(5);
                s6 = resultset.getString(6);
                s7 = resultset.getString(7);
                s8 = resultset.getString(8);
                s9 = resultset.getString(9);
                s10 = resultset.getString(10);
                s11 = resultset.getString(11);
                s12 = resultset.getString(12);
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception) { }
    }

    public String getMileageClass(double d, double d1)
    {
        String s = null;
        sql = "SELECT TMC_CLASS_CODE FROM TNT_MILEAGE_CLASS WHERE ? BETWEEN TMC_SALARY_SSB_FROM AND TMC_SALARY_SSB_TO AND ? BETWEEN TMC_VEHICLE_CC_FROM AND TMC_VEHICLE_CC_TO";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setDouble(1, d);
            preparedstatement.setDouble(2, d1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s = resultset.getString(1);
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return s;
    }

    public String getDriverID(String s)
    {
        String s1 = "";
        sql = "SELECT TT_DRIVER_ID FROM TRAVEL_TRIP WHERE TT_TRIP_ID = ?";
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
        }
        return s1;
    }

    public double getMileageClaim(String s, double d, double d1)
    {
        double d2 = 0.0D;
        double d4 = 0.0D;
        double d5 = getStaffSalary(s);
        String s1 = getMileageClass(d5, d);
        String s2 = "SELECT * FROM TNT_MILEAGE_RATE WHERE TMR_CLASS_CODE = '" + s1 + "' " + "AND (" + d1 + " BETWEEN TMR_KM_FROM AND TMR_KM_TO OR " + "(" + d1 + " NOT BETWEEN TMR_KM_FROM AND TMR_KM_TO AND " + d1 + " > TMR_KM_TO))";
        try
        {
            Statement statement = conn.createStatement(1004, 1008);
            ResultSet resultset = statement.executeQuery(s2);
            if(resultset.isBeforeFirst())
                while(resultset.next()) 
                    if(!resultset.isLast())
                    {
                        double d3 = (resultset.getDouble(3) - resultset.getDouble(2)) + 1.0D;
                        d1 -= d3;
                        d4 += d3 * resultset.getDouble(4);
                    } else
                    {
                        d4 += d1 * resultset.getDouble(4);
                    }
            resultset.close();
            statement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return d4;
    }

    public double getOverseaClaim(String s, String s1, String s2, String s3, String s4)
    {
        double d = 0.0D;
        sql = "SELECT ";
        if(s.compareTo("OFFICIAL") == 0)
        {
            if(s1.compareTo("MEAL") == 0)
                sql = sql + "TRO_OFFICIAL_MEAL_ALLOWANCE ";
            else
            if(s1.compareTo("HOTEL") == 0)
                sql = sql + "TRO_OFFICIAL_HOTEL_ALLOWANCE ";
            else
            if(s1.compareTo("LOGGING") == 0)
                sql = sql + "TRO_OFFICIAL_LOGGING_ALLOWANCE ";
        } else
        if(s.compareTo("TRAINING") == 0)
            if(s1.compareTo("MEAL") == 0)
                sql = sql + "TRO_TRAINING_MEAL_ALLOWANCE ";
            else
            if(s1.compareTo("HOTEL") == 0)
                sql = sql + "TRO_TRAINING_HOTEL_ALLOWANCE ";
            else
            if(s1.compareTo("LOGGING") == 0)
                sql = sql + "TRO_TRAINING_LOGGING_ALLOWANCE ";
        sql = sql + "FROM TNT_RATE_OVERSEA WHERE TRO_COUNTRY_CODE = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s2);
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

    public double getClaim(String s, String s1, String s2, String s3, String s4, String s5, String s6)
    {
        double d = 0.0D;
        double d1 = 0.0D;
        String s7 = null;
        double d2 = 0.0D;
        double d3 = 0.0D;
        s7 = getStaffSSB(s);
        d2 = getStaffSalary(s);
        for(d1 = getHourDifference(s5, s6); d1 >= 24D; d1 -= 24D)
            d++;

        if(d1 >= 8D)
            d += 0.5D;
        if(d < 1.0D)
            return 0.0D;
        if(s4.compareTo("MEAL") == 0)
            sql = "SELECT TRM_MEAL_ALLOWANCE FROM TNT_RATE_MAIN WHERE TRM_STAFF_SALARY_CATEGORY = ? AND ? BETWEEN TRM_STAFF_SALARY_FROM AND TRM_STAFF_SALARY_TO AND TRM_TRAVEL_RANGE = ? AND TRM_TRAVEL_TYPE = ?";
        else
        if(s4.compareTo("HOTEL") == 0)
            sql = "SELECT TRM_HOTEL_ALLOWANCE FROM TNT_RATE_MAIN WHERE TRM_STAFF_SALARY_CATEGORY = ? AND ? BETWEEN TRM_STAFF_SALARY_FROM AND TRM_STAFF_SALARY_TO AND TRM_TRAVEL_RANGE = ? AND TRM_TRAVEL_TYPE = ?";
        else
        if(s4.compareTo("LOGGING") == 0)
            sql = "SELECT TRM_LOGGING_ALLOWANCE FROM TNT_RATE_MAIN WHERE TRM_STAFF_SALARY_CATEGORY = ? AND ? BETWEEN TRM_STAFF_SALARY_FROM AND TRM_STAFF_SALARY_TO AND TRM_TRAVEL_RANGE = ? AND TRM_TRAVEL_TYPE = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s7);
            preparedstatement.setDouble(2, d2);
            preparedstatement.setString(3, s2);
            preparedstatement.setString(4, s1);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                if(resultset.getDouble(1) == -1D)
                    d3 = getOverseaClaim(s1, s4, s3, s5, s6) * d;
                else
                if(resultset.getDouble(1) == -3D)
                    d3 = 0.0D;
                else
                    d3 = resultset.getDouble(1);
                if(s4.compareTo("MEAL") == 0)
                {
                    if(s1.compareTo("OFFICIAL") == 0)
                        d3 *= d;
                    if(s1.compareTo("TRAINING") == 0)
                        d3 *= d + 0.10000000000000001D;
                } else
                if(s4.compareTo("HOTEL") == 0 || s4.compareTo("LOGGING") == 0)
                    d3 *= (int)d;
                else
                    d3 *= d;
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return d3;
    }

    public boolean createNewClaim(String s, String s1)
    {
        boolean flag = false;
        if(isClaimExists(s, s1))
        {
            errmsg = "Claim already exists";
            return false;
        }
        sql = "INSERT INTO STAFF_TRAVEL_CLAIM_HEAD (STCH_STAFF_ID, STCH_TRIP_ID, STCH_CLAIM_TYPE, STCH_STATUS, STCH_CLAIM_DATE) VALUES (?, ?, 'CLAIM', 'ENTRY', SYSDATE)";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to create claim.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean SubmitClaim(String s, String s1)
    {
        boolean flag = false;
        sql = "UPDATE STAFF_TRAVEL_CLAIM_HEAD SET STCH_STATUS = 'APPLY', STCH_CLAIM_DATE = SYSDATE WHERE STCH_STAFF_ID = ? AND STCH_TRIP_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to submit claim.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean addClaimAddress(String s, String s1, String s2)
    {
        boolean flag = false;
        sql = "UPDATE STAFF_TRAVEL_CLAIM_HEAD SET STCH_ACCOMODATION_ADDRESS = ? WHERE STCH_STAFF_ID = ? AND STCH_TRIP_ID = ?";
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
                errmsg = "Unable to update accomodation address.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean createNewClaimDetail(String s, String s1, String s2, double d, String s3)
    {
        boolean flag = false;
        if(!isClaimExists(s, s1))
        {
            errmsg = "Claim doesn't exist";
            return false;
        }
        sql = "INSERT INTO STAFF_TRAVEL_CLAIM_DETL (STCD_STAFF_ID, STCD_TRIP_ID, STCD_CLAIM_TYPE, STCD_CLAIM_AMOUNT, STCD_RECEIPT_NUMBER) VALUES (?, ?, ?, ?, ?)";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            preparedstatement.setDouble(4, d);
            preparedstatement.setString(5, s3);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to create claim.";
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

    public boolean DeleteClaimDetail(String s, String s1, String s2)
    {
        boolean flag = false;
        sql = "DELETE STAFF_TRAVEL_CLAIM_DETL WHERE STCD_STAFF_ID = ? AND STCD_TRIP_ID = ? AND STCD_CLAIM_TYPE = ? ";
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
                errmsg = "Unable to delete claim detail.";
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

    public boolean createNewClaimDetailTrip(String s, String s1, String s2, String s3, String s4, String s5, String s6, 
            double d, String s7, String s8, String s9, String s10)
    {
        boolean flag = false;
        sql = "INSERT INTO STAFF_TRAVEL_CLAIM_TRIP(STCT_STAFF_ID, STCT_TRIP_ID, STCT_DATE, STCT_TIME_FROM, STCT_TIME_TO, STCT_FROM, STCT_TO, STCT_KM, STCT_DESC, STCT_BREAKFAST, STCT_LUNCH,STCT_DINNER    ) VALUES (?, ?, TO_DATE(?,'DD/MM/YYYY'), TO_DATE(?,'HH24:MI'), TO_DATE(?,'HH24:MI'), ?, ?, ?, ?, ?, ?, ?)";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            preparedstatement.setString(4, s3);
            preparedstatement.setString(5, s4);
            preparedstatement.setString(6, s5);
            preparedstatement.setString(7, s6);
            preparedstatement.setDouble(8, d);
            preparedstatement.setString(9, s7);
            preparedstatement.setString(10, s8);
            preparedstatement.setString(11, s9);
            preparedstatement.setString(12, s10);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to create trip details.";
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

    public boolean DeleteClaimDetailTrip(String s, String s1, String s2, String s3, String s4)
    {
        boolean flag = false;
        sql = "DELETE STAFF_TRAVEL_CLAIM_TRIP WHERE STCT_STAFF_ID = ? AND STCT_TRIP_ID = ? AND TO_CHAR(STCT_DATE,'DD/MM/YYYY') = ? AND TO_CHAR(STCT_TIME_FROM,'HH24:MI') = ? AND TO_CHAR(STCT_TIME_TO,'HH24:MI') = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            preparedstatement.setString(4, s3);
            preparedstatement.setString(5, s4);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to delete trip details.";
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

    public boolean updateClaimTotal(String s, String s1)
    {
        boolean flag = false;
        if(!isClaimExists(s, s1))
        {
            errmsg = "Claim not exists";
            return false;
        }
        sql = "UPDATE STAFF_TRAVEL_CLAIM_HEAD SET STCH_TOTAL_CLAIM_RM = (SELECT SUM (STCD_CLAIM_AMOUNT) FROM STAFF_TRAVEL_CLAIM_DETL WHERE STCD_STAFF_ID = ? AND STCD_TRIP_ID = ?) WHERE STCH_STAFF_ID = ? AND STCH_TRIP_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s);
            preparedstatement.setString(4, s1);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to update claim totals.";
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
}