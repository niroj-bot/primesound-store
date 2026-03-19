package aiwa.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import aiwa.entity.Item;
import aiwa.entity.Sale;
import aiwa.entity.User;
import aiwa.model.ItemModel;
import aiwa.model.SaleModel;

@WebServlet("/SaleInsertController")
public class SaleInsertController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		//1.PARAMETER

		//2.MODEL
		User user = (User) session.getAttribute("user");
		ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");
		SaleModel sm = new SaleModel();
		ItemModel im = new ItemModel();

		for (Item c : cart) {
			Sale sale = new Sale();
			sale.setUser(user);
			sale.setItem(c);
			sm.insert(getServletContext(), sale);
			im.decreaseStock(getServletContext(), c.getItemId(), c.getAmount());
		}

		cart.clear();

		session.setAttribute("cart", cart);

		//3.VIEW
		response.sendRedirect("SaleListController");
	}

}
