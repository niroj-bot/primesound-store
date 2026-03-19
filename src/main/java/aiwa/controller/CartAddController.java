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
import aiwa.model.ItemModel;

@WebServlet("/CartAddController")
public class CartAddController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		
		if (session.getAttribute("user") == null) {
			
			session.setAttribute("redirectUrl", "CartListController");
			response.sendRedirect("ItemListController");
			return;
		}

		//1.PARAMETER
		String itemId = request.getParameter("itemid");

		//2.MODEL
		ItemModel im = new ItemModel();
		Item item = im.findById(getServletContext(), Integer.parseInt(itemId));

		// Block if out of stock
		if (item.getStock() <= 0) {
			response.sendRedirect("ItemListController");
			return;
		}

		ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");

		if (cart == null) {
			cart = new ArrayList<Item>();
		}

		// Check current cart amount for this item
		int currentAmount = 0;
		for (Item c : cart) {
			if (c.getItemId() == item.getItemId()) {
				currentAmount = c.getAmount();
			}
		}

		// Block if cart amount already reached stock limit
		if (currentAmount >= item.getStock()) {
			response.sendRedirect("CartListController");
			return;
		}

		boolean hit = false;
		for (Item c : cart) {
			if (c.getItemId() == item.getItemId()) {
				c.setAmount(c.getAmount() + 1);
				hit = true;
			}
		}

		if (!hit) {
			cart.add(item);
		}

		session.setAttribute("cart", cart);

		//3.VIEW
		response.sendRedirect("CartListController");
	}
}
