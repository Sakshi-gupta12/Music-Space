
<%@ page import="Connectdb.Conn_class,java.io.IOException,java.sql.*,java.util.ArrayList,java.time.LocalTime,java.time.LocalDate"%>
<%! 
    String uname,email,sql;
    int uid;
    %>
    <%
         uname=(String)session.getAttribute("uname");
         email=(String)session.getAttribute("email");
        Connectdb.Conn_class connectionClass = new Conn_class();
         Connection connection = connectionClass.getConnection();
         Statement statement = connection.createStatement();                     


//      ------------------CHECKING IF USER OF THE SAME USERNAME EXISTS IN THE DATABASE---------------------

        String sql = "SELECT uid FROM userdata WHERE uname='"+uname+"' and email='"+email+"'";
        
        try {
            ResultSet resultSet=statement.executeQuery(sql);
            if(resultSet.next())
            {
                uid=resultSet.getInt(1);
            }
        
            if(request.getParameter("btn_submit")!=null)
            {
                String gen[]=request.getParameterValues("chk_gen");
                String lang[]=request.getParameterValues("chk_lang");
                String art[]=request.getParameterValues("chk_art");


       
       //        ----------------------Traversing the list of languages and storing ticked entries in database------
                for (String str : lang)
                {
                   int data=0;
                    sql = "SELECT LID FROM Lang WHERE LName='"+str+"'";
                    statement = connection.createStatement();
                    try {
                        resultSet = statement.executeQuery(sql);
                        if(resultSet.next()){
                            data = resultSet.getInt(1);
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    sql = "INSERT INTO userlang(UID, LID) VALUES ("+uid+","+data+")";
                    statement = connection.createStatement();
                    try {
                        statement.executeUpdate(sql);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                    //        ----------------------Traversing the list of genres and storing ticked entries in database----
                for (String str : gen)
                {
                    int data=0;
                    sql = "SELECT GID FROM Genre WHERE GName='"+str+"'";
                    statement = connection.createStatement();
                    try {
                        resultSet = statement.executeQuery(sql);
                        if(resultSet.next()){
                            data = resultSet.getInt(1);
                        }

                    } catch (Exception e) {
                          e.printStackTrace();
                    }

                    sql = "INSERT INTO usergenre(UID,GID) VALUES ("+uid+","+data+")";
                    statement = connection.createStatement();
                    try {
                        statement.executeUpdate(sql);
                    } catch (Exception e) {
                        e.printStackTrace();
                    } 
                }
        //        ----------------------Traversing the list of artists and storing ticked entries in database------
                for (String str : art)
                {
                    int data=0;
                    sql = "SELECT AID FROM Artist WHERE AName='"+str+"'";
                    statement = connection.createStatement();
                    try {
                        resultSet = statement.executeQuery(sql);
                        if(resultSet.next()){
                            data = resultSet.getInt(1);
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    sql = "INSERT INTO userartist(UID, AID) VALUES ("+uid+","+data+")";
                    statement = connection.createStatement();
                    try {
                        statement.executeUpdate(sql);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                response.sendRedirect("player.jsp");
            }
            
        }
        catch(Exception ex)
        {
                ex.printStackTrace();
        }
       %>
