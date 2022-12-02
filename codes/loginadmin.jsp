
<%@ page import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
  <!--for logging as an admin the admin's username and password must already be present in the database(ADMINLOGIN TABLE) -->
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="login.css" rel="stylesheet">

<body onload="noBack();" 
	  onpageshow="if (event.persisted) noBack();" onunload="">
<SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() { window.history.forward(); }
</SCRIPT>
</head>
    <header>
      <div class="container">
        <div class="header-left">
          <a href="page1.html">Home</a>
        </div>
        <div class="main-content">
          <div class="concept concept-six">
            <h1 class="word"><span class="char">A</span><span class="char">D</span><span class="char">M</span><span class="char">I</span><span class="char">N</span></h1>
          </div>
        </div>
        <div class="header-right">
          <img class="logo" src="pictures/horizontal_on_white_by_logaster.png"/>         
        </div>
       </div>
    </header>
    <form class="box">
            <input type="text" placeholder="username" name="txtname" class="usid" required="required">
            <span style="color:white">*</span><br>
            <input type="password" placeholder="password" name="txtpswd" class="usid">
            <br> <span style="color:white" id="cpasserror"></span>
            <br><input type="submit" value="login" name="btnlogin" class="buttons">
    </form>
</body>
</html>


<% 
    try{ 
        
        if(request.getParameter("btnlogin")!=null){
        String aname=request.getParameter("txtname");
        String password=request.getParameter("txtpswd");
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        java.sql.Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
        Statement st= con.createStatement();
        ResultSet rs=st.executeQuery("select * from adminlogin where adminname='"+aname+"' and adminpswd='"+password+"'");
        if(rs.next()){
        if(password.equals(rs.getString("adminpswd")) && aname.equals(rs.getString("adminname")))
        {
           
            response.sendRedirect("admin.jsp");   
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
   }
catch (Exception e) {
e.printStackTrace();
}
%>


