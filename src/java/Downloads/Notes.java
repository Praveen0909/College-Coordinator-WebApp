/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Downloads;

import com.action.Base;
import dbconnection.dbcon;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Home
 */
public class Notes extends Downloadable{
    
    String academicyr;
    String sem;
    String subcode;
    String type;

    public String getAcademicyr() {
        return academicyr;
    }

    public void setAcademicyr(String academicyr) {
        this.academicyr = academicyr;
    }

    public String getSem() {
        return sem;
    }

    public void setSem(String sem) {
        this.sem = sem;
    }

    public String getSubcode() {
        return subcode;
    }

    public void setSubcode(String subcode) {
        this.subcode = subcode;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    
       public static List<Notes> getAll(String dept,Notes n){
    List<Notes> list = new ArrayList<Notes>();
    Connection conn=null;
    Statement stmt=null;
    try{
    conn=new dbcon().getConnection(dept);
    stmt = conn.createStatement();
     String path = Base.path+"/notes/"+n.getAcademicyr()+"/"+dept+"/"+"%"+"/"+n.getSem()+"/"+n.getSubcode()+"/"+n.getType()+"/";
       
                    ResultSet rs=stmt.executeQuery("select * from notes where path like '"+path+"'");
                    
                    rs.beforeFirst();
                    while(rs.next()){
                        Notes note=new Notes();
                     note.setAcademicyr(rs.getString("acadamic_yr"));
                     note.setDesc(rs.getString("descp"));
                     note.setName(rs.getString("filename"));
                     note.setPath(rs.getString("path"));
                     note.setSem(rs.getString("sem"));
                     note.setSubcode(rs.getString("subcode"));
                     note.setType(rs.getString("notes_type"));
                       list.add(note);
                    }
    }catch(Exception e){
    e.printStackTrace();
    }finally{
        try {
            if(stmt!=null)
                stmt.close();
            if(conn!=null)
                conn.close();
        } catch (SQLException ex) {
      ex.printStackTrace();
        }
    }
    return list;
    }
}
