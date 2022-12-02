<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<head>
<body onload="noBack();" 
	  onpageshow="if (event.persisted) noBack();" onunload="">
    <SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() { window.history.forward(); }
</SCRIPT>
</head>
</body>
<%
//String name=(String)session.getAttribute("name");
//String email=(String)session.getAttribute("email");
//String phone=(String)session.getAttribute("phone");
int otp= (Integer) session.getAttribute("otp");
String otpvalue=request.getParameter("otpvalue");
int enterOtp=Integer.parseInt(otpvalue);
if(otp==enterOtp)
{
try
{
 response.sendRedirect("change password.jsp");
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
}
else
{
out.println("OTP not matched");
}
%>