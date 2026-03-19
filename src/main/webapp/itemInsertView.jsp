<%@page import="aiwa.entity.User"%>
<%@page import="aiwa.entity.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品登録 - PrimeSound Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
	ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
	User user = (User) session.getAttribute("user");
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
		<span class="text-white"><i class="bi bi-shield-check text-warning"></i> <%= user.getUserName() %></span>
		<a href="SaleListController" class="btn btn-outline-light btn-sm"><i class="bi bi-clock-history"></i> 購入履歴</a>
		<a href="LogoutController" class="btn btn-outline-danger btn-sm"><i class="bi bi-box-arrow-right"></i> ログアウト</a>
	</div>
</nav>

<div class="container mt-4">

	<a href="#" onclick="history.back()" class="btn btn-secondary btn-sm mb-3"><i class="bi bi-arrow-left"></i> 戻る</a>

	<div class="card p-4">
		<h5 class="mb-4"><i class="bi bi-plus-circle"></i> 商品登録</h5>

		<form action="ItemInsertController" method="post">
			<div class="mb-3">
				<label class="form-label">商品名</label>
				<input type="text" class="form-control" name="itemname" placeholder="商品名" required>
			</div>
			<div class="mb-3">
				<label class="form-label">価格</label>
				<input type="number" class="form-control" name="price" placeholder="価格" required>
			</div>
			<div class="mb-3">
				<label class="form-label">説明</label>
				<textarea class="form-control" name="detail" placeholder="説明" rows="3"></textarea>
			</div>
			<div class="mb-3">
				<label class="form-label">画像URL</label>
				<input type="text" class="form-control" name="image" placeholder="https://...">
			</div>
			<div class="mb-3">
				<label class="form-label">評価: <span id="rangeValue">0</span></label>
				<input type="range" class="form-range" name="rating" min="0" max="5" value="0" step="0.1" id="range4">
			</div>
			<div class="mb-3">
				<label class="form-label">在庫数</label>
				<input type="number" class="form-control" name="stock" placeholder="在庫数" min="0" value="0" required>
			</div>
			<div class="mb-3">
				<label class="form-label">カテゴリー</label>
				<select name="categoryid" class="form-select">
					<% for (Category c : categories) { %>
						<option value="<%= c.getCategoryId() %>"><%= c.getCategoryName() %></option>
					<% } %>
				</select>
			</div>
			<div class="text-end">
				<button type="button" class="btn btn-secondary" onclick="history.back()"><i class="bi bi-x-circle"></i> キャンセル</button>
				<button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> 登録</button>
			</div>
		</form>
	</div>

</div>

<script>
	const rangeInput = document.getElementById('range4');
	const rangeOutput = document.getElementById('rangeValue');
	rangeOutput.textContent = rangeInput.value;
	rangeInput.addEventListener('input', function() {
		rangeOutput.textContent = this.value;
	});
</script>
</body>
</html>
