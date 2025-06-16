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
import model.FoodCategory;

public class FoodCategoryDAO {

    private Connection conn;

    public FoodCategoryDAO() {
        try {
            this.conn = DBconnection.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("Failed to connect to DB", e);
        }
    }

// 1. Add a link between a food and a category
    public void addFoodCategory(int foodId, int categoryId) throws SQLException {
        String sql = "INSERT INTO FoodCategories (FoodID, CategoryID) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, foodId);
            ps.setInt(2, categoryId);
            ps.executeUpdate();
        }
    }

// 2. Remove a link
    public void removeFoodCategory(int foodId, int categoryId) throws SQLException {
        String sql = "DELETE FROM FoodCategories WHERE FoodID = ? AND CategoryID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, foodId);
            ps.setInt(2, categoryId);
            ps.executeUpdate();
        }
    }

// 3. Get all categories for a given food
    public List<Integer> getCategoryIdsByFoodId(int foodId) throws SQLException {
        List<Integer> categoryIds = new ArrayList<>();
        String sql = "SELECT CategoryID FROM FoodCategories WHERE FoodID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, foodId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    categoryIds.add(rs.getInt("CategoryID"));
                }
            }
        }
        return categoryIds;
    }

// 4. Get all foods under a given category
    public List<Integer> getFoodIdsByCategoryId(int categoryId) throws SQLException {
        List<Integer> foodIds = new ArrayList<>();
        String sql = "SELECT FoodID FROM FoodCategories WHERE CategoryID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    foodIds.add(rs.getInt("FoodID"));
                }
            }
        }
        return foodIds;
    }

    // Get all category names for a given FoodID
    public List<String> getCategoryNamesByFoodId(int foodId) throws SQLException {
        List<String> categoryNames = new ArrayList<>();
        String sql = """
                        SELECT c.CategoryName FROM FoodCategories fc
                        JOIN Categories c ON fc.CategoryID = c.CategoryID
                        WHERE fc.FoodID = ?
                        """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, foodId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    categoryNames.add(rs.getString("CategoryName"));
                }
            }
        }
        return categoryNames;
    }
}
