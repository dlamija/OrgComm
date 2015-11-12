/**
 * 
 */
package cms.staff;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperRunManager;

import common.BaseJasperServlet;

/**
 * @web.servlet name = "OvertimeClaimRep"
 * @web.servlet-mapping url-pattern = "/OvertimeClaimRep"
 * @author Osman Sulaiman
 *
 */
public class OvertimeClaimRep extends BaseJasperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	public OvertimeClaimRep() {
		super.setJdbcResourceName("jdbc/cmsdb");
	}

	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#service(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		DataSource ds = super.getDataSource();
		String reportFileName = "ot-claim.jasper";
		String staffId = null;
		String month = request.getParameter("m");
		String year = request.getParameter("y");
		
		String claimMonth = null;
		if (month != null && !month.isEmpty() && year != null && !year.isEmpty()) {
			claimMonth = month + "/" + year;
		}
		
		HttpSession session = request.getSession();
		if (session != null) {
			staffId = (String) session.getAttribute("staffid");
		}
		
		if (ds != null && staffId != null && !staffId.isEmpty() 
				&& claimMonth != null && !claimMonth.isEmpty()) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			Map params = new HashMap();
			params.put("CLAIM_MONTH", month);
			params.put("CLAIM_YEAR", year);
			
			StringBuffer sql = new StringBuffer();
			sql.append("select sm.sm_staff_id, sm.sm_staff_name, sm.sm_ic_no,")
					.append(" dm.dm_dept_desc, ss.ss_basic_salary,")
					.append(" sod.sod_date, sod.sod_remark,")
					.append(" sod.sod_time1_start, sod.sod_time1_end,")
					.append(" sod.sod_time2_start, sod.sod_time2_end,")
					.append(" sod.sod_time3_start, sod.sod_time3_end,")
					.append(" sod.sod_total_daily_hours, sod.sod_total_daily_rm")
					.append(" from staff_main sm, department_main dm,")
					.append(" staff_salary ss, staff_overtime_detl sod")
					.append(" where sm.sm_dept_code = dm.dm_dept_code")
					.append(" and ss.ss_staff_id = sm.sm_staff_id")
					.append(" and sod.sod_staff_id = sm.sm_staff_id")
					.append(" and sm.sm_staff_id = ?")
					.append(" and sod.sod_claim_month = to_date(?,'mm/yyyy')");
			
			try {
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql.toString());
				pstmt.setString(1, staffId);
				pstmt.setString(2, claimMonth);
				rs = pstmt.executeQuery();
				JRResultSetDataSource jrDataSource = new JRResultSetDataSource(rs);
				
				OutputStream outputStream = response.getOutputStream();
				JasperRunManager.runReportToPdfStream(super.getReport(reportFileName), outputStream, params, jrDataSource);
				response.setContentType("application/pdf");
				outputStream.flush();
				outputStream.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JRException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
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
}
