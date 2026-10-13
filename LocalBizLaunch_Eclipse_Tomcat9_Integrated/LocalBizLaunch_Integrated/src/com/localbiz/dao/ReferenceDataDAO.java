package com.localbiz.dao;
import com.localbiz.model.BusinessCategory;import com.localbiz.model.Area;import com.localbiz.util.DBConnection;import java.sql.*;import java.util.*;
public class ReferenceDataDAO {
 public List<BusinessCategory> getCategories() throws SQLException {List<BusinessCategory> out=new ArrayList<>();try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("SELECT category_id,category_name,description FROM business_categories ORDER BY category_name");ResultSet r=p.executeQuery()){while(r.next()){BusinessCategory b=new BusinessCategory();b.setCategoryId(r.getInt(1));b.setCategoryName(r.getString(2));b.setDescription(r.getString(3));out.add(b);}}return out;}
 public List<Area> getAreas() throws SQLException {List<Area> out=new ArrayList<>();try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("SELECT area_id,area_name FROM areas ORDER BY area_name");ResultSet r=p.executeQuery()){while(r.next()){Area a=new Area();a.setAreaId(r.getInt(1));a.setAreaName(r.getString(2));out.add(a);}}return out;}
}
