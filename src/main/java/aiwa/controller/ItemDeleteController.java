package aiwa.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.model.ItemModel;

@WebServlet("/ItemDeleteController")
public class ItemDeleteController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//1.PARAMETER
		String itemId = request.getParameter("itemid");

		//2.MODEL
		ItemModel im = new ItemModel();
		im.delete(getServletContext(), Integer.parseInt(itemId));

		//3.VIEW
		response.sendRedirect("ItemListController");
	}

}
