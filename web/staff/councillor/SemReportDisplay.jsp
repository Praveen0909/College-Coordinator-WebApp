<%-- 
    Document   : getmarks
    Created on : 26 May, 2015, 2:39:34 PM
    Author     : aravind
--%>

<%@page import="Actor.Student"%>
<%@page import="Actor.Staff"%>
<%@page import="com.action.Find"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="dbconnection.dbcon"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% 
   try
    {
        
    
    String username = session.getAttribute("username").toString();
    String password = session.getAttribute("password").toString();
    
    
   Connection connn = new dbcon().getConnection("login");
    Statement sttt = connn.createStatement();
    String type1 ="";
    ResultSet rsss = sttt.executeQuery("select * from staff_login_details where staffid='"+username+"' and password='"+password+"'");
    if(rsss.isBeforeFirst())
    {
        
    session.setAttribute("deptname", Find.sdept(username));
    
    %>
    
    <head>
        <!--<link href="../css/tabledesign.css" rel="stylesheet">-->
        <style>
            
            /*
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
*/
/* 
    Created on : 26 May, 2015, 3:36:50 PM
    Author     : aravind
*/



table {
    *border-collapse: collapse; /* IE7 and lower */
    border-spacing: 0;
    width: 70%;  
    overflow-x : auto; 
}


.bordered {
    border: solid #ccc 1px;
    -moz-border-radius: 6px;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    -webkit-box-shadow: 0 1px 1px #ccc; 
    -moz-box-shadow: 0 1px 1px #ccc; 
    box-shadow: 0 1px 1px #ccc;         
}

.bordered tr:hover {
    background: #fbf8e9;
    -o-transition: all 0.1s ease-in-out;
    -webkit-transition: all 0.1s ease-in-out;
    -moz-transition: all 0.1s ease-in-out;
    -ms-transition: all 0.1s ease-in-out;
    transition: all 0.1s ease-in-out;     
}    
    
.bordered td, .bordered th {
    border-left: 1px solid #ccc;
    border-top: 1px solid #ccc;
    padding: 10px;
    text-align: left;    
}

.bordered th {
    background-color: #dce9f9;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
    background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
    background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
    -webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset; 
    -moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;  
    box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;        
    border-top: none;
    text-shadow: 0 1px 0 rgba(255,255,255,.5); 
}

.bordered td:first-child, .bordered th:first-child {
    border-left: none;
}

.bordered th:first-child {
    -moz-border-radius: 6px 0 0 0;
    -webkit-border-radius: 6px 0 0 0;
    border-radius: 6px 0 0 0;
}

.bordered th:last-child {
    -moz-border-radius: 0 6px 0 0;
    -webkit-border-radius: 0 6px 0 0;
    border-radius: 0 6px 0 0;
}

.bordered th:only-child{
    -moz-border-radius: 6px 6px 0 0;
    -webkit-border-radius: 6px 6px 0 0;
    border-radius: 6px 6px 0 0;
}

.bordered tr:last-child td:first-child {
    -moz-border-radius: 0 0 0 6px;
    -webkit-border-radius: 0 0 0 6px;
    border-radius: 0 0 0 6px;
}

.bordered tr:last-child td:last-child {
    -moz-border-radius: 0 0 6px 0;
    -webkit-border-radius: 0 0 6px 0;
    border-radius: 0 0 6px 0;
}
            
        </style>
        
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%System.out.print("test1");
    String a = request.getParameter("word");
            if(a!=null)
            {
            if(a.equals("yes"))
            {
                String formName = "";
                        formName = "test.doc";
                        File filepath = new File(formName);
                        response.setContentType("application/vnd.ms-word");
                        response.setHeader("Content-Disposition", "inline; filename=" + filepath);
            }
            }
            Staff s=new Staff(username);
        String dept = s.getCouncillorDetails().getDept();
        String batch = s.getCouncillorDetails().getBatch();
        String sec = s.getCouncillorDetails().getSec();
       
   
        String sem = request.getParameter("sem");
       
       
       
        
        String regulation=null;
        String subcode,rollno,name;
        
        
        session.setAttribute("regulation",regulation);
        session.setAttribute("sem",sem);
        session.setAttribute("batch",batch);
        session.setAttribute("sec", sec);
        session.setAttribute("dept",dept);
        
        
        
        %>
        <body>
           
        <center>   <h2>ATTENDANCE REPORT FOR <%=dept.toUpperCase()%> DEPARTMENT</h2><h2> <%=batch%> BATCH <%=sem%>th SEM <%=sec%> SECTION</h2></center>
        <center>
          
            <table class="bordered" border="1">
    <thead>

    <tr>
        <th>Roll No</th>
        <th>Name</th>
        <th>Absent Date</th>
        <th>Number of days</th>
        
        
    </tr>
    </thead>
    
    <%
          for(Student stu:Student.getAll(s.getCouncillorDetails().getDept(), s.getCouncillorDetails().getBatch(),s.getCouncillorDetails().getSec())){
     
         rollno=stu.getId();
         name = stu.getName();
         %>
         <tr>
        <td><%=rollno.toUpperCase()%></td>        
        <td><%=name.toUpperCase()%></td>
        
        <td>
       <%
        Connection con=new dbcon().getConnection(dept);
           
         String sql2 = "select * from councillor_attendance where rollno='"+rollno+"' and sem='"+sem+"'";
         Statement st1 = con.createStatement();
         ResultSet rs2= st1.executeQuery(sql2);
        int count=0;
         
        while(rs2.next())
        {
            String date = rs2.getString("date");
            count++;
            if(count!=1)
            {
                
            
        %>
      
    ,
    
    <%      }
                %>
       <%=date%>    <%
        
     }   
            if(st1!=null)
                st1.close();
                      if(con!=null)
                                con.close();
             
%>
            
            </td>
            <td><%=count%></td>
    </tr>        
    
        

    
   <%
       
                            
        
     
} 
     %>
     
     </table>
        </center>
        <a href ="SemReportDisplay.jsp?word=yes&sem=<%=sem%>&batch=<%=batch%>&section=<%=sec%>&dept=<%=dept%>" >Export to word</a>
    </body>
     <%
       
    
}
    else
    {
        response.sendRedirect("../index.jsp");
    }
    

                            if(sttt!=null)
                            sttt.close();
                              if(connn!=null)
                                connn.close();
    }

catch(Exception e)
    {
        e.printStackTrace();
//        response.sendRedirect("../index.jsp");
    }
    
    %>
</html>