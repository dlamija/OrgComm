package cms.admin.meeting.bean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import common.CommonFunction;

public class MeetingCategory implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String mtgCatCode = "";
	private String mtgCatDesc = "";
	private String mtgDeptCode = "";
	private String mtgDeptDesc = "";
	private String mtgStatus = "";
	private String mtgCreatedBy = "";
	private String mtgActive = "";
	private String staffName = "";
	
	protected Connection conn;
    protected String errmsg;
    protected PreparedStatement pstmt;
    protected Statement stmt;
    protected Statement stmt2;
    protected ResultSet rset;
    protected ResultSet rset2;
    protected String sql;

    public void setDBConnection(Connection connection) {
        conn = connection;
    }
    
    public String getMtgActive() {
		return mtgActive;
	}

	public void setMtgActive(String mtgActive) {
		this.mtgActive = mtgActive;
	}

	public String getStaffName() {
		return staffName;
	}

	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}

	public String getMtgCreatedBy() {
		return mtgCreatedBy;
	}

	public void setMtgCreatedBy(String mtgCreatedBy) {
		this.mtgCreatedBy = mtgCreatedBy;
	}

	public String getMtgDeptDesc() {
		return mtgDeptDesc;
	}

	public void setMtgDeptDesc(String mtgDeptDesc) {
		this.mtgDeptDesc = mtgDeptDesc;
	}
	
	public String getMtgCatCode() {
		return mtgCatCode;
	}

	public void setMtgCatCode(String mtgCatCode) {
		this.mtgCatCode = mtgCatCode;
	}

	public String getMtgCatDesc() {
		return mtgCatDesc;
	}

	public void setMtgCatDesc(String mtgCatDesc) {
		this.mtgCatDesc = mtgCatDesc;
	}

	public String getMtgDeptCode() {
		return mtgDeptCode;
	}

	public void setMtgDeptCode(String mtgDeptCode) {
		this.mtgDeptCode = mtgDeptCode;
	}

	public String getMtgStatus() {
		return mtgStatus;
	}

	public void setMtgStatus(String mtgStatus) {
		this.mtgStatus = mtgStatus;
	}

	public String getErrorMessage() {
        return errmsg;
    }

    public boolean queryMeetingCategoryInfo(String status,String staffID) {
        boolean flag = true;
        errmsg = "";

        StringBuilder sb = new StringBuilder("");
        if ("APPROVE".equals(status) || "ALL".equals(status)) {
	        sb.append("SELECT mc_category_code,mc_category_desc,mc_dept_code,mc_status,mc_active ");
	        sb.append("FROM meeting_category ");
	        sb.append("WHERE mc_active = 'Y' AND mc_status NOT IN ('REJECT','DELETED') ");
	        
	        if ("APPROVE".equals(status))
	        	sb.append("AND mc_status = 'APPROVE' ");
	        sb.append("AND (mc_apply_by = '" + staffID + "' OR EXISTS ");
	        sb.append("(SELECT 1 FROM meeting_members WHERE mm_member_mtgtype = mc_category_code AND mm_member_id = '" + staffID + "' )) ");
        }
        else if ("APPLY".equals(status)) {
	        sb.append("SELECT mc_category_code,mc_category_desc,mc_dept_code,mc_status,mc_active,sm_staff_name ");
	        sb.append("FROM meeting_category,CMSADMIN.staff_main ");
	        sb.append("WHERE mc_apply_by = sm_staff_id AND mc_status = 'APPLY' AND mc_active = 'Y' ");
	        sb.append("AND mc_apply_by = '" + staffID + "' ");
        }
        sb.append("ORDER BY mc_status DESC,mc_category_desc ");
        
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sb.toString());
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

    public boolean queryMeetingCategoryApproval() {
        boolean flag = true;
        errmsg = "";

        StringBuilder sb = new StringBuilder("");
        sb.append("SELECT mc_category_code,mc_category_desc,mc_dept_code,mc_status,mc_active,sm_staff_name ");
        sb.append("FROM meeting_category,CMSADMIN.staff_main ");
        sb.append("WHERE mc_apply_by = sm_staff_id AND mc_status = 'APPLY' AND mc_active = 'Y' ");
        sb.append("ORDER BY mc_status DESC,mc_category_desc ");
        
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sb.toString());
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

    public boolean nextMeetingCategoryInfo(String status)
    {
        boolean flag = true;
        try
        {
            if (rset != null) {
                if(rset.next()) {
                	mtgCatCode = rset.getString(1);
                	mtgCatDesc = rset.getString(2);
                	mtgDeptCode = rset.getString(3);
                	mtgDeptDesc = queryMeetingTypeDept(mtgDeptCode);
                	mtgStatus = rset.getString(4);
                	mtgActive = rset.getString(5);
                	if ("APPLY".equals(status))
                		staffName = rset.getString(6);
                } 
                else {
                    rset.close();
                    rset = null;
                    stmt.close();
                    stmt = null;
                    flag = false;
                }
            } 
            else {
                flag = false;
                errmsg = "Result Set is NULL.";
            }
        }
        catch(SQLException sqlexception) {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
            try
            {
                if(rset != null) {
                    rset.close();
                    rset = null;
                }
                if(stmt != null) {
                    stmt.close();
                    stmt = null;
                }
            }
            catch(Exception exception) {
                exception.printStackTrace();
            }
            flag = false;
        }
        return flag;
    }

    public String queryMeetingTypeDept(String s)
    {
        ResultSet resultset = null;
        String s1 = null;
        String s2 = "SELECT DM_DEPT_CODE, DM_DEPT_DESC FROM CMSADMIN.DEPARTMENT_MAIN  WHERE DM_DEPT_CODE = '" + s + "'";
        Statement statement = null;
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
                s1 = resultset.getString(2);
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

    public String queryMeetingDesc(String s)
    {
        ResultSet resultset = null;
        String s1 = null;
        String s2 = "SELECT MM_MTG_DESC FROM MEETING_MAIN WHERE MM_MTG_CODE = '" + s + "'";
        Statement statement = null;
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

    public boolean queryMeetingCategoryDesc(String s)
    {
        boolean flag = false;
        ResultSet resultset = null;
        String s2 = "SELECT mc_category_desc FROM meeting_category";
        try
        {
            Statement statement = conn.createStatement();
            resultset = statement.executeQuery(s2);
            if(!resultset.isBeforeFirst())
            {
                resultset.close();
                resultset = null;
                statement.close();
                statement = null;
                flag = true;
            } else
            {
                for(; resultset.next(); flag = true)
                {
                    String s1 = resultset.getString(1);
                    if(!s1.equalsIgnoreCase(s))
                        continue;
                    flag = false;
                    break;
                }

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
                stmt.close();
            }
            catch(Exception exception1) { }
        }
        return flag;
    }

    public boolean queryMeetingCatInfo(String catCode, String staffID)
    {
        boolean flag = false;
        errmsg = "";
        sql = "SELECT mc_category_code,mc_category_desc,mc_dept_code " +
        		"FROM meeting_category " +
        		"WHERE mc_category_code = '" + catCode + "' AND mc_apply_by = '" + staffID + "' AND mc_active = 'Y'";
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if (rset.next()) {
            	mtgCatCode = rset.getString(1);
            	mtgCatDesc = rset.getString(2);
            	mtgDeptCode = rset.getString(3);            	
               
                flag = true;
            }
        }
        catch(SQLException sqlexception) {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
        }
        finally {
            try {
                if (rset != null) rset.close();
                if (stmt != null) stmt.close();                  
            }
            catch(Exception e) { }
        }
        return flag;
    }

    public boolean addMeetingCategory()
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "SELECT 'MC' || lpad( mm_mtgtype_code.nextval, 9, '0' ) FROM dual";
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);
            if(rset.next())
                mtgCatCode = rset.getString(1);
            rset.close();
            stmt.close();
            if(mtgCatCode != null && mtgCatCode.length() > 0)
            {
                if(queryMeetingCategoryDesc(mtgCatDesc))
                {
                    sql = "INSERT INTO meeting_category(mc_category_code,mc_category_desc,mc_dept_code,mc_status,mc_apply_by, " +
                    		"mc_apply_date,mc_active) " +
                    		"VALUES( ? , ? , ? , ? , ? , sysdate, 'Y')";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, mtgCatCode);
                    pstmt.setString(2, mtgCatDesc);
                    pstmt.setString(3, mtgDeptCode);
                    pstmt.setString(4, "APPLY");
                    pstmt.setString(5, mtgCreatedBy);
                    int i = pstmt.executeUpdate();
                    pstmt.close();
                    if(i > 0) {
                        flag = true;
                        
                    }
                    else {
                        errmsg = "No new record is created.";
                        flag = false;
                    }
                    conn.commit();
                } 
                else {
                    errmsg = "The description is not unique";
                    flag = false;
                }
            } else
            {
                errmsg = "Fail to generate unique sequence number for the meeting type";
                flag = false;
            }
        }
        catch(SQLException sqlexception) {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();
            try {
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

    public boolean updateMeetingCategory(String catCode)
    {
        boolean flag = true;
        errmsg = "";

        sql = "UPDATE meeting_category SET mc_category_desc = ?, mc_dept_code = ? WHERE mc_category_code = ? ";
        try
        {
            if (queryMeetingCategoryDesc(mtgCatDesc))
            {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, mtgCatDesc);
                pstmt.setString(2, mtgDeptCode);                
                pstmt.setString(3, catCode);
                int i = pstmt.executeUpdate();
                pstmt.close();
                if(i > 0) {
                    flag = true;
                }
                else {
                    errmsg = "No matched record is updated.";
                    flag = false;
                }
                conn.commit();
            } 
            else {
                errmsg = "The description is not unique";
                flag = false;
            }
        }
        catch(SQLException sqlexception)
        {
            flag = false;
            sqlexception.printStackTrace();
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
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return flag;
    }

    public boolean updateAgendaTemplate(String s)
    {
        boolean flag = true;
        errmsg = "";
        sql = "UPDATE meeting_type  SET mt_mtgtype_agenda_template = null  WHERE mt_mtgtype_agenda_template = ? ";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, s.trim());
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
            {
                flag = true;
            } else
            {
                errmsg = "No matched record is updated.";
                flag = false;
            }
            conn.commit();
        }
        catch(SQLException sqlexception)
        {
            flag = false;
            sqlexception.printStackTrace();
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
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return flag;
    }

    public boolean removeMtgCategory(String catCode)
    {
        boolean flag = true;
        errmsg = "";
        try
        {
            sql = "DELETE meeting_category WHERE mc_category_code = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, catCode.trim());
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0) {
                flag = true;
            } 
            else {
                errmsg = "No matched record is removed.";
                flag = false;
            }
        }
        catch(SQLException sqlexception) {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();            
        }
        finally {
            try {
            	if (rset != null) rset.close();
                if (pstmt != null) pstmt.close();
            }
            catch(Exception e) { }
        }
        return flag;
    }

    public int countMeetingCategory(String status,String staffID)
    {
        int i = 0;
        errmsg = "";
        StringBuilder sb = new StringBuilder("SELECT count(1) FROM meeting_category ");
        sb.append("WHERE mc_active = 'Y' AND mc_status NOT IN ('REJECT','DELETED') AND (mc_apply_by = '" + staffID + "' OR EXISTS ");
        sb.append("(SELECT 1 FROM meeting_members WHERE mm_member_mtgtype = mc_category_code AND mm_member_id = '" + staffID + "' )) ");
        
        if ("APPROVE".equals(status))
        	sb.append("AND mc_status = 'APPROVE' ");
        else if ("APPLY".equals(status))
        	sb.append("AND mc_status = 'APPLY' ");
        
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sb.toString());
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
            i = 0;
        }
        return i;
    }

    public int countMeetingCategoryApproval()
    {
        int i = 0;
        errmsg = "";
        StringBuilder sb = new StringBuilder("SELECT count(1) FROM meeting_category ");
        sb.append("WHERE mc_active = 'Y' AND mc_status = 'APPLY' ");
        
        try
        {
            stmt = conn.createStatement();
            rset = stmt.executeQuery(sb.toString());
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
            i = 0;
        }
        return i;
    }

    public boolean updateMeetingCategoryStatus(String catCode, String status, String staffID, String userID)
    {
        boolean flag = true;
        errmsg = "";

        sql = "UPDATE meeting_category SET mc_status = ?,mc_approve_by = ?,mc_approve_date = sysdate WHERE mc_category_code = ? ";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setString(2, staffID);
            pstmt.setString(3, catCode);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
                flag = true;
            else {
                errmsg = "No matched record is updated.";
                flag = false;
            }
            
            if ("APPROVE".equals(status)) { //if approved, send memo to staff
            	String msgBody = "Please take note that your Meeting Category application has been approved.";
            	memoNotification(userID, msgBody, catCode);
            }
        }
        catch(SQLException sqlexception) {
            flag = false;
            sqlexception.printStackTrace();
        }
        finally {
            try {
                if (rset != null) rset.close();                   
                if (pstmt != null) pstmt.close();                
            }
            catch(Exception e) { }
        }
        return flag;
    }

    public void memoNotification(String memoFrom, String msgBody, String catCode)
    {
  		PreparedStatement pstmt1 = null;
    	ResultSet rset1 = null;
  		String receiverID = "";
  		Object[] memoTo = new Object[1];
  		
  		StringBuilder sb = new StringBuilder("");
  		sb.append("SELECT userid FROM cmsusers_view,meeting_category ");
  		sb.append("WHERE cmsid = mc_apply_by AND mc_category_code = ?");
  		
  		try {
  			pstmt1 = conn.prepareStatement(sb.toString());
  			pstmt1.setString(1, catCode);
     	 	rset1 = pstmt1.executeQuery();
   
     		if (rset1.isBeforeFirst()) {
     			if (rset1.next())   			
  	   				receiverID = rset1.getString("userid");
     		}
  			rset1.close();
  			pstmt1.close();
  			
  			if (receiverID != null && !receiverID.equals("")) {
  				memoTo[0] = receiverID;
  				CommonFunction.sendMemo(conn, memoTo, memoFrom, msgBody, CommonFunction.getDate("yyyy-MM-dd HH:mm:ss"), "FYI", 
  		    		"Meeting Category has been approved.", "Y"); //send official memo
  			}
  		}
  		catch (Exception e) {
     		e.printStackTrace();
  		}
    }

    public boolean inactiveMeetingCategory(String catCode)
    {
        boolean flag = true;
        errmsg = "";

        sql = "UPDATE meeting_category SET mc_active = 'N' WHERE mc_category_code = ? ";
        try
        {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, catCode);
            int i = pstmt.executeUpdate();
            pstmt.close();
            if(i > 0)
                flag = true;
            else {
                errmsg = "No matched record is updated.";
                flag = false;
            }
        }
        catch(SQLException sqlexception) {
            flag = false;
            sqlexception.printStackTrace();
        }
        finally {
            try {
                if (rset != null) rset.close();                   
                if (pstmt != null) pstmt.close();                
            }
            catch(Exception e) { }
        }
        return flag;
    }
    
    public boolean isCreator(String catCode, String staffID) {
        boolean recExist = false;
        PreparedStatement pstmt1 = null;
        ResultSet rset1 = null;
        StringBuilder sb = new StringBuilder("");
        sb.append("SELECT count(1) FROM meeting_category ");
        sb.append("WHERE mc_category_code = ? AND mc_apply_by = ? ");
        
        try
        {
            pstmt1 = conn.prepareStatement(sb.toString());
            pstmt1.setString(1, catCode);
            pstmt1.setString(2, staffID);
            rset1 = pstmt1.executeQuery();
            
            if (rset1.isBeforeFirst()) {
                if (rset1.next())
                	if (rset1.getInt(1) > 0) recExist = true;
            }
        }
        catch(SQLException sqle) {
        	sqle.printStackTrace();
        }
        finally {
        	try {
	        	if (rset1 != null) rset1.close();
	        	if (pstmt1 != null) pstmt1.close();
        	}
        	catch (Exception e) { }
        }
        return recExist;
    }

    public boolean isMeetingHighCommittee(String catCode, String staffID) {
        boolean recExist = false;
        PreparedStatement pstmt1 = null;
        ResultSet rset1 = null;

        StringBuilder sb = new StringBuilder("");
        sb.append("SELECT count(1) FROM meeting_category,meeting_members ");
        sb.append("WHERE mc_category_code = mm_member_mtgtype AND mc_category_code = ? ");
        sb.append("AND mm_member_id = ? AND mm_position IN ('MR0001','MR0002','MR0008')");
        
        try
        {
            pstmt1 = conn.prepareStatement(sb.toString());
            pstmt1.setString(1, catCode);
            pstmt1.setString(2, staffID);
            rset1 = pstmt1.executeQuery();
            
            if (rset1.isBeforeFirst()) {
                if (rset1.next())
                	if (rset1.getInt(1) > 0) recExist = true;
            }
        }
        catch(SQLException sqle) {
        	sqle.printStackTrace();
        }
        finally {
        	try {
	        	if (rset1 != null) rset1.close();
	        	if (pstmt1 != null) pstmt1.close();
        	}
        	catch (Exception e) { }
        }        
        return recExist;
    }

}