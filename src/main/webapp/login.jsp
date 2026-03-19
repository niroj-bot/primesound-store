<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン - PrimeSound Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
	String message = (String) request.getAttribute("message");
	String registered = request.getParameter("registered");
%>

<style>
	body { background-color: #f8f9fa; }
	.navbar-brand { color: #ff9900 !important; font-weight: bold; }
</style>
</head>
<body>

<div class="container mt-5">
	<div class="row justify-content-center">
		<div class="col-md-5">

			<div class="text-center mb-4">
				<h3 style="color:#ff9900; font-weight:bold;"><i class="bi bi-shop"></i> PrimeSound Store</h3>
				<p class="text-muted">アカウントにサインイン</p>
			</div>

			<div class="card">
				<div class="card-header bg-dark text-white">
					<i class="bi bi-box-arrow-in-right"></i> ログイン
				</div>
				<div class="card-body p-4">

					<% if (registered != null && registered.equals("1")) { %>
						<div class="alert alert-success">
							<i class="bi bi-check-circle"></i> 登録が完了しました。ログインしてください。
						</div>
					<% } %>

					<form action="LoginController" method="post">
						<div class="mb-3">
							<label class="form-label">メールアドレス</label>
							<input type="email" class="form-control" name="userid" placeholder="example@email.com" required>
						</div>
						<div class="mb-3">
							<label class="form-label">パスワード</label>
							<input type="password" class="form-control" name="password" placeholder="パスワード" required>
						</div>

						<% if (message != null) { %>
							<div class="alert alert-danger">
								<i class="bi bi-exclamation-circle"></i> <%= message %>
							</div>
						<% } %>

						<div class="d-grid">
							<button type="submit" class="btn btn-dark"><i class="bi bi-box-arrow-in-right"></i> ログイン</button>
						</div>
					</form>

					<hr>
					<div class="text-center">
						アカウントをお持ちでない方は <a href="register.jsp">新規登録</a>
					</div>
					<div class="text-center mt-2">
						<a href="ItemListController" class="text-muted"><i class="bi bi-arrow-left"></i> ショッピングを続ける</a>
					</div>

				</div>
			</div>
			
			<div class="card mt-3 border-warning">
				<div class="card-body p-3 text-muted small">
					<strong><i class="bi bi-info-circle"></i> テスト用アカウント</strong><br>
					Admin: admin@gmail.com / 12345<br>
					User: user@gmail.com / 12345
				</div>
			</div>

		</div>
	</div>
</div>
</body>
</html>
