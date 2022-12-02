<%@page import="org.apache.commons.lang.WordUtils"%>
<%@page import="java.sql.*,java.util.*,Server.SongPathFind,Server.SearchSong,java.util.Random"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MusicSpace</title>
    <!-- it is connected to two stylesheets -->
    <link rel="stylesheet" type="text/css" href="Stylesheet_main.css"><!-- this is the main stylesheet -->
    <!-- desktop first approach is used for the same. -->
    <link rel="stylesheet" type="text/css" href="primary page responsive.css"><!-- this is the style sheet with all the media queries -->
    <!-- this script is just for font awesome fonts -->
    <script src="https://kit.fontawesome.com/803f4c4d8d.js" crossorigin="anonymous"></script>
   
</head>
<%!
   
    Connection conn;
    Statement stmt;
    ResultSet rs,rs1,rs2,rs3,rs4,rs5;
    String album,sname,songpath="songsdatabase/Pop/Dilliwaali Girlfriend.mp3",songname="Dilliwaali Girlfriend",albumname="Yeh Jawaani Hai Deewani",s;
    String q,qq,rpath,ralbum,rname;
    int sid=1,i=1,lid,rid,j=0,userid,k=0;
    ArrayList<String> l=new ArrayList<String>();
    ArrayList<Integer>al=new ArrayList<Integer>();
    SongPathFind sp=new SongPathFind();
    ArrayList<Integer>st= new ArrayList<Integer>();
    
    public static void shuffleArray(ArrayList<Integer> a) {
        int n = a.size();
        Random random = new Random();
        random.nextInt();
        for (int i = 0; i < n; i++) {
            int change = i + random.nextInt(n - i);
            swap(a, i, change);
        }
    }

    private static void swap(ArrayList<Integer> a, int i, int change) {
        int helper = a.get(i);
        a.set(i, a.get(change));
        a.set(change, helper) ;
    }
%>
<% 
    String uid=(String)session.getAttribute("uid");
     userid=Integer.parseInt(uid);
    String uname=(String)session.getAttribute("uname");
%>
<body>
<script>
        function handleClick(myRadio) {
           var path=myRadio.value.split('; ');
               document.getElementById("sound1").setAttribute('src',path[0]);
               document.getElementById("albm").innerHTML=path[1];
               document.getElementById("snn").innerHTML=path[2];
               var img="Final pictures/";
               img=img.concat(path[1]);
               img=img.concat(".jpg");
               document.getElementById("simg").setAttribute('src',img);
               
        }
