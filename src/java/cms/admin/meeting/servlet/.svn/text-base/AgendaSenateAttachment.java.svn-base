package cms.admin.meeting.servlet;

import java.beans.Beans;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tvo.TvoDBConnectionPoolFactory;
import utilities.AttachmentUtil;
import cms.admin.meeting.bean.MeetingAgendaAttachment;
import cms.admin.meeting.solr.SolrTools;

import common.CommonFunction;
import common.DBConnectionPool;
import common.MultipartRequest;
import common.TvoContextManager;

/**
 * @web.servlet name = "agendaSenateAttachment"
 * @web.servlet-mapping url-pattern = "/agendaSenateAttachment"
 */
public class AgendaSenateAttachment extends HttpServlet {
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

		String amw001 = (String) localHttpSession.getAttribute("AMW001");

		String agendaCode = (String) localHttpSession
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

				String agendaSeq;
				Object obj;

				if (action2.equals("addAgendaAttach")) {
					agendaSeq = paramHttpServletRequest
							.getParameter("agendaSeq");
					if (addAgendaAttach(paramHttpServletRequest,
							paramHttpServletResponse, agendaCode)) {
						obj = paramHttpServletResponse.getWriter();
						((PrintWriter) obj).println("<script>");
						((PrintWriter) obj)
								.println("opener.location.reload();");
						((PrintWriter) obj).println("opener.location.hash = '"
								+ agendaSeq + "_updateForm';");
						((PrintWriter) obj).println("window.close();");
						((PrintWriter) obj).println("</script>");
						i = 1;
					} else {
						i = 0;
						this.errorMssg = "Add Attachment Not Successful ";
					}
				} else if (action2.equals("RemoveAttachment")) {
					obj = null;
					obj = (MeetingAgendaAttachment) Beans.instantiate(super
							.getClass().getClassLoader(),
							"cms.admin.meeting.bean.MeetingAgendaAttachment");

					agendaSeq = paramHttpServletRequest
							.getParameter("agendaSeq");
					String seqNo = paramHttpServletRequest
							.getParameter("seqNo");

					((MeetingAgendaAttachment) obj)
							.setDBConnection(localConnection);

					String fileName = ((MeetingAgendaAttachment) obj)
							.queryPhysicalFileName(agendaSeq, seqNo);

					if (((MeetingAgendaAttachment) obj).removeAttachment(
							agendaSeq, seqNo, agendaCode)) {
						i = 1;

						System.out.println(">>>> Del file from Solr :"
								+ agendaSeq + "_" + seqNo);
						SolrTools.getInstance()
								.delFile(agendaSeq + "_" + seqNo);

						CommonFunction.printAlert(paramHttpServletRequest,
								paramHttpServletResponse, "Attachment Deleted",
								"senateMeeting.jsp?action=Agenda&meetingCode="
										+ agendaCode + "#" + agendaSeq.trim()
										+ "_updateForm");
					} else {
						i = 0;
						this.errorMssg = "Delete Attachment Not Successful ";
					}

					if (!(fileName.equals("null"))) {
						ServletContext localServletContext = super
								.getServletContext();
						String str8 = TvoContextManager.getRealPath(
								localServletContext, paramHttpServletRequest,
								"/eMeeting/" + agendaCode);

						AttachmentUtil.deleteAttachment(str8, fileName);
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

	public synchronized boolean addAgendaAttach(
			HttpServletRequest paramHttpServletRequest,
			HttpServletResponse paramHttpServletResponse, String paramString) {

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
		boolean status = false;

		PreparedStatement localPreparedStatement2 = null;
		ResultSet localResultSet = null;
		try {
			MultipartRequest localMultipartRequest = new MultipartRequest(
					paramHttpServletRequest, tempRealPath);

			localDBConnectionPool = TvoDBConnectionPoolFactory
					.getConnectionPool(paramHttpServletRequest);
			localConnection = localDBConnectionPool.getConnection();

			String agendaSeq = localMultipartRequest.getParameter("agendaSeq");

			int j = 1;
			localPreparedStatement2 = localConnection
					.prepareStatement(" SELECT MAX( MAA_ATTC_SEQNO ) FROM "
							+ "MEETING_AGENDA_ATTC WHERE MAA_AGENDA_SEQ = ?");

			localPreparedStatement2.setString(1, agendaSeq);
			localResultSet = localPreparedStatement2.executeQuery();
			if (localResultSet.next()) {
				j = localResultSet.getInt(1) + 1;
			}

			localPreparedStatement1 = localConnection
					.prepareStatement("INSERT INTO MEETING_AGENDA_ATTC( "
							+ "MAA_AGENDA_SEQ, MAA_ATTC_SEQNO, MAA_ORIGINAL_FILE_NAME, MAA_PHYSICAL_FILE_NAME "
							+ ") VALUES ( " + "?, ?, ?, ? ) ");

			Enumeration localEnumeration = localMultipartRequest.getFileNames();
			while (localEnumeration.hasMoreElements()) {
				String fileName = localMultipartRequest
						.getFilesystemName((String) localEnumeration
								.nextElement());
				if (fileName == null) {
					continue;
				}
				String savedFileName = AttachmentUtil.saveAttachment(
						tempRealPath, realPath, fileName);

				if (savedFileName == null) {
					continue;
				}

				try {
					SolrTools.getInstance().addMtgAttcFile(realPath, fileName,
							agendaSeq, Integer.toString(j));
				} catch (Exception e) {
				}

				localPreparedStatement1.setString(1, agendaSeq);
				localPreparedStatement1.setInt(2, j);
				localPreparedStatement1.setString(3, fileName);
				localPreparedStatement1.setString(4, savedFileName);
				localPreparedStatement1.executeUpdate();
				j++;

			}

			status = true;
		} catch (Exception localException1) {
			localException1.printStackTrace();
			status = false;
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

		return status;
	}
}