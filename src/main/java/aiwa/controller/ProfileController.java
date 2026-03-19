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

@WebServlet("/ProfileController")
public class ProfileController extends HttpServlet {

	// GET - show profile page with current data
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		// Must be logged in
		if (user == null) {
			response.sendRedirect("ItemListController");
			return;
		}

		request.getRequestDispatcher("/profileView.jsp").forward(request, response);
	}

	// POST - save updated profile
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		// Must be logged in
		if (user == null) {
			response.sendRedirect("ItemListController");
			return;
		}

		//1. PARAMETERS
		String userName    = request.getParameter("username");
		String newPassword = request.getParameter("newpassword");
		String confirm     = request.getParameter("confirm");

		//2. VALIDATION
		if (userName == null || userName.trim().isEmpty()) {
			request.setAttribute("errorMessage", "ユーザー名を入力してください");
			request.getRequestDispatcher("/profileView.jsp").forward(request, response);
			return;
		}

		// If new password entered, validate it
		String passwordToSave = user.getPassword(); // keep current by default

		if (newPassword != null && !newPassword.isEmpty()) {
			if (newPassword.length() < 5) {
				request.setAttribute("errorMessage", "パスワードは5文字以上で入力してください");
				request.getRequestDispatcher("/profileView.jsp").forward(request, response);
				return;
			}
			if (!newPassword.equals(confirm)) {
				request.setAttribute("errorMessage", "パスワードが一致しません");
				request.getRequestDispatcher("/profileView.jsp").forward(request, response);
				return;
			}
			passwordToSave = newPassword;
		}

		//3. MODEL - update DB
		UserModel um = new UserModel();
		boolean success = um.updateUser(getServletContext(), user.getUserId(), userName.trim(), passwordToSave);

		//4. VIEW
		if (success) {
			// Update session with new data
			user.setUserName(userName.trim());
			user.setPassword(passwordToSave);
			session.setAttribute("user", user);

			response.sendRedirect("ItemListController?updated=1");
		} else {
			request.setAttribute("errorMessage", "更新に失敗しました");
			request.getRequestDispatcher("/profileView.jsp").forward(request, response);
		}
	}
}
