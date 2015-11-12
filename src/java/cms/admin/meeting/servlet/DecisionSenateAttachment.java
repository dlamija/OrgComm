package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingDecisionAttachment;
import cms.admin.meeting.solr.SolrTools;

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
 * @web.servlet name = "decisionSenateAttachment"
 * @web.servlet-mapping url-pattern = "/decisionSenateAttachment"
 */
public class DecisionSenateAttachment extends HttpServlet {
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

	public void doGet(HttpServletRequest paramHttpServletRequest,
			HttpServletResponse paramHttpServletResponse)
			throws ServletException, IOException {
		doPost(paramHttpServletRequest, paramHttpServletResponse);
	}

	public void doPost(HttpServletRequest paramHttpServletRequest,
			HttpServletResponse paramHttpServletResponse) throws IOException,
			ServletException {
		int i = 1;
		HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

		String role = (String) localHttpSession.getAttribute("AMW001");

		String action = paramHttpServletRequest.getParameter("action");

		String agendaMtgCode = (String) localHttpSession
				.getAttribute("agendaMtgCode");
		String action2 = paramHttpServletRequest.getParameter("action");

		localHttpSession.removeAttribute("errmsg");

		Connection localConnection = null;
		DBConnectionPool localDBConnectionPool = null;
		try {
			localDBConnectionPool = TvoDBConnectionPoolFactory
					.getConnectionPool(paramHttpServletRequest);
			localConnection = localDBConnectionPool.getConnection();

			if (localConnection != null) {
				String decisionSeq = paramHttpServletRequest
						.getParameter("decisionSeq");
				Object localObject1;
				if (action2.equals("addDecisionAttach")) {
					if (addDecisionAttach(paramHttpServletRequest,
							paramHttpServletResponse, agendaMtgCode)) {
						localObject1 = paramHttpServletResponse.getWriter();
						((PrintWriter) localObject1).println("<script>");
						((PrintWriter) localObject1)
								.println("opener.location.reload();");
						((PrintWriter) localObject1)
								.println("opener.location.hash = '"
										+ decisionSeq + "_updateDecisionForm';");
						((PrintWriter) localObject1).println("window.close();");
						((PrintWriter) localObject1).println("</script>");
						i = 1;
					} else {
						i = 0;
						this.errorMssg = "Add Attachment Not Successful ";
					}
				} else if (action2.equals("RemoveAttachment")) {
					localObject1 = null;
					localObject1 = (MeetingDecisionAttachment) Beans
							.instantiate(super.getClass().getClassLoader(),
									"cms.admin.meeting.bean.MeetingDecisionAttachment");

					String seqNo = paramHttpServletRequest
							.getParameter("seqNo");

					((MeetingDecisionAttachment) localObject1)
							.setDBConnection(localConnection);

					String str7 = ((MeetingDecisionAttachment) localObject1)
							.queryPhysicalFileName(decisionSeq, seqNo);

					if (((MeetingDecisionAttachment) localObject1)
							.removeAttachment(decisionSeq, seqNo)) {

						System.out.println(">>>> Del file from Solr :"
								+ decisionSeq + "_" + seqNo);
						SolrTools.getInstance().delFile(
								decisionSeq.trim() + "_" + seqNo);

						CommonFunction.printAlert(paramHttpServletRequest,
								paramHttpServletResponse, "Attachment Deleted",
								"senateMeeting.jsp?action=Decision&meetingCode="
										+ agendaMtgCode + "#"
										+ decisionSeq.trim()
										+ "_updateDecisionForm");
						i = 1;
					} else {
						i = 0;
						this.errorMssg = "Delete Attachment Not Successful ";
					}

					if (!(str7.equals("null"))) {
						ServletContext localServletContext = super
								.getServletContext();
						String str8 = TvoContextManager.getRealPath(
								localServletContext, paramHttpServletRequest,
								"/eMeeting/" + agendaMtgCode);

						AttachmentUtil localAttachmentUtil = new AttachmentUtil();
						AttachmentUtil.deleteAttachment(str8, str7);
					}

				}

			} else {
				i = 0;
				this.errorMssg = "Connection to database is not available.";
			}

		} catch (Exception localException) {
			localException.printStackTrace();
			localHttpSession.setAttribute("errmsg", localException.toString());
			i = 0;
		} finally {
			localDBConnectionPool.returnConnection(localConnection);
		}

		if (i != 0) {
			return;
		}
		if (this.errorMssg.equals("null"))
			this.errorMssg = "Error!";
		CommonFunction.printAlert(paramHttpServletRequest,
				paramHttpServletResponse, this.errorMssg,
				paramHttpServletRequest.getHeader("Referer"));
	}

