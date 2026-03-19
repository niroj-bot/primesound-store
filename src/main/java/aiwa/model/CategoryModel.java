package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.Category;

public class CategoryModel {

	public ArrayList<Category> findAll(ServletContext context) {

		ArrayList<Category> result = new ArrayList<Category>();

		try {

			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "select * from categories order by categoryid";

			PreparedStatement stmt = conn.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {

				Category category = new Category();
				category.setCategoryId(rs.getInt("categoryid"));
				category.setCategoryName(rs.getString("categoryname"));
				result.add(category);
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}
