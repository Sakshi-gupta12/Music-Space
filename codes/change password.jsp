<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager,java.sql.*"%>


<!DOCTYPE html>
<html>
    <!--after changing the password user have to login again-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <link href="password.css" rel="stylesheet">
    </head>
    <body>
       <form class="box">
            <input type="text" placeholder="username" name ="txtu" class="usid" required/>
            <input type="password" placeholder="New Password" name="txtp" class="usid" required/>
            <input type="password" placeholder="Re-enter Password:" id="pswd" name="txtcp" class="usid" required/>
            <span style="color:white" id="cpasserror"></span><br>
            <input type="submit" name="btnsave" value="Save" id="cnpswd" class='button'>
    </form>
    
    </body>
</html>
<%
    try{
        if(request.getParameter("btnsave")!=null){
        String u=request.getParameter("txtu");
        String p=request.getParameter("txtp");
        String cp=request.getParameter("txtcp");
        String user="";
        Statement st = null;
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
        st=con.createStatement();
        ResultSet rs= st.executeQuery("select * from USERDATA where uname = '"+u+"'");
        if (rs.next()){
            user=rs.getString("uname");
        }
        if(p.equals(cp)){
            
            if(user.equals(u)){
                st=con.createStatement();
                int x=st.executeUpdate("Update USERDATA SET passwd='"+p+"' where uname ='"+u+"'");
                  %>
                   <script type="text/javascript">
                    document.getElementById("cpasserror").innerHTML="Password changed successfully!!!";
                   </script>
          <%
                response.sendRedirect("change password.jsp");%>
                
           <% }
            else{
                 %>
                   <script type="text/javascript">
                    document.getElementById("cpasserror").innerHTML="Username doesn't match";
                   </script>
          <%
            }
        }
        else{
          %>
                   <script type="text/javascript">
                    document.getElementById("cpasserror").innerHTML="password doesn't matching";
                   </script>
          <%
        }
        }%>
        <form action="login.jsp">
                <button type="submit" class="usid">LOGIN</button>
                </form>
    <%}
    catch(Exception e){
        out.println(e);
    }
%>