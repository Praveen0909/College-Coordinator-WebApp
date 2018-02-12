/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.action.Base;
import com.action.Find;
import dbconnection.dbcon;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author aravind-pt844
 */
public class maincircularupload extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet maincircularupload</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet maincircularupload at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       // processRequest(request, response);
        String name ="";
        String desc ="";
        String type = "";
        String UPLOAD_DIRECTORY="";
        


                
        
        
       if(ServletFileUpload.isMultipartContent(request)){
            try {
                
                List<FileItem> multiparts = new ServletFileUpload(
                                         new DiskFileItemFactory()).parseRequest(request);
              
                for(FileItem item : multiparts){
                    if (item.isFormField()) {
            if (item.getFieldName().equals("file")) {
                name = item.getString();
                // Do something with the value
            }
             if (item.getFieldName().equals("desc")) {
                desc = item.getString();
                // Do something with the value
            }
             if (item.getFieldName().equals("type")) {
                type = item.getString();
                // Do something with the value
            }
              
                     // if(!ayear.equals("")&&!dept.equals("")&&!batch.equals("")&&!sem.equals("")&&!subcode.equals("")&&!notes.equals(""))
                      UPLOAD_DIRECTORY = Base.path+"/commoncircular"+"/"+type+"/";
    File file = new File(UPLOAD_DIRECTORY);
 Boolean a = file.mkdirs();
                    }
                    if(!item.isFormField()){
                        name = new File(Find.parseFilename(item.getName() )).getName();
                        
                        item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
                    }
                    
                    
                }
           
               //File uploaded successfully
               request.setAttribute("message", "File Uploaded Successfully "+name );
            } catch (Exception ex) {
               request.setAttribute("message", "File Upload Failed due to " + ex +UPLOAD_DIRECTORY);
            }          
         
        }else{
            request.setAttribute("message", "Sorry this Servlet only handles file upload request");
        }
    
        
        
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection connection1 = new dbcon().getConnection("sjitportal");
           // Statement statement1 = connection1.createStatement();
            PreparedStatement statement1=connection1.prepareStatement("insert into circular values("+null+",?,?,?,?)");
            statement1.setString(1, name);
            statement1.setString(2, desc);
            statement1.setString(3, type);
            statement1.setString(4,  UPLOAD_DIRECTORY);
            statement1.executeUpdate();
             request.getRequestDispatcher("admin/result.jsp").forward(request, response);
              if(statement1!=null)
                            statement1.close();
                              if(connection1!=null)
                                connection1.close();

        } catch (Exception ex) {
            PrintWriter out = response.getWriter();
            out.println(ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
