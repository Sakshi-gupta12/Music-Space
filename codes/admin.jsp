<%@page import="java.time.LocalTime"%>
<%@page import="java.sql.*,java.util.*,Server.SongPathFind,Server.SearchSong,java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMIN FORM</title>
         <link href="admin.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-1.12.4.min.js">
    </script>
    <body onload="noBack();" 
	  onpageshow="if (event.persisted) noBack();" onunload="">
<SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() { window.history.forward(); }
</SCRIPT>
<script>
        function handleClick() {
             var x = document.getElementById("myFile").files[0].name;
  
               document.getElementById("sound1").setAttribute('src',x);
           }
</script>
    </head>
        <header>
       <div class="container">
        <div class="header-left">
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
        <form class="frm">
            <center>
            <table>
                <div class="signup-container">
                <tr>
                    <td align='center' colspan='2'>
                        <h2 class="hh">Admin Login Page</h2>
                    </td>
                    
                </tr>
                
                <tr>
                    <td style="width: 176px;">
                        Song Name :
                    </td>
                    <td>
                        <input type="text" name="txtsn" value='' placeholder="Name" class="inp"/>
                    </td>
                </tr>
                <tr>
                    <td style="width: 176px;">
                        Artist Name :
                    </td>
                    <td>
                        <input type="text" name="txtan" value='' placeholder="ArtistName" class="inp"/>
                    </td>
                </tr>
                <tr>
                    <!--Album name and name of the song's poster name should be same-->
                    <td style="width: 176px;">
                        Album Name :
                    </td>
                    <td>
                        <input type="text" name="txtaln" value='' placeholder="Album(no special characters)" style="font-size: 9px;" class="inp"/>
                    </td>
                </tr>
                
                 <tr>
                     <!--song_genre should be replaced with the desired genre and song should only be in .mp3 format-->
                     <td style="width: 176px;">
                        SongPath :
                    </td>
                    <td>
                        <input type="text" name="txtsp" value='' placeholder="songsdatabase/song_genre/songname.mp3" style="font-size: 9px;" class="inp"/>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 176px;">
                        Genre:
                    </td>
                    <td><select name="drpGenre">
                            <option >Pop</option>
                            <option >Rock</option>
                            <option >Rap</option>
                            <option >Romantic</option>
                            <option >Sad</option>
                        </select></td>
                </tr>
                
                <tr>
                    <td style="width: 176px;">Language:</td>
                    <td><select name="drpLang">
                            <option >Hindi</option>
                            <option >English</option>
                            <option >Spanish</option>
                            <option >Punjabi</option>
                            </select></td>
                </tr>
                
                <tr>
                    <td style="width: 176px;">
                        Release Year :
                    </td>
                    <td>
                        <input type="text" name="txtry" value='' placeholder="YYYY" class="inp"/>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 176px;">
                        Length :
                    </td>
                    <td>
                        <input type="text" name="txtlength" value='' placeholder="mm:ss" class="inp"/>
                    </td>
                </tr>
                <tr>
                    <div class="foot">
                    <td colspan="2" align='center'>
                        <!--For adding new song to the database click on 'INSERT' then on 'UPDATE' after filling in the details of the song-->
                        <button type="submit" name="btnInsert" value="Insert" id="back">Insert</button>
                        <button type="submit" name="btnUpdate" value="Update" id="next">Update</button>
                        <!--For deleting a song just enter the songname and the click on delete-->
                        <button type="submit" name="btnDelete" value="Delete" id="back">Delete</button>
                        <button type="submit" name="btnView" value="View" id="next">View</button>
                    </td>
                    </div>
                </tr>
                </div>
                 </table>
                
            </center>
        </form>
            <center>
                <form action="songupload.jsp" method="post" enctype="multipart/form-data" class="frm">
                    <div class="foot">
                        <h4>Select a .mp3 file only</h4>
                        <br />
                        <input type="file" name="file" class="custom-file-input"/>
                        <br>
                        <input type="submit" name="btnSUpload" value="Upload File"  id="back" />
                    </div>
                </form>
                <form action="fileupload.jsp" method="post" enctype="multipart/form-data" class="frm">
                    <div class="foot">
                        <h4>Select .jpg file only</h4>
                        <br/>
                        <input type="file" name="file2" class="custom-file-input"/>
                        <br />
                        <input type="submit" name="btnUpload" value="Upload File"  id="back" />
                    </div>
                </form>
                <form>
                    <input type="submit" name="btnlogout" value="LOGOUT" class="usid"/>
                </form>
              
            </center>     
    </body>
</html>

<%
    