</script>
    <nav class="navigation-bar">
        <div class="title-combo">
            <div class="website-logo">
                <img src="pictures/horizontal_on_white_by_logaster.png">
            </div>
            <div class="website-name">
                <h1>
                    MusicSpace
                </h1>
                <h4>
                    Online Music Player
                </h4>
            </div>
        </div>
        <div class="favs">
            <h4>
                Favourites
            </h4>
        </div>
        <div class="search-bar">
        <form method="get">
            <input type="text" name="search" placeholder="Song,Album,Artist,Year,Language,Genre.." class="usid" style="width: 270px;">
            <button type="submit" name="btn_submit" class="usid" style="width: 30px;"><i class="fas fa-search" ></i></button>  
       
        <% 
       try
        {
           if(request.getParameter("btn_submit")!=null)
           {
               String input=request.getParameter("search");
               if(!Character.isDigit(input.charAt(0)))
                    input=WordUtils.capitalize(input);
        %>
               <select class="searchlist" name="lst" id="lst">                  
              <option value="-1" class="searchlist">select</option>
            <% 
              SearchSong ss=new SearchSong();
              List<String> back1 = new ArrayList<String>();
              Set<String> st=new HashSet<String>();
                    
                    ResultSet rs1=ss.byArtist(input);
                     while(rs1.next())
                    {
                        if(!st.contains(rs1.getString(1)))
                        {
                            back1.add(rs1.getString(1));
                            st.add(rs1.getString(1));
                        }
                    }
                    ResultSet rs2 = ss.byGenre(input);
                    while(rs2.next())
                    {
                        if(!st.contains(rs2.getString(1)))
                        {
                            back1.add(rs2.getString(1));
                            st.add(rs2.getString(1));
                        }
                    }
                    ResultSet rs3 = ss.byLanguage(input);
                    while(rs3.next())
                    {
                        if(!st.contains(rs3.getString(1)))
                        {
                            back1.add(rs3.getString(1));
                            st.add(rs3.getString(1));
                        }
                    }
                    ResultSet rs4 = ss.bySongName(input);
                    while(rs4.next())
                    {
                        if(!st.contains(rs4.getString(1)))
                        {
                            back1.add(rs4.getString(1));
                            st.add(rs4.getString(1));

                        }
                    }
                    ResultSet rs5 = ss.byAlbum(input);
                    while(rs5.next())
                    {
                        if(!st.contains(rs5.getString(1)))
                        {
                            back1.add(rs5.getString(1));
                            st.add(rs5.getString(1));

                        }
                    }
                    if(Character.isDigit(input.charAt(0)))
                    {
                        ResultSet rs6 = ss.byYear(input);
                        while(rs6.next())
                        {
                            if(!st.contains(rs6.getString(1)))
                            {
                                back1.add(rs6.getString(1));
                                st.add(rs6.getString(1));

                            }
                        }
                    }
                    for (String x:back1)
                    {%>
                    <option value="<%=x%>"><%=x%></option>; 
                    <%}}%>
               </select>             
                
               <input type="submit" name="btn_sub" value="PLAY SONG" class="usid">
                
<%
           if(request.getParameter("btn_sub")!=null)
           {
            sname=request.getParameter("lst");
            String query="Select sid from songdata WHERE sname='"+sname+"'";
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
            stmt = conn.createStatement();
            ResultSet resultSet=stmt.executeQuery(query);
            if(resultSet.next())
            sid=resultSet.getInt(1);
            l=sp.songpathfinder(sid);
            songname=l.get(0);
            songpath=l.get(1);
            albumname=l.get(2);
            String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                 int a=stmt.executeUpdate(o);
            String q="select timesplayed from songdata where sid="+sid+"" ;
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String e="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(e) ;
                    }
              String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
             ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String e="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(e) ;
                    }
     }} catch (Exception e) {
            e.printStackTrace();
        }
     %>
      </form>
        </div>
    <!--  <h1><%=sname%></h1>
    <h1><%=sid%></h1>
    <h1><%=songpath%></h1>
    <h1><%=albumname%></h1>-->
     
        <div class="profile-picture">
            <img src="pictures/profile_picture.svg">
            <div>
                <h5><i>Hello <%=session.getAttribute("uname")%></i> </h5>
            </div>
        </div>
            
    </nav>
  
    <main>
        <aside class="aside section-1">
            <!-- this is for the carousel -->
            <div class="outer-carousel">
                <div class="carousel">
                    <!-- these are the 3 images in the carousel -->
                    <% 
          try
          {
                String query="Select sid from usersong WHERE liked > 0 ORDER BY RANDOM() fetch first 3 rows only ";
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
                stmt = conn.createStatement();
                ResultSet rs1=stmt.executeQuery(query);
                while(rs1.next())
                {
                    rid=rs1.getInt(1);
                    l=sp.songpathfinder(rid);
                    rname=l.get(0);
                    rpath=l.get(1);
                    ralbum=l.get(2);
        %>
                    <label>
                        <form>
                    <input type="submit" name="<%=rid%>" id="chksong" class="radio" value="<%=rid%>" style="opacity:0;">
                        </form>    
                    <img src="Final pictures/<%=ralbum%>.jpg">
                    </label>
     <% 
               }Enumeration e=request.getParameterNames();
               while(e.hasMoreElements())
                {
                    String f=(String)e.nextElement();
                      l=sp.songpathfinder(Integer.parseInt(f));
                    sid=Integer.parseInt(f);
                    songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
                    String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                 int a=stmt.executeUpdate(o);
                     String q="select timesplayed from songdata where sid="+sid+"" ;
                     rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String ef="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ef) ;
                    }
              String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
             ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(eg) ;
                    }
                    
               }
              
           }
          catch(Exception ex)
          {
              ex.printStackTrace();
          }
        %>    
                </div>
            </div>
            <!-- this is the latest release section -->
            <div class="latest-release">
                <h1 style="margin-bottom: 12px;">
                    Latest Release
                </h1>
                <div class="latest-release-content">
