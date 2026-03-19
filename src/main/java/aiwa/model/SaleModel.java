package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.Category;
import aiwa.entity.Item;
import aiwa.entity.Sale;
import aiwa.entity.User;

public class SaleModel {
	
	public ArrayList<Sale> findByUserId(ServletContext context, String userId){
		ArrayList<Sale> result = new ArrayList<Sale>();
		try {
		
		Class.forName("org.sqlite.JDBC");

		Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

		String sql = "select "
				+ "	* "
				+ "from "
				+ "	sales s "
				+ "inner join "
				+ "	users u "
				+ "on "
				+ "	s.userid = u.userid "
				+ "inner join "
				+ "	items i "
				+ "on "
				+ "	s.itemid = i.itemid "
				+ "inner join "
				+ "	categories c "
				+ "on "
				+ "	i.categoryid = c.categoryid "
				+ "where "
				+"s.userid = ? "
				+ "order by "
				+ "	saleid desc ";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, userId);

		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
			Sale sale = new Sale();
			sale.setSaleId(rs.getInt("saleid"));
			sale.setSaleDate(rs.getString("saledate"));
			sale.setAmount(rs.getInt("amount"));

			User user = new User();
			user.setUserId(rs.getString("userid"));
			user.setUserName(rs.getString("username"));
			user.setPassword(rs.getString("password"));
			user.setManager(rs.getInt("manager"));

			sale.setUser(user);

			Item item = new Item();
			item.setItemId(rs.getInt("itemid"));
			item.setItemName(rs.getString("itemname"));
			item.setPrice(rs.getInt("price"));
			item.setDetail(rs.getString("detail"));
			item.setRating(rs.getDouble("rating"));
			item.setImage(rs.getString("image"));

			Category category = new Category();
			category.setCategoryId(rs.getInt("categoryid"));
			category.setCategoryName(rs.getString("categoryname"));

			item.setCategory(category);

			sale.setItem(item);
			
			result.add(sale);
			
		}
			
			conn.close();

			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<Sale> findAll(ServletContext context) {

		ArrayList<Sale> result = new ArrayList<Sale>();

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "select "
					+ "	* "
					+ "from "
					+ "	sales s "
					+ "inner join "
					+ "	users u "
					+ "on "
					+ "	s.userid = u.userid "
					+ "inner join "
					+ "	items i "
					+ "on "
					+ "	s.itemid = i.itemid "
					+ "inner join "
					+ "	categories c "
					+ "on "
					+ "	i.categoryid = c.categoryid "
					+ "order by "
					+ "	saleid desc ";

			PreparedStatement stmt = conn.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Sale sale = new Sale();
				sale.setSaleId(rs.getInt("saleid"));
				sale.setSaleDate(rs.getString("saledate"));
				sale.setAmount(rs.getInt("amount"));

				User user = new User();
				user.setUserId(rs.getString("userid"));
				user.setUserName(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setManager(rs.getInt("manager"));

				sale.setUser(user);

				Item item = new Item();
				item.setItemId(rs.getInt("itemid"));
				item.setItemName(rs.getString("itemname"));
				item.setPrice(rs.getInt("price"));
				item.setDetail(rs.getString("detail"));
				item.setRating(rs.getDouble("rating"));
				item.setImage(rs.getString("image"));

				Category category = new Category();
				category.setCategoryId(rs.getInt("categoryid"));
				category.setCategoryName(rs.getString("categoryname"));

				item.setCategory(category);

				sale.setItem(item);

				result.add(sale);
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public void insert(ServletContext context, Sale sale) {
		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "insert into sales(saledate, userid, itemid, amount) values(datetime('now', 'localtime'),?,?,?)";

			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, sale.getUser().getUserId());
			stmt.setInt(2, sale.getItem().getItemId());
			stmt.setInt(3, sale.getItem().getAmount());

			stmt.executeUpdate();

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
