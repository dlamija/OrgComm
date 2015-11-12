package cms.admin.meeting.servlet;

import common.*;
import cms.admin.meeting.EMeetingQuery;
import cms.admin.meeting.bean.MeetingResourceBean;
import java.beans.Beans;
import java.io.IOException;
import java.sql.Connection;
import java.util.Hashtable;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import tvo.TvoBean;
import tvo.TvoDBConnectionPoolFactory;
import utilities.ResourceUtil;
import utilities.UserUtil;

/**
 * @web.servlet name = "addMtgResources"
 * @web.servlet-mapping url-pattern = "/addMtgResources"
 */
public class MeetingResource extends HttpServlet
{

    public MeetingResource()
    {
        mtgCode = null;
        roomCode = null;
        mtgDate = null;
        mtgStartTime = null;
        mtgEndTime = null;
        errorMssg = "ERROR";
        creatorID = null;
        resourceSeq = null;
        resourceIDs = null;
        userType = null;
        resourceTrxnSeq = null;
        vSelectedResources = null;
        toAddResources = null;
        toDeleteResources = null;
        resourceHastable = null;
        userID = null;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException
    {
        boolean status = true;
        HttpSession session = request.getSession(true);
        DBConnectionPool dbPool = null;
        Connection conn = null;
        userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
        UserUtil uu = new UserUtil();
        uu.initTVO(request);
        userType = uu.getUserType(userID);
        creatorID = uu.getCMSID(userID);
        mtgCode = (String)session.getAttribute("meetingCode");
        mtgDate = request.getParameter("mtgDate");
        mtgStartTime = request.getParameter("mtgStartTime");
        mtgEndTime = request.getParameter("mtgEndTime");
        resourceIDs = request.getParameterValues("selectedResources");
        session.removeAttribute("errmsg");
        if(mtgCode == null || mtgCode.length() == 0)
        {
            errorMssg = "The meeting unique id is not available.";
            status = false;
        }
        if(status && (mtgDate == null || mtgDate.length() == 0))
        {
            errorMssg = "Date of the meeting is not specified.";
            status = false;
        }
        if(status && (mtgStartTime == null || mtgStartTime.length() == 0))
        {
            errorMssg = "Start time of the meeting is not specified.";
            status = false;
        }
        if(status && (mtgEndTime == null || mtgEndTime.length() == 0))
        {
            errorMssg = "End time of the meeting is not specified.";
            status = false;
        }
        if(status)
            try
            {
                dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
                conn = dbPool.getConnection();
                if(conn != null)
                {
                    MeetingResourceBean mr = (MeetingResourceBean)Beans.instantiate(getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingResourceBean");
                    mr.setDBConnection(conn);
                    vSelectedResources = mr.queryResourceTrxn(mtgCode);
                    ResourceUtil rUtil = new ResourceUtil();
                    rUtil.initTVO(request);
                    resourceHastable = ResourceUtil.getResourcesOldNew(conn, resourceIDs, vSelectedResources);
                    toAddResources = (Vector)resourceHastable.get("toInsert_ResourceID");
                    toDeleteResources = (Vector)resourceHastable.get("toDelete_ResourceTrxnSeq");
                    int addRSize = toAddResources.size();
                    int deleteRSize = toDeleteResources.size();
                    if(addRSize != 0)
                    {
                        for(int i = 0; i < addRSize; i++)
                        {
                            String ymdDate = CommonFunction.getDate("dd-mm-yyyy", "yyyy-mm-dd", mtgDate);
                            boolean hasConflict = ResourceUtil.hasConflict(conn, (String)toAddResources.elementAt(i), ymdDate + " " + mtgStartTime, ymdDate + " " + mtgEndTime);
                            String resourceRecordID = null;
                            if(!hasConflict)
                            {
                                String approval = rUtil.checkApproval((String)toAddResources.elementAt(i));
                                String date = CommonFunction.getDate("dd-mm-yyyy", "yyyy-mm-dd", mtgDate);
                                String startTime = CommonFunction.getDate("yyyy-MM-dd HH:mm", "dd-MMM-yyyy hh:mm:ss aa", date + " " + mtgStartTime);
                                String endTime = CommonFunction.getDate("yyyy-MM-dd HH:mm", "dd-MMM-yyyy hh:mm:ss aa", date + " " + mtgEndTime);
                                resourceTrxnSeq = rUtil.bookResource(userType, userID, (String)toAddResources.elementAt(i), startTime, endTime, mtgCode + ": E-Meeting", true, false);
                                if(resourceTrxnSeq != null)
                                {
                                    mr.setResourceTrxn(resourceTrxnSeq);
                                    mr.setMeetingCode(mtgCode);
                                    if(!mr.addMeetingResource())
                                    {
                                        status = false;
                                        errorMssg = "Record(s) Not Added Successfully";
                                    }
                                }
                            } else
                            {
                                status = false;
                                errorMssg = "Resource Conflict";
                            }
                        }

                    }
                    if(status && deleteRSize != 0)
                    {
                        for(int i = 0; i < deleteRSize; i++)
                        {
                            boolean deleteStatus = mr.deleteMeetingResource(mtgCode, (String)toDeleteResources.elementAt(i));
                            if(deleteStatus)
                            {
                                String cancelStatus = rUtil.cancelResource(creatorID, (String)toDeleteResources.elementAt(i));
                                if(!cancelStatus.equals(""))
                                {
                                    status = false;
                                    errorMssg = cancelStatus;
                                }
                            } else
                            {
                                status = false;
                                errorMssg = "Meeting Resource(s) Not Cancel Successful";
                            }
                        }

                    }
                } else
                {
                    status = false;
                    errorMssg = "Connection to database is not available.";
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                session.setAttribute("errmsg", e.toString());
                status = false;
            }
            finally
            {
                dbPool.returnConnection(conn);
            }
        if(status)
        {
            EMeetingQuery emQuery = new EMeetingQuery();
            emQuery.initTVO(request);
            emQuery.setMeetingApptDirty(mtgCode);
        }
        if(status)
            CommonFunction.printAlert(request, response, "Resources Added Successfully", request.getHeader("Referer"));
        else
            CommonFunction.printAlert(request, response, errorMssg, request.getHeader("Referer"));
    }

    String mtgCode;
    String roomCode;
    String mtgDate;
    String mtgStartTime;
    String mtgEndTime;
    String errorMssg;
    String creatorID;
    String resourceSeq;
    String resourceIDs[];
    String userType;
    String resourceTrxnSeq;
    Vector vSelectedResources;
    Vector toAddResources;
    Vector toDeleteResources;
    Hashtable resourceHastable;
    String userID;
}