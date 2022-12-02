<%@page import="org.apache.commons.lang.WordUtils"%>
<%@page import="com.sun.xml.ws.util.StringUtils"%>
<%@page import="java.sql.*,java.util.*,Server.SongPathFind,Server.SearchSong"%>
<!DOCTYPE html>

<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>ROCK</title>
	
       <link rel="stylesheet" href="Genrepages.css"><link rel="stylesheet" type="text/css" href="Stylesheet_main.css"><!-- this is the main stylesheet -->
    <!-- desktop first approach is used for the same. -->
    <link rel="stylesheet" type="text/css" href="primary page responsive.css"><!-- this is the style sheet with all the media queries -->
    <!-- this script is just for font awesome fonts -->
    <script src="https://kit.fontawesome.com/2d9b67a497.js" ></script>
</head>
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
<%!
        Connection conn;
        Statement stmt;
        ResultSet rs;
        String q,album,sname,rname,rpath,ralbum,songpath="songsdatabase/Pop/Dilliwaali Girlfriend.mp3",songname="Dilliwaali Girlfriend",albumname="Yeh Jawaani Hai Deewani" ;
        int sid=1,rid=1,i=1,gid,userid,j=0;
        ArrayList<String> l=new ArrayList<String>();
        ArrayList<Integer> al=new ArrayList<Integer>();
        
        SongPathFind sp=new SongPathFind();
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
    <nav class="navigation-bar" style="margin-bottom: 0px">
        <div class="title-combo">
            <div class="website-logo">
                <img src="pictures/horizontal_on_white_by_logaster.png">
            </div>
            <div class="website-name">
                <h1>
                    SMP
                </h1>
                <h4>
                    Online Music Player
                </h4>
            </div>
        </div>
        <div class="favs">
            <h4>
                ROCK SONGS
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
                    input=WordUtils.capitalize(input);%>
               <select class="searchlist" name="lst" id="lst">                  
              <option value="-1" class="searchlist">select</option>
            <% 
              input=StringUtils.capitalize(input);
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
     }} catch (Exception e) {
            e.printStackTrace();
        }
     %>
      </form>
        </div>
      <a href="player.jsp"><i class="fas fa-house-user"></i></a>
        <div class="profile-picture">
            <img src="pictures/profile_picture.svg">
            <div>
                <h5><i>Hello <%=session.getAttribute("uname")%></i> </h5>
            </div>
        </div>
            
    </nav>
<div class="wrapper">
<div class="lan">
            <div class="lan-co">
  <% 
                try{
                String query="Select gid from genre WHERE gname='Rock'";
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
            stmt = conn.createStatement();
            ResultSet resultSet=stmt.executeQuery(query);
            if(resultSet.next())
                gid=resultSet.getInt(1);
                
            q="Select sid from songgenre WHERE gid="+gid+"";
            rs=stmt.executeQuery(q);
            while(rs.next())
            {
                rid=rs.getInt(1);
                 al.add(j,rid);
                l=sp.songpathfinder(rid);
                rname=l.get(0);
                rpath=l.get(1);
                ralbum=l.get(2);
                j=j+1;
            %>
            
            <label class="opt_it">
                <form>
                <input type="submit" name="<%=rid%>" id="chksong" class="radio" value="<%=rid%>">
                </form>
            <div class="opt_in genre">
            <img src="Final pictures/<%=ralbum%>.jpg">
            </div>
            <div>
                <%=rname%>
            </div>               
            </label>
            
        <% }Enumeration e=request.getParameterNames();
               while(e.hasMoreElements())
                {
                    String f=(String)e.nextElement();
                    l=sp.songpathfinder(Integer.parseInt(f));
                    sid=Integer.parseInt(f);
                    songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
               }

        }catch(Exception ex){
                ex.printStackTrace();
}%>
</div>
</div>
</div>
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