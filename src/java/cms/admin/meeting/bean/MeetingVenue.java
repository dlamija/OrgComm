package cms.admin.meeting.bean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import utilities.ResourceUtil;

public class MeetingVenue
  implements Serializable
{
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;
    protected String mtgCode;
    protected String mtgVenueRemark;
    protected String bkgDate;
    protected String bkgStartTime;
    protected String bkgEndTime;
    protected String roomCode;
    protected String roomDesc;
    protected String roomCapacity;
    protected String bldgCode;
    protected String roomBkgSeq;
    protected String resourceSeq;
    protected String subsytm;
    protected String kodKey;
    protected String status;
    protected String approverID;
    protected String capacity;
    protected String owner;
    protected String requireApprove;
    protected String desc;
    protected String staffName;
    protected String resourceRecordID;

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public void setMtgCode(String s)
    {
        mtgCode = s;
    }

    public void setRoomCode(String s)
    {
        roomCode = s;
    }

    public void setBkgDate(String s)
    {
        bkgDate = s;
    }

    public void setBkgStartTime(String s)
    {
        bkgStartTime = s;
    }

    public void setBkgEndTime(String s)
    {
        bkgEndTime = s;
    }

    public void setSubsytm(String s)
    {
        subsytm = s;
    }

    public void setKodKey(String s)
    {
        kodKey = s;
    }

    public void setStatus(String s)
    {
        status = s;
    }

    public void setApproverID(String s)
    {
        approverID = s;
    }

    public void setCapacity(String s)
    {
        capacity = s;
    }

    public void setRequireApprove(String s)
    {
        requireApprove = s;
    }

    public void setDesc(String s)
    {
        desc = s;
    }

    public void setStaffName(String s)
    {
        staffName = s;
    }

    public void setResourceRecordID(String s)
    {
        resourceRecordID = s;
    }

    public String queryStaffName(String s)
    {
        String s1 = null;
        sql = " SELECT SM_STAFF_NAME\tFROM CMSADMIN.staff_main  WHERE  SM_STAFF_ID = '" + s + "'";
        try
        {
            pstmt = conn.prepareStatement(sql);
            rset = pstmt.executeQuery();
            if(rset != null)
            {
                if(rset.next())
                    s1 = rset.getString(1);
                rset.close();
                rset = null;
                pstmt.close();
                pstmt = null;
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        finally
        {
            try
            {
                rset.close();
                pstmt.close();
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public String queryResourceRecordID(String s)
    {
        String s1 = null;
        PreparedStatement preparedstatement = null;
        Object obj = null;
        String s2 = "SELECT MV_RESOURCE_REC_ID  FROM MEETING_VENUE,  WHERE MV_MTG_CODE = '" + s + "'";
        try
        {
            preparedstatement = conn.prepareStatement(s2);
            rset = preparedstatement.executeQuery();
            if(rset != null)
            {
                if(rset.next())
                    s1 = rset.getString(1);
                rset.close();
                rset = null;
                preparedstatement.close();
                preparedstatement = null;
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        finally
        {
            try
            {
                rset.close();
                preparedstatement.close();
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public String queryResourceSeq(String s)
    {
        String s1 = null;
        PreparedStatement preparedstatement = null;
        Object obj = null;
        String s2 = "SELECT re_resource_seq  FROM CMSADMIN.resource_main  WHERE re_kod_key = '" + s + "'";
        try
        {
            preparedstatement = conn.prepareStatement(s2);
            rset = preparedstatement.executeQuery();
            if(rset != null)
            {
                if(rset.next())
                    s1 = rset.getString(1);
                rset.close();
                rset = null;
                preparedstatement.close();
                preparedstatement = null;
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        finally
        {
            try
            {
                rset.close();
                preparedstatement.close();
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public boolean queryRoom(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT re_resource_seq, re_subsytm, re_kod_key, re_status, re_approver_id, \tre_capacity, re_owner, re_require_approve , re_desc  FROM CMSADMIN.resource_main  WHERE re_kod_key = '" + s + "'";
        try
        {
            pstmt = conn.prepareStatement(sql);
            rset = pstmt.executeQuery();
            if(rset != null)
            {
                if(rset.next())
                {
                    resourceSeq = rset.getString(1);
                    subsytm = rset.getString(2);
                    kodKey = rset.getString(3);
                    approverID = rset.getString(5);
                    capacity = rset.getString(6);
                    owner = rset.getString(7);
                    requireApprove = rset.getString(8);
                    desc = rset.getString(9);
                }
                rset.close();
                rset = null;
                pstmt.close();
                pstmt = null;
            } else
            {
                flag = false;
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();
        }
        return flag;
    }

    public boolean queryAvailableRoom()
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT re_resource_seq, re_subsytm, re_kod_key, re_status, re_approver_id, \tre_capacity, re_owner, re_require_approve , re_desc  FROM CMSADMIN.resource_main ";
        try
        {
            pstmt = conn.prepareStatement(sql);
            rset = pstmt.executeQuery();
            if(!rset.isBeforeFirst())
            {
                flag = false;
                if(rset != null)
                {
                    rset.close();
                    rset = null;
                    pstmt.close();
                    pstmt = null;
                }
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();
        }
        return flag;
    }

    public boolean nextAvailableRoom()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    resourceSeq = rset.getString(1);
                    subsytm = rset.getString(2);
                    kodKey = rset.getString(3);
                    approverID = rset.getString(5);
                    capacity = rset.getString(6);
                    owner = rset.getString(7);
                    requireApprove = rset.getString(8);
                    desc = rset.getString(9);
                } else
                {
                    rset.close();
                    rset = null;
                    pstmt.close();
                    pstmt = null;
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

    public boolean queryMtgVenue(String s)
    {
        boolean flag = false;
        errmsg = "";
        String s1 = " SELECT MV_MTG_CODE, MV_ROOM_CODE, MV_RESOURCE_REC_ID  RM_ROOM_CODE, RM_ROOM_DESC  FROM MEETING_VENUE, CMSADMIN.ROOM_MAIN  WHERE MV_MTG_CODE = '" + s + "'" + " AND RM_ROOM_CODE = MV_ROOM_CODE ";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(s1);
            if(rset.next())
            {
                roomCode = rset.getString(2);
                resourceRecordID = rset.getString(3);
                flag = true;
            }
            rset.close();
            if(flag)
            {
                String s2 = "SELECT rm_room_desc, rm_room_code  FROM CMSADMIN.room_main  WHERE rm_room_code = '" + roomCode + "' ";
                rset = stmt.executeQuery(s2);
                if(rset.next())
                {
                    desc = rset.getString(1);
                    roomCode = rset.getString(2);
                }
                rset.close();
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
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

    public boolean bookVenue()
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            resourceSeq = queryResourceSeq(roomCode);
            sql = " INSERT INTO meeting_venue( mv_mtg_code, mv_room_code, mv_resource_rec_id, mv_resource_seq)  VALUES( ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mtgCode);
            pstmt.setString(2, roomCode);
            pstmt.setString(3, resourceRecordID);
            pstmt.setString(4, resourceSeq);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i <= 0)
            {
                errmsg = "No new record is created.";
                flag = false;
            }
            if(flag)
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
                if(stmt != null)
                {
                    stmt.close();
                    stmt = null;
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

    public boolean cancelBooking(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "DELETE meeting_venue WHERE mv_mtg_code = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i <= 0)
            {
                errmsg = "No matched record is removed.";
                flag = false;
            }
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            flag = false;
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

    public boolean cancelBookingA(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        Object obj = null;
        try
        {
            String s2 = queryResourceRecordID(s);
            ResourceUtil resourceutil = new ResourceUtil();
            String s3 = resourceutil.cancelResource(s1, s2);
            if(s3.equals(""))
            {
                sql = "DELETE meeting_venue WHERE mv_mtg_code = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, s);
                int i = pstmt.executeUpdate();
                pstmt.close();
                if(i > 0)
                    flag = true;
            } else
            {
                flag = false;
            }
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            flag = false;
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

    public String queryRoomCode(String s)
    {
        String s1 = null;
        PreparedStatement preparedstatement = null;
        ResultSet resultset = null;
        sql = "SELECT MV_ROOM_CODE FROM  MEETING_VENUE  WHERE MV_MTG_CODE = '" + s + "'";
        try
        {
            preparedstatement = conn.prepareStatement(sql);
            resultset = preparedstatement.executeQuery();
            if(resultset != null)
            {
                if(resultset.next())
                    s1 = resultset.getString(1);
                resultset.close();
                resultset = null;
                preparedstatement.close();
                preparedstatement = null;
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        finally
        {
            try
            {
                resultset.close();
                preparedstatement.close();
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public String getErrorMessage()
    {
        return errmsg;
    }

    public String getSQL()
    {
        return sql;
    }

    public String getMtgCode()
    {
        return mtgCode;
    }

    public String getResourceSeq()
    {
        return resourceSeq;
    }

    public String getSubsytm()
    {
        return subsytm;
    }

    public String getKodKey()
    {
        return kodKey;
    }

    public String getStatus()
    {
        return status;
    }

    public String getApproverID()
    {
        return approverID;
    }

    public String getCapacity()
    {
        return capacity;
    }

    public String getOwner()
    {
        return owner;
    }

    public String getRequireApprove()
    {
        return requireApprove;
    }

    public String getDesc()
    {
        return desc;
    }

    public String getStaffName()
    {
        return staffName;
    }

    public String getRoomCode()
    {
        return roomCode;
    }

    public String getRoomDesc()
    {
        return roomDesc;
    }

    public String getRoomCapacity()
    {
        return roomCapacity;
    }

    public String getBldgCode()
    {
        return bldgCode;
    }

    public String getRoomBkgSeq()
    {
        return roomBkgSeq;
    }

    public String getResourceRecordID()
    {
        return resourceRecordID;
    }

}