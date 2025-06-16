package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Users;

public class UserDAO extends DBconnection {

    private final Connection conn;

    public UserDAO() {
        conn = DBconnection.getConnection();
    }

    public UserDAO(Connection connection) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean register(Users user) throws Exception {
        try {
            String sql = "INSERT INTO Users (email, password, fullName, phoneNumber, status, createdAt) VALUES (?, ?, ?, ?, ?, GETDATE())";
            System.out.println("Preparing SQL: " + sql);

            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, user.getEmail());
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getFullName());
                ps.setString(4, user.getPhoneNumber());
                ps.setString(5, "Active"); // Hoặc "1" nếu status là INT

                System.out.println("Set parameters:");
                System.out.println("Email: " + user.getEmail());
                System.out.println("Password: " + user.getPassword());
                System.out.println("FullName: " + user.getFullName());
                System.out.println("Phone: " + user.getPhoneNumber());

                int rows = ps.executeUpdate();
                System.out.println("Inserted rows: " + rows);

                if (rows > 0) {
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        int newUserID = rs.getInt(1);
                        System.out.println("New UserID: " + newUserID);

                        insertUserRole(newUserID, 1); // Gán Role mặc định (2 = User)
                    }
                    return true;
                } else {
                    System.out.println("No rows inserted.");
                }

            }
        } catch (SQLException e) {
            System.err.println("SQL Error during register:");
            e.printStackTrace();
        }
        return false;
    }

    private void insertUserRole(int userID, int roleID) throws SQLException {
        String sql = "INSERT INTO UserRole (UserID, RoleID) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, roleID);
            int rows = ps.executeUpdate();
            System.out.println("Inserted role for user: " + userID + " with roleID: " + roleID);
        }
    }

    public Users login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM Users WHERE Email = ? AND Password = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Users(
                            rs.getInt("UserID"),
                            rs.getString("Email"),
                            rs.getString("Password"),
                            rs.getString("FullName"),
                            rs.getString("PhoneNumber"),
                            rs.getString("Status"),
                            rs.getTimestamp("CreatedAt")
                    );
                }
            }
        }
        return null;
    }

    public List<Users> getAllUsers() throws SQLException {
        List<Users> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            Users u = new Users();
            u.setUserID(rs.getInt("UserID"));
            u.setEmail(rs.getString("Email"));
            u.setFullName(rs.getString("FullName"));
            u.setStatus(rs.getString("Status"));
            users.add(u);
        }
        return users;
    }

    public void updateUserStatus(int userId, String status) throws SQLException {
        String sql = "UPDATE Users SET Status=? WHERE UserID=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, userId);
        ps.executeUpdate();
    }

    public Users getUserByEmail(String email) {
        Users user = null;
        String sql = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new Users();
                    user.setUserID(rs.getInt("id"));
                    user.setFullName(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setFullName(rs.getString("fullname"));
                    user.setPhoneNumber(rs.getString("phone"));
                    user.setStatus(rs.getString("status"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public Users authenticate(String email, String password) {
        String query = "SELECT * FROM Users WHERE Email = ? AND Password = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Users(rs.getInt("id"), rs.getString("email"), rs.getString("fullname"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean updateUser(Users user) {
        String query = "UPDATE Users SET fullName = ?, phoneNumber = ? WHERE userID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhoneNumber());
            ps.setInt(3, user.getUserID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public Users getUserWithRole(int userID) {
        Users user = null;
        String query = "SELECT u.UserID, u.Email, u.FullName, u.PhoneNumber, u.Status, u.CreatedAt, "
                + "r.RoleName "
                + "FROM Users u "
                + "LEFT JOIN UserRole ur ON u.UserID = ur.UserID "
                + "LEFT JOIN Roles r ON ur.RoleID = r.RoleID "
                + "WHERE u.UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new Users();
                    user.setUserID(rs.getInt("UserID"));
                    user.setEmail(rs.getString("Email"));
                    user.setFullName(rs.getString("FullName"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                    user.setStatus(rs.getString("Status"));
                    user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    user.setRoleName(rs.getString("RoleName") != null ? rs.getString("RoleName") : "Không xác định");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
