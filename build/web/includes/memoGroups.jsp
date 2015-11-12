<%@ include file="/includes/import.jsp" %>
<%@page import="java.util.*, utilities.RecipientUtil, paulUtil.TimingUtil, paulUtil.Util, common.*" %>

<%@ taglib uri="http://ajaxtags.sourceforge.net/tags/ajaxtags" prefix="ajax"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	RecipientUtil recipientUtil = new RecipientUtil();
	recipientUtil.initTVO(request);
	//load main category
	Vector mainCatVec = recipientUtil.getMainCategory();
	
	String mcID    = request.getParameter("ddCategory");
	
	if (mcID==null)
	{
		mcID = "";
	}
%>

<script type="text/javascript">
    /*
     * USER DEFINED FUNCTIONS
     */

    window.initProgress = function() {
        Element.show('progressMsg');
    };

    window.resetProgress = function(request) {
        Effect.Fade('progressMsg');
    };

    window.reportError = function() {
        $('errorMsg').innerHTML = "AjaxTag busted!";
        Element.show('errorMsg');
        setTimeout("Effect.DropOut('errorMsg')", 2500);
    };
</script>

<style type="text/css">
	.button1 {
		font-family: Verdana, sans-serif; 
		font-size: 8px; 
		width: 100px;
	}
</style>

<form action="" name="formGroup" id="formGroup" method="post">
	<table width="100%" border="0" cellspacing = "2" cellpadding = "3">
		<tr><td colspan="3" class="contentBgColorAlternate">&nbsp;</td></tr>
		
		<tr>
			<td width="20%" class="contentBgColorAlternate">Category</td>
			<td class="contentBgColorAlternate" width="1%">:</td>
			<td class="contentBgColorAlternate">
				<select id="ddCategory" name="ddCategory" >
					<option value="0">--- Select Category ---</option>
					<% for (int i=0; i<mainCatVec.size(); i++) { %>
						<% Hashtable ht = (Hashtable) mainCatVec.get(i); %>
						<% String currMcID = (String) ht.get("MCID"); %>
						<option value="<%=currMcID%>" <%if(mcID.equals(currMcID)){%>selected<%}%>><%=ht.get("MCNAME")%></option>
					<% } %>				
					
				</select>
				
			</td>
		</tr>
		
		<tr>
			<td width="20%" class="contentBgColorAlternate">Existing Group</td>
			<td class="contentBgColorAlternate" width="1%">:</td>
			<td class="contentBgColorAlternate">
				<select id="ddExistingGroup" name="ddExistingGroup">
					<option>--- Select Group ---</option>
				</select>
			</td>
		</tr>

		<tr>
			<td width="20%" class="contentBgColorAlternate">Search Name</td>
			<td class="contentBgColorAlternate" width="1%">:</td>
			<td class="contentBgColorAlternate">
				<input type="text" id="txSearch"/>
			</td>
		</tr>
		
		<tr><td colspan="3" class="contentBgColorAlternate">Edit Group Member&nbsp;</td></tr>
		<tr>
			<td width="20%" class="contentBgColorAlternate">&nbsp;</td>
			
			<td class="contentBgColorAlternate" colspan="2">
				<table border="0">
					<tr>
						<td rowspan="6">
							<select id="lsSearchResult" size="10" multiple="multiple" style="width:150px;"/>
						    	<option value=""></option>
						    </select>
						</td>
						<td align="center" valign="middle">&nbsp;</td>
						<td rowspan="6">
							<select id="lsGroupMember" size="10" multiple="multiple" style="width:150px;"/>
						    	<option value=""></option>
							</select>
						&nbsp;</td>
					</tr>
					<tr>
						<td align="center" valign="middle" ><input type="button" class="button1" value="<< REMOVE ALL"  />						    &nbsp;</td>
					</tr>
					<tr>
						<td align="center" valign="middle"><input type="button" class="button1" value="ADD >"/>
					    &nbsp;</td>
					</tr>
					<tr>
						<td align="center" valign="middle" ><input type="button" class="button1" value="< REMOVE"/>
					    &nbsp;</td>
					</tr>
					<tr>
						<td align="center" valign="middle" ><input type="button" class="button1" value="<< REMOVE ALL"  />&nbsp;</td>
					</tr>
					<tr>
						<td align="center" valign="middle" >&nbsp;</td>
					</tr>
				</table>
		    </td>
		</tr>
		<tr>
			<td colspan="3" class="contentBgColorAlternate" align="center">
				<input type="button" class="button1" value="ADD"  />&nbsp;
				<input type="button" class="button1" value="CANCEL"  />&nbsp;
				<input type="button" class="button1" value="<< BACK"  />&nbsp;
			</td>
		</tr>
	</table>
	<div id="errorMsg"
	style="display: none; border: 1px solid #e00; background-color: #fee; padding: 2px; margin-top: 8px; width: 300px; font: normal 12px Arial; color: #900"></div>
</form>

<ajax:select baseUrl="MemoGroupDropdown" source="ddCategory" target="ddExistingGroup"
	parameters="ddCategory={ddCategory},action=loadGroup"
	emptyOptionName="--- Select Group ---"/>

