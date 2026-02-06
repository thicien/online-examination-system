package com.oes.dao;

import com.oes.model.Admin;
import com.oes.util.DbConnection;
import java.sql.*;

public class AdminDao {
    
    public Admin loginAdmin(String username, String password) {
        Admin admin = null;
        String query = "SELECT * FROM admins WHERE username=? AND password=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("admin_id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }
}