	public synchronized boolean addDecisionAttach(
			HttpServletRequest paramHttpServletRequest,
			HttpServletResponse paramHttpServletResponse, String paramString) {
		String str1 = "";
		ServletContext localServletContext = super.getServletContext();
		String userId = (String) TvoContextManager.getSessionAttribute(
				paramHttpServletRequest, "Login.userID");

		String realPath = TvoContextManager.getRealPath(localServletContext,
				paramHttpServletRequest, "/eMeeting/" + paramString);
		String tempRealPath = TvoContextManager.getRealPath(
				localServletContext, paramHttpServletRequest, "/eMeeting/temp/"
						+ paramString);

		DBConnectionPool localDBConnectionPool = null;
		Connection localConnection = null;
		PreparedStatement localPreparedStatement1 = null;
		boolean flag = false;

		PreparedStatement localPreparedStatement2 = null;
		ResultSet localResultSet = null;
		try {
			MultipartRequest localMultipartRequest = new MultipartRequest(
					paramHttpServletRequest, tempRealPath);

			localDBConnectionPool = TvoDBConnectionPoolFactory
					.getConnectionPool(paramHttpServletRequest);
			localConnection = localDBConnectionPool.getConnection();

			String decisionSeq = localMultipartRequest
					.getParameter("decisionSeq");

			int j = 1;
			localPreparedStatement2 = localConnection
					.prepareStatement("SELECT MAX(MAA_ATTC_SEQNO) FROM MEETING_DECISION_ATTC WHERE MAA_DECISION_SEQ = ?");

			localPreparedStatement2.setString(1, decisionSeq);
			localResultSet = localPreparedStatement2.executeQuery();
			if (localResultSet.next()) {
				j = localResultSet.getInt(1) + 1;
			}

			localPreparedStatement1 = localConnection
					.prepareStatement("INSERT INTO MEETING_DECISION_ATTC  (MAA_DECISION_SEQ, MAA_ATTC_SEQNO, MAA_ORIGINAL_FILE_NAME, MAA_PHYSICAL_FILE_NAME )  VALUES  (?, ?, ?, ?)");

			Enumeration localEnumeration = localMultipartRequest.getFileNames();
			while (localEnumeration.hasMoreElements()) {
				String fileName = localMultipartRequest
						.getFilesystemName((String) localEnumeration
								.nextElement());
				if (fileName == null)
					continue;
				String savedFileName = AttachmentUtil.saveAttachment(
						tempRealPath, realPath, fileName);

				if (savedFileName == null)
					continue;
				try {
					SolrTools.getInstance().addMtgAttcFileDec(realPath,
							fileName, decisionSeq, Integer.toString(j));
				} catch (Exception e) {
				}
				localPreparedStatement1.setString(1, decisionSeq);
				localPreparedStatement1.setInt(2, j);
				localPreparedStatement1.setString(3, fileName);
				localPreparedStatement1.setString(4, savedFileName);
				localPreparedStatement1.executeUpdate();
				++j;
			}

			flag = true;
		} catch (Exception localException1) {
			str1 = localException1.toString();
			localException1.printStackTrace();
			flag = false;
		} finally {
			try {
				if (localPreparedStatement1 != null)
					localPreparedStatement1.close();
				if (localConnection != null)
					localDBConnectionPool.returnConnection(localConnection);
				if (localResultSet != null)
					localResultSet.close();
				if (localPreparedStatement2 != null)
					localPreparedStatement2.close();

				CommonFunction.delFileTree(tempRealPath);
			} catch (Exception localException2) {
				localException2.printStackTrace();
			}
		}

		return flag;
	}
}