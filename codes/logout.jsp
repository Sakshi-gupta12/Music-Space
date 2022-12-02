
<%@ page import="Connectdb.Conn_class,java.sql.*"%>;

  
<% 
    String uname=(String)session.getAttribute("uname");
   Connectdb.Conn_class connectionClass=new Conn_class();//Connection through JDBC driver to database
        Connection connection=connectionClass.getConnection();
        Statement statement=connection.createStatement();
        String sql="UPDATE userdata SET Active=false WHERE Uname = '"+uname+"'";
        statement=connection.createStatement();
        try {
            statement.executeUpdate(sql); 
            session.removeAttribute("uname");
            session.invalidate();
            response.sendRedirect("page1.html");
        }
        catch(Exception e){
            e.printStackTrace();
        }
     
 

%>