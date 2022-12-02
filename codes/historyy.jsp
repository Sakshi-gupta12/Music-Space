
<%@page import="java.sql.*,java.util.*,Server.SongPathFind,Server.SearchSong,java.util.Random"%>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HISTORY</title>
    <link rel="stylesheet" href="Genrepages.css"><link rel="stylesheet" type="text/css" href="Stylesheet_main.css"><!-- this is the main stylesheet -->
    <link rel="stylesheet" type="text/css" href="primary page responsive.css"><!-- this is the style sheet with all the media queries -->
    <!-- this script is just for font awesome fonts -->
    <script src="https://kit.fontawesome.com/2d9b67a497.js" ></script>
</head>

<body>
   <%!
        Connection conn;
        Statement stmt;
        ResultSet rs;
        String q,album,sname,rname,rpath,ralbum,songpath="songsdatabase/Pop/Dilliwaali Girlfriend.mp3",songname="Dilliwaali Girlfriend",albumname="Yeh Jawaani Hai Deewani" ;
        int sid=1,rid=1,i=1,gid,userid;
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
       // Stack<Integer> s=(Stack<Integer>)session.getAttribute("history");
        %>
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
                RECENTLY PLAYED SONGS
            </h4>
        </div>
                <a href="player.jsp"><i class="fas fa-house-user"></i></a>
                
        <div class="profile-picture">
            <img src="pictures/profile_picture.svg">
            <div>
                <h5>
                    <i>Hello <%=session.getAttribute("uname")%></i>
                </h5>
            </div>
        </div>
    </nav>
<div class="wrapper">
<div class="lan">
    <div class="lan-co">
<%
    int i=0;
    ArrayList<Integer> al=(ArrayList<Integer>)session.getAttribute("history");
    Set<Integer> st=new HashSet<Integer>();
    int j=al.size()-1;
    int count=0;
                    while(count!=15&&j>=0)
                    {
                        rid=al.get(j);
                        if(!st.contains(rid))
                        {
                            l=sp.songpathfinder(rid);
                            rname=l.get(0);
                            rpath=l.get(1);
                            ralbum=l.get(2);
                            count=count+1;
                        
                        
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
            
        <%     
                    }
                        st.add(rid);
                        j=j-1;
                        
                }
                Enumeration e=request.getParameterNames();
                while(e.hasMoreElements())
                {
                    String f=(String)e.nextElement();
                    l=sp.songpathfinder(Integer.parseInt(f));
                    sid=Integer.parseInt(f);
                    songname=l.get(0);
                    songpath=l.get(1);
                    albumname=l.get(2);
               }
          
        %>
        
    </div>
</div> 
</div>
        <footer>
 <%
               /*try{ 
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
                        int y=stmt.executeUpdate(ux) ;
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
                        int t=stmt.executeUpdate(ux);
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
                        int p=stmt.executeUpdate(ef);
                    }
                String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
                ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int w=stmt.executeUpdate(eg);
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
                        int aa=stmt.executeUpdate(ef);
                    }
                String rt="select timesplayed from usersong where uid="+userid+" and sid="+sid+" " ;
                ResultSet rs=stmt.executeQuery(rt);
                    if(rs.next())
                    {
                        int t=rs.getInt(1);
                        t=t+1 ;
                       String eg="update usersong set timesplayed="+t+" where sid="+sid+" and uid="+userid+"" ;
                        int ii=stmt.executeUpdate(eg);
                    }
                    }}catch(Exception ex)
                {
                    ex.printStackTrace();
                }*/
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
           
         <div><audio  id="sound1"controls><source src="<%=songpath%>"></audio></div>
    </footer>
</body>
</html>