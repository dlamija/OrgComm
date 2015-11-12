<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>


<jsp:useBean id="work" class="cms.staff.WorkOrderBean" scope="request" />
<TABLE width="100%" border=0 CELLSPACING="1" CELLPADDING="3">

<%
	Connection conn = null;
	float total;
	String body = null;
	String travel_range ="";
	String destination ="";
	String trans ="";
	String reason ="";
	String accompany ="";
	String vehicle ="";

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

	if (conn != null && request.getParameter("laction") != null && request.getParameterValues ("approve")!=null)
	{
		work.setDBConnection (conn);
		String approve [] = request.getParameterValues ("approve");
		String work_id [] = request.getParameterValues ("work_id");
		for (int a=0;a<approve.length;a++)
		{
			//if (approve[a]!=null && approve[a].compareTo("Y")==0)
			{
				if (work.ApproveWork (session.getAttribute("staffid").toString(), Integer.parseInt(approve[a])))
				{
				//Send email
                int approveStatus = 0;
				work.memoWorkorderApprove (Integer.parseInt(approve[a]),request,approveStatus);
%>
				<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
		       <TD CLASS="contentBgColorAlternate" ALIGN="MIDDLE" ><B><font color="#FF0000">
		       Approving work order Ref ID <%=approve[a]%> ... OK</font></B>
		      </TD>
		     </TR>
<% 				}
				else
				{
%>
				<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
		       <TD CLASS="contentBgColorAlternate" ALIGN="MIDDLE" ><B><font color="#FF0000">
			   Approving work order Ref ID <%=approve[a]%> ... Fail : <%=work.getErrorMessage()%></font></B>
			   </TD>
			   </TR>
 <% 			}
			}
		}
	}	
%>
<%
if (conn != null && request.getParameter("laction") != null 
	    && request.getParameterValues("approve") != null )
	{
	String [] approve = request.getParameterValues("approve");
	String work_id [] = request.getParameterValues ("work_id");
	String sql = "UPDATE STAFF_TRAVEL_REQUEST SET STR_APPROVE_BY = 'APPROVE', STR_APPROVE_DATE = SYSDATE "+
	             "WHERE STR_WORKORDER_ID = ? ";
				 
	for (int a=0; a<approve.length; a++)
		{
		try
			{
			PreparedStatement pstmt = conn.prepareStatement (sql);
		        pstmt.setString (1, approve[a]);
			int rc=pstmt.executeUpdate();
			if (rc>0)
				{ out.println("Travelling request has been approved "+ approve[a]); }
			else 
				{ out.println("Travelling request approved ... Fail" + approve[a]); }
			pstmt.close ();
			}
		catch (SQLException e)
			{ out.println ("Error : " + e.toString ()); }
		}
	}
//conn.close ();
%>
</TABLE>
<TABLE width="100%" border=0 CELLPADDING="3" CELLSPACING="1">
	<TR>
	<TD CLASS="contentBgColor" align="center"><B> Approve Workorder and Travelling Request </B></TD>
	</TR>
<form action="../workorder/workorderMain.jsp?action=approve&laction=save" method="post">
   

