package aiwa.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import aiwa.entity.User;
import aiwa.model.UserModel;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//1.PARAMETER
		request.setCharacterEncoding("UTF-8");

		String userId  = request.getParameter("userid");
		String password = request.getParameter("password");

		//2.MODEL
		UserModel um = new UserModel();
		User user = um.findByIdAndPassword(getServletContext(), userId, password);

		//3.VIEW
		if (user == null) {
			request.setAttribute("message", "ユーザーIDまたはパスワードが違います");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			// Smart redirect: go back to saved URL if exists (e.g. cart), else item list
			String redirectUrl = (String) session.getAttribute("redirectUrl");
			if (redirectUrl != null && !redirectUrl.isEmpty()) {
				session.removeAttribute("redirectUrl");
				response.sendRedirect(redirectUrl);
			} else {
				response.sendRedirect("ItemListController");
			}
		}
	}
}
