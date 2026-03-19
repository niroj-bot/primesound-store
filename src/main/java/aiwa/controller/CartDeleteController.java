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

@WebServlet("/CartDeleteController")
public class CartDeleteController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		//1.PARAMETER
		String itemId = request.getParameter("itemid");

		//2.CART
		ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");

		for (Item c : cart) {

			if (c.getItemId() == Integer.parseInt(itemId)) {
				c.setAmount(c.getAmount() - 1);
				if (c.getAmount() == 0) {
					cart.remove(c);
					break;
				}
			}
		}

		session.setAttribute("cart", cart);

		//3.VIEW
		response.sendRedirect("CartListController");
	}

}
