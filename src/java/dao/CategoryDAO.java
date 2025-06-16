/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Categories;

public class CategoryDAO {

    private Connection conn;

    public CategoryDAO() {
        try {
            this.conn = DBconnection.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("Failed to connect to DB", e);
        }
    }

    public List<Categories> getAllCategories() throws SQLException {
        List<Categories> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Categories(
                        rs.getInt("CategoryID"),
                        rs.getString("CategoryName")
                ));
            }
        }
        return list;
    }

    public Categories getCategoryById(int id) throws SQLException {
        String sql = "SELECT * FROM Categories WHERE CategoryID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Categories(
                            rs.getInt("CategoryID"),
                            rs.getString("CategoryName")
                    );
                }
            }
        }
        return null;
    }

    public void insertCategory(Categories category) throws SQLException {
        String sql = "INSERT INTO Categories (CategoryName) VALUES (?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, category.getName());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    category.setId(rs.getInt(1));
                }
            }
        }
    }

    public void updateCategory(Categories category) throws SQLException {
        String sql = "UPDATE Categories SET CategoryName = ? WHERE CategoryID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setInt(2, category.getId());
            ps.executeUpdate();
        }
    }

    public void deleteCategory(int id) throws SQLException {
        String sql = "DELETE FROM Categories WHERE CategoryID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
