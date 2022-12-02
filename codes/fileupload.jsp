<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%
  
File file ;
int maxFileSize = 50000 * 1024;
int maxMemSize = 50000 * 1024;
String filePath = "C:/Users/lenovo/Documents/NetBeansProjects/SMP/web/Final pictures/";
String contentType = request.getContentType();
if ((contentType.indexOf("multipart/form-data") >= 0)) {
DiskFileItemFactory factory = new DiskFileItemFactory();
factory.setSizeThreshold(maxMemSize);
factory.setRepository(new File("c:\\temp"));
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setSizeMax( maxFileSize );
try{
List fileItems = upload.parseRequest(request);
Iterator i = fileItems.iterator();
while ( i.hasNext () )
{
FileItem fi = (FileItem)i.next();
if ( !fi.isFormField () ) {
String fieldName = fi.getFieldName();
String fileName = fi.getName();
boolean isInMemory = fi.isInMemory();
long sizeInBytes = fi.getSize();
file = new File( filePath + fileName) ;
fi.write( file ) ;
%>
<h6>Image inserted successfully.</h6>
<%response.sendRedirect("admin.jsp");
}
}
}catch(Exception ex) {
System.out.println(ex);
}
}else{
out.print("Error in file upload.");
}
%>

