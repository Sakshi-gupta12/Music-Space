
<%@page import= "java.sql.*,java.util.*,Server.SongPathFind,Server.SearchSong"%>
<html>

  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Profile</title>
    <link rel="stylesheet" href="login.css" />
    <link rel="stylesheet" href="page1.css"/>
    <style>
        .container{
            overflow-x: hidden;
        }
    </style>
  </head>
  <body>
    <!-- Header -->
<header>
      <div class="container">
        <div class="header-left">
          <a href="player.jsp">Music Player</a>
        </div>
        <div class="main-content">
          <div class="concept concept-six">
            <h1 class="word"><span class="char">P</span><span class="char">R</span><span class="char">O</span><span class="char">F</span><span class="char">I</span><span class="char">L</span><span class="char">E</span></h1>
          </div>
        </div>
        <div class="header-right">
          <img class="logo" src="pictures/horizontal_on_white_by_logaster.png"/>         
        </div>
       </div>
    </header>
    <div class="parallax3">
      <div class="container">
          <div class="message">
              <div>
              <a href="#"><span class="button"><h1>UPDATE</h1></span></a>
              <form>
              <br><input type="submit" value="Preferences" name="btnpref" class="buttons">
              <br><input type="submit" value="History" name="btnhistory" class="buttons">
              </form>
              </div>
              <br><br><br>
          </div>
          <form action="logout.jsp">
                    <input type="submit" value="Logout" class="buttons" style="margin-left: 50%;border-radius: 50%; opacity: 1;">
                </form>
      </div>
    </div>
  </body>
</html>
<%
    try{
            if(request.getParameter("btnpref")!=null){
           
                response.sendRedirect("pref2.jsp");
            }
            if(request.getParameter("btnhistory")!=null){
           
                response.sendRedirect("historyy.jsp");
            }
    }
    catch(Exception e){
        e.printStackTrace();
    }
                
%>