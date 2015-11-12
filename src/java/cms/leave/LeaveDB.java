package cms.leave;

public class LeaveDB
{
  private String leaveID;
  private String staffID;
  private String staffName;
  private String leaveCode;
  private String leaveType;
  private String leaveBalance;
  private String dateFrom;
  private String dateTo;
  private String applyDate;
  private int totalDays;
  private String status;
  private String substitute;
  private String substituteID;
  private String reason;
  private String address;
  private String contactNo;
  private String leaveTypeDet;

  public void setLeaveID(String leaveID)
  {
    this.leaveID = leaveID;
  }

  public void setStaffID(String staffID)
  {
    this.staffID = staffID;
  }

  public String getLeaveTypeDet() {
	return leaveTypeDet;
  }

  public void setLeaveTypeDet(String leaveTypeDet) {
	this.leaveTypeDet = leaveTypeDet;
  }

  public void setStaffName(String staffName)
  {
    this.staffName = staffName;
  }

  public void setLeaveCode(String leaveCode)
  {
    this.leaveCode = leaveCode;
  }

  public void setLeaveType(String leaveType)
  {
    this.leaveType = leaveType;
  }

  public void setLeaveBalance(String leaveBalance)
  {
    this.leaveBalance = leaveBalance;
  }

  public void setDateFrom(String dateFrom)
  {
    this.dateFrom = dateFrom;
  }

  public void setDateTo(String dateTo)
  {
    this.dateTo = dateTo;
  }

  public void setApplyDate(String applyDate)
  {
    this.applyDate = applyDate;
  }

  public void setTotalDays(int totalDays)
  {
    this.totalDays = totalDays;
  }

  public void setStatus(String status)
  {
    this.status = status;
  }

  public void setSubstitute(String substitute)
  {
    this.substitute = substitute;
  }

  public void setSubstituteID(String substituteID)
  {
    this.substituteID = substituteID;
  }

  public void setReason(String reason)
  {
    this.reason = reason;
  }

  public void setAddress(String address)
  {
    this.address = address;
  }

  public void setContactNo(String contactNo)
  {
    this.contactNo = contactNo;
  }

  public String getLeaveID()
  {
    return this.leaveID;
  }

  public String getStaffID()
  {
    return this.staffID;
  }

  public String getStaffName()
  {
    return this.staffName;
  }

  public String getLeaveCode()
  {
    return this.leaveCode;
  }

  public String getLeaveType()
  {
    return this.leaveType;
  }

  public String getLeaveBalance()
  {
    return this.leaveBalance;
  }

  public String getDateFrom()
  {
    return this.dateFrom;
  }

  public String getDateTo()
  {
    return this.dateTo;
  }

  public String getApplyDate()
  {
    return this.applyDate;
  }

  public int getTotalDays()
  {
    return this.totalDays;
  }

  public String getStatus()
  {
    return this.status;
  }

  public String getSubstitute()
  {
    return this.substitute;
  }

  public String getSubstituteID()
  {
    return this.substituteID;
  }

  public String getReason()
  {
    return this.reason;
  }

  public String getAddress()
  {
    return this.address;
  }

  public String getContactNo()
  {
    return this.contactNo;
  }
}
