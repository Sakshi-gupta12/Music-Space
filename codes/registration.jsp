<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<html>
<head>
  <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>new registration</title>
<link rel="stylesheet" href="registration.css"/>
</head>
<script type="text/javascript">
    function confirmPass() {
        var pass = document.getElementById("pswd").value;
        var confPass = document.getElementById("cnpswd").value;
        if(pass != confPass) {
            document.getElementById("cpasserror").innerHTML="Passwords do not Match!!";
            return false;
        }
        return true;
    }
 </script>
<body>
    <header>
       <div class="container">
        <div class="header-left">
         <a href="page1.html">Home</a>
        </div>     
        <div class="main-content">
         <div class="concept concept-six">
           <h1 class="word"><span class="char">R</span><span class="char">E</span><span class="char">G</span><span class="char">I</span><span class="char">S</span><span class="char">T</span><span class="char">E</span><span class="char">R</span></h1>
         </div>
        </div>
        <div class="header-right">
         <img class="logo" src="pictures/horizontal_on_white_by_logaster.png"/>
        </div>
       </div>
    </header>
    <div class="registers">
      <div class="details">
     <form  onsubmit="return confirmPass()" action="" method="post">
          <div id="div1">NAME :<input type="text" name="uname" required="required"/></div>
          <span style="color:white">*</span><br>
          <div id="div2">MOBILE :<input type="text" name="mobno" pattern="[6-9]{1}[0-9]{9}" required="required" title="Mobile No. should be of 10 digits.It can start with either 6,7,8 or 9."/></div>
          <span style="color:white">*</span><br>
          <div id="div3">EMAIL ID :<input type="email" name="email" required="required"/></div>
          <span style="color:white">*</span><br>
          <div id="div4">PASSWORD :<input type="password" id="pswd" name="passwd"  pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"required="required"/></div>
          <span style="color:white">*</span><br>
          <div id="div5">CONFIRM PASSWORD :<input type="text" id="cnpswd" name="cn" required="required"/></div>
          <span style="color:white">*</span><br>
          <span style="color:white" id="cpasserror"></span><br>
          <span style="color:white" id="serror"></span><br>
          <input type="submit" value="REGISTER" class="button"/><br> <!--you have to click on 'submit' only , the outer part is just css only-->
          
          <div id="div7">Already Registered?<a href="login.jsp" ><h3>Login</h3></a></div>
      
      </form>
      </div>
</div>
      
</body>
</html>
<%@page import="java.sql.*,java.util.*"%>
<%
String uname=request.getParameter("uname");
String mobno=request.getParameter("mobno");
String email=request.getParameter("email");
String passwd=request.getParameter("passwd");
String cn=request.getParameter("cn");

try
{
    int uid=0;
Class.forName("org.apache.derby.jdbc.ClientDriver");
Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
Statement st=conn.createStatement();
ResultSet rs=st.executeQuery("select * from userdata where mobno='"+mobno+"'");
if(rs.next())
{%>
    <script type="text/javascript">
                    document.getElementById("serror").innerHTML="Already a user!!Please LOGIN";
     </script>
<%}
int i=st.executeUpdate("insert into userdata(uname,mobno,email,passwd)values('"+uname+"','"+mobno+"','"+email+"','"+passwd+"')");
st.executeUpdate("update userdata set active=true where uname='"+uname+"' and email ='"+email+"'");
rs=st.executeQuery("select uid from USERDATA where uname='"+uname+"' and passwd='"+passwd+"'");
if(rs.next())
    uid=rs.getInt(1);
String x=String.valueOf(uid);
session.setAttribute("uid",x);
session.setAttribute("uname", uname);
session.setAttribute("email", email);
response.sendRedirect("pref.html");
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}   
%>