package cms.admin.meeting.bean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

public class MeetingResourceBean
  implements Serializable
{
    protected Connection conn;
    protected String meetingCode;
    protected String resourceTrxn;
    protected String errmsg;
    protected String sql;
    protected String resourceDesc;

    public void setDBConnection(Connection connection)
    {
        conn = connection;
    }

    public void setResourceTrxn(String s)
    {
        resourceTrxn = s;
    }

    public void setMeetingCode(String s)
    {
        meetingCode = s;
    }

    public void setResourceDesc(String s)
    {
        resourceDesc = s;
    }

    public String getResourceTrxn()
    {
        return resourceTrxn;
    }

    public String getMeetingCode()
    {
        return meetingCode;
    }

    public String getResourceDesc()
    {
        return resourceDesc;
    }

    public Vector querySelectedResource(String s)
    {
        Statement statement = null;
        Vector vector = new Vector();
        ResultSet resultset = null;
        sql = "SELECT resource_trxn_seq,red_resource_id, re_resource_seq, re_desc FROM meeting_resource, CMSADMIN.resource_trxn, CMSADMIN.resource_main  WHERE mtg_code = '" + s + "'" + " AND resource_trxn_seq = red_resource_trxn_seq " + " AND red_resource_id =  re_resource_seq ";
        try
        {
            statement = conn.createStatement();
            MeetingResourceBean meetingresourcebean;
            for(resultset = statement.executeQuery(sql); resultset.next(); vector.addElement(meetingresourcebean))
            {
                meetingresourcebean = new MeetingResourceBean();
                meetingresourcebean.setResourceTrxn(resultset.getString(2));
                meetingresourcebean.setResourceDesc(resultset.getString(4));
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
                {
                    resultset.close();
                    resultset = null;
                }
                if(statement != null)
                {
                    statement.close();
                    statement = null;
                }
            }
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return vector;
    }

    public Vector queryResourceTrxn(String s)
    {
        boolean flag = true;
        errmsg = "";
        Statement statement = null;
        ResultSet resultset = null;
        Vector vector = new Vector();
        sql = "SELECT resource_trxn_seq  FROM meeting_resource  WHERE mtg_code = '" + s + "'";
        try
        {
            statement = conn.createStatement();
            resultset = statement.executeQuery(sql);
            if(resultset != null)
            {
                for(int i = 0; resultset.next(); i++)
                    vector.add(resultset.getString(1));

            }
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            errmsg = sqlexception.toString();
            boolean flag1 = false;
        }
        finally
        {
            try
            {
                if(resultset != null)
                {
                    resultset.close();
                    resultset = null;
                }
                if(statement != null)
                {
                    statement.close();
                    statement = null;
                }
            }
            catch(Exception exception1) { }
        }
        return vector;
    }

    public boolean addMeetingResource()
    {
        boolean flag = true;
        errmsg = "";
        PreparedStatement preparedstatement = null;
        try
        {
            sql = " INSERT INTO meeting_resource( mtg_code, resource_trxn_seq)  VALUES( ?, ?)";
            preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, meetingCode);
            preparedstatement.setString(2, resourceTrxn);
            int i = preparedstatement.executeUpdate();
            preparedstatement.close();
            if(i <= 0)
            {
                errmsg = "No new record is created.";
                flag = false;
            }
            if(flag)
                conn.commit();
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();
            try
            {
                conn.rollback();
            }
            catch(Exception exception) { }
        }
        finally
        {
            try
            {
                if(preparedstatement != null)
                {
                    preparedstatement.close();
                    preparedstatement = null;
                }
            }
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return flag;
    }

    public boolean deleteMeetingResource(String s, String s1)
    {
        boolean flag = true;
        errmsg = "";
        PreparedStatement preparedstatement = null;
        try
        {
            sql = "DELETE meeting_resource WHERE mtg_code = ? AND resource_trxn_seq = ? ";
            preparedstatement = conn.prepareStatement(sql);
            preparedstatement.setString(1, s);
            preparedstatement.setString(2, s1);
            int i = preparedstatement.executeUpdate();
            preparedstatement.close();
            if(i <= 0)
            {
                errmsg = "No record is deleted";
                flag = false;
            }
            if(flag)
                conn.commit();
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
            flag = false;
            errmsg = sqlexception.toString();
            try
            {
                conn.rollback();
            }
            catch(Exception exception) { }
        }
        finally
        {
            try
            {
                if(preparedstatement != null)
                {
                    preparedstatement.close();
                    preparedstatement = null;
                }
            }
            catch(Exception exception2)
            {
                exception2.printStackTrace();
            }
        }
        return flag;
    }
}