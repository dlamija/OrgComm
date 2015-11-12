package cms.admin.meeting.servlet;

import cms.UserAuthentication;
import java.beans.Beans;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @web.servlet name = "vlogin"
 * @web.servlet-mapping url-pattern = "/vlogin"
 */
public class LoginValidator extends HttpServlet
{
  String username = null;
  String passwd = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    this.username = paramHttpServletRequest.getParameter("username");
    this.passwd = paramHttpServletRequest.getParameter("passwd");

    if ((this.username == null) || (this.username.length() == 0) || (this.passwd == null) || (this.passwd.length() == 0))
    {
      localHttpSession.setAttribute("errmsg", "Invalid Username or Password");
      i = 0;
    } else {
      try {
        this.username = this.username.trim();
        this.passwd = this.passwd.trim();

        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection localConnection = DriverManager.getConnection("jdbc:oracle:thin:@192.168.200.18:1521:cms", "cmsadmin", "cmsadmin");

        UserAuthentication localUserAuthentication = (UserAuthentication)Beans.instantiate(super.getClass().getClassLoader(), "cms.UserAuthentication");

        localUserAuthentication.setDBConnection(localConnection);
        localUserAuthentication.setUsername(this.username);
        localUserAuthentication.setPasswd(this.passwd);

        localHttpSession.setMaxInactiveInterval(1800);
        localHttpSession.setAttribute("user", this.username);
        localHttpSession.setAttribute("staffid", localUserAuthentication.getStaffId());
        localHttpSession.setAttribute("staffname", localUserAuthentication.getStaffName());
        localHttpSession.setAttribute("deptcode", localUserAuthentication.getDeptCode());
        localHttpSession.setAttribute("logintime", localUserAuthentication.getLoginTime());
        localHttpSession.setAttribute("user", this.username);
        localHttpSession.setAttribute("AMW001", "AMW001");

        localConnection.close();
      }
      catch (Exception localException) {
        localHttpSession.setAttribute("errmsg", localException.toString());
        i = 0;
      }
    }

    if (i != 0)
      paramHttpServletResponse.sendRedirect("cmsmtgmain.jsp");
    else
      paramHttpServletResponse.sendRedirect("cmsmtglogin.jsp");
  }
}