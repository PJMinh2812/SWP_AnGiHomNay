/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 *
 * @author ASUS
 */
public class DBconnection {

    protected static Connection connection = null;

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://PJM-PC\\Minh;databaseName=AnGiHomNay;encrypt=true;trustServerCertificate=true;";
            String username = "sa"; // Thay bằng username của bạn
            String password = "1234"; // Thay bằng password của bạn
            connection = DriverManager.getConnection(url, username, password);
            connection.setAutoCommit(true);
            System.out.println("Connected to database successfully!");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("Failed to connect to database.");
        }

        return connection;
    }

    public static void printCustomer() {
        String sql = "SELECT * FROM [ShoeStore].[dbo].[Customers]";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            System.out.println("Data from Student table:");
            while (rs.next()) {
                System.out.println("Customer ID: " + rs.getInt("Customer_ID"));
                System.out.println("Name: " + rs.getString("User_name"));
                System.out.println("Email: " + rs.getString("Email"));
                System.out.println("Phone: " + rs.getString("Phone_number"));
                System.out.println("-----------------------------");
            }
        } catch (SQLException e) {
            System.err.println("Failed to retrieve data from Student table: " + e.getMessage());
        }
    }

    public static void printUserByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM Users WHERE Email = ? AND Password = ?";
        try (Connection connection = getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            System.out.println("Data for User with provided email and password:");
            if (rs.next()) {
                System.out.println("Email: " + rs.getString("Email"));
                System.out.println("Password: " + rs.getString("Password"));
                System.out.println("-----------------------------");
            } else {
                System.out.println("No user found with the provided email and password.");
            }
        } catch (SQLException e) {
            System.err.println("Failed to retrieve data from Users table: " + e.getMessage());
        }
    }

    public static void main(String args[]) {
        printCustomer();
        printUserByEmailAndPassword("admin@angi.vn", "admin123");
    }
}
