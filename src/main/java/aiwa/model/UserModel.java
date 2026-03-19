package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletContext;

import aiwa.entity.User;

public class UserModel {

	public User findByIdAndPassword(ServletContext context, String userId, String password) {

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "select * from users where userid = ? and password = ? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, userId);
			stmt.setString(2, password);

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				User user = new User();
				user.setUserId(rs.getString("userid"));
				user.setUserName(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setManager(rs.getInt("manager"));
				conn.close();

				return user;
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// Check if email (userid) already exists
	public boolean existsById(ServletContext context, String userId) {

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "select userid from users where userid = ?";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, userId);

			ResultSet rs = stmt.executeQuery();

			boolean exists = rs.next();
			conn.close();
			return exists;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Update username and password for existing user
	public boolean updateUser(ServletContext context, String userId, String userName, String password) {

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "update users set username = ?, password = ? where userid = ?";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, userName);
			stmt.setString(2, password);
			stmt.setString(3, userId);

			int result = stmt.executeUpdate();
			conn.close();

			return result > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Insert new regular user (manager = 0)
	public boolean insertUser(ServletContext context, String userId, String userName, String password) {

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "insert into users (userid, username, password, manager) values (?, ?, ?, 0)";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, userId);
			stmt.setString(2, userName);
			stmt.setString(3, password);

			int result = stmt.executeUpdate();
			conn.close();

			return result > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
