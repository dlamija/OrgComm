<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*" %>
<% //if (request.getParameter("action").equals("sendkatalaluan") && status3) {
    
	boolean status = true;
	String mailServer = "172.16.30.45";
	String fromEmail    = "recruitment@ump.edu.my";
	String toEmail      = email;
	String msg1 = "PERMOHONAN JAWATAN SECARA ONLINE UNIVERSITI MALAYSIA PAHANG";
	//String msg2 = "                                                                                              ";
	String newline = System.getProperty("line.separator");       
	String msg3 = "Terima kasih kerana berurusan dengan Universiti Malaysia Pahang. Permohonan online anda selamat "+
				  "diterima dan akan diproses dalam masa yang ditetapkan dengan kadar segera. ";
	String msg4 = "Untuk sebarang maklumat lanjut, sila hubungi :-";
	String msg5 = "Unit Perjawatan, Bahagian Sumber Manusia";
	String msg6 = "Jabatan Pendaftar";
	String msg7 = "Universiti Malaysia Pahang,";
	String msg8 = "Lebuhraya Tun Razak,";
	String msg9 = "26300 Gambang,Kuantan";
	String msg10 = "Pahang Darul Makmur";
	String msg11 = "Tel : 09-5492522/ 2521/ 2504";
	String msg12 = "Faks : 09-5492544/ 9181";
	String msg13 = "Email : recruitmenthr@ump.edu.my";
	String messageEnter = msg1 +  newline + newline + msg3 +  newline + newline + msg4 + newline + newline + msg5 +  newline + msg6 +  newline + msg7 +  newline + msg8 +  newline + msg9 +  newline + msg10 +  newline + msg11 +  newline + msg12 +  newline + msg13;


  if(toEmail.equals("") )
       toEmail = "recruitment@ump.edu.my";
 
  try
  {

    Properties props = new Properties();
    props.put("mail.smtp.host", mailServer);
    Session s = Session.getInstance(props,null);
    MimeMessage message = new MimeMessage(s);
    InternetAddress from = new InternetAddress(fromEmail);
    message.setFrom(from);
    InternetAddress to = new InternetAddress(toEmail);
    message.addRecipient(Message.RecipientType.TO, to);
    message.setSubject("Permohonan Jawatan Secara Online Universiti Malaysia Pahang");
    message.setText(messageEnter);
    Transport.send(message);
  }
  catch(NullPointerException n)
  {
     System.out.println(n.getMessage() );
     out.println("ERROR, you need to enter a message");
     status = false;

  }
  catch (Exception e)
  {
     System.out.println(e.getMessage() );
     //out.println("ERROR, your message to " + toEmail + " failed, reason is: " + e);
     status = false;

  }
%>
