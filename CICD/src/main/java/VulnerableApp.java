import java.sql.*;

public class VulnerableApp {
    public static void login(String username, String password) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/test");
            
            // VULNERABLE: SQL Injection
            String query = "SELECT * FROM users WHERE username = '" + username + "' AND password = '" + password + "'";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);  // SQL Injection here!
            
            if (rs.next()) {
                System.out.println("Login successful");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        login("admin", "password123");
    }
}
