package cms.admin.meeting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.Hashtable;
import java.util.Vector;
import javax.servlet.ServletContext;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import ecomm.bean.FreeTime;
import tvo.TvoBean;
import utilities.AppointmentUtil;
import utilities.QueryUtil;

public class EMeetingQuery extends TvoBean
{
  public Vector getMeetingDateTime(String paramString)
  {
    Vector localVector = new Vector();
    String str1 = getMeetingDateStr(paramString);
    String str2 = getMeetingStartTimeStr(paramString);
    String str3 = getMeetingEndTimeStr(paramString);
    localVector.add(FreeTime.getDateFrom_yyyyMMdd_HHmm(str1, str2));
    localVector.add(FreeTime.getDateFrom_yyyyMMdd_HHmm(str1, str3));
    return localVector;
  }

  public Vector getMeetingAttendeesVector(String paramString)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    Vector localVector = new Vector();
    try
    {
      localConnection = super.getConnection();
      localPreparedStatement = localConnection.prepareStatement("SELECT CMSUSERS_VIEW.USERID FROM  CMSUSERS_VIEW, MEETING_ATTENDANCE WHERE CMSUSERS_VIEW.CMSID = MEETING_ATTENDANCE.MA_STAFF_ID   AND CMSUSERS_VIEW.USERTYPE ='STAFF'   AND MEETING_ATTENDANCE.MA_MTG_CODE = ?");
      localPreparedStatement.setString(1, paramString);
      for (localResultSet = localPreparedStatement.executeQuery(); localResultSet.next(); localVector.add(localResultSet.getString("USERID")));
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (localConnection != null)
          super.returnConnection(localConnection);
      } catch (Exception localException2) {
      }
    }
    return localVector;
  }

  public static boolean isResourceLinked_EMeeting(Connection connection, String s)
  {
      boolean flag = false;
      PreparedStatement preparedstatement = null;
      ResultSet resultset = null;
      try
      {
          preparedstatement = connection.prepareStatement("SELECT RESOURCE_TRXN_SEQ FROM MEETING_RESOURCE WHERE RESOURCE_TRXN_SEQ = ?");
          preparedstatement.setString(1, s);
          resultset = preparedstatement.executeQuery();
          if(resultset.next())
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
              if(resultset != null)
                  resultset.close();
              if(preparedstatement != null)
                  preparedstatement.close();
          }
          catch(Exception exception2) { }
      }
      return flag;
  }

  public String getMeetingAttendeesList(String paramString)
  {
    Vector localVector = getMeetingAttendeesVector(paramString);
    String str = "";
    for (int i = 0; i < localVector.size(); ++i)
    {
      if (i != 0)
        str = str + ", ";
      str = str + "'" + ((String)localVector.get(i)) + "'";
    }

    return str;
  }

  public Hashtable getMeetingCompulsoryAttendees(String paramString1, String paramString2)
  {
    Vector localVector = getMeetingAttendeesVector(paramString1);
    boolean bool;
    if (localVector.remove(paramString2))
      bool = false;
    else
      bool = true;
    String[] arrayOfString = new String[localVector.size()];
    for (int i = 0; i < localVector.size(); ++i) {
      arrayOfString[i] = ((String)localVector.get(i));
    }
    Hashtable localHashtable = new Hashtable();
    localHashtable.put("excludeScheduler", new Boolean(bool));
    localHashtable.put("compulsoryAttendees", arrayOfString);
    return localHashtable;
  }

  public String getMeetingDesc(String paramString)
  {
    return getMeetingInfo(paramString, "MM_MTG_DESC");
  }

  public Date getMeetingDate(String paramString)
  {
    String str = getMeetingDateStr(paramString);
    return FreeTime.getDateFrom_yyyyMMdd_HHmm(str, "00:00");
  }

  public String getMeetingDateStr(String paramString)
  {
    String str = getMeetingInfo(paramString, "MM_MTG_DATE");
    return str.substring(0, 10);
  }

  public String getMeetingStartTimeStr(String paramString)
  {
    String str = getMeetingInfo(paramString, "MM_MTG_STARTTIME");
    return str.substring(11, 16);
  }

  public String getMeetingEndTimeStr(String paramString)
  {
    String str = getMeetingInfo(paramString, "MM_MTG_ENDTIME");
    return str.substring(11, 16);
  }

  private String getMeetingInfo(String paramString1, String paramString2)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    String str = "";
    try
    {
      localConnection = super.getConnection();
      localPreparedStatement = localConnection.prepareStatement("SELECT " + paramString2 + " " + "FROM MEETING_MAIN " + "WHERE MM_MTG_CODE = ?");
      localPreparedStatement.setString(1, paramString1);
      localResultSet = localPreparedStatement.executeQuery();
      if (localResultSet.next())
        str = localResultSet.getString(paramString2);
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (localConnection != null)
          super.returnConnection(localConnection);
      } catch (Exception localException2) {
      }
    }
    return str;
  }

  public String getMeetingCode(int paramInt)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    String str = null;
    try
    {
      localConnection = super.getConnection();
      localPreparedStatement = localConnection.prepareStatement("SELECT MTG_CODE FROM MEETING_APPOINTMENT WHERE CALENDARAPPTID = ?");
      localPreparedStatement.setInt(1, paramInt);
      localResultSet = localPreparedStatement.executeQuery();
      if (localResultSet.next())
        str = localResultSet.getString("MTG_CODE");
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (localConnection != null)
          super.returnConnection(localConnection);
      } catch (Exception localException2) {
      }
    }
    return str;
  }

  public Vector getMeetingConflict(String paramString)
  {
    Vector localVector1 = getMeetingDateTime(paramString);
    String str1 = getMeetingAttendeesList(paramString);
    FreeTime localFreeTime = new FreeTime();
    localFreeTime.initTVO(this.request);
    Vector localVector2 = new Vector();
    if (localVector1.size() == 2)
      localVector2 = localFreeTime.getUserConflict((Date)localVector1.get(0), (Date)localVector1.get(1), str1);
    if (localVector2.size() != 0)
    {
      Hashtable localHashtable1 = getMeetingApptInfo(paramString);
      String str2 = (String)localHashtable1.get("CALENDARAPPTID");
      if (str2 != null)
      {
        for (int i = 0; i < localVector2.size(); ++i)
        {
          Hashtable localHashtable2 = (Hashtable)localVector2.get(i);
          Vector localVector3 = (Vector)localHashtable2.get("conflicts");
          for (int j = 0; j < localVector3.size(); ++j)
          {
            Hashtable localHashtable3 = (Hashtable)localVector3.get(j);
            String str3 = (String)localHashtable3.get("CalendarApptID");
            if (!(str2.equals(str3)))
              continue;
            localVector3.remove(j);
            break;
          }
        }
      }

    }

    return localVector2;
  }

  public Hashtable getMeetingApptInfo(String paramString)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    ResultSet localResultSet = null;
    Hashtable localHashtable = new Hashtable();
    try
    {
      localConnection = super.getConnection();
      localPreparedStatement = localConnection.prepareStatement("SELECT CALENDARAPPTID, ISDIRTY FROM MEETING_APPOINTMENT WHERE MTG_CODE = ?");
      localPreparedStatement.setString(1, paramString);
      localResultSet = localPreparedStatement.executeQuery();
      if (localResultSet.next())
      {
        localHashtable.put("CALENDARAPPTID", localResultSet.getString("CALENDARAPPTID"));
        localHashtable.put("ISDIRTY", localResultSet.getString("ISDIRTY"));
      }
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localResultSet != null)
          localResultSet.close();
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (localConnection != null)
          super.returnConnection(localConnection);
      } catch (Exception localException2) {
      }
    }
    return localHashtable;
  }

  public void setMeetingApptDirty(String paramString)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    try
    {
      localConnection = super.getConnection();
      localPreparedStatement = localConnection.prepareStatement("UPDATE MEETING_APPOINTMENT SET ISDIRTY = '1' WHERE MTG_CODE = ?");
      localPreparedStatement.setString(1, paramString);
      localPreparedStatement.executeUpdate();
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (localConnection != null)
          super.returnConnection(localConnection);
      }
      catch (Exception localException2) {
      }
    }
  }

  public void deleteMeetingAppt(ServletContext paramServletContext, String paramString1, String paramString2) {
    Hashtable localHashtable = getMeetingApptInfo(paramString2);
    String str = (String)localHashtable.get("CALENDARAPPTID");
    if (str == null)
      return;
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    try
    {
      localConnection = super.getConnection();
      localPreparedStatement = localConnection.prepareStatement("DELETE MEETING_APPOINTMENT WHERE MTG_CODE = ?");
      localPreparedStatement.setString(1, paramString2);
      localPreparedStatement.executeUpdate();
      AppointmentUtil localAppointmentUtil = new AppointmentUtil();
      localAppointmentUtil.initTVO(this.request);
      localAppointmentUtil.deleteAppointment(paramServletContext, paramString1, Integer.parseInt(str));
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (localConnection != null)
          super.returnConnection(localConnection);
      }
      catch (Exception localException2)
      {
      }
    }
  }

  private void createMeetingApptLink(String paramString, int paramInt) {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null;
    try
    {
      localConnection = super.getConnection();
      localPreparedStatement = localConnection.prepareStatement("INSERT INTO MEETING_APPOINTMENT (MTG_CODE, CALENDARAPPTID) VALUES (?, ?)");
      localPreparedStatement.setString(1, paramString);
      localPreparedStatement.setInt(2, paramInt);
      localPreparedStatement.executeUpdate();
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    finally
    {
      try
      {
        if (localPreparedStatement != null)
          localPreparedStatement.close();
        if (localConnection != null)
          super.returnConnection(localConnection);
      }
      catch (Exception localException2) {
      }
    }
  }

  public void setMeetingAppt(ServletContext servletcontext, String s, String s1, boolean flag, boolean flag1, String s2)
  {
      Hashtable hashtable = getMeetingApptInfo(s);
      boolean flag2 = true;
      if(hashtable.get("CALENDARAPPTID") != null)
      {
          deleteMeetingAppt(servletcontext, s1, s);
          flag2 = false;
      }
      String s3 = "";
      String s4 = "";
      Connection connection = null;
      try
      {
          connection = super.getConnection();
          Vector vector = QueryUtil.runQuery(connection, "SELECT MM_MTG_DESC FROM MEETING_MAIN WHERE MM_MTG_CODE = '" + s + "'");
          s3 = (String)((Hashtable)vector.get(0)).get("MM_MTG_DESC");
          Vector vector1 = QueryUtil.runQuery(connection, "SELECT RM_ROOM_CODE, RM_ROOM_DESC FROM MEETING_VENUE, CMSADMIN.ROOM_MAIN WHERE MV_ROOM_CODE = RM_ROOM_CODE AND MV_MTG_CODE = '" + s + "'");
          if(vector1.size() == 1)
          {
              Hashtable hashtable1 = (Hashtable)vector1.get(0);
              s4 = hashtable1.get("RM_ROOM_CODE") + " - " + hashtable1.get("RM_ROOM_DESC");
          }
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
      String s5 = getMeetingDateStr(s);
      String s6 = s5;
      String s7 = getMeetingStartTimeStr(s);
      String s8 = getMeetingEndTimeStr(s);
      String s9 = null;
      String s10 = (flag2 ? "New E-Meeting" : "Updated E-Meeting") + ":\n" + s3;
      String s11 = "";
      String s12 = s4;
      boolean flag3 = true;
      Hashtable hashtable2 = getMeetingCompulsoryAttendees(s, s1);
      boolean flag4 = ((Boolean)hashtable2.get("excludeScheduler")).booleanValue();
      String as[] = (String[])hashtable2.get("compulsoryAttendees");
      String as1[] = null;
      AppointmentUtil appointmentutil = new AppointmentUtil();
      appointmentutil.initTVO(super.request);
      int i = appointmentutil.insertAppointment(s1, s5, s7, s6, s8, s9, s10, s11, s12, flag3, flag4, as, as1, flag, flag1, s2);
      createMeetingApptLink(s, i);
  }

  public static String genMinuteCode(String meetingCode)
  {
      return encrypt(meetingCode).substring(0, 8);
  }

  private static String encrypt(String password)
  {
      try
      {
          MessageDigest md = MessageDigest.getInstance("MD5");
          byte encryptedBytes[] = md.digest(password.getBytes());
          String encryptedPassword = "";
          for(int i = 0; i < encryptedBytes.length; i++)
              encryptedPassword = encryptedPassword + byteToHex(encryptedBytes[i]);

          return encryptedPassword;
      }
      catch(NoSuchAlgorithmException nosuchalgorithmexception)
      {
          return password;
      }
  }

  private static String byteToHex(byte b)
  {
      char hexDigit[] = {
          '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
          'a', 'b', 'c', 'd', 'e', 'f'
      };
      char array[] = {
          hexDigit[b >> 4 & 0xf], hexDigit[b & 0xf]
      };
      return new String(array);
  }
  
}