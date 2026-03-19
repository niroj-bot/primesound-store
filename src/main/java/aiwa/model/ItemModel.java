package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.condition.ItemSearchCondition;
import aiwa.entity.Category;
import aiwa.entity.Item;

public class ItemModel {

	// Decrease stock when item is purchased
	public void decreaseStock(ServletContext context, int itemId, int amount) {
		try {
			Class.forName("org.sqlite.JDBC");
			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));
			String sql = "update items set stock = stock - ? where itemid = ? and stock > 0";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, amount);
			stmt.setInt(2, itemId);
			stmt.executeUpdate();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void update(ServletContext context, Item item) {
		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "update items set itemname = ?, price = ?, detail = ?, rating = ?, image = ?, categoryid = ?, stock = ? where itemid = ?";

			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, item.getItemName());
			stmt.setInt(2, item.getPrice());
			stmt.setString(3, item.getDetail());
			stmt.setDouble(4, item.getRating());
			stmt.setString(5, item.getImage());
			stmt.setInt(6, item.getCategory().getCategoryId());
			stmt.setInt(7, item.getStock());
			stmt.setInt(8, item.getItemId());

			stmt.executeUpdate();

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void insert(ServletContext context, Item item) {
		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "insert into items(itemname, price, detail, rating, image, categoryid, stock) values(?,?,?,?,?,?,?)";

			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, item.getItemName());
			stmt.setInt(2, item.getPrice());
			stmt.setString(3, item.getDetail());
			stmt.setDouble(4, item.getRating());
			stmt.setString(5, item.getImage());
			stmt.setInt(6, item.getCategory().getCategoryId());
			stmt.setInt(7, item.getStock());

			stmt.executeUpdate();

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void delete(ServletContext context, int itemId) {
		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "delete from items where itemid = ?";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, itemId);

			stmt.executeUpdate();

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Item findById(ServletContext context, int itemId) {

		try {

			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "select * from items i inner join categories c on i.categoryid = c.categoryid where itemid = ? ";

			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, itemId);

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				Item item = new Item();
				item.setItemId(rs.getInt("itemid"));
				item.setItemName(rs.getString("itemname"));
				item.setPrice(rs.getInt("price"));
				item.setDetail(rs.getString("detail"));
				item.setImage(rs.getString("image"));
				item.setRating(rs.getDouble("rating"));
				item.setStock(rs.getInt("stock"));

				Category category = new Category();
				category.setCategoryId(rs.getInt("categoryid"));
				category.setCategoryName(rs.getString("categoryname"));

				item.setCategory(category);

				conn.close();

				return item;
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public ArrayList<Item> findByCondition(ServletContext context, ItemSearchCondition condition) {

		ArrayList<Item> result = new ArrayList<Item>();

		try {

			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:" + context.getRealPath("WEB-INF/webapp16.db"));

			String sql = "select "
					+ " * "
					+ "from "
					+ " items i "
					+ "inner join "
					+ " categories c "
					+ "on "
					+ " i.categoryid = c.categoryid "
					+ "where "
					+ " (itemname like ? or detail like ? ) ";

			if (condition.getCategoryId() > 0) {
				sql += "and i.categoryid = ? ";
			}

			if (condition.getPriceMin() > 0) {
				sql += "and price >= ? ";
			}

			if (condition.getPriceMax() > 0) {
				sql += "and price <= ? ";
			}

			switch (condition.getOrder()) {
			case 0:
				sql += "order by itemid ";
				break;
			case 1:
				sql += "order by price ";
				break;
			case 2:
				sql += "order by price desc ";
				break;
			case 3:
				sql += "order by rating ";
				break;
			case 4:
				sql += "order by rating desc ";
				break;
			}

			PreparedStatement stmt = conn.prepareStatement(sql);

			int index = 1;
			stmt.setString(index++, "%" + condition.getWord() + "%");
			stmt.setString(index++, "%" + condition.getWord() + "%");

			if (condition.getCategoryId() > 0) {
				stmt.setInt(index++, condition.getCategoryId());
			}

			if (condition.getPriceMin() > 0) {
				stmt.setInt(index++, condition.getPriceMin());
			}

			if (condition.getPriceMax() > 0) {
				stmt.setInt(index++, condition.getPriceMax());
			}

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Item item = new Item();
				item.setItemId(rs.getInt("itemid"));
				item.setItemName(rs.getString("itemname"));
				item.setPrice(rs.getInt("price"));
				item.setDetail(rs.getString("detail"));
				item.setImage(rs.getString("image"));
				item.setRating(rs.getDouble("rating"));
				item.setStock(rs.getInt("stock"));

				Category category = new Category();
				category.setCategoryId(rs.getInt("categoryid"));
				category.setCategoryName(rs.getString("categoryname"));

				item.setCategory(category);

				result.add(item);
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}
