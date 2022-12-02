<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>PREFERENCES</title>
	<link rel="stylesheet" href="pref.css">
</head>
<body>
<header>
      <div class="container">
        <div class="header-left">
          <img class="logo" src="pictures/horizontal_on_white_by_logaster.png"/>
        </div>
        <div class="header-msg">
            <h2><i>SELECT YOUR FAVORITES</i></h2>
        </div>
        <div class="header-right">
         <a href="player.jsp">Home</a>
        </div>
      </div>
</header>
<form name="f1" method="post">
<div class="wrapper">
  <div class="title">
    Choose your favorite language from below options
  </div>

  <div class="container0">
    <label class="option_item">
      <input type="checkbox" name="chk_lang" class="checkbox" value="English">
      <div class="option_inner english">
          <div class="tickmark"></div>
        <div class="name">English</div>
      </div>
    </label>
    <label class="option_item">
      <input type="checkbox" name="chk_lang" class="checkbox" checked value="Hindi">
      <div class="option_inner hindi">
        <div class="tickmark"></div>
        <div class="name">Hindi</div>
      </div>
    </label>
    <label class="option_item">
      <input type="checkbox" name="chk_lang" class="checkbox" value="Punjabi">
      <div class="option_inner punjabi">
        <div class="tickmark"></div>
        <div class="name">Punjabi</div>
      </div>
    </label>
    <label class="option_item">
      <input type="checkbox" name="chk_lang" class="checkbox" checked value="Spanish">
      <div class="option_inner spanish">
        <div class="tickmark"></div>
        <div class="name">Spanish</div>
      </div>
    </label>
  </div>
</div>
 
    <div class="wrapper1">
  <div class="title1">
    Choose your favorite genre from below options
  </div>

  <div class="container1">
    <label class="option_item1">
      <input type="checkbox" name="chk_gen" class="checkbox" value="Pop">
      <div class="option_inner pop">
        <div class="tickmark"></div>
        <div class="name">Pop</div>
      </div>
    </label>
    <label class="option_item1">
      <input type="checkbox" name="chk_gen" class="checkbox" checked value="Rock">
      <div class="option_inner rock">
        <div class="tickmark"></div>
        <div class="name">Rock</div>
      </div>
    </label>
    <label class="option_item1">
      <input type="checkbox" name="chk_gen" class="checkbox" value="Rap">
      <div class="option_inner rap">
        <div class="tickmark"></div>
        <div class="name">Rap</div>
      </div>
    </label>
    <label class="option_item1">
      <input type="checkbox" name="chk_gen" class="checkbox" value="Romantic" checked>
      <div class="option_inner romantic">
        <div class="tickmark"></div>
        <div class="name">Romantic</div>
      </div>
    </label>
      <label class="option_item1">
      <input type="checkbox" name="chk_gen" class="checkbox" value="Sad" checked>
      <div class="option_inner sad">
        <div class="tickmark"></div>
        <div class="name">Sad</div>
      </div>
    </label>
  </div>
 </div>
<div class="wrapper2">
  <div class="title2">
    Choose your favorite artist from below options
  </div>

  <div class="container2">
    <label class="option_item2">
      <input type="checkbox" name="chk_art" class="checkbox" value="Post Malone">
      <div class="option_inner postmalone">
        <div class="tickmark"></div>
        <div class="name">Post Malone</div>
      </div>
    </label>
    <label class="option_item2">
      <input type="checkbox" name="chk_art" class="checkbox" value="Shakira" checked >
      <div class="option_inner shakira">
        <div class="tickmark"></div>
        <div class="name">Shakira</div>
      </div>
    </label>
    <label class="option_item2">
      <input type="checkbox" name="chk_art" class="checkbox" value="Guru Randhawa">
      <div class="option_inner gr">
        <div class="tickmark"></div>
        <div class="name">Guru Randhawa</div>
      </div>
    </label>
    <label class="option_item2">
      <input type="checkbox" name="chk_art" class="checkbox" value="Maroon 5" checked>
      <div class="option_inner m5">
        <div class="tickmark"></div>
        <div class="name">Maroon 5</div>
      </div>
    </label>
    <label class="option_item2">
      <input type="checkbox" name="chk_art" class="checkbox" value="Shreya Ghoshal" checked>
      <div class="option_inner sg">
        <div class="tickmark"></div>
        <div class="name">Shreya Ghoshal</div>
      </div>
    </label>
    <label class="option_item2">
      <input type="checkbox" name="chk_art" class="checkbox" value="Hardy Sandhu">
      <div class="option_inner hs">
        <div class="tickmark"></div>
        <div class="name">Hardy Sandhu</div>
      </div>
    </label>
    <label class="option_item2">
      <input type="checkbox" name="chk_art" class="checkbox" value="Ozuna" checked>
      <div class="option_inner ozuna">
        <div class="tickmark"></div>
        <div class="name">Ozuna</div>
      </div>
    </label>
    <label class="option_item2">
      <input type="checkbox" name="chk_art" class="checkbox" value="Arijit Singh">
      <div class="option_inner arijit">
        <div class="tickmark"></div>
        <div class="name">Arijit Singh</div>
      </div>
    </label>
  </div>
