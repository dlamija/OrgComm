/**
 * 
 */
package cms.staff;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 * @web.servlet name = "OvertimeVCApprvRep"
 * @web.servlet-mapping url-pattern = "/OvertimeVCApprvRep"
 * @author Osman Sulaiman
 *
 */
public class OvertimeVCApprvRep extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#service(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		DataSource ds = getDataSource();
		String reportFileName = "/WEB-INF/report/ot-vcapprv.jasper";
		String claimMonth = request.getParameter("cm");
		String staffId = null;
		
		HttpSession session = request.getSession();
		if (session != null) {
			staffId = (String) session.getAttribute("staffid");
		}
		
		if (ds != null && staffId != null && !staffId.isEmpty() 
				&& claimMonth != null && !claimMonth.isEmpty()) {
			
			Map params = new HashMap();
			params.put("LOGO", getResourceFile("/images/logo-ump-102x50.jpg"));
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			StringBuffer sql = new StringBuffer();
			sql.append("select sm.sm_staff_id, sm.sm_staff_name, sm.sm_ic_no, dm.dm_dept_desc,")
					.append(" soh.soh_claim_month, soh.soh_total_hours, soh.soh_total_rm")
					.append(" from staff_overtime_head soh, staff_main sm, department_main dm")
					.append(" where soh.soh_staff_id = sm.sm_staff_id")
					.append(" and dm.dm_dept_code = sm.sm_dept_code")
					.append(" and sm_staff_id = ?")
					.append(" and soh_claim_month = to_date(?,'mm/yyyy')");
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql.toString());
				pstmt.setString(1, staffId);
				pstmt.setString(2, claimMonth);
				rs = pstmt.executeQuery();
				JRResultSetDataSource jrDataSource = new JRResultSetDataSource(rs);
				
				OutputStream outputStream = response.getOutputStream();
				JasperRunManager.runReportToPdfStream(getResourceFile(reportFileName), outputStream, params, jrDataSource);
				response.setContentType("application/pdf");
				outputStream.flush();
				outputStream.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JRException e) {
				// TODO Auto-generated catch block
				System.out.println("Error generating PDF report.");
				e.printStackTrace();
			}
			finally {
				try {
					rs.close();
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					// do nothing
				}
			}
		}
	}

	private DataSource getDataSource() {
		
		DataSource ds = null;
		try {
			Context envContext = (Context) new InitialContext().lookup("java:comp/env");
			ds = (DataSource) envContext.lookup("jdbc/cmsdb");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ds;
	}
	
	private InputStream getResourceFile(String path) {
		
		if (path != null && !path.isEmpty()) {
			return getServletConfig().getServletContext().getResourceAsStream(path);
		}
		
		return null;
	}
}
