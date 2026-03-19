package aiwa.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.model.UserModel;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//1.PARAMETER
		request.setCharacterEncoding("UTF-8");

		String userId   = request.getParameter("userid");
		String userName = request.getParameter("username");
		String password = request.getParameter("password");

		//2.SERVER-SIDE VALIDATION

		// Email format check (simple)
		if (userId == null || !userId.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
			request.setAttribute("errorMessage", "有効なメールアドレスを入力してください");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Username check
		if (userName == null || userName.trim().isEmpty()) {
			request.setAttribute("errorMessage", "ユーザー名を入力してください");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Password minimum length (5 characters)
		if (password == null || password.length() < 5) {
			request.setAttribute("errorMessage", "パスワードは5文字以上で入力してください");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		//3.MODEL
		UserModel um = new UserModel();

		// Duplicate email check
		if (um.existsById(getServletContext(), userId)) {
			request.setAttribute("errorMessage", "このメールアドレスはすでに登録されています");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Insert new user
		boolean success = um.insertUser(getServletContext(), userId, userName.trim(), password);

		//4.VIEW
		if (success) {
			response.sendRedirect("login.jsp?registered=1");
		} else {
			request.setAttribute("errorMessage", "登録に失敗しました。もう一度お試しください");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
		}
	}
}