</div>
<div class="final">
    <input type="submit" name="btn_submit" class="button" value="Next">
</div>
</form>
</body>
</html>
<%@ page import="Connectdb.Conn_class,java.io.IOException,java.sql.*,java.util.ArrayList,java.time.LocalTime,java.time.LocalDate"%>
<%! 
    String uname,email,sql;
    int uid,userid;
    %>
    <%
         uname=(String)session.getAttribute("uname");
         email=(String)session.getAttribute("email");
        Connectdb.Conn_class connectionClass = new Conn_class();
         Connection connection = connectionClass.getConnection();
         Statement stmt = connection.createStatement();                     


        String u=(String)session.getAttribute("uid");
         userid=Integer.parseInt(u);
    %><%
//      ------------------CHECKING IF USER OF THE SAME USERNAME EXISTS IN THE DATABASE---------------------
        int y=stmt.executeUpdate("delete from userlang where uid ="+userid+"");
        int t=stmt.executeUpdate("delete from userartist where uid ="+userid+"");
        int a=stmt.executeUpdate("delete from usergenre where uid ="+userid+"");
        
        String sql = "SELECT uid FROM userdata WHERE uname='"+uname+"' and email='"+email+"'";
        
        try {
            ResultSet resultSet=stmt.executeQuery(sql);
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
                    stmt = connection.createStatement();
                    try {
                        resultSet = stmt.executeQuery(sql);
                        if(resultSet.next()){
                            data = resultSet.getInt(1);
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    sql = "INSERT INTO userlang(UID, LID) VALUES ("+uid+","+data+")";
                    stmt = connection.createStatement();
                    try {
                        stmt.executeUpdate(sql);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                    //        ----------------------Traversing the list of genres and storing ticked entries in database----
                for (String str : gen)
                {
                    int data=0;
                    sql = "SELECT GID FROM Genre WHERE GName='"+str+"'";
                    stmt = connection.createStatement();
                    try {
                        resultSet = stmt.executeQuery(sql);
                        if(resultSet.next()){
                            data = resultSet.getInt(1);
                        }

                    } catch (Exception e) {
                          e.printStackTrace();
                    }

                    sql = "INSERT INTO usergenre(UID,GID) VALUES ("+uid+","+data+")";
                    stmt = connection.createStatement();
                    try {
                        stmt.executeUpdate(sql);
                    } catch (Exception e) {
                        e.printStackTrace();
                    } 
                }
        //        ----------------------Traversing the list of artists and storing ticked entries in database------
                for (String str : art)
                {
                    int data=0;
                    sql = "SELECT AID FROM Artist WHERE AName='"+str+"'";
                    stmt = connection.createStatement();
                    try {
                        resultSet = stmt.executeQuery(sql);
                        if(resultSet.next()){
                            data = resultSet.getInt(1);
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    sql = "INSERT INTO userartist(UID, AID) VALUES ("+uid+","+data+")";
                    stmt = connection.createStatement();
                    try {
                        stmt.executeUpdate(sql);
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