try{
    int lid=0,gid=0,aid=0;
    String gidd,lidd,aidd ,flagg;
    int p=0,r=0,s=0,d=0,i=0 ;
    int id =0,z=0,flag=0;
    if(request.getParameter("btnInsert")!=null)
    {
        int year=Integer.parseInt(request.getParameter("txtry"));
        String length=request.getParameter("txtlength");
        LocalTime time = LocalTime.parse(length);
        String sname=request.getParameter("txtsn");
        String spath=request.getParameter("txtsp");
        String artistname=request.getParameter("txtan");
        String albumname=request.getParameter("txtaln");
        String genre=request.getParameter("drpGenre");
        session.setAttribute("genre",genre);
        String language= request.getParameter("drpLang");
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
        Statement st=conn.createStatement();
        ResultSet rs5 =st.executeQuery("Select gid from genre where gname='"+genre+"' "); 
        if(rs5.next()){
            gid = rs5.getInt(1);
            session.setAttribute("g",String.valueOf(gid));
        }
        ResultSet rs1 =st.executeQuery("Select lid from lang where lname='"+language+"' ");
       
        if(rs1.next()){
            lid = rs1.getInt(1);
            session.setAttribute("l",String.valueOf(lid));
        }
        int x=st.executeUpdate("insert into songdata(sname,spath,releaseyear,slength) values ('"+sname+"','"+spath+"',"+year+",'"+time+"')");
        int y=st.executeUpdate("insert into album(alname) values ('"+albumname+"')");
        ResultSet rs2=st.executeQuery("Select aid from artist where aname='"+artistname+"' ");
        if(rs2.next()){
            aid = rs2.getInt(1);
            flag=1;
            session.setAttribute("ar",String.valueOf(aid));
            session.setAttribute("fl",String.valueOf(flag));
            int f=x&y;
            if(f>0)   
            out.print("<script>alert('record inserted successfully.')</script>");
        }
        else{
             flag=0;
             session.setAttribute("fl",String.valueOf(flag));
            z=st.executeUpdate("insert into artist(aname) values ('"+artistname+"')");
            int e=x&(y&z);
            if(e>0)   
                out.print("<script>alert('record inserted successfully.')</script>");
        }
    }
    
    if(request.getParameter("btnUpdate")!=null){
        out.print("Hello");
        gidd=(String)session.getAttribute("g");
        lidd=(String)session.getAttribute("l");
        aidd=(String)session.getAttribute("ar");
        flagg=(String)session.getAttribute("fl");
        out.print(flagg);
        out.print(aidd);
       Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
        Statement stmt=conn.createStatement();
        
        ResultSet rs =stmt.executeQuery("SELECT sid FROM songdata ORDER BY sid DESC Fetch first 1 row only");
        if(rs.next())
            r=rs.getInt(1);
        ResultSet rs1 =stmt.executeQuery("SELECT alid FROM album ORDER BY alid DESC Fetch first 1 row only");
        if(rs1.next())
            p=rs1.getInt(1);
        if(flagg.equals("0")){  
        ResultSet rs2 =stmt.executeQuery("SELECT aid FROM artist ORDER BY aid DESC Fetch first 1 row only");
            if(rs2.next())
                s=rs2.getInt(1);
            d =stmt.executeUpdate("insert into songartist values ("+r+","+s+")");
        }
        else{
            i =stmt.executeUpdate("insert into songartist values ("+r+","+Integer.parseInt(aidd)+")");
        
        }
        int a =stmt.executeUpdate("insert into songgenre values ("+r+","+Integer.parseInt(gidd)+")");
        int b =stmt.executeUpdate("insert into songlang values ("+r+","+Integer.parseInt(lidd)+")");
        int c =stmt.executeUpdate("insert into songalbum values ("+r+","+p+")");
        
        
       
        int e = (a&b)&(c&d);
        int f = (a&b)&(c&i);
        if(e>0){
            out.print("<script>alert('record updated successfully.')</script>");
        }
        if(f>0){
            out.print("<script>alert('record updated successfully.')</script>");
        }  
                
    } 
    
    if(request.getParameter("btnView")!=null)
    {
       
       Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
        Statement stmt=conn.createStatement();
        ResultSet rs=stmt.executeQuery("select sid,sname,releaseyear,slength from songdata");
        out.print("</br>");
        out.print("</br>");
             out.print("<html><body><center>");
            
            out.print("<table bgcolor='pink'  width='60%' border='1'>");
        while(rs.next())
        {
            
            out.print("<tr>");
            out.print("<td>"+ rs.getInt(1)+ "</td><td>" + rs.getString(2) + "</td><td>"+rs.getInt(3) +"</td><td>"+rs.getTime(4)+"</td>");
            out.print("</tr>");
            
        }
             out.print("</table");
             out.print("</center></body></html>");
    }
    if(request.getParameter("btnDelete")!=null){
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/smp","smp","smp");
        Statement stmt=conn.createStatement();
        String sname=request.getParameter("txtsn");
        ResultSet rs = stmt.executeQuery("select sid from songdata where sname='"+sname+"'");
        if(rs.next())
            id= rs.getInt(1);
        int y=stmt.executeUpdate("delete from songalbum where sid ="+id+"");
        int t=stmt.executeUpdate("delete from songartist where sid ="+id+"");
        int a=stmt.executeUpdate("delete from songgenre where sid ="+id+"");
        int b=stmt.executeUpdate("delete from songlang where sid ="+id+"");
        int o =stmt.executeUpdate("delete from usersong where sid="+id+"");
        int x=stmt.executeUpdate("delete from songdata where sid ="+id+"");
        int c=(x&o)&((y&t)&(a&b));
        if(c>0)
           out.print("<script>alert('record deleted successfully.')</script>");
    } 
    if(request.getParameter("btnlogout")!=null){
        response.sendRedirect("page1.html");
    }
     
}catch(Exception ex){
    ex.printStackTrace();
}


%>