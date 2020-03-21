package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
		private final String url = "jdbc:mysql://localhost:3306/project1";
		private final String id = "root";
		private final String pwd = "1234";
		private Connection conn = null;
		
		public Connection getConnection(){
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(url,id,pwd);
			
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		return conn;
	}
}
