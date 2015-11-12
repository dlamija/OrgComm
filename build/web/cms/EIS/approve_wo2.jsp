<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>


<jsp:useBean id="work" class="cms.staff.WorkOrderBean" scope="request" />

<%
	Connection conn = null;
	String sid= (String)session.getAttribute("staffid");
	String action = request.getParameter("action");
	float total;
	String body = null;
	String travel_id ="";
	String travel_range ="";
	String destination ="";
	String trans ="";
	String transdetl = "";
	String reason ="";
	String accompany ="";
	String vehicle ="";
	int sts = 0;

	try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
	}
	catch( Exception e )
	{ 
		out.println (e.toString()); 
	}
%>

<%
if (conn != null && request.getParameter("laction") != null 
	    && request.getParameterValues("approve") != null )
	{
	String approve [] = request.getParameterValues("approve");
	String work_id [] = request.getParameterValues ("work_id");
	String sql = "UPDATE WORK_ORDER_HEAD SET WOH_STATUS = 'APPROVE', WOH_APPROVE_DATE = SYSDATE, WOH_APPROVE_BY = ? "+
	             "WHERE WOH_WORKORDER_ID = ? ";
				 
	for (int a=0; a<approve.length; a++)
		{
		try
			{
			PreparedStatement pstmt = conn.prepareStatement (sql);
		        pstmt.setString (1, sid);
				pstmt.setString (2, approve[a]);
			int rc=pstmt.executeUpdate();
			if (rc>0)
				{ out.println("Approving workorder Ref ID "+ approve[a] +"... Done."); }
			else 
				{ out.println("Approving workorder Ref ID "+ approve[a] +"... Fail."); }
			pstmt.close ();
			}
		catch (SQLException e)
			{ out.println ("Error : " + e.toString ()); }
		}
	}
//conn.close ();<br>
%>

<%
if (conn != null && request.getParameter("laction") != null 
	    && request.getParameterValues("approve") != null )
	{
	String approve []  = request.getParameterValues("approve");
	String work_id [] = request.getParameterValues ("work_id");
	String sql = "UPDATE STAFF_TRAVEL_REQUEST SET STR_STATUS = 'APPROVE', STR_APPROVE_DATE = SYSDATE, STR_APPROVE_BY = ? "+
	             "WHERE STR_WORKORDER_ID = ? ";
				 
	for (int a=0; a<approve.length; a++)
		{
		try
			{
			PreparedStatement pstmt = conn.prepareStatement (sql);
		        pstmt.setString (1, sid);
				pstmt.setString (2, approve[a]);
			int rc=pstmt.executeUpdate();
			if (rc>0)
				{ out.println("Approving travel request  ... Done."); }
			else 
				{ out.println("Approving travel request  ... Fail."); }
			pstmt.close ();
			}
		catch (SQLException e)
			{ out.println ("Error : " + e.toString ()); }
		}
	}
//conn.close ();
%>

<!------------------------ memo from approver to applicant ------------------------>

<% if (conn !=null && request.getParameter("laction") != null 
	    && request.getParameterValues("approve") != null)
	{

		String approve [] = request.getParameterValues("approve");
		String work_id [] = request.getParameterValues ("work_id");

		String sql = "{? = call cmsadmin.workorder.APPROVE(?, ?) }";
		for (int a=0; a<approve.length; a++)
		{
			try
			{

			CallableStatement cs = conn.prepareCall(sql);
			cs.registerOutParameter(1, Types.NUMERIC);
			cs.setString(2, sid);
			cs.setString(3, approve[a]);
			//cs.setString(4, leave_year);
			cs.execute();
			sts = cs.getInt(1);

				if (sts == 1) //submit approve is successful
				{
				out.println("Memo Sent" + "<br>");
				}
				else //submit checkin reason
				{
				out.println("Memo Fail To Sent!" + "<br>");
				}
				cs.close();
			}

				catch (SQLException e)
				{out.println("Error : " + e.toString());}
		}
	}

%>

<!------------------------memo from approver to assign staff------------------------>

<% if (conn !=null && request.getParameter("laction") != null && request.getParameterValues("approve") != null)
	{

		String approve [] = request.getParameterValues("approve");
		String work_id [] = request.getParameterValues ("work_id");
		//String staffid [] = request.getParameterValues ("wod_staff_id");

		String sql = "{? = call cmsadmin.workorder.ASSIGN_STAFF(?, ?) }";
		for (int a=0; a<approve.length; a++)
		{
			try
			{

			CallableStatement cs = conn.prepareCall(sql);
			cs.registerOutParameter(1, Types.NUMERIC);
			cs.setString(2, sid);
			cs.setString(3, approve[a]);
			//cs.setString(4, staffid[a]);
			cs.execute();
			sts = cs.getInt(1);

				if (sts == 1) //submit approve is successful
				{
				out.println("Memo Sent to assign staff Work Id " +  approve[a] + " Done!");
				}
				else //submit checkin reason
				{
				out.println("Memo Fail To Sent!" + "<br>");
				}
				cs.close();
			}

				catch (SQLException e)
				{out.println("Error : " + e.toString());}
		}
	}

