package aiwa.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.entity.Category;
import aiwa.entity.Item;
import aiwa.model.CategoryModel;
import aiwa.model.ItemModel;

@WebServlet("/ItemInsertController")
public class ItemInsertController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//1.PARAMETER

		//2.MODEL
		CategoryModel cm = new CategoryModel();
		ArrayList<Category> categories = cm.findAll(getServletContext());

		//3.VIEW
		request.setAttribute("categories", categories);
		request.getRequestDispatcher("/itemInsertView.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//1.PARAMETER
		request.setCharacterEncoding("UTF-8");
		String itemName = request.getParameter("itemname");
		String price = request.getParameter("price");
		String detail = request.getParameter("detail");
		String image = request.getParameter("image");
		String rating = request.getParameter("rating");
		String categoryId = request.getParameter("categoryid");
		String stock = request.getParameter("stock");

		//2.MODEL
		ItemModel im = new ItemModel();

		Item item = new Item();
		item.setItemName(itemName);
		item.setPrice(Integer.parseInt(price));
		item.setDetail(detail);
		item.setImage(image);
		item.setRating(Double.parseDouble(rating));
		item.setStock(Integer.parseInt(stock));

		Category category = new Category();
		category.setCategoryId(Integer.parseInt(categoryId));

		item.setCategory(category);

		im.insert(getServletContext(), item);

		//3.VIEW
		response.sendRedirect("ItemListController");
	}

}
