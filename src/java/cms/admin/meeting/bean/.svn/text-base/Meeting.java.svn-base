package cms.admin.meeting.bean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import common.CommonFunction;

public class Meeting implements Serializable
{
    protected String mtgCode;
    protected String mtgDesc;
    protected String mtgDate;
    protected String mtgStartTime;
    protected String mtgEndTime;
    protected String mtgType;
    protected String mtgStatus;
    protected String mtgOwner;
    protected String mtgKeyInBy;
    protected String mtgDateKeyIn;
    protected String mtgVenue;
    protected String mtgArchive;
    protected String mtgApprovedBy;
    protected String mtgRef;
    protected String mtgFileName;
    protected String mtgOriFileName;
    protected String mtgGroup;
    protected String mtgAgenda;
    protected Connection conn;
    protected String sql;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected ResultSet rset;

    public void setMtgDesc(String s)
    {
        mtgDesc = s;
    }

    public void setMtgDate(String s)
    {
        mtgDate = s;
    }

    
    public String getMtgGroup() {
		return mtgGroup;
	}

	public void setMtgGroup(String mtgGroup) {
		this.mtgGroup = mtgGroup;
	}

	
	public String getMtgAgenda() {
		return mtgAgenda;
	}

	public void setMtgAgenda(String mtgAgenda) {
		this.mtgAgenda = mtgAgenda;
	}

	public void setMtgStartTime(String s)
    {
        mtgStartTime = s;
    }

    public void setMtgEndTime(String s)
    {
        mtgEndTime = s;
    }

    public void setMtgType(String s)
    {
        mtgType = s;
    }

    public void setMtgStatus(String s)
    {
        mtgStatus = s;
    }

    public void setMtgOwner(String s)
    {
        mtgOwner = s;
    }

    public void setMtgKeyInBy(String s)
    {
        mtgKeyInBy = s;
    }

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public void setMtgVenue(String s)
    {
        mtgVenue = s;
    }

    public void setMtgRef(String s)
    {
        mtgRef = s;
    }

    public void setMtgArchive(String s)
    {
        if(s == null)
            mtgArchive = "NO";
        else
            mtgArchive = "YES";
    }

    public boolean queryMeeting2(String s)
    {
        boolean flag = true;
        sql = "SELECT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME, MM_MTG_STATUS, MM_MTG_TYPE, " +
        		"MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE FROM MEETING_MAIN WHERE MM_MTG_CODE = '" + s + "'";
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

    public boolean nextMeeting2()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    mtgCode = rset.getString(1);
                    mtgDesc = rset.getString(2);
                    String s = rset.getString(3).substring(0, 10);
                    mtgDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s);
                    mtgStartTime = rset.getString(4);
                    mtgEndTime = rset.getString(5);
                    mtgStatus = rset.getString(6);
                    mtgType = rset.getString(7);
                    mtgRef = rset.getString(8);
                    mtgArchive = rset.getString(9);
                    mtgVenue = queryMeetingVenue(mtgCode);
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

    public int countMeeting(String s, String s1, String s2)
    {
        int i = 0;
        errmsg = "";
        String s3 = "";
        if(s2.equals("view"))
            s3 = " AND MM_MTG_ARCHIVE IS NULL";
        else
            s3 = " AND MM_MTG_ARCHIVE IS NOT NULL";
        if(s1.equals("STAFF"))
            sql = " SELECT COUNT(1)  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE  WHERE MA_STAFF_ID = '" + s + "'" + s3;
        else
            sql = "SELECT COUNT(1)  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE_OTHER MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE  WHERE  MA.MA_USER_ID = '" + s + "'" + s3;
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
                i = rset.getInt(1);
            rset.close();
            rset = null;
            stmt.close();
            stmt = null;
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        return i;
    }

    public int countMeetingByGroup(String loginID, String s1, String s2, String meetingGrp)
    {
        int i = 0;
        errmsg = "";
        String sqlAppend = "";
        if(s2.equals("view"))
        	sqlAppend = " AND MM_MTG_ARCHIVE IS NULL";
        else
        	sqlAppend = " AND MM_MTG_ARCHIVE IS NOT NULL";
        
        if (s1.equals("STAFF"))
            sql = " SELECT COUNT(1) FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_MEMBERS MA ON MA.MM_MEMBER_MTGTYPE = MM.MM_MTG_TYPE " +
            		"WHERE MA.MM_MEMBER_ID = '" + loginID + "' AND MM_MTG_TYPE = '" + meetingGrp + "'" + sqlAppend;
        else
            sql = "SELECT COUNT(1) FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_MEMBERS MA ON MA.MM_MEMBER_MTGTYPE = MM.MM_MTG_CODE " +
            		"WHERE MA.MM_MEMBER_ID = '" + loginID + "' AND MM_MTG_TYPE = '" + meetingGrp + "'" + sqlAppend;
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
                i = rset.getInt(1);
            rset.close();
            rset = null;
            stmt.close();
            stmt = null;
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        return i;
    }
    