%>




<TABLE width="100%" border=0 CELLPADDING="3" CELLSPACING="1">
	<TR>
	<TD CLASS="contentBgColor" align="center"><B>Workorder and Traveling Request Approval</B></TD>
	</TR>
<form action="../workorder/workorderMain.jsp?action=approve" method="post">
    <tr>
      <td CLASS="contentBgColor" align="right"><b>Month</b> &nbsp;
      <select name="month2" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">
<%
	if (conn!=null)
	{
		String sql2 = null;
		
			sql2	= "SELECT DISTINCT TO_CHAR (WOH_ENTER_DATE,'MM/YYYY') WOH_ENTER_DATE, TO_CHAR (WOH_ENTER_DATE,'MONTH YYYY') " +
				      "FROM WORK_ORDER_HEAD " +
				      "WHERE WOH_STATUS  = 'ENTRY' " +
				      "AND WOH_APPROVE_BY = ? " +
				      "ORDER BY TO_DATE (WOH_ENTER_DATE,'MM/YYYY') DESC ";

		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql2);
			pstmt.setString (1, session.getAttribute("staffid").toString());
			ResultSet rset = pstmt.executeQuery ();
			while (rset.next ())
			{
				if (request.getParameter("month2")!=null && request.getParameter("month2").compareTo(rset.getString(1))==0)
				{ 
%>
		          <option value="<%=rset.getString(1)%>" selected><%=rset.getString(2)%></option>
<% 
				}
				else
				{ 
%>
        		  <option value="<%=rset.getString(1)%>"><%=rset.getString(2)%></option>
<% 	
				}
		}
		pstmt.close ();
		rset.close ();
		}
		catch( Exception e )
		{ 
			out.println (e.toString()); 
		}
	}
%>
        </select>
        &nbsp; <input name="Go" type="submit" id="Go" value="Go"></td>
    </tr>

</form>

<form action="../workorder/workorderMain.jsp?action=approve&action=save" method="post">