<% 
          try
          {
                String query="Select sid from songdata WHERE releaseyear > 2015 ORDER BY RANDOM() fetch first 6 rows only";
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
                stmt = conn.createStatement();
                ResultSet rs1=stmt.executeQuery(query);
                while(rs1.next())
                {
                    rid=rs1.getInt(1);
                    l=sp.songpathfinder(rid);
                    rname=l.get(0);
                    rpath=l.get(1);
                    ralbum=l.get(2);
        %>
                    <div class="card">
                     <label>
                    <form>
                <input type="submit" name="<%=rid%>" id="chksong" class="radio" value="<%=rid%>">
                </form>
                                     
                        <div>
                            <img src="Final pictures/<%=ralbum%>.jpg">
                        </div>
                        <div class="latest-release-content play-button" style="top:-105px;">
                                <i class="fas fa-play" style="width:100%; height:100%; display:inline-block;"></i>
                        </div>
                     </label>
                        <div class="song-description">
                            <h3>
                           <%=rname%>
                            </h3>
                        </div>                                         
                    </div>
                     <% 
               }Enumeration e=request.getParameterNames();
               while(e.hasMoreElements())
                {
                    String f=(String)e.nextElement();
                      l=sp.songpathfinder(Integer.parseInt(f));
                    sid=Integer.parseInt(f);
                    String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                 int a=stmt.executeUpdate(o);
                     String q="select timesplayed from songdata where sid="+sid+"" ;
                     rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String ef="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ef) ;
                    }
              String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
             ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(eg) ;
                    }
                    songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
               }
              
           }
          catch(Exception ex)
          {
              ex.printStackTrace();
          }
        %>
                </div>
            </div>
  
            <!-- this is another themes portion, that electronic, party and road theme -->
            <div class="music-themes-2">
                <!-- 3 divs content -->
                <div class="outer-div">
                    <div class="inner-div">
                        <a href="Rock.jsp"><span>Rock</span></a>
                    </div>
                </div>
                <div class="outer-div">
                    <div class="inner-div">
                        <a href="Pop.jsp"><span>Pop</span></a>
                    </div>
                </div>
                <div class="outer-div">
                    <div class="inner-div">
                        <a href="Romantic.jsp"><span>Romantic</span></a>
                    </div>
                </div>
            </div>
           
                <!-- latest english section -->
            <div class="language english">
                <h1 class="language-heading">
                    Latest English
                </h1>
                <div class="language-content">
<% 
          try
          {
                String query="Select lid from lang WHERE lname='English'";
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
                stmt = conn.createStatement();
                ResultSet resultSet=stmt.executeQuery(query);
                if(resultSet.next())
                    lid=resultSet.getInt(1);
                q="select sid from songdata where sid IN(select songlang.sid from songlang INNER JOIN songdata ON songdata.sid=songlang.sid where songlang.lid="+lid+")AND songdata.releaseyear>2018 ";
                 rs1=stmt.executeQuery(q);
                while(rs1.next())
                {
                    rid=rs1.getInt(1);
                    l=sp.songpathfinder(rid);
                    rname=l.get(0);
                    rpath=l.get(1);
                    ralbum=l.get(2);
        %>
                <div>
                <label class="option_item">
                <form>
                <input type="submit" name="<%=rid%>" id="chksong" class="radio" value="<%=rid%>">
                </form>
                
                <div class="option_inner lr"> 
                    <img src="Final pictures/<%=ralbum%>.jpg">
                </div>
                </label>
                    <p><%=rname%></p>
                </div>
                
        <% 
               }Enumeration e=request.getParameterNames();
               while(e.hasMoreElements())
                {
                    String f=(String)e.nextElement();
                      l=sp.songpathfinder(Integer.parseInt(f));
                    sid=Integer.parseInt(f);
                    String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                 int a=stmt.executeUpdate(o);
                     String q="select timesplayed from songdata where sid="+sid+"" ;
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String ef="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ef) ;
                    }
              String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
             ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(eg) ;
                    }
                    songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
               }
              
           }
          catch(Exception ex)
          {
              ex.printStackTrace();
          }
        %>
                </div>
            </div>
            <div class="language Hindi">
                <h1 class="language-heading">
                    Latest Hindi
                </h1>
                <div class="language-content">
