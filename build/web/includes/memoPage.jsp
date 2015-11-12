<%    

System.out.println("\tstart: "+start+"\tlimit:"+limit+"\tmemocount:"+memoCount);

if ( memoCount > limit )
     {Object variable[] = new Object[1];
      variable[0] = new Integer(limit);

        %>
	   <TR VALIGN="TOP">
       <TD BGCOLOR="#DBDBDB" CLASS="contentBgColor" colspan="7">
         <table border=0 cellspacing=0 cellpadding=0 width=100%>
         <TR VALIGN="TOP">
		<%System.out.println("\tstart: "+start+"\tlimit:"+limit+"\tmemocount"); %>
          <%
          if ( (start - limit) > 0)
          {
            %>
            <TD BGCOLOR="#DBDBDB" CLASS="contentBgColor">
            <a href="memo.jsp?action=<%= action %>&folderID=<%= folderID %>&type=<%=request.getParameter("type")%>&sort=<%= sortBy %>&order=<%= currentSortOrder %>&start=<%= start - limit %>&listing=<%= limit %><%= str %>" onMouseOver="window.status='<%= messages.getString("previous",variable) %>';return true;">
            <%= messages.getString("previous",variable) %>
            </a>
			</td>
            <%
          }
          %>
          <%
          if ( (start + limit) <= memoCount)
          
		  {
            %>
          <TD BGCOLOR="#DBDBDB" CLASS="contentBgColor" ALIGN="RIGHT">
            <a href="memo.jsp?action=<%= action %>&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>&sort=<%= sortBy %>&order=<%= currentSortOrder %>&start=<%= start + limit %>&listing=<%= limit %><%= str %>" onMouseOver="window.status='<%= messages.getString("next",variable) %>';return true;">
            <%= messages.getString("next",variable) %>
            </a>
			</td>
            <%
          }
          %>
        </TR>      
		
		 <tr valign="top">
	            <td align="center" BGCOLOR="#DBDBDB" CLASS="contentBgColor" 
				<%  
				  if ( (start-limit) > 0 && (start + limit) <= memoCount) 
				  {
				%>
				   COLSPAN="2"
				<%
				  }
				%>																			
				>
				<%= messages.getString("page") %>:
				<%
				  pageSum = memoCount/limit;
			      if ( memoCount%limit > 0)
				   pageSum++;
		          if (pageSum > 0)
		          {
			       for (i=0;i<pageSum;i++)
			       {
				 		    variable[0] = new Integer(i+1);
								pageNo = (limit * i) - start;
							  if (pageNo == -1)
		    				  selected = String.valueOf(i+1);						 
							  else
								    selected = "<a href=\"memo.jsp?action=" + action + 
										           "&folderID="+ folderID +
														   "&type="+request.getParameter("type")+
														   "&sort="+ sortBy +"&order="+ currentSortOrder +
												       "&start="+ String.valueOf(1 + limit*i)+
				  									   "&listing="+limit + str + "\" "+ 
						   							   "onMouseOver=\"window.status='"+ messages.getString("page.no",variable) +"';return true;\">"+
				    				           String.valueOf(i+1)+"</a>";

				%>
				<%= selected %>
				<%
			    if (i+1<pageSum )
			    {
			   %>
			    |
			   <%
			    }
			   }
		      }

			%>

				</td>
				 </tr>
				  </table>
			 </td>
			 </tr>

        <%
      }      
      %>