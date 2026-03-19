package aiwa.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.condition.ItemSearchCondition;
import aiwa.entity.Category;
import aiwa.entity.Item;
import aiwa.model.CategoryModel;
import aiwa.model.ItemModel;

@WebServlet("/ItemListController")
public class ItemListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//1.PARAMETER
		String word = request.getParameter("word") == null ? "" : request.getParameter("word");
		String categoryId = request.getParameter("categoryid") == null ? "0" : request.getParameter("categoryid");

		String priceMin = request.getParameter("pricemin") == null || request.getParameter("pricemin").equals("") ? "0"
				: request.getParameter("pricemin");

		String priceMax = request.getParameter("pricemax") == null || request.getParameter("pricemax").equals("") ? "0"
				: request.getParameter("pricemax");

		String order = request.getParameter("order") == null ? "0" : request.getParameter("order");

		//2.MODEL
		ItemModel im = new ItemModel();
		ItemSearchCondition condition = new ItemSearchCondition();
		condition.setWord(word);
		condition.setCategoryId(Integer.parseInt(categoryId));
		condition.setPriceMin(Integer.parseInt(priceMin));
		condition.setPriceMax(Integer.parseInt(priceMax));
		condition.setOrder(Integer.parseInt(order));

		ArrayList<Item> items = im.findByCondition(getServletContext(), condition);

		CategoryModel cm = new CategoryModel();
		ArrayList<Category> categories = cm.findAll(getServletContext());

		//3.VIEW
		request.setAttribute("items", items);
		request.setAttribute("word", word);
		request.setAttribute("categoryid", Integer.parseInt(categoryId));
		request.setAttribute("pricemin", Integer.parseInt(priceMin));
		request.setAttribute("pricemax", Integer.parseInt(priceMax));
		request.setAttribute("order", Integer.parseInt(order));

		request.setAttribute("categories", categories);

		request.getRequestDispatcher("/itemListView.jsp").forward(request, response);
	}

}
