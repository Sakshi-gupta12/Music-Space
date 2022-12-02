<%@page import="java.util.Random"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>OTP VERIFICATION</title>
<link href="password.css" rel="stylesheet">
<body onload="noBack();" 
	  onpageshow="if (event.persisted) noBack();" onunload="">
<SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() { window.history.forward(); }
</SCRIPT>
</head>
<form action="otpprocess.jsp" method="post" class="box">
<input type="text" placeholder="otp" name="otpvalue" class="usid" required/>
<input type="submit" value="Verify" class="button"/>
</form>
</body>
</html>