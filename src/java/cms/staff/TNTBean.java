package cms.staff;

import java.sql.*;

public class TNTBean
{
    protected String staff_id;
    protected String application_date;
    protected String workorder_id;
    protected String date_from;
    protected String date_to;
    protected String destination;
    protected String travel_type;
    protected String travel_range;
    protected int distance;
    protected String reason;
    protected String contact_number;
    protected String transport_type;
    protected String transport_choice;
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected String advance_id;

    public TNTBean()
    {
        staff_id = null;
        application_date = null;
        workorder_id = null;
        date_from = null;
        date_to = null;
        destination = null;
        travel_type = null;
        travel_range = null;
        distance = 0;
        reason = null;
        contact_number = null;
        transport_type = null;
        transport_choice = null;
        conn = null;
        sql = null;
        errmsg = null;
        advance_id = null;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public String getAdvanceID()
    {
        return advance_id;
    }

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public void setStaffId(String s)
    {
        staff_id = s;
    }

    public void setApplicationDate(String s)
    {
        application_date = s;
    }

    public void setDateFrom(String s)
    {
        date_from = s;
    }

    public void setDateTo(String s)
    {
        date_to = s;
    }

    public void setWorkorderId(String s)
    {
        workorder_id = s;
    }

    public void setDestination(String s)
    {
        destination = s;
    }

    public void setTravelType(String s)
    {
        travel_type = s;
    }

    public void setTravelRange(String s)
    {
        travel_range = s;
    }

    public void setDistance(int i)
    {
        distance = i;
    }

    public void setReason(String s)
    {
        reason = s;
    }

    public void setContactNumber(String s)
    {
        contact_number = s;
    }

    public void setTransportType(String s)
    {
        transport_type = s;
    }

    public void setTransportChoice(String s)
    {
        transport_choice = s;
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

    public boolean isWorkOrderValid()
    {
        boolean flag = false;
        double d = 0.0D;
        sql = "SELECT 1 FROM WORK_ORDER_HEAD WHERE WOH_WORKORDER_ID = ? AND ? = TO_CHAR(WOH_DATE_FROM,'DD/MM/YYYY') AND ( (WOH_DATE_TO IS NULL) OR (WOH_DATE_TO IS NOT NULL AND ? = TO_CHAR(WOH_DATE_TO,'DD/MM/YYYY')))";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, workorder_id);
            preparedstatement.setString(2, date_from);
            preparedstatement.setString(3, date_to);
            ResultSet resultset = preparedstatement.executeQuery();
            boolean flag1;
            if(resultset.next())
                flag1 = true;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
        }
        return true;
    }

    public boolean isApplicationDateValid()
    {
        if(getDayDifference(application_date + ":00:00", date_from) < 0.0D)
        {
            errmsg = "Application must be made before travel";
            return false;
        } else
        {
            return true;
        }
    }

