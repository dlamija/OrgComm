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
 * @web.servlet name = "OvertimeAuthRep"
 * @web.servlet-mapping url-pattern = "/OvertimeAuthRep"
 * @author Osman Sulaiman
 *
 */
public class OvertimeAuthRep extends BaseJasperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	public OvertimeAuthRep() {
		super.setJdbcResourceName("jdbc/cmsdb");
	}

	/* (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#service(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		DataSource ds = super.getDataSource();
		String reportFileName = "ot-authorization.jasper";
		String claimMonth = request.getParameter("cm");
		String requestMonth = request.getParameter("rm");
		String staffId = null;
		
		HttpSession session = request.getSession();
		if (session != null) {
			staffId = (String) session.getAttribute("staffid");
		}

		if (ds != null && staffId != null && !staffId.isEmpty() 
				&& claimMonth != null && !claimMonth.isEmpty()) {
			
			Connection conn = null;
			PreparedStatement pstmt1 = null, pstmt2 = null;
			ResultSet rs1 = null, rs2 = null;
			
			if (requestMonth == null || requestMonth.isEmpty()) {
				requestMonth = claimMonth;
			}
			
			Map params = new HashMap();
			params.put("LETTER_HEAD", super.getResourceFile("/cms/overtime/images/letter_head.gif"));
			params.put("MONTH_REQUESTED", requestMonth);
			params.put("SUBREPORT_FILE", super.getReport("ot-authorization-sub1.jasper"));
			
			// query for subreport
			StringBuffer sql1 = new StringBuffer();
			sql1.append("select sod.sod_workorder_id, sod.sod_date, woh.woh_desc,")
					.append(" sod.sod_time1_start, sod.sod_time1_end,")
					.append(" sod.sod_time2_start, sod.sod_time2_end,")
					.append(" sod.sod_time3_start, sod.sod_time3_end,")
					.append(" sod.sod_total_daily_hours")
					.append(" from staff_overtime_detl sod, work_order_head woh")
					.append(" where woh.woh_workorder_id = sod.sod_workorder_id")
					.append(" and sod.sod_claim_month = to_date(?,'mm/yyyy')")
					.append(" and sod.sod_staff_id = ?")
					.append(" and to_char(sod.sod_date,'mm/yyyy') = ?");
			
			// query for master report
			StringBuffer sql2 = new StringBuffer();
			/*
			sql2.append("select sm.sm_staff_id, sm.sm_staff_name, dm.dm_dept_desc, sm.sm_ic_no,")
					.append(" soh.soh_claim_month, soh.soh_verify_by, sma.sm_staff_name as soh_verify_name,")
					.append(" soh.soh_recommend_by, smb.sm_staff_name as soh_recommend_name")
					.append(" from staff_main sm, department_main dm,")
					.append(" staff_overtime_head soh, staff_main sma, staff_main smb")
					.append(" where sm.sm_dept_code = dm.dm_dept_code")
					.append(" and soh.soh_staff_id = sm.sm_staff_id")
					.append(" and sma.sm_staff_id = soh.soh_verify_by")
					.append(" and smb.sm_staff_id = soh.soh_recommend_by")
					.append(" and sm.sm_staff_id = ?")
					.append(" and soh.soh_claim_month = to_date(?,'mm/yyyy')");
			*/
			sql2.append("select d.*, smb.sm_staff_name as soh_recommend_name")
					.append(" from (")
					.append(" select sm.sm_staff_id, sm.sm_staff_name, dm.dm_dept_desc, sm.sm_ic_no,")
					.append(" soh.soh_claim_month, soh.soh_verify_by,")
					.append(" sma.sm_staff_name as soh_verify_name,")
					.append(" soh.soh_recommend_by")
					.append(" from staff_overtime_head soh, staff_main sm, department_main dm,")
					.append(" staff_main sma")
					.append(" where soh.soh_staff_id = sm.sm_staff_id")
					.append(" and sm.sm_dept_code = dm.dm_dept_code")
					.append(" and soh.soh_verify_by = sma.sm_staff_id(+)")
					.append(" and soh.soh_staff_id = ?")
					.append(" and soh.soh_claim_month = to_date(?,'mm/yyyy')")
					.append(" ) d, staff_main smb")
					.append(" where d.soh_recommend_by = smb.sm_staff_id(+)");

			try {
				conn = ds.getConnection();
				
				pstmt1 = conn.prepareStatement(sql1.toString());
				pstmt1.setString(1, claimMonth);
				pstmt1.setString(2, staffId);
				pstmt1.setString(3, requestMonth);
				rs1 = pstmt1.executeQuery();
				JRResultSetDataSource jrSubreportDataSource = new JRResultSetDataSource(rs1);
				params.put("SUBREPORT_DATA_SOURCE", jrSubreportDataSource);
				
				pstmt2 = conn.prepareStatement(sql2.toString());
				pstmt2.setString(1, staffId);
				pstmt2.setString(2, claimMonth);
				rs2 = pstmt2.executeQuery();
				JRResultSetDataSource jrDataSource = new JRResultSetDataSource(rs2);
				
				OutputStream outputStream = response.getOutputStream();
				JasperRunManager.runReportToPdfStream(super.getReport(reportFileName), outputStream, params, jrDataSource);
				response.setContentType("application/pdf");
				outputStream.flush();
				outputStream.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (JRException e) {
				System.out.println("Error generating PDF report.");
				e.printStackTrace();
			} finally {
				try {
					rs2.close();
					pstmt2.close();
					rs1.close();
					pstmt1.close();
					conn.close();
				} catch (SQLException e) {
					// do nothing
				}
			}
		}
	}
}
