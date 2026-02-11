import com.oes.util.DbConnection;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;

public class UpdateDbSchema {
    public static void main(String[] args) {
        String sql = "ALTER TABLE exams ADD COLUMN is_active BOOLEAN DEFAULT FALSE";
        try (Connection con = DbConnection.getConnection();
             Statement stmt = con.createStatement()) {
            stmt.executeUpdate(sql);
            System.out.println("Database schema updated successfully: Added is_active column.");
        } catch (SQLException e) {
            if (e.getMessage().contains("Duplicate column name")) {
                System.out.println("Column is_active already exists.");
            } else {
                e.printStackTrace();
            }
        }
    }
}
