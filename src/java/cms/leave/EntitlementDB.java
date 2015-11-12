package cms.leave;

public class EntitlementDB
{
  private String staffID;
  private String leaveType;
  private String leaveDesc;
  private int annualLeaveEntitlement;
  private int annualBalance;
  private String replacementBalance;
  private int goldenHandshakeDays;
  private int prevYearCarryForward;
  private int beforeYearCarryForward;
  private int takenBalance;

  public EntitlementDB()
  {
    this.takenBalance = 0;
    this.replacementBalance = "0";
    this.prevYearCarryForward = 0;
    this.beforeYearCarryForward = 0;
  }

  public String getStaffID()
  {
    return this.staffID;
  }

  public void setStaffID(String paramString)
  {
    this.staffID = paramString;
  }

  public String getLeaveType()
  {
    return this.leaveType;
  }

  public void setLeaveType(String paramString)
  {
    this.leaveType = paramString;
  }

  public String getLeaveDesc()
  {
    return this.leaveDesc;
  }

  public void setLeaveDesc(String paramString)
  {
    this.leaveDesc = paramString;
  }

  public int getAnnualLeaveEntitlement()
  {
    return this.annualLeaveEntitlement;
  }

  public void setAnnualLeaveEntitlement(int paramInt)
  {
    this.annualLeaveEntitlement = paramInt;
  }

  public int getAnnualBalance()
  {
    return this.annualBalance;
  }

  public void setAnnualBalance(int paramInt)
  {
    this.annualBalance = paramInt;
  }

  public String getReplacementBalance()
  {
    return this.replacementBalance;
  }

  public void setReplacementBalance(String paramString)
  {
    this.replacementBalance = paramString;
  }

  public int getTakenBalance()
  {
    return this.takenBalance;
  }

  public int getGoldenHandshakeDays()
  {
    return this.goldenHandshakeDays;
  }

  public void setGoldenHandshakeDays(int paramInt)
  {
    this.goldenHandshakeDays = paramInt;
  }

  public void setTakenBalance(int paramInt)
  {
    this.takenBalance = paramInt;
  }

  public int getPrevYearCarryForward()
  {
    return this.prevYearCarryForward;
  }

  public void setPrevYearCarryForward(int paramInt)
  {
    this.prevYearCarryForward = paramInt;
  }

  public int getBeforeYearCarryForward()
  {
    return this.beforeYearCarryForward;
  }

  public void setBeforeYearCarryForward(int paramInt)
  {
    this.beforeYearCarryForward = paramInt;
  }
}