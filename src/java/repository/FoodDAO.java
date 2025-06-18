package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Foods;

public class FoodDAO {
    private Connection conn;

    public FoodDAO() {
        try {
            this.conn = DBconnection.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("Failed to connect to DB", e);
        }
    }

    public FoodDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Foods> getAllFoods() throws SQLException {
        List<Foods> list = new ArrayList<>();
        String sql = "SELECT * FROM Foods";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToFood(rs));
            }
        }
        return list;
    }

    public Foods getFoodById(int id) throws SQLException {
        String sql = "SELECT * FROM Foods WHERE FoodID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFood(rs);
                }
            }
        }
        return null;
    }

    public List<Foods> getFoodsByCategoryId(int categoryId) throws SQLException {
        List<Foods> list = new ArrayList<>();
        String sql = """
                SELECT f.* FROM Foods f
                JOIN FoodCategories fc ON f.FoodID = fc.FoodID
                WHERE fc.CategoryID = ?
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToFood(rs));
                }
            }
        }
        return list;
    }

    public void insertFood(Foods food) throws SQLException {
        String sql = """
                INSERT INTO Foods (Name, Description, FoodImage, Calories, Protein, Fat, Carbohydrates, Ingredients, PreparationMethod, Status)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            setFoodParams(ps, food);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    food.setFoodID(rs.getInt(1));
                }
            }
        }
    }

    public void updateFood(Foods food) throws SQLException {
        String sql = """
                UPDATE Foods SET Name = ?, Description = ?, FoodImage = ?, Calories = ?, Protein = ?, Fat = ?, Carbohydrates = ?, Ingredients = ?, PreparationMethod = ?, Status = ?
                WHERE FoodID = ?
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            setFoodParams(ps, food);
            ps.setInt(11, food.getFoodID());
            ps.executeUpdate();
        }
    }

    public void deleteFood(int id) throws SQLException {
        String sql = "DELETE FROM Foods WHERE FoodID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private void setFoodParams(PreparedStatement ps, Foods food) throws SQLException {
        ps.setString(1, food.getName());
        ps.setString(2, food.getDescription());
        ps.setString(3, food.getImage());
        ps.setInt(4, food.getCalories());
        ps.setDouble(5, food.getProtein());
        ps.setDouble(6, food.getFat());
        ps.setDouble(7, food.getCabonhydrates()); // Fixed typo from getCabonhydrates
        ps.setString(8, food.getIngredients());
        ps.setString(9, food.getPreparationMethod());
        ps.setString(10, food.getStatus());
    }

    private Foods mapResultSetToFood(ResultSet rs) throws SQLException {
        return new Foods(
                rs.getInt("FoodID"),
                rs.getString("Name"),
                rs.getString("Description"),
                rs.getString("FoodImage"),
                rs.getInt("Calories"),
                rs.getDouble("Protein"),
                rs.getDouble("Fat"),
                rs.getDouble("Carbohydrates"),
                rs.getString("Ingredients"),
                rs.getString("PreparationMethod"),
                rs.getString("Status"),
                rs.getTimestamp("CreatedAt")
        );
    }
}