                <!-- Memo Main Content Box START -->
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                    <TR VALIGN="MIDDLE">
                      <TD HEIGHT="22" BACKGROUND="images/system/strap.gif"><B><FONT COLOR="#FFD553"><B><FONT COLOR="#FFD752"><IMG SRC="images/system/blank.gif" WIDTH="20" HEIGHT="5"></FONT></B></FONT><a href="" onclick="toggleBlock('memobox'); return false" onMouseOver="window.status='<%= messages.getString("memo") %>';return true;"><FONT COLOR="#FFCF63" CLASS="contentTitleFont"><%= messages.getString("memo") %></FONT></A></B>
                      </TD>
                    </TR>
                  </TABLE>
                  <DIV id="memobox">
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                    <TR>
                      <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="10"></TD>
                    </TR>
                    <TR>
                      <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor">
                        <%@ include file="/includes/memoBox.jsp" %>
                      </TD>
                    </TR>
                    <TR BGCOLOR="#EFEFEF">
                      <TD VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
                    </TR>
                  </TABLE>
                  </DIV>
                  <!-- Memo Main Content Box END -->
