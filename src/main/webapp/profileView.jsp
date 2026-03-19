<%@page import="aiwa.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>プロフィール編集 - PrimeSound Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
	User user = (User) session.getAttribute("user");
	String errorMessage = (String) request.getAttribute("errorMessage");
%>

<style>
	body { background-color: #f8f9fa; }
	.navbar-brand { color: #ff9900 !important; font-weight: bold; }
</style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark px-3">
	<a class="navbar-brand" href="ItemListController"><i class="bi bi-shop"></i> PrimeSound Store</a>
	<div class="d-flex gap-2 align-items-center">
		<span class="text-white"><i class="bi bi-person-circle"></i> <%= user.getUserName() %>さん</span>
		<a href="LogoutController" class="btn btn-outline-danger btn-sm"><i class="bi bi-box-arrow-right"></i> ログアウト</a>
	</div>
</nav>

<div class="container mt-4">

	<a href="#" onclick="history.back()" class="btn btn-secondary btn-sm mb-3"><i class="bi bi-arrow-left"></i> 戻る</a>

	<div class="row justify-content-center">
		<div class="col-md-6">

			<div class="card p-4">
				<h5 class="mb-4"><i class="bi bi-person-circle"></i> プロフィール編集</h5>

				<% if (errorMessage != null) { %>
					<div class="alert alert-danger">
						<i class="bi bi-exclamation-circle"></i> <%= errorMessage %>
					</div>
				<% } %>

				<form action="ProfileController" method="post">

					<div class="mb-3">
						<label class="form-label">メールアドレス (変更不可)</label>
						<input type="email" class="form-control" value="<%= user.getUserId() %>" disabled>
					</div>

					<div class="mb-3">
						<label class="form-label">ユーザー名</label>
						<input type="text" class="form-control" name="username" value="<%= user.getUserName() %>" required>
					</div>

					<hr>
					<p class="text-muted small">パスワードを変更する場合のみ入力してください。変更しない場合は空白のままにしてください。</p>

					<div class="mb-3">
						<label class="form-label">新しいパスワード <small class="text-muted">(5文字以上)</small></label>
						<input type="password" class="form-control" name="newpassword" id="newpassword" placeholder="新しいパスワード">
					</div>

					<div class="mb-3">
						<label class="form-label">パスワード確認</label>
						<input type="password" class="form-control" name="confirm" id="confirm" placeholder="パスワードをもう一度">
						<small id="pwMatchMsg"></small>
					</div>

					<div class="text-end">
						<button type="button" class="btn btn-secondary" onclick="history.back()"><i class="bi bi-x-circle"></i> キャンセル</button>
						<button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> 保存</button>
					</div>

				</form>
			</div>

		</div>
	</div>
</div>

<script>
	const pw  = document.getElementById('newpassword');
	const pw2 = document.getElementById('confirm');
	const msg = document.getElementById('pwMatchMsg');

	function checkMatch() {
		if (pw.value.length === 0 || pw2.value.length === 0) {
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
</script>
</body>
</html>
