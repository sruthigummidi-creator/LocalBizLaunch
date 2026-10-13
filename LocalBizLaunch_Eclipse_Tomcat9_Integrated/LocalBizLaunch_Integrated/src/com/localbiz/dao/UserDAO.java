package com.localbiz.dao;

import com.localbiz.model.User;
import com.localbiz.util.DBConnection;
import java.sql.*;

public class UserDAO {
    public boolean emailExists(String email) throws SQLException {
        try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("SELECT 1 FROM users WHERE email=? LIMIT 1")) {
            p.setString(1,email);
            try(ResultSet r=p.executeQuery()){return r.next();}
        }
    }
    public void create(User user) throws SQLException {
        String sql="INSERT INTO users (full_name,email,phone,password_hash,role) VALUES (?,?,?,?,?)";
        try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)) {
            p.setString(1,user.getFullName());p.setString(2,user.getEmail());p.setString(3,user.getPhone());
            p.setString(4,user.getPasswordHash());p.setString(5,user.getRole());p.executeUpdate();
        }
    }
    public User findByEmail(String email) throws SQLException {
        String sql="SELECT user_id,full_name,email,phone,password_hash,role FROM users WHERE email=? LIMIT 1";
        try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)) {
            p.setString(1,email);
            try(ResultSet r=p.executeQuery()) {
                if(!r.next()) return null;
                User u=new User(r.getInt("user_id"),r.getString("full_name"),r.getString("email"),r.getString("role"));
                u.setPhone(r.getString("phone"));u.setPasswordHash(r.getString("password_hash"));return u;
            }
        }
    }
}