<% 
          try
          {
                String query="Select lid from lang WHERE lname='Hindi'";
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
                stmt = conn.createStatement();
                ResultSet resultSet=stmt.executeQuery(query);
                if(resultSet.next())
                    lid=resultSet.getInt(1);
                q="select sid from songdata where sid IN(select songlang.sid from songlang INNER JOIN songdata ON songdata.sid=songlang.sid where songlang.lid="+lid+")AND songdata.releaseyear>2018 fetch first 6 rows only";
                 rs1=stmt.executeQuery(q);
                while(rs1.next())
                {
                    rid=rs1.getInt(1);
                    l=sp.songpathfinder(rid);
                    rname=l.get(0);
                    rpath=l.get(1);
                    ralbum=l.get(2);
        %>
                <div>
                <label class="option_item">
                     <form>
                <input type="submit" name="<%=rid%>" id="chksong" class="radio" value="<%=rid%>">
                </form>
                
                <div class="option_inner lr"> 
                    <img src="Final pictures/<%=ralbum%>.jpg">
                </div>
                </label>
                    <p><%=rname%></p>
                </div>
                
        <% 
               }Enumeration e=request.getParameterNames();
               while(e.hasMoreElements())
                {
                    String f=(String)e.nextElement();
                    %>
                    
              <%    l=sp.songpathfinder(Integer.parseInt(f));
                    sid=Integer.parseInt(f);
                    String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                 int a=stmt.executeUpdate(o);
                     String q="select timesplayed from songdata where sid="+sid+"" ;
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String ef="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ef) ;
                    }
              String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
             ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(eg) ;
                    }
                    songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
               }
           }
          catch(Exception ex)
          {
              ex.printStackTrace();
          }
        %>
                </div>
            </div>
            <div class="language spanish">
                <h1 class="language-heading">
                    Latest Spanish
                </h1>
                <div class="language-content">
<% 
          try
          {
                String query="Select lid from lang WHERE lname='Spanish'";
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
                stmt = conn.createStatement();
                ResultSet resultSet=stmt.executeQuery(query);
                if(resultSet.next())
                    lid=resultSet.getInt(1);
                q="select sid from songdata where sid IN(select songlang.sid from songlang INNER JOIN songdata ON songdata.sid=songlang.sid where songlang.lid="+lid+")AND songdata.releaseyear>2016";
                 rs1=stmt.executeQuery(q);
                while(rs1.next())
                {
                    rid=rs1.getInt(1);
                    l=sp.songpathfinder(rid);
                    rname=l.get(0);
                    rpath=l.get(1);
                    ralbum=l.get(2);
        %>
                <div>
                <label class="option_item">
                      <form>
                <input type="submit" name="<%=rid%>" id="chksong" class="radio" value="<%=rid%>">
                </form>
                
                <div class="option_inner lr"> 
                    <img src="Final pictures/<%=ralbum%>.jpg">
                </div>
                </label>
                    <p><%=rname%></p>
                </div>
                
        <% 
               }Enumeration e=request.getParameterNames();
               while(e.hasMoreElements())
                {
                    String f=(String)e.nextElement();
                    %>
              <% l=sp.songpathfinder(Integer.parseInt(f));
              sid=Integer.parseInt(f);
              String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                 int a=stmt.executeUpdate(o);
                     String q="select timesplayed from songdata where sid="+sid+"" ;
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String ef="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ef) ;
                    }
              String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
             ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(eg) ;
                    }
                     songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
           }
           }
          catch(Exception ex)
          {
              ex.printStackTrace();
          }
        %>
                </div>
            </div>
            <div class="language punjabi">
                <h1 class="language-heading">
                    Latest Punjabi
                </h1>
                <div class="language-content">
