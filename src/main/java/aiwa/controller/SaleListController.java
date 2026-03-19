package aiwa.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.entity.Sale;
import aiwa.entity.User;
import aiwa.model.SaleModel;

@WebServlet("/SaleListController")
public class SaleListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		if(request.getSession().getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		//1.PARAMETER

		//2.MODEL
		SaleModel sm = new SaleModel();
		
		User user = (User) request.getSession().getAttribute("user");
		
		ArrayList<Sale> sales; 
		if(user.getManager() == 1) {
		
		sales = sm.findAll(getServletContext());
		} else {
			sales = sm.findByUserId(getServletContext(), user.getUserId());
		}
			

		//3.VIEW
		request.setAttribute("sales", sales);
		request.getRequestDispatcher("/saleListView.jsp").forward(request, response);
		}
		
	
	
}