<%
	if (conn != null)
	{
		String sql = null;
		
		if (request.getParameter("month2")!=null)
			 sql  = "SELECT WOH_WORKORDER_ID, TO_CHAR(WOH_ENTER_DATE,'DD/MM/YYYY'), NVL(WOH_DESC,' '),  " +
					"NVL(TO_CHAR(WOH_DATE_FROM,'DD/MM/YYYY'),' '), NVL(TO_CHAR(WOH_DATE_TO,'DD/MM/YYYY'),' ') " +
					"FROM WORK_ORDER_HEAD " +
					"WHERE WOH_APPROVE_BY = ?"+
					"AND WOH_STATUS = 'ENTRY' " +
					"AND TO_CHAR(WOH_ENTER_DATE,'MM/YYYY') = ? " +
					"ORDER BY WOH_WORKORDER_ID DESC ";
		else
			 sql  = "SELECT WOH_WORKORDER_ID, TO_CHAR(WOH_ENTER_DATE,'DD/MM/YYYY'), NVL(WOH_DESC,' '),  " +
					"NVL(TO_CHAR(WOH_DATE_FROM,'DD/MM/YYYY'),' '), NVL(TO_CHAR(WOH_DATE_TO,'DD/MM/YYYY'),' ') " +
					"FROM WORK_ORDER_HEAD " +
					"WHERE WOH_APPROVE_BY = ?"+
					"AND WOH_STATUS = 'ENTRY' " +
					"AND TO_CHAR(WOH_ENTER_DATE,'MM/YYYY') = TO_CHAR(SYSDATE,'MM/YYYY') " +
					"ORDER BY WOH_WORKORDER_ID DESC ";
		
			try
			{
				PreparedStatement pstmt = conn.prepareStatement(sql);
				//pstmt.setString (1, session.getAttribute("deptcode").toString());
				if (request.getParameter("month2")!=null)
				{
				pstmt.setString (1, session.getAttribute("staffid").toString());
				pstmt.setString (2, request.getParameter("month2"));
				} else {
				pstmt.setString (1, session.getAttribute("staffid").toString());
				//pstmt.setString (2, session.getAttribute("staffid").toString());
				}
				ResultSet rset = pstmt.executeQuery ();
%>
				<%
				if (rset.isBeforeFirst ())
				{
%>
<TR>
	<TD class="contentBgColor" align="center">
 <table width="100%" border="1" cellspacing="1" cellpadding="3">
        	<tr> 
          <td CLASS="contentBgColor"  align="center" width="6%">
		    <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><B>Ref ID</B></font>
		  </td>
          <td CLASS="contentBgColor"  align="center" width="12%">
		    <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><B>Date</b></font>
		  </td>
          <td CLASS="contentBgColor"  align="center" width="55%">
		    <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><B>Description</b></font>
		  </td>
          <td CLASS="contentBgColor"  align="center" width="15%">
		    <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><B>Date From</b></font>
		  </td>
          <td CLASS="contentBgColor"  align="center"width="9%">
		    <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><B>Date To</b></font>
		  </td>
          <td CLASS="contentBgColor"  align="center" width="3%">
		    <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><B>Approve</b></font>
		  </td>
        </tr>
<%				
				while (rset.next ())
				{
%>
        <tr> 
          <td class="contentBgColorAlternate" align="center">
		  <!--a href="workorderMain.jsp?action=approve&ref_id=<!%=rset.getString(1)%>"><!%=rset.getString(1)%></a>
          <a href="cms/workorder/viewdetail.jsp?ref_id=<!%=rset.getString(1)%>" target = "_blank" onMouseOver="window.status='View';return true;"><!%=rset.getString(1)%></a-->
		  <!--a href="javascript:void(window.open('cms/workorder/viewdetail.jsp?ref_id=<%=rset.getString(1)%>','view', 'height=600,width=600,menubar=no,toolbar=no,scrollbars=yes'))">
		  <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong><%=rset.getString(1)%></strong></font></a-->
		  <a href="javascript:void(window.open('cms/workorder/viewdetailhod.jsp?ref_id=<%=rset.getString(1)%>','view', 'height=500,width=600,menubar=no,toolbar=no,scrollbars=yes'))">
		  <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong><%=rset.getString(1)%></strong></font></a>
		  <input name="work_id" type="hidden" value="<%=rset.getString(1)%>"></td>
          <td class="contentBgColorAlternate"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=rset.getString(2)%></font></td>
          <td class="contentBgColorAlternate"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><b><%=rset.getString(3)%></b></font></td>
          <td class="contentBgColorAlternate"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=rset.getString(4)%></font></td>
          <td class="contentBgColorAlternate"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=rset.getString(5)%></font></td>
          <td class="contentBgColorAlternate">
		  <input name="approve" type="checkbox" id="approve" value="<%=rset.getString(1)%>"></td>
        </tr>
        <tr> 
          <td colspan="2" align="center" class="contentBgColorAlternate" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">
		  Assigned Staff :</td>
          <td colspan="4" align="left" class="contentBgColorAlternate" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">
				<%
					String sql2 = "SELECT WOD_STAFF_ID,SM_STAFF_NAME " +
		   						  "FROM WORK_ORDER_DETL,STAFF_MAIN " +
								  "WHERE SM_STAFF_ID = WOD_STAFF_ID " +
								  "AND WOD_WORKORDER_ID = ? " +
								  "ORDER BY WOD_STAFF_ID";
					PreparedStatement pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString (1, rset.getString(1));
					ResultSet rset2 = pstmt2.executeQuery ();
					
					
					
					while (rset2.next())
						{ 
				%>
            <table width="100%" border="0" cellpadding="3" cellspacing="0">
              <tr> 
                <td><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=rset2.getString(2)%></font></td>
              </tr>
            </table>
					<!--<input name="wod_staff_id" type="hidden" value="<!%=rset2.getString(1)%>">--->
				<% 						
						
						}
						
					rset2.close ();
					pstmt2.close ();
				%>		  
		  </td>
        </tr>

<%
				}
%>
</table>
</tr></td>			
				<TR>
				<TD class="contentBgColorAlternate" align="right" colspan="6">
				 <input name="Approve" type="submit" value="Approve">
				</TD>
				</TR>

<%
				}
				else
				{ 
%>
<tr><td>
			<table width="100%" border="1" cellspacing="1" cellpadding="3">		
			<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
		    <TD CLASS="contentBgColorAlternate" ALIGN="CENTER" colspan="6" ><B>
			No work order waiting for your approval</B>
			</TD>
			</TR>
		    </table>
</tr></td>
<% 		
				}				
			rset.close ();
			pstmt.close ();
		}		
		catch (SQLException e)
		{ 
			out.println ("Error! : " + e.toString ());  
		}
	}
%>
</form>						
</TD>
</TR>
</TABLE>


<%	
	try
	{
		conn.close ();
	}
	catch(Exception e)
	{
		System.out.println("Error(cms/workorder/approve.jsp): " + e.toString());
	}
	
%>
	
<% conn.close(); %>