    public int countSenateMeeting(String s, String s1)
    {
        int i = 0;
        errmsg = "";
        String s2 = "";
        boolean flag = isSenateMember(s1);
        if(s.equals("view"))
            s2 = " AND MM_MTG_ARCHIVE IS NULL";
        else
            s2 = " AND MM_MTG_ARCHIVE IS NOT NULL";
        if(!flag)
            sql = "SELECT COUNT(1) FROM MEETING_MAIN MM, MEETING_ATTENDANCE MA WHERE MM_MTG_CODE = MA_MTG_CODE AND MM_MTG_TYPE = 'M000000241' AND MA_STAFF_ID = '" + s1 + "' " + "AND MA_ATTD_POSITION IN ('MR0005','MR0007','MR0004') " + s2;
        else
            sql = "SELECT COUNT(1) FROM MEETING_MAIN MM WHERE MM_MTG_TYPE = 'M000000241' " + s2;
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
                i = rset.getInt(1);
            rset.close();
            rset = null;
            stmt.close();
            stmt = null;
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        return i;
    }
/*
    public int countSearchMeeting(String s, String s1, String s2, String s3, String s4, String s5, String s6)
    {
        int i = 0;
        errmsg = "";
        String s7 = "";
        String s8 = "";
        if(s3.equals("0"))
            s7 = " AND (UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + s2 + "%') OR " + " UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + s2 + "%') OR" + " UPPER(MD.MD_DECISION) LIKE UPPER('%" + s2 + "%') OR" + " UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + s2 + "%')) ";
        else
        if(s3.equals("1"))
            s7 = "AND UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("2"))
            s7 = "AND UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("3"))
            s7 = "AND UPPER(MD.MD_DECISION) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("4"))
            s7 = "AND UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + s2 + "%')";
        if(s6 != null && !s6.equals("0"))
            s8 = " AND UPPER(MM.MM_MTG_OWNER) = '" + s6 + "'";
        if(!s4.equals("") && !s5.equals(""))
            s7 = s7 + " AND MM_MTG_DATE BETWEEN TO_DATE('" + s4 + "','DD/MM/YYYY') AND TO_DATE('" + s5 + "','DD/MM/YYYY')";
        if(s1.equals("STAFF"))
            sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_STAFF_ID  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE =MM.MM_MTG_CODE  WHERE MA_STAFF_ID = '" + s + "'" + s7 + s8;
        else
            sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_USER_ID  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE_OTHER MA ON MA.MA_MTG_CODE=MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE =MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE =MM.MM_MTG_CODE  WHERE MA_USER_ID = '" + s + "'" + s7 + s8;
        try
        {
            stmt = conn.createStatement();
            for(rset = stmt.executeQuery(sql); rset.next();)
                i++;

            rset.close();
            rset = null;
            stmt.close();
            stmt = null;
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        return i;
    }
*/
    public int countSearchMeeting(String s, String userType, String keyword, String searchBy, String mtgGroup, int sDay, 
    		String sMth, int sYear, String decCat, String mtgNo)
    {
        int i = 0;
        errmsg = "";
        String sqlAppend = "";
        String s8 = "";
        /*if (searchBy.equals("0"))
        	sqlAppend = " AND (UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + keyword + "%') " + 
	            		"OR UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + keyword + "%') " + 
	            		"OR UPPER(MD.MD_DECISION) LIKE UPPER('%" + keyword + "%') " + 
	            		"OR UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + keyword + "%')) "; */
        if(searchBy.equals("1"))
        	sqlAppend = "AND UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + keyword + "%') ";
        else if(searchBy.equals("2"))
        	sqlAppend = "AND UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + keyword + "%') ";
        else if(searchBy.equals("3"))
        	sqlAppend = "AND UPPER(MD.MD_DECISION) LIKE UPPER('%" + keyword + "%') ";
        else if(searchBy.equals("4"))
        	sqlAppend = "AND UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + keyword + "%') ";
        else if(searchBy.equals("5"))
        	sqlAppend = "AND UPPER(MAC.MAA_ORIGINAL_FILE_NAME) LIKE UPPER('%" + keyword + "%') ";
        
        if (mtgGroup != null && !mtgGroup.equals("0"))
            s8 = " AND UPPER(MM.MM_MTG_TYPE) = '" + mtgGroup + "'";
        
        if (sDay > 0)
        	sqlAppend += " AND to_char(MM.MM_MTG_DATE,'d') = '" + sDay + "' ";
        
        if (sMth != null && !sMth.equals("0"))
        	sqlAppend += " AND to_char(MM.MM_MTG_DATE,'mm') = '" + sMth + "' ";
        
        if (sYear > 0)
        	sqlAppend += " AND to_char(MM.MM_MTG_DATE,'yyyy') = '" + sYear + "' ";
        
        if (decCat != null && !decCat.equals("0"))
        	sqlAppend += " AND MD_DECISION_CATEGORY = '" + decCat + "' ";
        
        if (mtgNo != null && !mtgNo.trim().equals(""))
        	sqlAppend += " AND MM_MTG_TYPE_SEQNO = " + mtgNo + " ";
        	
        if (searchBy != null && searchBy.equals("5")) //search by filename
            sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, " +
            		"MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MMR.MM_MEMBER_ID, MAA_PHYSICAL_FILE_NAME, " +
            		"MAA_ORIGINAL_FILE_NAME " +
            		"FROM MEETING_MAIN MM " +
            		//"LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_MEMBERS MMR ON MMR.MM_MEMBER_MTGTYPE = MM.MM_MTG_TYPE " +
            		"LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_AGENDA_ATTC MAC ON MAC.MAA_AGENDA_SEQ = MAG.MA_AGENDA_SEQ " +
            		"WHERE MM_MTG_TYPE <> 'M000000241' AND SUBSTR(MM_MTG_TYPE,1,2) = 'MC' AND MMR.MM_MEMBER_ID = '" + s + "'" + sqlAppend + s8;
        else
            sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, " +
            		"MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MMR.MM_MEMBER_ID " +
            		"FROM MEETING_MAIN MM " +
            		//"LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_MEMBERS MMR ON MMR.MM_MEMBER_MTGTYPE = MM.MM_MTG_TYPE " +
            		"LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE = MM.MM_MTG_CODE " +
            		"WHERE MM_MTG_TYPE <> 'M000000241' AND SUBSTR(MM_MTG_TYPE,1,2) = 'MC' AND MMR.MM_MEMBER_ID = '" + s + "'" + sqlAppend + s8;
        
	    try
        {
            stmt = conn.createStatement();
            for(rset = stmt.executeQuery(sql); rset.next();)
                i++;

            rset.close();
            rset = null;
            stmt.close();
            stmt = null;
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        return i;
    }

    public int countSearchSenateMeeting(String s, String s1, String s2, String s3, String s4, String s5, String s6)
    {
        int i = 0;
        errmsg = "";
        String s7 = "";
        String s8 = "";
        if(s3.equals("0"))
            s7 = " AND (UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + s2 + "%') OR " + " UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + s2 + "%') OR" + " UPPER(MD.MD_DECISION) LIKE UPPER('%" + s2 + "%') OR" + " UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + s2 + "%')) ";
        else
        if(s3.equals("1"))
            s7 = "AND UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("2"))
            s7 = "AND UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("3"))
            s7 = "AND UPPER(MD.MD_DECISION) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("4"))
            s7 = "AND UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("5"))
            s7 = "AND UPPER(MAC.MAA_ORIGINAL_FILE_NAME) LIKE UPPER('%" + s2 + "%')";
        if(s6 != null && !s6.equals("0"))
            s8 = " AND UPPER(MM.MM_MTG_OWNER) = '" + s6 + "'";
        if(!s4.equals("") && !s5.equals(""))
            s7 = s7 + " AND MM_MTG_DATE BETWEEN TO_DATE('" + s4 + "','DD/MM/YYYY') AND TO_DATE('" + s5 + "','DD/MM/YYYY')";
        if(s1.equals("STAFF"))
        {
            if(s3 != null && s3.equals("5"))
                sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_STAFF_ID, MAA_PHYSICAL_FILE_NAME, MAA_ORIGINAL_FILE_NAME  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE = MM.MM_MTG_CODE  LEFT OUTER JOIN MEETING_AGENDA_ATTC MAC ON MAC.MAA_AGENDA_SEQ = MAG.MA_AGENDA_SEQ  WHERE MM_MTG_TYPE = 'M000000241'  AND MA_STAFF_ID = '" + s + "'" + s7 + s8;
            else
                sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_STAFF_ID  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE = MM.MM_MTG_CODE  WHERE MM_MTG_TYPE = 'M000000241'  AND MA_STAFF_ID = '" + s + "'" + s7 + s8;
        } else
        if(s3 != null && s3.equals("5"))
            sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_USER_ID, MAA_PHYSICAL_FILE_NAME, MAA_ORIGINAL_FILE_NAME  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE_OTHER MA ON MA.MA_MTG_CODE=MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE =MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE =MM.MM_MTG_CODE  LEFT OUTER JOIN MEETING_AGENDA_ATTC MAC ON MAC.MAA_AGENDA_SEQ = MAG.MA_AGENDA_SEQ  WHERE MM_MTG_TYPE = 'M000000241'  AND MA_USER_ID = '" + s + "'" + s7 + s8;
        else
            sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_USER_ID  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE_OTHER MA ON MA.MA_MTG_CODE=MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE =MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE =MM.MM_MTG_CODE  WHERE MM_MTG_TYPE = 'M000000241'  AND MA_USER_ID = '" + s + "'" + s7 + s8;
        try
        {
            stmt = conn.createStatement();
            for(rset = stmt.executeQuery(sql); rset.next();)
                i++;

            rset.close();
            rset = null;
            stmt.close();
            stmt = null;
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        return i;
    }

    public boolean queryMeetingAll(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        if(s1.equals("STAFF"))
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME, MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_STAFF_ID  FROM MEETING_MAIN, MEETING_ATTENDANCE\t WHERE MM_MTG_CODE = MA_MTG_CODE  AND MA_STAFF_ID = '" + s + "'" + " ORDER BY MM_MTG_DATE DESC";
        else
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME, MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_USER_ID  FROM MEETING_MAIN, MEETING_ATTENDANCE_OTHER  WHERE MM_MTG_CODE = MA_MTG_CODE  AND MA_USER_ID = '" + s + "'" + " ORDER BY MM_MTG_DATE DESC";
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

    public boolean queryMeeting(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        if(s1.equals("STAFF"))
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,  MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_STAFF_ID  FROM MEETING_MAIN, MEETING_ATTENDANCE\t WHERE MM_MTG_CODE = MA_MTG_CODE  AND MA_STAFF_ID = '" + s + "' AND MM_MTG_ARCHIVE IS NULL" + " AND MM_MTG_TYPE <> 'M000000241' " + " ORDER BY MM_MTG_DATE DESC";
        else
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,  MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_USER_ID  FROM MEETING_MAIN, MEETING_ATTENDANCE_OTHER  WHERE MM_MTG_CODE = MA_MTG_CODE  AND MA_USER_ID = '" + s + "' AND MM_MTG_ARCHIVE IS NULL" + " AND MM_MTG_TYPE <> 'M000000241' " + " ORDER BY MM_MTG_DATE DESC";
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

    public boolean queryMeetingGroup(String s, String s1, String mtgGrp)
    {
        boolean flag = true;
        errmsg = "";
        
        if (s1.equals("STAFF"))
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME, MM_MTG_STATUS, " +
            		"MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MM_MEMBER_ID " +
            		"FROM MEETING_MAIN, MEETING_MEMBERS " +
            		"WHERE MM_MTG_TYPE = MM_MEMBER_MTGTYPE " +
            		"AND MM_MEMBER_ID = '" + s + "' AND MM_MTG_ARCHIVE IS NULL" + " AND MM_MTG_TYPE = '" + mtgGrp + "' " + 
            		"ORDER BY MM_MTG_DATE DESC";
        else
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME, MM_MTG_STATUS, " +
            		"MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MM_MEMBER_ID " +
            		"FROM MEETING_MAIN, MEETING_MEMBERS " +
            		"WHERE MM_MTG_TYPE = MM_MEMBER_MTGTYPE AND MM_MEMBER_ID = '" + s + "' " +
            		"AND MM_MTG_ARCHIVE IS NULL" + " AND MM_MTG_TYPE = '" + mtgGrp + "' " + 
            		"ORDER BY MM_MTG_DATE DESC";
        
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

    public boolean querySenateMeeting(String s)
    {
        boolean flag = true;
        errmsg = "";
        boolean flag1 = isSenateMember(s);
        if(!flag1)
            sql = "SELECT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,  MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE FROM MEETING_MAIN, MEETING_ATTENDANCE\t WHERE MM_MTG_CODE = MA_MTG_CODE  AND MM_MTG_TYPE = 'M000000241' AND MM_MTG_ARCHIVE IS NULL  AND MA_ATTD_POSITION IN ('MR0005','MR0007','MR0004')  AND MA_STAFF_ID = '" + s + "' " + " ORDER BY MM_MTG_DATE DESC";
        else
            sql = "SELECT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,  MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE FROM MEETING_MAIN\t WHERE MM_MTG_TYPE = 'M000000241' AND MM_MTG_ARCHIVE IS NULL ORDER BY MM_MTG_DATE DESC";
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

    public boolean queryArchiveMeeting(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        if(s1.equals("STAFF"))
            sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME, MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE,  MA_MTG_CODE, MA_STAFF_ID  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE  WHERE MA_STAFF_ID = '" + s + "' AND MM_MTG_ARCHIVE IS NOT NULL " + " AND MM_MTG_TYPE <> 'M000000241' ";
        else
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME, MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE,  MA_MTG_CODE, MA_USER_ID  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE_OTHER MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE  WHERE MA_USER_ID = '" + s + "' AND MM_MTG_ARCHIVE IS NOT NULL " + " AND MM_MTG_TYPE <> 'M000000241' ";
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

    public boolean queryArchiveMeetingGroup(String s, String s1, String mtgGrp)
    {
        boolean flag = true;
        errmsg = "";
        
        if (s1.equals("STAFF"))
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME, MM_MTG_STATUS, " +
            		"MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE, MA_MTG_CODE, MA_STAFF_ID " +
            		"FROM MEETING_MAIN MM " +
            		"LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE = MM.MM_MTG_CODE " +
            		"WHERE MA_STAFF_ID = '" + s + "' AND MM_MTG_ARCHIVE IS NOT NULL " + 
            		"AND MM_MTG_TYPE = '" + mtgGrp + "' ";
        else
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME, MM_MTG_STATUS, " +
            		"MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE, MA_MTG_CODE, MA_USER_ID " +
            		"FROM MEETING_MAIN MM " +
            		"LEFT OUTER JOIN MEETING_ATTENDANCE_OTHER MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE " +
            		"WHERE MA_USER_ID = '" + s + "' AND MM_MTG_ARCHIVE IS NOT NULL " + 
            		"AND MM_MTG_TYPE = '" + mtgGrp + "' ";
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

    public boolean queryAllSenateMeeting(String s)
    {
        boolean flag = true;
        errmsg = "";
        boolean flag1 = isSenateMember(s);
        if(!flag1)
            sql = "SELECT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,  MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE FROM MEETING_MAIN, MEETING_ATTENDANCE\t WHERE MM_MTG_CODE = MA_MTG_CODE  AND MM_MTG_TYPE = 'M000000241' AND MA_ATTD_POSITION IN ('MR0005','MR0007','MR0004')  AND MA_STAFF_ID = '" + s + "' " + " ORDER BY MM_MTG_DATE DESC";
        else
            sql = "SELECT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,  MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE FROM MEETING_MAIN\t WHERE MM_MTG_TYPE = 'M000000241' ORDER BY MM_MTG_DATE DESC";
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

    public boolean querySenateArchiveMeeting(String s)
    {
        boolean flag = true;
        errmsg = "";
        boolean flag1 = isSenateMember(s);
        if(!flag1)
            sql = " SELECT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,  MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE FROM MEETING_MAIN MM, MEETING_ATTENDANCE MA  WHERE MM_MTG_CODE = MA_MTG_CODE  AND MM_MTG_TYPE = 'M000000241' AND MM_MTG_ARCHIVE IS NOT NULL  AND MA_ATTD_POSITION IN ('MR0005','MR0007','MR0004')  AND MA_STAFF_ID = '" + s + "' " + " ORDER BY MM_MTG_DATE DESC";
        else
            sql = " SELECT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,  MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE FROM MEETING_MAIN MM  WHERE MM_MTG_TYPE = 'M000000241' AND MM_MTG_ARCHIVE IS NOT NULL  ORDER BY MM_MTG_DATE DESC";
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

    public boolean searchMeeting(String myID, String userType, String keyword, String searchBy, String mtgGroup, int sDay, 
    		String sMth, int sYear, String decCat, String mtgNo)
    {
    	boolean flag = true;
        int i = 0;
        errmsg = "";
        String sqlAppend = "";
        String s8 = "";
       /* if (searchBy.equals("0"))
        	sqlAppend = " AND (UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + keyword + "%') " + 
	            		"OR UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + keyword + "%') " + 
	            		"OR UPPER(MD.MD_DECISION) LIKE UPPER('%" + keyword + "%') " + 
	            		"OR UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + keyword + "%')) "; */
        if(searchBy.equals("1"))
        	sqlAppend = "AND UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + keyword + "%') ";
        else if(searchBy.equals("2"))
        	sqlAppend = "AND UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + keyword + "%') ";
        else if(searchBy.equals("3"))
        	sqlAppend = "AND UPPER(MD.MD_DECISION) LIKE UPPER('%" + keyword + "%') ";
        else if(searchBy.equals("4"))
        	sqlAppend = "AND UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + keyword + "%') ";
        else if(searchBy.equals("5"))
        	sqlAppend = "AND UPPER(MAC.MAA_ORIGINAL_FILE_NAME) LIKE UPPER('%" + keyword + "%') ";
        
        if (mtgGroup != null && !mtgGroup.equals("0"))
            s8 = " AND UPPER(MM.MM_MTG_TYPE) = '" + mtgGroup + "'";
        
        if (sDay > 0)
        	sqlAppend += " AND to_char(MM.MM_MTG_DATE,'dd') = '" + sDay + "' ";
        
        if (sMth != null && !sMth.equals("0"))
        	sqlAppend += " AND to_char(MM.MM_MTG_DATE,'mm') = '" + sMth + "' ";
        
        if (sYear > 0)
        	sqlAppend += " AND to_char(MM.MM_MTG_DATE,'yyyy') = '" + sYear + "' ";
        
        if (decCat != null && !decCat.equals("0"))
        	sqlAppend += " AND MD_DECISION_CATEGORY = '" + decCat + "' ";

        if (mtgNo != null && !mtgNo.trim().equals(""))
        	sqlAppend += " AND MM_MTG_TYPE_SEQNO = " + mtgNo + " ";

        if (searchBy != null && searchBy.equals("5")) //search by filename
            sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, " +
            		"MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MMR.MM_MEMBER_ID, MAA_PHYSICAL_FILE_NAME, " +
            		"MAA_ORIGINAL_FILE_NAME,MC_CATEGORY_DESC,MA_AGENDA_DESC " +
            		"FROM MEETING_MAIN MM " +
            		//"LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_MEMBERS MMR ON MMR.MM_MEMBER_MTGTYPE = MM.MM_MTG_TYPE " +
            		"LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_AGENDA_ATTC MAC ON MAC.MAA_AGENDA_SEQ = MAG.MA_AGENDA_SEQ " +
            		"LEFT OUTER JOIN MEETING_CATEGORY MC ON MC.MC_CATEGORY_CODE = MM.MM_MTG_TYPE " +
            		"WHERE MM_MTG_TYPE <> 'M000000241' AND SUBSTR(MM_MTG_TYPE,1,2) = 'MC' AND MMR.MM_MEMBER_ID = '" + myID + "'" + sqlAppend + s8;
        else
            sql = " SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, " +
            		"MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MMR.MM_MEMBER_ID,MC_CATEGORY_DESC " +
            		"FROM MEETING_MAIN MM " +
            		//"LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_MEMBERS MMR ON MMR.MM_MEMBER_MTGTYPE = MM.MM_MTG_TYPE " +
            		"LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE = MM.MM_MTG_CODE " +
            		"LEFT OUTER JOIN MEETING_CATEGORY MC ON MC.MC_CATEGORY_CODE = MM.MM_MTG_TYPE " +
            		"WHERE MM_MTG_TYPE <> 'M000000241' AND SUBSTR(MM_MTG_TYPE,1,2) = 'MC' AND MMR.MM_MEMBER_ID = '" + myID + "'" + sqlAppend + s8;

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

    public boolean searchSenateMeeting(String s, String s1, String s2, String s3, String s4, String s5, String s6)
    {
        boolean flag = true;
        errmsg = "";
        String s7 = "";
        String s8 = "";
        if(s3.equals("0"))
            s7 = " AND (UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + s2 + "%') OR " + " UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + s2 + "%') OR" + " UPPER(MD.MD_DECISION) LIKE UPPER('%" + s2 + "%') OR" + " UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + s2 + "%')) ";
        else
        if(s3.equals("1"))
            s7 = "AND UPPER(MM.MM_MTG_DESC) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("2"))
            s7 = "AND UPPER(MAG.MA_AGENDA_DESC) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("3"))
            s7 = "AND UPPER(MD.MD_DECISION) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("4"))
            s7 = "AND UPPER(MDA.MDA_ACTION_DESC) LIKE UPPER('%" + s2 + "%')";
        else
        if(s3.equals("5"))
            s7 = "AND UPPER(MAC.MAA_ORIGINAL_FILE_NAME) LIKE UPPER('%" + s2 + "%')";
        if(s6 != null && !s6.equals("0"))
            s8 = " AND UPPER(MM.MM_MTG_OWNER) = '" + s6 + "'";
        if(!s4.equals("") && !s5.equals(""))
            s7 = s7 + " AND MM_MTG_DATE BETWEEN TO_DATE('" + s4 + "','DD/MM/YYYY') AND TO_DATE('" + s5 + "','DD/MM/YYYY')";
        if(s1.equals("STAFF"))
        {
            if(s3 != null && s3.equals("5"))
                sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_STAFF_ID,MAA_PHYSICAL_FILE_NAME, MAA_ORIGINAL_FILE_NAME  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE =MM.MM_MTG_CODE  LEFT OUTER JOIN MEETING_AGENDA_ATTC MAC ON MAC.MAA_AGENDA_SEQ = MAG.MA_AGENDA_SEQ  WHERE MM_MTG_TYPE = 'M000000241'  AND MA_STAFF_ID = '" + s + "'" + s7 + s8 + " ORDER BY MM_MTG_DATE DESC";
            else
                sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_STAFF_ID  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE MA ON MA.MA_MTG_CODE= MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE =MM.MM_MTG_CODE  WHERE MM_MTG_TYPE = 'M000000241'  AND MA_STAFF_ID = '" + s + "'" + s7 + s8 + " ORDER BY MM_MTG_DATE DESC";
        } else
        if(s3 != null && s3.equals("5"))
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_USER_ID,MAA_PHYSICAL_FILE_NAME, MAA_ORIGINAL_FILE_NAME  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE_OTHER MA ON MA.MA_MTG_CODE=MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE =MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE =MM.MM_MTG_CODE  LEFT OUTER JOIN MEETING_AGENDA_ATTC MAC ON MAC.MAA_AGENDA_SEQ = MAG.MA_AGENDA_SEQ  WHERE MM_MTG_CODE = 'M000000241'  AND MA_USER_ID = '" + s + "'" + s7 + s8 + " ORDER BY MM_MTG_DATE DESC";
        else
            sql = "SELECT DISTINCT MM_MTG_CODE, MM_MTG_DESC, MM_MTG_DATE, MM_MTG_STARTTIME, MM_MTG_ENDTIME,MM_MTG_STATUS, MM_MTG_TYPE, MM_MTG_TYPE_SEQNO, MM_MTG_ARCHIVE MA_MTG_CODE, MA_USER_ID  FROM MEETING_MAIN MM LEFT OUTER JOIN MEETING_ATTENDANCE_OTHER MA ON MA.MA_MTG_CODE=MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_AGENDA MAG ON MAG.MA_MTG_CODE =MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DECISION MD ON MD.MD_MTG_CODE = MM.MM_MTG_CODE LEFT OUTER JOIN MEETING_DEC_ACTION MDA ON MDA.MDA_MTG_CODE =MM.MM_MTG_CODE  WHERE MM_MTG_CODE = 'M000000241'  AND MA_USER_ID = '" + s + "'" + s7 + s8 + " ORDER BY MM_MTG_DATE DESC";
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

    public boolean nextMeeting(String s)
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    mtgCode = rset.getString(1);
                    mtgDesc = rset.getString(2);
                    String s1 = rset.getString(3).substring(0, 10);
                    mtgDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s1);
                    mtgStartTime = rset.getString(4);
                    mtgEndTime = rset.getString(5);
                    mtgStatus = rset.getString(6);
                    mtgType = rset.getString(7);
                    mtgRef = rset.getString(8);
                    mtgArchive = rset.getString(9);
                    mtgVenue = queryMeetingVenue(mtgCode);
                    if(s != null && s.equals("5"))
                    {
                        mtgFileName = rset.getString(11);
                        mtgOriFileName = rset.getString(12);
                        mtgAgenda = rset.getString("MA_AGENDA_DESC");
                    }
                    mtgGroup = rset.getString("MC_CATEGORY_DESC");
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

    public boolean nextMeeting()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    mtgCode = rset.getString(1);
                    mtgDesc = rset.getString(2);
                    String s1 = rset.getString(3).substring(0, 10);
                    mtgDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s1);
                    mtgStartTime = rset.getString(4);
                    mtgEndTime = rset.getString(5);
                    mtgStatus = rset.getString(6);
                    mtgType = rset.getString(7);
                    mtgRef = rset.getString(8);
                    mtgArchive = rset.getString(9);
                    mtgVenue = queryMeetingVenue(mtgCode);
                    
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

    public boolean nextSenateMeeting(String s)
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    mtgCode = rset.getString(1);
                    mtgDesc = rset.getString(2);
                    String s1 = rset.getString(3).substring(0, 10);
                    mtgDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s1);
                    mtgStartTime = rset.getString(4);
                    mtgEndTime = rset.getString(5);
                    mtgStatus = rset.getString(6);
                    mtgType = rset.getString(7);
                    mtgRef = rset.getString(8);
                    mtgArchive = rset.getString(9);
                    mtgVenue = queryMeetingVenue(mtgCode);
                    if(s != null && s.equals("5"))
                    {
                        mtgFileName = rset.getString(11);
                        mtgOriFileName = rset.getString(12);
                    }
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

    public boolean queryPreviousMeeting(String s, String s1, String s2)
    {
        boolean flag = true;
        errmsg = "";
        if(s2 == null)
            s2 = "-1";
        sql = "SELECT MM_MTG_CODE, MM_MTG_DESC , MM_MTG_TYPE_SEQNO  FROM MEETING_MAIN  WHERE MM_MTG_TYPE = '" + s + "'" + " AND MM_MTG_CODE <> '" + s1 + "'" + " AND MM_MTG_TYPE_SEQNO < '" + s2 + "'" + " ORDER BY MM_MTG_TYPE_SEQNO ";
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

    public boolean nextPreviousMeeting()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    mtgCode = rset.getString(1);
                    mtgDesc = rset.getString(2);
                    mtgRef = rset.getString(3);
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

    public String queryMeetingVenue(String s)
    {
        ResultSet resultset = null;
        Statement statement = null;
        String s1 = null;
        String s2 = " SELECT MV_MTG_CODE, MV_ROOM_CODE,  RM_ROOM_CODE, RM_ROOM_DESC  FROM MEETING_VENUE, CMSADMIN.ROOM_MAIN  WHERE MV_MTG_CODE = '" + s + "'" + " AND RM_ROOM_CODE = MV_ROOM_CODE ";
        try
        {
            statement = conn.createStatement();
            resultset = statement.executeQuery(s2);
            if(!resultset.isBeforeFirst())
            {
                resultset.close();
                resultset = null;
                statement.close();
                statement = null;
            } else
            if(resultset.next())
                s1 = resultset.getString(4);
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
                resultset = null;
                statement.close();
                statement = null;
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public boolean queryMeetingList(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "SELECT mm_mtg_code, substr( mm_mtg_desc, 1, 30 ), to_char( mm_mtg_date, 'DD-MM-YYYY' ), mm_mtg_status, mm_mtg_type_seqno FROM meeting_main WHERE mm_mtg_owner = '" + s + "' " + "AND nvl( mm_mtg_archive, 'N' ) <> 'Y' ORDER BY mm_mtg_date DESC";
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

    public boolean nextMeetingList()
    {
        boolean flag = true;
        try
        {
            if(rset != null)
            {
                if(rset.next())
                {
                    mtgCode = rset.getString(1);
                    mtgDesc = rset.getString(2);
                    String s = rset.getString(3).substring(0, 10);
                    mtgDate = CommonFunction.getDate("yyyy-mm-dd", "dd-mm-yyyy", s);
                    mtgStatus = rset.getString(4);
                    mtgRef = rset.getString(5);
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

    public boolean queryMeetingInfo(String s)
    {
        boolean flag = false;
        errmsg = "";
        sql = "SELECT mm_mtg_code, mm_mtg_desc, to_char( mm_mtg_date, 'DD-MM-YYYY' ), to_char( mm_mtg_starttime, 'HH24:MI' ), to_char( mm_mtg_endtime, 'HH24:MI' ), mm_mtg_type, mm_mtg_status, mm_mtg_owner, mm_mtg_keyinby, to_char( mm_mtg_datekeyin, 'HH24:MI DD-MM-YYYY' ), mm_mtg_archive, mm_mtg_approvedby, mm_mtg_type_seqno FROM meeting_main WHERE mm_mtg_code = '" + s + "'";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
            {
                s = rset.getString(1);
                mtgDesc = rset.getString(2);
                mtgDate = rset.getString(3);
                mtgStartTime = rset.getString(4);
                mtgEndTime = rset.getString(5);
                mtgType = rset.getString(6);
                mtgStatus = rset.getString(7);
                mtgOwner = rset.getString(8);
                mtgKeyInBy = rset.getString(9);
                mtgDateKeyIn = rset.getString(10);
                mtgArchive = rset.getString(11);
                mtgApprovedBy = rset.getString(12);
                mtgRef = rset.getString(13);
                flag = true;
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
            catch(Exception exception1)
            {
                exception1.printStackTrace();
            }
        }
        return flag;
    }

    public boolean addMeeting()
    {
        boolean flag = true;
        errmsg = "";
        String s = null;
        try
        {
            sql = "SELECT 1 FROM dual WHERE to_date( ?, 'HH24:MI' ) >= to_date( ?, 'HH24:MI' ) ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mtgEndTime);
            pstmt.setString(2, mtgStartTime);
            rset = pstmt.executeQuery();
            if(!rset.next())
            {
                errmsg = "End time should be after start time.";
                flag = false;
            }
            rset.close();
            rset = null;
            pstmt.close();
            if(!flag)
            {
                boolean flag1 = false;
                boolean flag3 = flag1;
                boolean flag4 = flag3;
                return flag4;
            }
            sql = "SELECT 'M' || lpad( mm_mtg_code.nextval, 9, '0' ) FROM dual";
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
                mtgCode = rset.getString(1);
            rset.close();
            rset = null;
            stmt.close();
            boolean flag2 = true;
            if(mtgType != null && mtgCode.length() > 0)
            {
                sql = "SELECT MAX (mm_mtg_type_seqno) maxID FROM meeting_main WHERE mm_mtg_type = '" + mtgType + "'";
                stmt = conn.createStatement();
                rset = stmt.executeQuery(sql);
                if(rset.next())
                {
                    int i = rset.getInt("maxID");
                    int k = i + 1;
                    s = "" + k;
                }
                rset.close();
                rset = null;
                stmt.close();
            }
            if(mtgCode != null && mtgCode.length() > 0)
            {
                sql = "INSERT INTO meeting_main( mm_mtg_code, mm_mtg_desc, mm_mtg_date, mm_mtg_starttime, mm_mtg_endtime, mm_mtg_type, mm_mtg_status, mm_mtg_owner, mm_mtg_keyinby, mm_mtg_datekeyin, mm_mtg_type_seqno ) VALUES( ?, ?, to_date( ?, 'DD-MM-YYYY' ), to_date( ?, 'HH24:MI' ), to_date( ?, 'HH24:MI' ), ?, ?, ?, ?, sysdate, ? )";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, mtgCode);
                pstmt.setString(2, mtgDesc);
                pstmt.setString(3, mtgDate);
                pstmt.setString(4, mtgStartTime);
                pstmt.setString(5, mtgEndTime);
                pstmt.setString(6, mtgType);
                pstmt.setString(7, mtgStatus);
                pstmt.setString(8, mtgOwner);
                pstmt.setString(9, mtgKeyInBy);
                if(mtgType != null)
                    pstmt.setString(10, s);
                else
                    pstmt.setString(10, mtgRef);
                int j = pstmt.executeUpdate();
                pstmt.close();
                if(j > 0)
                {
                    MeetingAttendance meetingattendance = new MeetingAttendance();
                    meetingattendance.setStaffId(mtgKeyInBy);
                    meetingattendance.setDBConnection(conn);
                    String s1 = "MR0002";
                    if(mtgCode != null && mtgType != null && mtgType.length() > 0)
                    {
                        if(!populateMeetingAttendance())
                        {
                            errmsg = "Fail to add meeting member as meeting attendee";
                            flag = false;
                        } else
                        {
                            flag = true;
                        }
                        String s2 = hasAgendaTemplate(mtgType.trim());
                        if(s2 != null)
                        {
                            String s3 = s2;
                            String s4 = mtgCode;
                            MeetingAgenda meetingagenda = new MeetingAgenda();
                            meetingagenda.setDBConnection(conn);
                            meetingagenda.copyMtgAgendaMain(s3.trim(), s4.trim());
                        }
                    }
                } else
                {
                    errmsg = "No new record is created.";
                    flag = false;
                }
                conn.commit();
            } else
            {
                errmsg = "Fail to generate unique sequence number for the meeting.";
                flag = false;
            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();
            System.out.println("debug errmsg" + errmsg);
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
            catch(Exception exception2) { }
        }
        return flag;
    }

    public boolean updMeetingInfo(String s)
    {
        boolean flag = false;
        errmsg = "";
        String s1 = null;
        boolean flag1 = true;
        Object obj = null;
        try
        {
            sql = "SELECT mm_mtg_type FROM meeting_main WHERE mm_mtg_code = '" + s + "'";
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
                s1 = rset.getString(1);
            rset.close();
            rset = null;
            stmt.close();
            sql = "SELECT MAX (mm_mtg_type_seqno) maxID FROM meeting_main WHERE mm_mtg_type = '" + mtgType + "'";
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            String s2;
            if(rset.next())
            {
                int i = rset.getInt("maxID");
                int k = i + 1;
                s2 = "" + k;
            } else
            {
                s2 = mtgRef;
            }
            rset.close();
            rset = null;
            stmt.close();
            sql = "UPDATE meeting_main SET mm_mtg_desc = ?, mm_mtg_date = to_date( ?, 'DD-MM-YYYY' ), mm_mtg_starttime = to_date( ?, 'HH24:MI' ), mm_mtg_endtime = to_date( ?, 'HH24:MI' ), mm_mtg_type = ?, mm_mtg_status = ? , mm_mtg_type_seqno = ?  WHERE mm_mtg_code = ? AND mm_mtg_owner = ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mtgDesc);
            pstmt.setString(2, mtgDate);
            pstmt.setString(3, mtgStartTime);
            pstmt.setString(4, mtgEndTime);
            pstmt.setString(5, mtgType);
            pstmt.setString(6, mtgStatus);
            if(mtgType != null)
                pstmt.setString(7, s2);
            else
                pstmt.setString(7, mtgRef);
            pstmt.setString(8, s);
            pstmt.setString(9, mtgOwner);
            int j = pstmt.executeUpdate();
            pstmt.close();
            if(j > 0)
            {
                flag = true;
                if(mtgType != null && mtgType.length() != 0 && s1 != null && s1.compareTo(mtgType) != 0)
                    populateMeetingAttendance();
                if(!hasAgenda(s) && mtgType != null)
                {
                    String s3 = hasAgendaTemplate(mtgType.trim());
                    if(s3 != null)
                    {
                        String s4 = s3;
                        String s5 = s;
                        MeetingAgenda meetingagenda = new MeetingAgenda();
                        meetingagenda.setDBConnection(conn);
                        meetingagenda.copyMtgAgendaMain(s4.trim(), s5.trim());
                    }
                }
            } else
            {
                errmsg = "No matched record is updated.";
            }
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
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

    protected boolean populateMeetingAttendance()
        throws SQLException
    {
        boolean flag = false;
        try
        {
            sql = "SELECT mm_member_id, mm_position, mm_remark FROM meeting_members " +
            		"WHERE mm_member_mtgtype = '" + mtgType + "'" + 
            		"AND NOT EXISTS( " + "SELECT 1 FROM meeting_attendance WHERE ma_mtg_code = '" + mtgCode + "'" + 
            		"AND ma_staff_id = mm_member_id ) ";
            
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            sql = "INSERT INTO meeting_attendance( ma_attd_seq, ma_mtg_code, ma_staff_id, ma_attd_position, ma_attd_remark ) SELECT ma_attd_seq.nextval, ?, ?, ?, ? FROM dual ";
            pstmt = conn.prepareStatement(sql);
            for(; rset.next(); pstmt.executeUpdate())
            {
                pstmt.setString(1, mtgCode);
                pstmt.setString(2, rset.getString(1));
                pstmt.setString(3, rset.getString(2));
                pstmt.setString(4, rset.getString(3));
            }

            flag = true;
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
            flag = false;
        }
        finally
        {
            try
            {
                rset.close();
                rset = null;
                stmt.close();
            }
            catch(Exception exception2) { }
        }
        return flag;
    }

    public String getMeetingTypeDesc(String s)
    {
        ResultSet resultset = null;
        Statement statement = null;
        String s1 = null;
        String s2 = "SELECT MT_MTGTYPE FROM MEETING_TYPE WHERE MT_MTGTYPE_CODE = '" + s + "'";
        try
        {
            statement = conn.createStatement();
            resultset = statement.executeQuery(s2);
            if(!resultset.isBeforeFirst())
            {
                resultset.close();
                resultset = null;
                statement.close();
                statement = null;
            } else
            if(resultset.next())
                s1 = resultset.getString(1);
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
                statement.close();
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public String getMeetingCategoryDesc(String grpCode)
    {
        ResultSet resultset = null;
        Statement statement = null;
        String s1 = null;
        String s2 = "SELECT MC_CATEGORY_DESC FROM MEETING_CATEGORY WHERE MC_CATEGORY_CODE = '" + grpCode + "'";
        try
        {
            statement = conn.createStatement();
            resultset = statement.executeQuery(s2);
            if(!resultset.isBeforeFirst())
            {
                resultset.close();
                resultset = null;
                statement.close();
                statement = null;
            } else
            if(resultset.next())
                s1 = resultset.getString(1);
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
                statement.close();
            }
            catch(Exception exception1) { }
        }
        return s1;
    }

    public boolean removeMeeting(String s)
    {
        boolean flag = true;
        boolean flag1 = true;
        errmsg = "";
        if(isAgendaTemplate(s.trim()))
        {
            MeetingType meetingtype = new MeetingType();
            meetingtype.setDBConnection(conn);
            if(meetingtype.updateAgendaTemplate(s))
            {
                System.out.println("here");
                flag1 = true;
            } else
            {
                flag1 = false;
            }
        }
        if(flag1)
        {
            sql = "DELETE MEETING_MAIN WHERE MM_MTG_CODE = ?";
            try
            {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, s.trim());
                int i = pstmt.executeUpdate();
                pstmt.close();
                if(i > 0)
                    flag = true;
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
                catch(Exception exception2) { }
            }
        }
        return flag;
    }

    public boolean archiveMeeting(String s)
    {
        boolean flag = false;
        errmsg = "";
        try
        {
            sql = "UPDATE meeting_main SET mm_mtg_archive = ? WHERE mm_mtg_code = ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Y");
            pstmt.setString(2, s.trim());
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
                flag = true;
            else
                errmsg = "No matched record is updated.";
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
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
            catch(Exception exception2) { }
        }
        return flag;
    }

    public String hasAgendaTemplate(String s)
    {
        Statement statement = null;
        ResultSet resultset = null;
        String s1 = null;
        try
        {
            sql = "SELECT MT_MTGTYPE_AGENDA_TEMPLATE FROM MEETING_TYPE WHERE MT_MTGTYPE_CODE = '" + s + "'";
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset.next())
                s1 = resultset.getString(1);
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
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
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return s1;
    }

    public boolean hasAgenda(String s)
    {
        Statement statement = null;
        ResultSet resultset = null;
        boolean flag = false;
        try
        {
            sql = "SELECT * FROM MEETING_AGENDA WHERE MA_MTG_CODE = '" + s + "'";
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset.next())
                flag = true;
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
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
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return flag;
    }

    public boolean isAgendaTemplate(String s)
    {
        Statement statement = null;
        ResultSet resultset = null;
        boolean flag = false;
        try
        {
            sql = "SELECT MT_MTGTYPE_AGENDA_TEMPLATE FROM MEETING_TYPE WHERE MT_MTGTYPE_AGENDA_TEMPLATE = '" + s + "'";
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset.next())
                flag = true;
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
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
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return flag;
    }

    public boolean isSenateMember(String s)
    {
        boolean flag = false;
        sql = "SELECT count(1) FROM meeting_members WHERE mm_member_mtgtype = 'M000000241' AND mm_member_id = '" + s + "'";
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

    public boolean isSenateAdmin(String s)
    {
        boolean flag = false;
        sql = "SELECT count(1) FROM meeting_members WHERE mm_member_mtgtype = 'M000000241' AND mm_member_id = '" + s + "' " + "AND mm_position in ('MR0001','MR0002','MR0008')";
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

    public boolean isMeetingSecretariat(String s)
    {
        boolean flag = false;
        sql = "SELECT count(1) FROM meeting_members WHERE mm_member_mtgtype = 'M000000141' AND mm_member_id = '" + s + "' " + "AND mm_position in ('MR0001','MR0002','MR0008')";
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

    public boolean isSenateAttendee(String s)
    {
        boolean flag = false;
        sql = "SELECT count(1) FROM meeting_attendance,meeting_main WHERE ma_mtg_code = mm_mtg_code AND mm_mtg_type = 'M000000241' AND ma_attd_position in('MR0005','MR0007','MR0004') AND ma_staff_id = '" + s + "'";
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

    public String getMtgFileName()
    {
        return mtgFileName;
    }

    public String getMtgOriFileName()
    {
        return mtgOriFileName;
    }

    public String getMtgDesc()
    {
        return mtgDesc;
    }

    public String getMtgDate()
    {
        return mtgDate;
    }

    public String getMtgStartTime()
    {
        return mtgStartTime;
    }

    public String getMtgEndTime()
    {
        return mtgEndTime;
    }

    public String getMtgType()
    {
        return mtgType;
    }

    public String getMtgStatus()
    {
        return mtgStatus;
    }

    public String getMtgOwner()
    {
        return mtgOwner;
    }

    public String getMtgKeyInBy()
    {
        return mtgKeyInBy;
    }

    public String getMtgDateKeyIn()
    {
        return mtgDateKeyIn;
    }

    public String getMtgArchive()
    {
        return mtgArchive;
    }

    public String getMtgApprovedBy()
    {
        return mtgApprovedBy;
    }

    public String getMtgVenue()
    {
        return mtgVenue;
    }

    public String getMtgRef()
    {
        return mtgRef;
    }
}