package cms.admin.meeting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.Vector;
import javax.servlet.ServletContext;
import paulUtil.DateUtil;
import tvo.TvoBean;
import utilities.QueryUtil;
import utilities.TaskUtil;

public class EMeetingTask extends TvoBean
{
    public boolean createTask(String s, String s1)
    {
        Connection connection = null;
        PreparedStatement preparedstatement = null;
        PreparedStatement preparedstatement1 = null;
        ResultSet resultset = null;
        ResultSet resultset1 = null;
        boolean flag = false;
        try
        {
            connection = super.getConnection();
            preparedstatement = connection.prepareStatement("SELECT MD_DECISION, MD_DUE_DATE FROM MEETING_DECISION WHERE MD_MTG_CODE = ?   AND MD_DECISION_SEQ = ?");
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            resultset = preparedstatement.executeQuery();
            preparedstatement1 = connection.prepareStatement("SELECT MM_MTG_DESC, MM_MTG_DATE, MM_MTG_TYPE_SEQNO FROM MEETING_MAIN WHERE MM_MTG_CODE = ?");
            preparedstatement1.setString(1, s);
            resultset1 = preparedstatement1.executeQuery();
            if(resultset.next() && resultset1.next())
            {
                String s2 = getInitialTaskCreator(connection, s);
                String as[] = new String[0];
                int i = 1;
                String s3 = resultset.getString("MD_DUE_DATE").substring(0, 10);
                String s4 = "17:00";
                String s5 = null;
                String s6 = resultset.getString("MD_DECISION");
                boolean flag1 = false;
                boolean flag2 = false;
                boolean flag3 = false;
                boolean flag4 = true;
                String s7 = "Meeting Desc: " + resultset1.getString("MM_MTG_DESC") + "\n" + "Meeting Date: " + DateUtil.formatDate("dd-MM-yyyy", resultset1.getDate("MM_MTG_DATE")) + "\n" + "Meeting Ref: " + resultset1.getString("MM_MTG_TYPE_SEQNO");
                Vector vector = getActionBy(connection, s, s1);
                String as1[] = new String[vector.size()];
                for(int j = 0; j < vector.size(); j++)
                {
                    Hashtable hashtable = (Hashtable)vector.get(j);
                    String s8 = (String)hashtable.get("USERID");
                    String s9 = (String)hashtable.get("CALENDARTODOID");
                    if(s9 == null)
                        as1[j] = s8;
                    else
                        throw new Exception("EMeetingTask.createTask: Unexpected data. userID=" + s8 + "; calendarToDoID=" + s9);
                }

                TaskUtil taskutil = new TaskUtil();
                taskutil.initTVO(super.request);
                int ai[] = taskutil.insertTask(s2, as1, as, i, s3, s4, s5, s6, flag1, flag2, flag3, flag4, s7);
                if(vector.size() == ai.length)
                {
                    PreparedStatement preparedstatement2 = null;
                    try
                    {
                        preparedstatement2 = connection.prepareStatement("UPDATE MEETING_DEC_ACTIONBY SET CALENDARTODOID = ? WHERE MDAB_ACTION_SEQ = ?   AND MDAB_ACTION_BY = ?");
                        for(int k = 0; k < ai.length; k++)
                        {
                            Hashtable hashtable1 = (Hashtable)vector.get(k);
                            String s10 = (String)hashtable1.get("MDAB_ACTION_BY");
                            preparedstatement2.setInt(1, ai[k]);
                            preparedstatement2.setString(2, s1);
                            preparedstatement2.setString(3, s10);
                            preparedstatement2.executeUpdate();
                        }

                        flag = true;
                    }
                    catch(Exception exception1)
                    {
                        exception1.printStackTrace();
                    }
                    finally
                    {
                        if(preparedstatement2 != null)
                            preparedstatement2.close();
                    }
                }
            }
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        finally
        {
            try
            {
                if(resultset != null)
                    resultset.close();
                if(resultset1 != null)
                    resultset1.close();
                if(preparedstatement != null)
                    preparedstatement.close();
                if(preparedstatement1 != null)
                    preparedstatement1.close();
                if(connection != null)
                    super.returnConnection(connection);
            }
            catch(Exception exception4) { }
        }
        return flag;
    }

    public boolean deleteTask(ServletContext servletcontext, String s, String s1)
    {
        Connection connection = null;
        PreparedStatement preparedstatement = null;
        boolean flag = false;
        try
        {
            connection = super.getConnection();
            Vector vector = getActionBy(connection, s, s1);
            preparedstatement = connection.prepareStatement("UPDATE MEETING_DEC_ACTIONBY SET CALENDARTODOID = null WHERE MDAB_ACTION_SEQ = ?");
            preparedstatement.setString(1, s1);
            preparedstatement.executeUpdate();
            TaskUtil taskutil = new TaskUtil();
            taskutil.initTVO(super.request);
            for(int i = 0; i < vector.size(); i++)
            {
                Hashtable hashtable = (Hashtable)vector.get(i);
                String s2 = (String)hashtable.get("CALENDARTODOID");
                if(s2 != null)
                {
                    int j = Integer.parseInt(s2);
                    taskutil.deleteTask(servletcontext, j);
                }
            }

            flag = true;
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        finally
        {
            try
            {
                if(preparedstatement != null)
                    preparedstatement.close();
                if(connection != null)
                    super.returnConnection(connection);
            }
            catch(Exception exception2) { }
        }
        return flag;
    }

    public static String getMeetingCode_From_DecisionSeq(Connection connection, String s)
    {
        Vector vector = QueryUtil.runQuery(connection, "SELECT MD_MTG_CODE FROM MEETING_DECISION WHERE MD_DECISION_SEQ = '" + s + "'");
        String s1 = null;
        if(vector.size() == 1)
        {
            Hashtable hashtable = (Hashtable)vector.get(0);
            s1 = (String)hashtable.get("MD_MTG_CODE");
        }
        return s1;
    }

    public boolean taskLinked(int i)
    {
        Connection connection = null;
        boolean flag = false;
        try
        {
            connection = super.getConnection();
            Vector vector = QueryUtil.runQuery(connection, "SELECT * FROM MEETING_DEC_ACTIONBY WHERE calendarToDoID = " + i);
            if(vector.size() != 0)
                flag = true;
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        finally
        {
            if(connection != null)
                super.returnConnection(connection);
        }
        return flag;
    }

    private Vector getActionBy(Connection connection, String s, String s1)
    {
        Vector vector = QueryUtil.runQuery(connection, "SELECT CMS_V.USERID, CMS_V.CMSID, CMS_V.USERTYPE, MEETING_DEC_ACTIONBY.MDAB_ACTION_BY, MEETING_DEC_ACTIONBY.CALENDARTODOID FROM MEETINGATTENDEES_VIEW MA_V, MEETING_DEC_ACTIONBY, CMSUSERS_VIEW CMS_V WHERE MA_V.MEETINGCODE = '" + s + "' " + "  AND MDAB_ACTION_SEQ = '" + s1 + "' " + "  AND MA_V.USERTYPE = MDAB_USER_TYPE " + "  AND ( " + "        (MDAB_USER_TYPE = 'STAFF' AND CMS_V.USERTYPE = 'STAFF' AND MA_V.STAFFID = MDAB_ACTION_BY AND MA_V.STAFFID = CMS_V.CMSID)  " + "      OR  " + "        (MDAB_USER_TYPE = 'OTHER' AND CMS_V.USERTYPE = 'EXTERNAL' AND MA_V.USERID = MDAB_ACTION_BY AND MA_V.USERID = CMS_V.USERID) " + "      )");
        return vector;
    }

    private String getInitialTaskCreator(Connection connection, String s)
    {
        Hashtable hashtable = EMeetingMain.getSecretary(connection, s);
        Hashtable hashtable1 = EMeetingMain.getChairman(connection, s);
        if(hashtable1 != null)
            return (String)hashtable1.get("USERID");
        else
            return (String)hashtable.get("USERID");
    }

}