<% 
          try
          {
                String query="Select lid from lang WHERE lname='Punjabi'";
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
                stmt = conn.createStatement();
                ResultSet resultSet=stmt.executeQuery(query);
                if(resultSet.next())
                    lid=resultSet.getInt(1);
                q="select sid from songdata where sid IN(select songlang.sid from songlang INNER JOIN songdata ON songdata.sid=songlang.sid where songlang.lid="+lid+")AND songdata.releaseyear>2018";
                 rs1=stmt.executeQuery(q);
                while(rs1.next())
                {
                    rid=rs1.getInt(1);
                    l=sp.songpathfinder(rid);
                    rname=l.get(0);
                    rpath=l.get(1);
                    ralbum=l.get(2);
        %>
                <div>
                <label class="option_item">
                    <form>
                <input type="submit" name="<%=rid%>" id="chksong" class="radio" value="<%=rid%>">
                </form>
                
                <div class="option_inner lr"> 
                    <img src="Final pictures/<%=ralbum%>.jpg">
                </div>
                </label>
                    <p><%=rname%></p>
                </div>
                
        <% 
               }Enumeration e=request.getParameterNames();
               while(e.hasMoreElements())
                {
                    String f=(String)e.nextElement();

                    %>
              <% l=sp.songpathfinder(Integer.parseInt(f));
              sid=Integer.parseInt(f);
              String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                 int a=stmt.executeUpdate(o);
                     String q="select timesplayed from songdata where sid="+sid+"" ;
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String ef="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ef) ;
                    }
              String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
             ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(eg) ;
                    }
                     songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
           }

           }
          catch(Exception ex)
          {
              ex.printStackTrace();
          }
        %>
                </div>
            </div>
        </aside>
        <label for="more"><i class="fas fa-angle-double-left"></i>More</label>
        <input type="checkbox" id="more">
        <aside class="aside section-2">
            <div class="heading">
                <h1>Recommended</h1>
                <h4>
                    <a href="#queue-option-box">More<i class="fas fa-chevron-circle-down"></i></a>
                </h4>
            </div>
            <div class="queue-options" id="queue-option-box">
                <p><a href="profile.jsp" style="color:#007bff; font-weight:bolder;">Profile</a></p>
                <hr>
                <p>
                <form action="logout.jsp">
                    <input type="submit" value="Logout" style="color:red; font-weight:bolder;">
                </form></p>
            </div>
            <div class="playlist-content">
            <%
                 try
          {
                j=0;
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
                stmt = conn.createStatement();
                String query="select DISTINCT sid,sname,spath from songdata where sid IN(((select songlang.sid from songlang INNER JOIN userlang ON songlang.lid=userlang.lid where uid="+userid+") INTERSECT (select songgenre.sid from songgenre INNER JOIN usergenre ON songgenre.gid=usergenre.gid where uid="+userid+"))UNION(select songartist.sid from songartist INNER JOIN userartist ON songartist.aid=userartist.aid where uid="+userid+"))";
                rs=stmt.executeQuery(query);
                while(rs.next())
                {
                    rid=rs.getInt(1);
                    l=sp.songpathfinder(rid);
                    album =l.get(2);
                    al.add(j,rid);
                    j=j+1;
               %>
               
                <div class=playlist-item>
                    <div class="left-content">
                        <div style="margin-right:4px;">
                            
                        </div>
                        <div class="coverer">
                        <label>
                            <form>
                        <input type="submit" name="<%=rid%>" id="chksong" class="radio" value="<%=rid%>">
                            </form>
                        
                        <div> 
                        <img src="Final pictures/<%= album%>.jpg">
                        <div class="coverer play-button">
                                <i class="fas fa-play" aria-hidden="true"></i>
                        </div>
                        </div>
                        </label> 
                        </div>
                        <div>
                                <%=rs.getString(2)%>
                        </div>
                        </div>
                </div>
               <%
                  }
                Enumeration e=request.getParameterNames();
               while(e.hasMoreElements())
                {
                    String f=(String)e.nextElement();
                    l=sp.songpathfinder(Integer.parseInt(f));
                    sid=Integer.parseInt(f);
                    String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                    int a=stmt.executeUpdate(o);
                    String q="select timesplayed from songdata where sid="+sid+"" ;
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String ef="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ef) ;
                    }
              String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
             ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(eg) ;
                    }
                     songname=l.get(0);
                    songpath =l.get(1);
                    albumname=l.get(2);
               } }
          catch(Exception ex)
          {
              ex.printStackTrace();
          }
                %>
               </div>
        </aside>
    </main>
                <% st.add(k,sid);
    k=k+1;
         session.setAttribute("history",st);%>  
     <footer>    
              <%
                try{ 
                 if(request.getParameter("like")!=null)
                {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
                stmt = conn.createStatement();
                String f="select uid,sid,disliked from usersong where uid="+userid+" AND sid="+sid+"";
                ResultSet r=stmt.executeQuery(f);
                
                if(r.next()){
                    if(r.getInt(3)==1){
                    String o="update usersong set liked=1,disliked=0 where sid="+r.getInt(2)+" AND uid="+r.getInt(1)+"";
                    int a=stmt.executeUpdate(o);
                    }
                    else{
                    String o="update usersong set liked=1 where sid="+r.getInt(2)+" AND uid="+r.getInt(1)+"";
                    int a=stmt.executeUpdate(o);
                    }
                    
                   
                }
                 //String o="insert into usersong(uid,sid,liked) values("+userid+","+sid+",1)";
                 
                 String q="select likes from songdata where sid="+sid+"";
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int l=rs1.getInt(1);
                        l=l+1;
                        String ux="update songdata set likes="+l+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ux) ;
                    }
                    
                }
                
                 if(request.getParameter("dislike")!=null)
                {
                   Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
                stmt = conn.createStatement();
                String g="select uid,sid,liked from usersong where uid="+userid+" AND sid="+sid+"";
                ResultSet r=stmt.executeQuery(g);
                if(r.next()){
                    if(r.getInt(3)==1){
                    String o="update usersong set disliked=1,liked=0 where sid="+r.getInt(2)+" AND uid="+r.getInt(1)+"";
                    int a=stmt.executeUpdate(o);
                    }
                    else{
                    String o="update usersong set disliked=1 where sid="+r.getInt(2)+" AND uid="+r.getInt(1)+"";
                    int a=stmt.executeUpdate(o);
                    }
                }String q="select dislikes from songdata where sid="+sid+"";
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int l=rs1.getInt(1);
                        l=l+1;
                        String ux="update songdata set dislikes="+l+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ux) ;
                    }
                    
                }
                    
                if(request.getParameter("shuffle")!=null)
                {
                    shuffleArray(al);
                      l=sp.songpathfinder(al.get(0));
                    songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
                    
                } if(request.getParameter("btn_subbb2")!=null)
                {
                   sid=sid-1;
                    if(sid==0)
                        sid=102;
                    l=sp.songpathfinder(sid);
                    songname=l.get(0);
                    songpath =l.get(1);
                    albumname=l.get(2);
                     String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                    int a=stmt.executeUpdate(o);
                    String q="select timesplayed from songdata where sid="+sid+"" ;
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String ef="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ef) ;
                    }
                String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
                ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(eg) ;
                    }
                     
                }   
                
                    if(request.getParameter("btn_subbb")!=null)
                    {
                    sid=sid+1;
                    if(sid==103)
                        sid=1;
                    l=sp.songpathfinder(sid);
                    songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
                     String o="insert into usersong(uid,sid) values("+userid+","+sid+")";
                    int a=stmt.executeUpdate(o);
                    String q="select timesplayed from songdata where sid="+sid+"" ;
                    ResultSet rs1=stmt.executeQuery(q);
                    if(rs1.next())
                    {
                        int t=rs1.getInt(1);
                        t=t+1 ;
                       String ef="update songdata set timesplayed="+t+" where sid="+sid+"";
                        int i=stmt.executeUpdate(ef) ;
                    }
                String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
                ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int i=stmt.executeUpdate(eg) ;
                    }
                    }}catch(Exception ex)
                {
                    ex.printStackTrace();
                }
                %>
        <div class="active-song-description">
            <div id="song-image">
                <img id="simg" src="Final pictures/<%=albumname%>.jpg">
            </div>
            <div class="song-desc">
                
                <div id="snn">
                    <%= songname%>
                </div>
                <div id="albm">
                    <%= albumname%>
                </div>
            </div>
                  </div>
            <div class="player">
            <div class="controls">
                <form>
                <button type="submit" name="like" class="usid"><i class="far fa-heart"></i></button>
                <button type="submit" name="shuffle" class="usid"><i class="fas fa-random"></i></button>
                <button type="submit" name="btn_subbb2" class="usid"><i class="fas fa-chevron-circle-left"></i></button>
                <button type="submit" name="btn_subbb" class="usid"><i class="fas fa-chevron-circle-right"></i></button>
                <button type="submit" name="dislike" class="usid"><i class="far fa-thumbs-down"></i></button>
                
                </form>
                
           </div>
            </div>
         <div><audio  id="sound1"controls><source src="<%=songpath%>"></audio></div>
    </footer>
</body>
</html>