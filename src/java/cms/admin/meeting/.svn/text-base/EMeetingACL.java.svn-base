package cms.admin.meeting;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Hashtable;
import tvo.TvoBean;
import tvo.TvoDebug;

public class EMeetingACL extends TvoBean
{
  public void ACL()
  {
  }

  public Hashtable getRights(String paramString1, String paramString2, String paramString3)
  {
    Connection localConnection = null;
    PreparedStatement localPreparedStatement1 = null;
    PreparedStatement localPreparedStatement2 = null;
    ResultSet localResultSet = null;
    Hashtable localHashtable = null;
    Object localObject1 = null;
    localHashtable = new Hashtable();
    if ((paramString1 != null) && (paramString2 != null) && (paramString3 != null))
      try
      {
        localConnection = super.getConnection();
        localPreparedStatement1 = localConnection.prepareStatement("SELECT userID, \"VIEW\", add_, \"EDIT\", delete_, approve, setup FROM " + paramString2 + "ACLUsers WHERE " + paramString2 + "ACLUsers.userID = ? ");
        localPreparedStatement2 = localConnection.prepareStatement("SELECT UsersGroups.userID as userID, Max(\"VIEW\") as view_, Max(add_) as add_, Max(\"EDIT\") as edit_, Max(delete_) as delete_, Max(approve) as approve_ , Max(setup) as setup_ FROM " + paramString2 + "ACLGroups, UsersGroups, Groups " + "WHERE " + paramString2 + "ACLGroups.groupID = UsersGroups.GroupID AND " + "UsersGroups.GroupID = Groups.groupID AND " + "Groups.isActive = '1' AND " + "UsersGroups.userID = ? " + "GROUP BY UsersGroups.userID");
        localPreparedStatement1.clearParameters();
        localPreparedStatement2.clearParameters();
        localPreparedStatement1.setString(1, paramString1);
        localPreparedStatement2.setString(1, paramString1);
        String str = "User";
        if (str.equals(paramString3))
        {
          localResultSet = localPreparedStatement1.executeQuery();
          if (localResultSet != null)
          {
            if (localResultSet.next())
            {
              localHashtable.put("type", str);
              localHashtable.put("userID", localResultSet.getString("userID"));
              localHashtable.put("view", localResultSet.getString("view"));
              localHashtable.put("add", localResultSet.getString("add_"));
              localHashtable.put("edit", localResultSet.getString("edit"));
              localHashtable.put("delete", localResultSet.getString("delete_"));
              localHashtable.put("approve", localResultSet.getString("approve"));
              localHashtable.put("setup", localResultSet.getString("setup"));
            }
            else {
              localHashtable.put("type", str);
              str = "0";
              localHashtable.put("userID", paramString1);
              localHashtable.put("view", str);
              localHashtable.put("add", str);
              localHashtable.put("edit", str);
              localHashtable.put("delete", str);
              localHashtable.put("approve", str);
              localHashtable.put("setup", str);
            }
            localResultSet.close();
          }
          else {
            localHashtable.put("type", str);
            str = "0";
            localHashtable.put("userID", paramString1);
            localHashtable.put("view", str);
            localHashtable.put("add", str);
            localHashtable.put("edit", str);
            localHashtable.put("delete", str);
            localHashtable.put("approve", str);
            localHashtable.put("setup", str);
          }
        }
        str = "Group";
        if (str.equals(paramString3))
        {
          localResultSet = localPreparedStatement2.executeQuery();
          if (localResultSet != null)
          {
            if (localResultSet.next())
            {
              localHashtable.put("type", str);
              localHashtable.put("userID", localResultSet.getString("userID"));
              localHashtable.put("view", localResultSet.getString("view_"));
              localHashtable.put("add", localResultSet.getString("add_"));
              localHashtable.put("edit", localResultSet.getString("edit_"));
              localHashtable.put("delete", localResultSet.getString("delete_"));
              localHashtable.put("approve", localResultSet.getString("approve_"));
              localHashtable.put("setup", localResultSet.getString("setup_"));
            }
            else {
              localHashtable.put("type", str);
              str = "0";
              localHashtable.put("userID", paramString1);
              localHashtable.put("view", str);
              localHashtable.put("add", str);
              localHashtable.put("edit", str);
              localHashtable.put("delete", str);
              localHashtable.put("approve", str);
              localHashtable.put("setup", str);
            }
            localResultSet.close();
          }
          else {
            localHashtable.put("type", str);
            str = "0";
            localHashtable.put("userID", paramString1);
            localHashtable.put("view", str);
            localHashtable.put("add", str);
            localHashtable.put("edit", str);
            localHashtable.put("delete", str);
            localHashtable.put("approve", str);
            localHashtable.put("setup", str);
          }
        }
        localPreparedStatement2.close();
        localPreparedStatement1.close();
      }
      catch (Exception localException1)
      {
        TvoDebug.printStackTrace(localException1);
        System.out.println("ACL.getRights():SQLException: " + localException1.getMessage());
      }
      finally
      {
        try
        {
          if (localResultSet != null)
            localResultSet.close();
          if (localPreparedStatement2 != null)
            localPreparedStatement2.close();
          if (localPreparedStatement1 != null)
            localPreparedStatement1.close();
        } catch (Exception localException2) {
        }
        super.returnConnection(localConnection);
      }
    return localHashtable;
  }
}