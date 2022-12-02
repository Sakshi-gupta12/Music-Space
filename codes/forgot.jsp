
<%@page import="java.io.*,java.net.*,java.sql.*,java.util.*,otp.Sendotp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FORGOT PASSWORD</title>
<link href="password.css" rel="stylesheet">

<body onload="noBack();" 
	  onpageshow="if (event.persisted) noBack();" onunload="">
<SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() { window.history.forward(); }
</SCRIPT>
</head>
    <form name="f2" class="box">
        <input type="text" placeholder="username" name="txtname" class="usid" required/>
        <input type="text" placeholder="email" name="txtemail" class="usid" required/>
        <input type="text" placeholder="phonenumber" name="txtphone" pattern="[6-9]{1}[0-9]{9}" required="required" title="Mobile No. should be of 10 digits.It can start with either 6,7,8 or 9." class="usid"/>
        <br>
        <span style="color:white" id="cpasserror"></span><br>
        <input type="submit" name="btnsave" value="Next" class="button"/>
    </form>
</body>
</html>


<% 
try
{
    if(request.getParameter("btnsave")!=null){
        String name = request.getParameter("txtname");
        String email = request.getParameter("txtemail");
        String phone = request.getParameter("txtphone");
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
        Statement st=con.createStatement();
        ResultSet rs = st.executeQuery("SELECT uname,email,mobno FROM USERDATA where email='"+email+"' and mobno='"+phone+"'");
        if(rs.next())
        {
            String number = phone;
            Random rand = new Random();
            int otp = rand.nextInt(900000) + 100000;
             String otpmessage="Hey "+name+" This msg is sent by SMART MUSIC PLAYER.\n Your OTP is : "+otp;
            Sendotp sotp=new Sendotp();
            sotp.sendotp(otpmessage,number);
            out.println(otp);
            out.println(number);
            session.setAttribute("otp",otp);
            response.sendRedirect("otp.jsp");

        }
        else{
 %>
            <script type="text/javascript">
              document.getElementById("cpasserror").innerHTML="invalid details";
            </script>
        <%
           
        }
    }
}
    catch(IOException e){
            System.out.println(e);
            
    }
%>