<%
	if (conn != null)
	{
		String sql	= "SELECT WOH_WORKORDER_ID, TO_CHAR(WOH_ENTER_DATE,'DD/MM/YYYY'), NVL(WOH_DESC,' '),  " +
				"NVL(TO_CHAR(WOH_DATE_FROM,'DD/MM/YYYY'),' '), NVL(TO_CHAR(WOH_DATE_TO,'DD/MM/YYYY'),' ') " +
				"FROM WORK_ORDER_HEAD " +
				"WHERE WOH_APPROVE_BY = ?"+
				"AND WOH_STATUS = 'ENTRY' " +
				"ORDER BY WOH_WORKORDER_ID";
		
			try
			{
				PreparedStatement pstmt = conn.prepareStatement(sql);
				//pstmt.setString (1, session.getAttribute("deptcode").toString());
				pstmt.setString (1, session.getAttribute("staffid").toString());
				//pstmt.setString (2, session.getAttribute("staffid").toString());
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
          <td CLASS="contentBgColor"  align="center" width="6%"><B>Ref I/D</b></td>
          <td CLASS="contentBgColor"  align="center" width="12%"><B>Date</b></td>
          <td CLASS="contentBgColor"  align="center" width="55%"><B>Description</b></td>
          <td CLASS="contentBgColor"  align="center" width="15%"><B>Date From</b></td>
          <td CLASS="contentBgColor"  align="center"width="9%"><B>Date To</b></td>
          <td CLASS="contentBgColor"  align="center" width="3%"><B>Approve</b></td>
        </tr>
<%				
				while (rset.next ())
				{
%>
        <tr> 
          <td class="contentBgColorAlternate" align="center"><a href="../workorder/workorderMain.jsp?action=approve&ref_id=<%=rset.getString(1)%>"><%=rset.getString(1)%></a><input name="work_id" type="hidden" value="<%=rset.getString(1)%>"></td>
          <td class="contentBgColorAlternate"><%=rset.getString(2)%></td>
          <td class="contentBgColorAlternate"><%=rset.getString(3)%></td>
          <td class="contentBgColorAlternate"><%=rset.getString(4)%></td>
          <td class="contentBgColorAlternate"><%=rset.getString(5)%></td>
          <td class="contentBgColorAlternate">
		  <input name="approve" type="checkbox" id="approve" value="<%=rset.getString(1)%>"></td>
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
			<table width="100%" border="0" cellspacing="1" cellpadding="3">		
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
	if (conn != null && request.getParameter("ref_id") != null)
	{
		String sql	= "SELECT WOD_STAFF_ID,SM_STAFF_NAME,WOD_POSITION " +
						    "FROM WORK_ORDER_DETL,STAFF_MAIN " +
							"WHERE SM_STAFF_ID = WOD_STAFF_ID " +
							"AND WOD_WORKORDER_ID = ? " +
							"ORDER BY WOD_STAFF_ID";
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString (1, request.getParameter("ref_id").toString());
			ResultSet rset = pstmt.executeQuery ();
			if (rset.isBeforeFirst ())
			{
%>

<TABLE width="100%" height="26" border=0 CELLPADDING="3" CELLSPACING="1">
	<TR>
	<TD CLASS="contentBgColor" align="center"><B> Workorder details - Ref ID <%=request.getParameter("ref_id").toString()%> </B></TD>
	</TR>
</TABLE> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
	<td> 
<table width="100%" border="1" cellspacing="1" cellpadding="3">
  <tr> 
     <td  CLASS="contentBgColor"  align="center" width="15%"><B>Staff ID</b></td>
     <td  CLASS="contentBgColor"  align="center" width="70%"><B>Staff Name</b></td>
	 <td class="contentBgColor" align="center" width="15%"><B>Position</b></td>
  </tr>				
<%
			while (rset.next ())
			{
%>
	  <tr> 
	  <td class="contentBgColorAlternate" align="center" width="15%"><%=rset.getString(1)%></td>
	  <td  class="contentBgColorAlternate" width="70%"><%=rset.getString(2)%></td>
	  <td class="contentBgColorAlternate" align="center"><%=rset.getString(3)%></td>
	  </tr>
<%
			}
%>
</table>
</td>
  </tr>
</table>
<%
		}
		rset.close ();
		pstmt.close ();
		}		
		catch (SQLException e)
		{ 
			out.println ("Error! : " + e.toString ());  
		}
	
%>
<%
	
	
	
	String sql_str	= "SELECT STR_TRAVEL_RANGE, STR_DESTINATION, STR_TRANSPORT_TYPE, STR_TRAVEL_REASON, STR_REMARK, STR_TRANSPORT_CHOICE "+
					  "FROM WORK_ORDER_HEAD, STAFF_TRAVEL_REQUEST " +
					  "WHERE STR_WORKORDER_ID = WOH_WORKORDER_ID " +
					  "AND STR_WORKORDER_ID = ? ";
				
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_str);
		pstmt.setString (1, request.getParameter("ref_id").toString());
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			travel_range		= rset.getString (1);
			destination 		= rset.getString (2);
			trans	    		= rset.getString (3);
			reason		 		= rset.getString (4);
			accompany	 		= rset.getString (5);
			vehicle				= rset.getString (6);
			}
		rset.close ();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_Dept: " + e.toString ()); }

%>
<table width="100%" border="1" cellspacing="1" cellpadding="3">

	<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
      <td colspan="4" align="center" class="contentBgColorAlternate"><b>Travelling and Transport Request</b></td>
    </tr>
	<tr COLSPAN="1" ALIGN="LEFT" > 
 	  <td CLASS="contentBgColor" align="right"><b>Transport Choice</b></td> 
      <td CLASS="contentBgColorAlternate" COLSPAN="1" ALIGN="LEFT" width="52%">
	   <%=trans%>	   <br>
	   Person Accompany (if exist): <%=( ( accompany ==null)?"-":accompany )%>
	  </td>
	</tr>
	<tr COLSPAN="1" ALIGN="LEFT" > 
 	  <td CLASS="contentBgColor" align="right"><b>Transport Type</b></td> 
      <td CLASS="contentBgColorAlternate" COLSPAN="1" ALIGN="LEFT" width="52%">
	   <%=( ( vehicle ==null)?"-":vehicle )%>
	  </td>
	</tr> 	 
	<tr COLSPAN="1" ALIGN="LEFT" > 
 	  <td CLASS="contentBgColor" align="right"><b>Travel Range</b></td> 
      <td CLASS="contentBgColorAlternate" COLSPAN="1" ALIGN="LEFT" width="52%">
	  <input type=hidden name= value="<%=travel_range%>"><%=( ( travel_range .equals("NULL"))?"-":travel_range )%>
	  </td>
	</tr>
	<tr COLSPAN="1" ALIGN="LEFT" > 
 	  <td CLASS="contentBgColor" align="right"><b>Destination </b></td> 
      <td CLASS="contentBgColorAlternate" COLSPAN="1" ALIGN="LEFT" width="52%">
	  <input type=hidden name=destination value="<%=destination%>"><%=destination%>
	  </td>
	</tr>


 </table>
<%}%>

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