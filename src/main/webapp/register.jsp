<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規登録 - PrimeSound Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
	String errorMessage = (String) request.getAttribute("errorMessage");
%>

<style>
	body { background-color: #f8f9fa; }
</style>
</head>
<body>

<div class="container mt-5">
	<div class="row justify-content-center">
		<div class="col-md-5">

			<div class="text-center mb-4">
				<h3 style="color:#ff9900; font-weight:bold;"><i class="bi bi-shop"></i> PrimeSound Store</h3>
				<p class="text-muted">新しいアカウントを作成</p>
			</div>

			<div class="card">
				<div class="card-header bg-dark text-white">
					<i class="bi bi-person-plus"></i> 新規登録
				</div>
				<div class="card-body p-4">

					<% if (errorMessage != null) { %>
						<div class="alert alert-danger">
							<i class="bi bi-exclamation-circle"></i> <%= errorMessage %>
						</div>
					<% } %>

					<form action="RegisterController" method="post" id="registerForm">
						<div class="mb-3">
							<label class="form-label">メールアドレス (ログインID)</label>
							<input type="email" class="form-control" name="userid" id="userid" placeholder="example@email.com" required>
						</div>
						<div class="mb-3">
							<label class="form-label">ユーザー名</label>
							<input type="text" class="form-control" name="username" placeholder="表示名" required>
						</div>
						<div class="mb-3">
							<label class="form-label">パスワード <small class="text-muted">(5文字以上)</small></label>
							<input type="password" class="form-control" name="password" id="password" placeholder="パスワード" required minlength="5">
						</div>
						<div class="mb-3">
							<label class="form-label">パスワード確認</label>
							<input type="password" class="form-control" name="password2" id="password2" placeholder="パスワードをもう一度" required>
							<small id="pwMatchMsg"></small>
						</div>

						<div class="d-grid">
							<button type="submit" class="btn btn-warning"><i class="bi bi-person-check"></i> 登録する</button>
						</div>
					</form>

					<hr>
					<div class="text-center">
						すでにアカウントをお持ちの方は <a href="login.jsp">ログイン</a>
					</div>

				</div>
			</div>

		</div>
	</div>
</div>

<script>
	const pw  = document.getElementById('password');
	const pw2 = document.getElementById('password2');
	const msg = document.getElementById('pwMatchMsg');

	function checkMatch() {
		if (pw2.value.length === 0) {
			msg.textContent = '';
			return;
		}
		if (pw.value === pw2.value) {
			msg.textContent = '✓ パスワードが一致しています';
			msg.style.color = 'green';
		} else {
			msg.textContent = '✗ パスワードが一致しません';
			msg.style.color = 'red';
		}
	}

	pw.addEventListener('input', checkMatch);
	pw2.addEventListener('input', checkMatch);

	document.getElementById('registerForm').addEventListener('submit', function(e) {
		if (pw.value !== pw2.value) {
			e.preventDefault();
			msg.textContent = '✗ パスワードが一致しません';
			msg.style.color = 'red';
		}
	});
</script>
</body>
</html>
