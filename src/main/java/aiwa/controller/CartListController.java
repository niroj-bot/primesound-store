package aiwa.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CartListController")
public class CartListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		if (session.getAttribute("user") == null) {
			// Save redirect URL so login brings them back here
			session.setAttribute("redirectUrl", "CartListController");
			response.sendRedirect("ItemListController");
			return;
		}

		request.getRequestDispatcher("/cartListView.jsp").forward(request, response);
	}
}
