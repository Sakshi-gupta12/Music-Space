<%@ page import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="login.css" rel="stylesheet">

<body onload="noBack();" 
	  onpageshow="if (event.persisted) noBack();" onunload="">
    <header>
       
      <div class="container">
        <div class="header-left">
          <a href="page1.html">Home</a>
        </div>
        <div class="main-content">
          <div class="concept concept-six">
            <h1 class="word"><span class="char">L</span><span class="char">O</span><span class="char">G</span><span class="char">I</span><span class="char">N</span></h1>
          </div>
        </div>
        <div class="header-right">
          <img class="logo" src="pictures/horizontal_on_white_by_logaster.png"/>         
        </div>
       </div>
    </header>
    <form class="box" method="post">
        <SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() { window.history.forward(); }
</SCRIPT>
<%

response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
    if(session.getAttribute("token")==null){
}
%>
</head>
            <input type="text" placeholder="username" name="txtname" class="usid" required="required">
            <span style="color:white">*</span><br>
            <input type="password" placeholder="password" name="txtpswd" class="usid">
            <br> <span style="color:white" id="cpasserror"></span>
            <br><input type="submit" value="login" name="btnlogin" class="buttons">
            <br><input type="submit" value="Forgot Password " name="btnfrtpswd" class="buttons">
    </form>
</body>
</html>


<% 
    try{ 
        int uid=0;
        if(request.getParameter("btnlogin")!=null){
        String uname=request.getParameter("txtname");
        String password=request.getParameter("txtpswd");
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
        Statement st= con.createStatement();
        ResultSet rs=st.executeQuery("select * from USERDATA where uname='"+uname+"' and passwd='"+password+"'");
        if(rs.next()){
        if(password.equals(rs.getString("passwd")) && uname.equals(rs.getString("uname")))
        {
            st.executeUpdate("Update USERDATA SET Active=true where uname='"+uname+"'");
            rs=st.executeQuery("select uid from USERDATA where uname='"+uname+"' and passwd='"+password+"'");
            if(rs.next())
                uid=rs.getInt(1);
            String x=String.valueOf(uid);
            request.getSession();  
            session.setAttribute("uname", uname);
            session.setAttribute("uid",x);
            response.sendRedirect("player.jsp");   
        }
        }
        else{ 
                
          %>
                   <script type="text/javascript">
                    document.getElementById("cpasserror").innerHTML="Invalid details";
                   </script>
          <% 
        }
        }
        else if(request.getParameter("btnfrtpswd")!=null){
             response.sendRedirect("forgotpass.html");   
        }
   }
catch (Exception e) {
e.printStackTrace();
}
%>

