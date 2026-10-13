package com.localbiz.dao;

import com.localbiz.model.Business;
import com.localbiz.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BusinessDAO {
    private Business map(ResultSet r) throws SQLException {
        Business b = new Business();
        b.setBusinessId(r.getInt("business_id"));
        b.setOwnerId(r.getInt("owner_id"));
        b.setCategoryId(r.getInt("category_id"));
        b.setAreaId(r.getInt("area_id"));
        b.setBusinessName(r.getString("business_name"));
        b.setDescription(r.getString("description"));
        b.setStreetAddress(r.getString("street_address"));
        b.setPhone(r.getString("contact_phone"));
        b.setEmail(r.getString("contact_email"));
        b.setLogoPath(r.getString("logo_path"));
        b.setStatus(r.getString("verification_status"));
        b.setCategoryName(r.getString("category_name"));
        b.setAreaName(r.getString("area_name"));
        return b;
    }

    public void create(Business b) throws SQLException {
        String sql = "INSERT INTO businesses (owner_id, category_id, area_id, business_name, description, street_address, contact_phone, contact_email, logo_path, verification_status) VALUES (?,?,?,?,?,?,?,?,?,'PENDING')";
        try (Connection c=DBConnection.getConnection(); PreparedStatement p=c.prepareStatement(sql)) {
            p.setInt(1,b.getOwnerId()); p.setInt(2,b.getCategoryId()); p.setInt(3,b.getAreaId());
            p.setString(4,b.getBusinessName()); p.setString(5,b.getDescription()); p.setString(6,b.getStreetAddress());
            p.setString(7,b.getPhone()); p.setString(8,b.getEmail()); p.setString(9,b.getLogoPath());
            p.executeUpdate();
        }
    }

    public List<Business> searchApproved(String query) throws SQLException {
        List<Business> list = new ArrayList<>();
        String sql = "SELECT b.business_id,b.owner_id,b.category_id,b.area_id,b.business_name,b.description,b.street_address,b.contact_phone,b.contact_email,b.logo_path,b.verification_status,bc.category_name,a.area_name " +
            "FROM businesses b LEFT JOIN business_categories bc ON b.category_id=bc.category_id LEFT JOIN areas a ON b.area_id=a.area_id " +
            "WHERE b.verification_status='APPROVED' ";
        boolean searching = query != null && !query.trim().isEmpty();
        if (searching) sql += "AND (b.business_name LIKE ? OR b.description LIKE ? OR b.street_address LIKE ? OR b.contact_phone LIKE ? OR b.contact_email LIKE ? OR bc.category_name LIKE ? OR a.area_name LIKE ?) ";
        sql += "ORDER BY b.business_name";
        try (Connection c=DBConnection.getConnection(); PreparedStatement p=c.prepareStatement(sql)) {
            if (searching) {
                String q = "%" + query.trim() + "%";
                for(int i=1;i<=7;i++) p.setString(i,q);
            }
            try(ResultSet r=p.executeQuery()) { while(r.next()) list.add(map(r)); }
        }
        return list;
    }

    public List<Business> findAllForAdmin() throws SQLException {
        List<Business> list = new ArrayList<>();
        String sql = "SELECT b.business_id,b.owner_id,b.category_id,b.area_id,b.business_name,b.description,b.street_address,b.contact_phone,b.contact_email,b.logo_path,b.verification_status,bc.category_name,a.area_name " +
            "FROM businesses b LEFT JOIN business_categories bc ON b.category_id=bc.category_id LEFT JOIN areas a ON b.area_id=a.area_id ORDER BY b.business_id DESC";
        try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql);ResultSet r=p.executeQuery()) {
            while(r.next()) list.add(map(r));
        }
        return list;
    }

    public List<Business> findForOwner(int ownerId) throws SQLException {
        List<Business> list = new ArrayList<>();
        String sql = "SELECT b.business_id,b.owner_id,b.category_id,b.area_id,b.business_name,b.description,b.street_address,b.contact_phone,b.contact_email,b.logo_path,b.verification_status,bc.category_name,a.area_name " +
            "FROM businesses b LEFT JOIN business_categories bc ON b.category_id=bc.category_id LEFT JOIN areas a ON b.area_id=a.area_id WHERE b.owner_id=? ORDER BY b.business_id DESC";
        try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)) {
            p.setInt(1,ownerId);
            try(ResultSet r=p.executeQuery()) { while(r.next()) list.add(map(r)); }
        }
        return list;
    }

    public boolean setStatus(int businessId,String status) throws SQLException {
        if(!"APPROVED".equals(status) && !"REJECTED".equals(status)) throw new IllegalArgumentException("Invalid status");
        try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("UPDATE businesses SET verification_status=? WHERE business_id=?")) {
            p.setString(1,status); p.setInt(2,businessId); return p.executeUpdate()==1;
        }
    }
}
