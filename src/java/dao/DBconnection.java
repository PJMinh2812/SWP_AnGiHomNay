/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author ASUS
 */
public class DBconnection {
     
private static Connection connection = null;

    public static Connection getConnection() {
        Connection conn = null;
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                String url = "jdbc:sqlserver://PJM-PC\\Minh;databaseName=AnGiHomNay;encrypt=true;trustServerCertificate=true;";
                String username = "sa"; // Thay bằng username của bạn
                String password = "1234"; // Thay bằng password của bạn
                connection = DriverManager.getConnection(url, username, password);
                System.out.println("Connected to database successfully!");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                System.out.println("Failed to connect to database.");
            }
        
        return connection;
    }
    
    public static void printCustomer() {
        String sql = "SELECT * FROM [ShoeStore].[dbo].[Customers]";
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
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
    
    public static void main(String args[]) {
        printCustomer();
    }
}