    public boolean isDateValid(String s)
    {
        boolean flag = false;
        String s1 = null;
        sql = "select to_char(to_date(?,'DD/MM/YYYY:HH24:MI'),'DD/MM/YYYY:HH24:MI') from dual";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s1 = resultset.getString(1);
            preparedstatement.close();
            if(s.compareTo(s1) == 0)
                flag = true;
            else
                flag = false;
        }
        catch(SQLException sqlexception)
        {
            flag = false;
        }
        return flag;
    }

    public boolean isDateFromToValid()
    {
        if(getHourDifference(date_from, date_to) < 0.0D)
        {
            errmsg = "Date To must be after Date From";
            return false;
        } else
        {
            return true;
        }
    }

    public boolean MemoNewTravelRequest(String s)
    {
        boolean flag = true;
        String s1 = null;
        String s2 = null;
        String s3 = null;
        sql = "SELECT STR_STAFF_ID,SM_STAFF_NAME,TO_CHAR(STR_APPLY_DATE,'DD/MM/YYYY'),NVL(WOH_DESC,'NONE'),TO_CHAR(STR_DATE_FROM,'DD/MM/YYYY:HH24:MI'), TO_CHAR(STR_DATE_TO,'DD/MM/YYYY:HH24:MI'),STR_TRAVEL_TYPE,STR_TRAVEL_RANGE, STR_DESTINATION,STR_DISTANCE,STR_TRAVEL_REASON, STR_TRANSPORT_TYPE,STR_TRANSPORT_CHOICE FROM STAFF_TRAVEL_REQUEST,STAFF_MAIN,WORK_ORDER_HEAD WHERE SM_STAFF_ID = STR_STAFF_ID AND WOH_WORKORDER_ID(+) = STR_WORKORDER_ID AND STR_REF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                s2 = resultset.getString(13);
                s3 = resultset.getString(1);
                s1 = "Please take note that there are a new travel request waiting for approval :<br><br>";
                s1 = s1 + "Details : <br><br>";
                s1 = s1 + "Staff : " + resultset.getString(1) + " - " + resultset.getString(2) + "<br>";
                s1 = s1 + "Application Date : " + resultset.getString(3) + "<br>";
                s1 = s1 + "Work Order : " + resultset.getString(4) + "<br>";
                s1 = s1 + "From : " + resultset.getString(5) + "<br>";
                s1 = s1 + "To : " + resultset.getString(6) + "<br>";
                s1 = s1 + "Travel Type : " + resultset.getString(7) + "<br>";
                if(resultset.getString(8).compareTo("A") == 0)
                    s1 = s1 + "Travel Range : Semenanjung/Kalimantan/Selatan Thai<br>";
                else
                if(resultset.getString(8).compareTo("B") == 0)
                    s1 = s1 + "Travel Range : Sabah & Sarawak<br>";
                else
                if(resultset.getString(8).compareTo("B") == 0)
                    s1 = s1 + "Travel Range : Luar Negeri<br>";
                s1 = s1 + "Destination : " + resultset.getString(9) + "<br>";
                s1 = s1 + "Estimated Distance : " + resultset.getString(10) + " KM<br>";
                s1 = s1 + "Travel Reason : " + resultset.getString(11) + "<br>";
                s1 = s1 + "Transport Type : " + resultset.getString(12) + "<br>";
                s1 = s1 + "Transport Choice : " + resultset.getString(13) + "<br>";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error during getting travel request info: " + sqlexception.toString();
        }
        try
        {
            if(s2.equals("OWN"))
                sql = "SELECT SH_REPORT_TO FROM STAFF_HIERARCHY WHERE SH_SYS_ID = 'ADM_AL' AND SH_STAFF_ID = ?";
            else
                sql = "SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'TRAVEL_REQUEST_SEND_TO'";
            PreparedStatement preparedstatement1 = conn.prepareStatement(sql);
            if(s2.equals("OWN"))
                preparedstatement1.setString(1, s3);
            ResultSet resultset1 = preparedstatement1.executeQuery();
            if(resultset1.next())
            {
                String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
                java.sql.CallableStatement callablestatement = conn.prepareCall(s4);
                callablestatement.setString(1, s3);
                callablestatement.setString(2, resultset1.getString(1));
                callablestatement.setString(3, null);
                callablestatement.setString(4, "New Travel Request");
                callablestatement.setString(5, s1);
                callablestatement.execute();
                callablestatement.close();
            }
            resultset1.close();
            preparedstatement1.close();
        }
        catch(Exception exception)
        {
            errmsg = "Error during sending memo to approver : " + exception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean MemoApproveTravelRequest(String s)
    {
        boolean flag = true;
        String s1 = null;
        String s2 = null;
        String s3 = null;
        sql = "SELECT STR_STAFF_ID,SM_STAFF_NAME,TO_CHAR(STR_APPLY_DATE,'DD/MM/YYYY'),NVL(WOH_DESC,'NONE'),TO_CHAR(STR_DATE_FROM,'DD/MM/YYYY:HH24:MI'), TO_CHAR(STR_DATE_TO,'DD/MM/YYYY:HH24:MI'),STR_TRAVEL_TYPE,STR_TRAVEL_RANGE, STR_DESTINATION,STR_DISTANCE,STR_TRAVEL_REASON, STR_APPROVE_BY,STR_TRANSPORT_TYPE,STR_TRANSPORT_CHOICE FROM STAFF_TRAVEL_REQUEST,STAFF_MAIN,WORK_ORDER_HEAD WHERE SM_STAFF_ID = STR_APPROVE_BY AND WOH_WORKORDER_ID(+) = STR_WORKORDER_ID AND STR_REF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
            {
                s2 = resultset.getString(12);
                s3 = resultset.getString(1);
                s1 = "Please take note that your travel request has been approved :<br><br>";
                s1 = s1 + "Details : <br><br>";
                s1 = s1 + "Application Date : " + resultset.getString(3) + "<br>";
                s1 = s1 + "Work Order : " + resultset.getString(4) + "<br>";
                s1 = s1 + "From : " + resultset.getString(5) + "<br>";
                s1 = s1 + "To : " + resultset.getString(6) + "<br>";
                s1 = s1 + "Travel Type : " + resultset.getString(7) + "<br>";
                if(resultset.getString(8).compareTo("A") == 0)
                    s1 = s1 + "Travel Range : Semenanjung/Kalimantan/Selatan Thai<br>";
                else
                if(resultset.getString(8).compareTo("B") == 0)
                    s1 = s1 + "Travel Range : Sabah & Sarawak<br>";
                else
                if(resultset.getString(8).compareTo("B") == 0)
                    s1 = s1 + "Travel Range : Luar Negeri<br>";
                s1 = s1 + "Destination : " + resultset.getString(9) + "<br>";
                s1 = s1 + "Estimated Distance : " + resultset.getString(10) + " KM<br>";
                s1 = s1 + "Travel Reason : " + resultset.getString(11) + "<br>";
                s1 = s1 + "Transport Type : " + resultset.getString(13) + "<br>";
                s1 = s1 + "Transport Choice : " + resultset.getString(14) + "<br>";
                s1 = s1 + "Approved By : " + resultset.getString(12) + " - " + resultset.getString(2) + "<br>";
            }
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error during getting travel request info: " + sqlexception.toString();
        }
        try
        {
            String s4 = "{ call create_memo( ?, ?, ?, ?, ?) }";
            java.sql.CallableStatement callablestatement = conn.prepareCall(s4);
            callablestatement.setString(1, s2);
            callablestatement.setString(2, s3);
            callablestatement.setString(3, null);
            callablestatement.setString(4, "Travel Request Approved");
            callablestatement.setString(5, s1);
            callablestatement.execute();
            callablestatement.close();
        }
        catch(Exception exception)
        {
            errmsg = "Error during sending memo to applicant : " + exception.toString();
            flag = false;
        }
        return flag;
    }

    public boolean addApplication()
    {
        boolean flag = false;
        String s = null;
        String s1 = null;
        if(!isDateFromToValid())
            return false;
        if(!isDateValid(date_from))
        {
            errmsg = "Invalid date/time entry";
            return false;
        }
        if(getDayDifference(date_from, date_to) < 0.0D)
        {
            errmsg = "Date/Time To must be after Date/Time From";
            return false;
        }
        if(destination == null)
        {
            errmsg = "Destination is empty";
            return false;
        }
        sql = "select to_char(sysdate,'YYYY')||'-'||ltrim(to_char(max(to_number(substr(str_ref_id,6,10))+1),'00000')) from cmsadmin.staff_travel_request";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                s = resultset.getString(1);
            else
                flag = true;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        if(transport_choice.equals("OWN"))
        {
            sql = "SELECT SH_REPORT_TO FROM STAFF_HIERARCHY WHERE SH_SYS_ID = 'ADM_AL' AND SH_STAFF_ID = ?";
            try
            {
                PreparedStatement preparedstatement1 = conn.prepareStatement(sql);
                preparedstatement1.setString(1, staff_id);
                ResultSet resultset1 = preparedstatement1.executeQuery();
                if(resultset1.next())
                    s1 = resultset1.getString(1);
                resultset1.close();
                preparedstatement1.close();
            }
            catch(SQLException sqlexception1)
            {
                flag = false;
            }
        }
        sql = "INSERT INTO STAFF_TRAVEL_REQUEST (STR_REF_ID, STR_STAFF_ID, STR_APPLY_DATE, STR_WORKORDER_ID, STR_STATUS, STR_DATE_FROM, STR_DATE_TO, STR_DESTINATION, STR_DISTANCE, STR_TRAVEL_REASON, STR_TRANSPORT_TYPE, STR_TRANSPORT_CHOICE, str_staff_contact_number, STR_TRAVEL_TYPE, STR_TRAVEL_RANGE,STR_APPROVE_BY) VALUES (?, ?, SYSDATE, ?, 'APPLY', TO_DATE(?,'DD/MM/YYYY:HH24:MI'), TO_DATE(?,'DD/MM/YYYY:HH24:MI'), ?, ?, ?, ?, ?, ?, ?, ?,?)";
        try
        {
            PreparedStatement preparedstatement2 = conn.prepareStatement(sql);
            preparedstatement2.setString(1, s);
            preparedstatement2.setString(2, staff_id);
            preparedstatement2.setString(3, workorder_id);
            preparedstatement2.setString(4, date_from);
            preparedstatement2.setString(5, date_to);
            preparedstatement2.setString(6, destination);
            preparedstatement2.setInt(7, distance);
            preparedstatement2.setString(8, reason);
            preparedstatement2.setString(9, transport_type);
            preparedstatement2.setString(10, transport_choice);
            preparedstatement2.setString(11, contact_number);
            preparedstatement2.setString(12, travel_type);
            preparedstatement2.setString(13, travel_range);
            preparedstatement2.setString(14, s1);
            int i = preparedstatement2.executeUpdate();
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
        }
        catch(SQLException sqlexception2)
        {
            errmsg = "Error : " + sqlexception2.toString();
            flag = false;
        }
        MemoNewTravelRequest(s);
        return flag;
    }

    public boolean RecommendApplication(String s, String s1, String s2, String s3, String s4, String s5)
    {
        boolean flag = false;
        sql = "UPDATE STAFF_TRAVEL_REQUEST SET STR_STATUS = 'RECOMMEND', STR_RECOMMEND_DATE = SYSDATE, STR_RECOMMEND_BY = ? WHERE STR_STAFF_ID = ? AND TO_CHAR(STR_APPLY_DATE,'DD/MM/YYYY') = ? AND STR_WORKORDER_ID = ? AND TO_CHAR(STR_DATE_FROM,'DD/MM/YYYY:HH24:MI') = ? AND TO_CHAR(STR_DATE_TO,'DD/MM/YYYY:HH24:MI') = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setString(3, s2);
            preparedstatement.setString(4, s3);
            preparedstatement.setString(5, s4);
            preparedstatement.setString(6, s5);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to recommend.";
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

    public boolean addAdvanceClaim(String s, String s1, double d)
    {
        boolean flag = false;
        sql = "select to_char(sysdate,'YYYY')||'-'||ltrim(to_char(STAFF_ADVANCE_HEAD_SEQ.NEXTVAL,'00000')) from dual";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            ResultSet resultset = preparedstatement.executeQuery();
            if(resultset.next())
                advance_id = resultset.getString(1);
            else
                flag = true;
            preparedstatement.close();
        }
        catch(SQLException sqlexception)
        {
            errmsg = "Error : " + sqlexception.toString();
            flag = false;
        }
        sql = "INSERT INTO STAFF_ADVANCE_HEAD (SAH_ADVANCE_ID,SAH_STAFF_ID,SAH_TRAVREQUEST_ID, SAH_APPLY_DATE,SAH_ADVANCE_AMT,SAH_STATUS) VALUES (?,?,?,sysdate,?,'APPLY')";
        try
        {
            PreparedStatement preparedstatement1 = conn.prepareStatement(sql);
            preparedstatement1.setString(1, advance_id);
            preparedstatement1.setString(2, s);
            preparedstatement1.setString(3, s1);
            preparedstatement1.setDouble(4, d);
            int i = preparedstatement1.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to apply advance.";
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

    public boolean addAdvanceClaimDetl(String s, String s1, double d)
    {
        boolean flag = false;
        sql = "INSERT INTO STAFF_ADVANCE_DETL (SAD_ADVANCE_ID,SAD_ADVANCE_TYPE,SAD_ADVANCE_AMT) VALUES (?,?,?)";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            preparedstatement.setDouble(3, d);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to apply advance details.";
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

    public boolean RecommendAdvanceApplication(String s, String s1)
    {
        boolean flag = false;
        sql = "UPDATE STAFF_ADVANCE_HEAD SET SAH_RECOMMEND_BY = ?, SAH_RECOMMEND_DATE = SYSDATE, SAH_STATUS = 'RECOMMEND' WHERE SAH_ADVANCE_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to recommend.";
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

    public boolean SubmitTravel(String s, String s1)
    {
        boolean flag = false;
        sql = "UPDATE STAFF_TRAVEL_REQUEST SET STR_VERIFY_STATUS = 'APPLY', STR_VERIFY_BY = ? WHERE STR_REF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s1);
            preparedstatement.setString(2, s);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to submit travel report.";
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

    public boolean VerifyTravel(String s, String s1)
    {
        boolean flag = false;
        sql = "UPDATE STAFF_TRAVEL_REQUEST SET str_verify_status='APPROVE', STR_VERIFY_BY = ?, STR_VERIFY_DATE = SYSDATE WHERE STR_REF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to submit travel report.";
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

    public boolean ApproveTravel(String s)
    {
        boolean flag = false;
        String s1 = null;
        double d = 0.0D;
        String s2 = null;
        String s3 = null;
        String s4 = null;
        String s5 = null;
        String s6 = null;
        String s7 = null;
        String s8 = null;
        String s9 = null;
        String s10 = null;
        String s11 = null;
        String s12 = null;
        sql = "UPDATE STAFF_TRAVEL_REQUEST SET str_status='APPROVE', STR_APPROVE_DATE = SYSDATE WHERE STR_REF_ID = ?";
        try
        {
            PreparedStatement preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            int i = preparedstatement.executeUpdate();
            if(i == 0)
            {
                conn.rollback();
                errmsg = "Unable to approve travel request.";
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
        sql = "SELECT STR_DESTINATION,STR_DISTANCE,STR_TRAVEL_TYPE,STR_TRAVEL_RANGE, TO_CHAR(STR_DATE_FROM,'DD/MM/YYYY'),TO_CHAR(STR_DATE_TO,'DD/MM/YYYY'), STR_TRANSPORT_TYPE,STR_TRANSPORT_CHOICE,TO_CHAR(TO_NUMBER(ST_VEHICLE_CC)), ST_VEHICLE_NO,STR_STAFF_ID,STR_APPROVE_BY FROM STAFF_TRAVEL_REQUEST,STAFF_TRANSPORT WHERE ST_STAFF_ID(+) = STR_STAFF_ID AND STR_REF_ID = ?";
        try
        {
            PreparedStatement preparedstatement1 = conn.prepareStatement(sql);
            preparedstatement1.setString(1, s);
            ResultSet resultset = preparedstatement1.executeQuery();
            if(resultset.next())
            {
                s1 = resultset.getString(1);
                d = resultset.getDouble(2);
                s2 = resultset.getString(3);
                s3 = resultset.getString(4);
                s4 = resultset.getString(5);
                s5 = resultset.getString(6);
                s6 = resultset.getString(7);
                s7 = resultset.getString(8);
                s8 = resultset.getString(9);
                s9 = resultset.getString(10);
                s10 = resultset.getString(11);
                s11 = resultset.getString(12);
            }
            preparedstatement1.close();
        }
        catch(SQLException sqlexception1)
        {
            errmsg = "Error : " + sqlexception1.toString();
        }
        sql = "select to_char(sysdate,'YY') || '-' || ltrim(to_char(TRAVEL_TRIP_ID.nextval,'000000')) FROM DUAL";
        try
        {
            PreparedStatement preparedstatement2 = conn.prepareStatement(sql);
            ResultSet resultset1 = preparedstatement2.executeQuery();
            if(resultset1.next())
                s12 = resultset1.getString(1);
            preparedstatement2.close();
        }
        catch(SQLException sqlexception2)
        {
            errmsg = "Error : " + sqlexception2.toString();
        }
        sql = "INSERT INTO TRAVEL_TRIP (TT_TRIP_ID,TT_STATUS,TT_DESTINATION_ADDRESS,TT_DISTANCE, TT_TRAVEL_TYPE,TT_TRAVEL_RANGE,TT_DATE_FROM,TT_DATE_TO,TT_TRANSPORT_TYPE,TT_TRANSPORT_CHOICE, TT_TRANSPORT_VEHICLE_CC,TT_TRANSPORT_VEHICLE_NUMBER,TT_DRIVER_ID, TT_CURRENT_CAPACITY,TT_MAX_CAPACITY,TT_CREATE_BY,TT_CREATE_DATE, TT_APPROVE_BY,TT_APPROVE_DATE,TT_DESTINATION_COUNTRY_CODE) VALUES (?,'APPROVE',?,?, ?,?,TO_DATE(?,'DD/MM/YYYY'),TO_DATE(?,'DD/MM/YYYY'),?,?, ?,?,?, 1,1,?,SYSDATE, ?,SYSDATE,'MAL')";
        try
        {
            PreparedStatement preparedstatement3 = conn.prepareStatement(sql);
            preparedstatement3.setString(1, s12);
            preparedstatement3.setString(2, s1);
            preparedstatement3.setDouble(3, d);
            preparedstatement3.setString(4, s2);
            preparedstatement3.setString(5, s3);
            preparedstatement3.setString(6, s4);
            preparedstatement3.setString(7, s5);
            preparedstatement3.setString(8, s6);
            preparedstatement3.setString(9, s7);
            preparedstatement3.setString(10, s8);
            preparedstatement3.setString(11, s9);
            preparedstatement3.setString(12, s10);
            preparedstatement3.setString(13, s11);
            preparedstatement3.setString(14, s11);
            int j = preparedstatement3.executeUpdate();
            if(j == 0)
            {
                conn.rollback();
                errmsg = "Unable to create travel trip.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement3.close();
        }
        catch(SQLException sqlexception3)
        {
            errmsg = "Error : " + sqlexception3.toString();
            flag = false;
        }
        sql = "UPDATE STAFF_TRAVEL_REQUEST SET STR_TRIP_ID = ? WHERE STR_REF_ID = ?";
        try
        {
            PreparedStatement preparedstatement4 = conn.prepareStatement(sql);
            preparedstatement4.setString(1, s12);
            preparedstatement4.setString(2, s);
            int k = preparedstatement4.executeUpdate();
            if(k == 0)
            {
                conn.rollback();
                errmsg = "Unable to assign trip.";
                flag = false;
            } else
            {
                conn.commit();
                flag = true;
            }
            preparedstatement4.close();
        }
        catch(SQLException sqlexception4)
        {
            errmsg = "Error : " + sqlexception4.toString();
            flag = false;
        }
        MemoApproveTravelRequest(s);
        return flag;
    }
}