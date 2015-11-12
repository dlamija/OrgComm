package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingDecisionAttachment;
import java.beans.Beans;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Enumeration;
import javax.servlet.GenericServlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonFunction;
import common.DBConnectionPool;
import common.MultipartRequest;
import common.TvoContextManager;

import tvo.TvoDBConnectionPoolFactory;
import utilities.AttachmentUtil;

/**
 * @web.servlet name = "decisionAttachment"
 * @web.servlet-mapping url-pattern = "/decisionAttachment"
 */
public class DecisionAttachment extends HttpServlet
{
  String mtgCode = null;
  String agendaDesc = null;
  String agendaLevel = null;
  String agendaSeqno = null;
  String parentAgenda = null;
  String sortSeq = null;
  String numbering = null;
  String errorMssg = null;
  String agendaSeq = null;

  String originalFileName = null;
  String physicalFileName = null;

  public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
    doPost(paramHttpServletRequest, paramHttpServletResponse);
  }

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str1 = (String)localHttpSession.getAttribute("AMW001");

    String str2 = paramHttpServletRequest.getParameter("action");

    String str3 = (String)localHttpSession.getAttribute("agendaMtgCode");
    String str4 = paramHttpServletRequest.getParameter("action");

    localHttpSession.removeAttribute("errmsg");

    Connection localConnection = null;
    try
    {
      DBConnectionPool localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
      localConnection = localDBConnectionPool.getConnection();

      if (localConnection != null) {
        String str5 = paramHttpServletRequest.getParameter("decisionSeq");
        Object localObject1;
        if (str4.equals("addDecisionAttach"))
        {
          if (addDecisionAttach(paramHttpServletRequest, paramHttpServletResponse, str3))
          {
            localObject1 = paramHttpServletResponse.getWriter();
            ((PrintWriter)localObject1).println("<script>");
            ((PrintWriter)localObject1).println("opener.location.reload();");
            ((PrintWriter)localObject1).println("opener.location.hash = '" + str5 + "_updateDecisionForm';");
            ((PrintWriter)localObject1).println("window.close();");
            ((PrintWriter)localObject1).println("</script>");
            i = 1;
          }
          else
          {
            i = 0;
            this.errorMssg = "Add Attachment Not Successful ";
          }
        }
        else if (str4.equals("RemoveAttachment"))
        {
          localObject1 = null;
          localObject1 = (MeetingDecisionAttachment)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingDecisionAttachment");

          String str6 = paramHttpServletRequest.getParameter("seqNo");

          ((MeetingDecisionAttachment)localObject1).setDBConnection(localConnection);

          String str7 = ((MeetingDecisionAttachment)localObject1).queryPhysicalFileName(str5, str6);

          if (((MeetingDecisionAttachment)localObject1).removeAttachment(str5, str6))
          {
            CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Attachment Deleted", "eMeeting.jsp?action=Decision&meetingCode=" + str3 + "#" + str5.trim() + "_updateDecisionForm");
            i = 1;
          }
          else
          {
            i = 0;
            this.errorMssg = "Delete Attachment Not Successful ";
          }

          if (!(str7.equals("null")))
          {
            ServletContext localServletContext = super.getServletContext();
            String str8 = TvoContextManager.getRealPath(localServletContext, paramHttpServletRequest, "/eMeeting/" + str3);

            AttachmentUtil localAttachmentUtil = new AttachmentUtil();
            AttachmentUtil.deleteAttachment(str8, str7);
          }

        }

      }
      else
      {
        i = 0;
        this.errorMssg = "Connection to database is not available.";
      }

      localConnection.close();
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
      localHttpSession.setAttribute("errmsg", localException1.toString());
      i = 0;
    }
    finally {
      if (localConnection != null)
        try {
          localConnection.close();
        }
        catch (Exception localException2)
        {
        }
    }
    if (i != 0) {
      return;
    }
    if (this.errorMssg.equals("null"))
      this.errorMssg = "Error!";
    CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }

  public synchronized boolean addDecisionAttach(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse, String paramString)
  {
    String str1 = "";
    ServletContext localServletContext = super.getServletContext();
    String str2 = (String)TvoContextManager.getSessionAttribute(paramHttpServletRequest, "Login.userID");

    String str3 = TvoContextManager.getRealPath(localServletContext, paramHttpServletRequest, "/eMeeting/" + paramString);
    String str4 = TvoContextManager.getRealPath(localServletContext, paramHttpServletRequest, "/eMeeting/temp/" + paramString);

    DBConnectionPool localDBConnectionPool = null;
    Connection localConnection = null;
    PreparedStatement localPreparedStatement1 = null;
    boolean flag = false;

    PreparedStatement localPreparedStatement2 = null;
    ResultSet localResultSet = null;
    try
    {
      MultipartRequest localMultipartRequest = new MultipartRequest(paramHttpServletRequest, str4);

      localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
      localConnection = localDBConnectionPool.getConnection();

      String str5 = localMultipartRequest.getParameter("decisionSeq");

      int j = 1;
      localPreparedStatement2 = localConnection.prepareStatement("SELECT Max(MAA_ATTC_SEQNO) FROM MEETING_DECISION_ATTC WHERE MAA_DECISION_SEQ = ?");

      localPreparedStatement2.setString(1, str5);
      localResultSet = localPreparedStatement2.executeQuery();
      if (localResultSet.next()) {
        j = localResultSet.getInt(1) + 1;
      }

      localPreparedStatement1 = localConnection.prepareStatement("INSERT INTO MEETING_DECISION_ATTC  (MAA_DECISION_SEQ, MAA_ATTC_SEQNO, MAA_ORIGINAL_FILE_NAME, MAA_PHYSICAL_FILE_NAME )  VALUES  (?, ?, ?, ?)");

      Enumeration localEnumeration = localMultipartRequest.getFileNames();
      while (localEnumeration.hasMoreElements()) {
        String str6 = localMultipartRequest.getFilesystemName((String)localEnumeration.nextElement());
        if (str6 == null)
          continue;
        String str7 = AttachmentUtil.saveAttachment(str4, str3, str6);

        if (str7 == null)
          continue;
        localPreparedStatement1.setString(1, str5);
        localPreparedStatement1.setInt(2, j);
        localPreparedStatement1.setString(3, str6);
        localPreparedStatement1.setString(4, str7);
        localPreparedStatement1.executeUpdate();
        ++j;
      }

      flag = true;
    }
    catch (Exception localException1) {
      str1 = localException1.toString();
      localException1.printStackTrace();
      flag = false;
    } finally {
      try {
        if (localPreparedStatement1 != null) localPreparedStatement1.close();
        if (localConnection != null) localDBConnectionPool.returnConnection(localConnection);
        if (localResultSet != null) localResultSet.close();
        if (localPreparedStatement2 != null) localPreparedStatement2.close();

        CommonFunction.delFileTree(str4);
      } catch (Exception localException2) {
        localException2.printStackTrace();
      }
    }

    return flag;
  }
}