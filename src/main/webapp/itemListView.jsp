<%@page import="aiwa.entity.User"%>
<%@page import="aiwa.entity.Category"%>
<%@page import="aiwa.util.StringUtil"%>
<%@page import="aiwa.entity.Item"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品一覧 - PrimeSound Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
	ArrayList<Item> items = (ArrayList<Item>) request.getAttribute("items");
	String word = (String) request.getAttribute("word");
	int priceMin = (int) request.getAttribute("pricemin");
	int priceMax = (int) request.getAttribute("pricemax");
	ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
	int categoryId = (int) request.getAttribute("categoryid");
	int order = (int) request.getAttribute("order");
	User user = (User) session.getAttribute("user");
	boolean isLoggedIn = (user != null);
	boolean isAdmin = isLoggedIn && (user.getManager() == 1);

	String updated = request.getParameter("updated");

	ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");
	int cartCount = 0;
	if (cart != null) {
		for (Item ci : cart) {
			cartCount += ci.getAmount();
		}
	}
%>

<style>
	body { background-color: #f8f9fa; }
	.navbar-brand { color: #ff9900 !important; font-weight: bold; }
	.card { border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
	.item-card { transition: transform 0.2s; }
	.item-card:hover { transform: translateY(-5px); }
	.card-img-top { height: 200px; object-fit: cover; }
</style>
</head>
<body>


<nav class="navbar navbar-dark bg-dark px-3">
	<a class="navbar-brand" href="ItemListController"><i class="bi bi-shop"></i> PrimeSound Store</a>
	<div class="d-flex gap-2 align-items-center">
		<% if (isLoggedIn) { %>
			<span class="text-white">
				<% if (isAdmin) { %>
					<i class="bi bi-shield-check text-warning"></i> <%= user.getUserName() %>
				<% } else { %>
					<a href="ProfileController" class="text-white text-decoration-none"><i class="bi bi-person-circle"></i> <%= user.getUserName() %>さん</a>
				<% } %>
			</span>
			<% if (!isAdmin) { %>
				<a href="CartListController" class="btn btn-outline-warning btn-sm">
					<i class="bi bi-cart3"></i> カート
					<% if (cartCount > 0) { %><span class="badge bg-warning text-dark"><%= cartCount %></span><% } %>
				</a>
			<% } %>
			<a href="SaleListController" class="btn btn-outline-light btn-sm"><i class="bi bi-clock-history"></i> 購入履歴</a>
			<a href="LogoutController" class="btn btn-outline-danger btn-sm"><i class="bi bi-box-arrow-right"></i> ログアウト</a>
		<% } else { %>
			<a href="login.jsp" class="btn btn-warning btn-sm"><i class="bi bi-box-arrow-in-right"></i> ログイン</a>
			<a href="register.jsp" class="btn btn-outline-light btn-sm"><i class="bi bi-person-plus"></i> 新規登録</a>
		<% } %>
	</div>
</nav>

<div class="container mt-4">

	<h4 class="mb-3">商品一覧</h4>

	<% if (isAdmin) { %>
		<a href="ItemInsertController" class="btn btn-warning mb-3"><i class="bi bi-plus-circle"></i> 商品登録</a>
	<% } %>

	
	<div class="card p-3 mb-4">
		<form action="ItemListController">
			<div class="row mb-2">
				<div class="col-md-4 mb-2">
					<select class="form-select" name="categoryid" onchange="submit(this.form)">
						<option value="0">すべてのカテゴリー</option>
						<% for (Category c : categories) { %>
							<option value="<%= c.getCategoryId() %>" <%= c.getCategoryId() == categoryId ? "selected" : "" %>>
								<%= c.getCategoryName() %>
							</option>
						<% } %>
					</select>
				</div>
				<div class="col-md-4 mb-2">
					<input type="text"  class="form-control" name="word" placeholder="キーワード" value="<%= word %>">
				</div>
				<div class="col-md-2 mb-2">
					<input type="number" class="form-control" name="pricemin" placeholder="最小価格" value="<%= priceMin > 0 ? priceMin : "" %>">
				</div>
				<div class="col-md-2 mb-2">
					<input type="number" class="form-control" name="pricemax" placeholder="最大価格" value="<%= priceMax > 0 ? priceMax : "" %>">
				</div>
			</div>
			<div class="mb-2 d-flex justify-content-between align-items-center">
				<div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" onchange="submit(this.form)" type="radio" name="order" value="0" <%= order == 0 ? "checked" : "" %>>
						<label class="form-check-label">ID順</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input"onchange="submit(this.form)" type="radio" name="order" value="1" <%= order == 1 ? "checked" : "" %>>
						<label class="form-check-label">価格安い順</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" onchange="submit(this.form)" type="radio" name="order" value="2" <%= order == 2 ? "checked" : "" %>>
						<label class="form-check-label">価格高い順</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" onchange="submit(this.form)" type="radio" name="order" value="3" <%= order == 3 ? "checked" : "" %>>
						<label class="form-check-label">評価低い順</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" onchange="submit(this.form)" type="radio" name="order" value="4" <%= order == 4 ? "checked" : "" %>>
						<label class="form-check-label">評価高い順</label>
					</div>
				</div>
				<button type="submit" class="btn btn-primary btn-sm"><i class="bi bi-search"></i> 検索</button>
			</div>
		</form>
	</div>

	<% if (updated != null && updated.equals("1")) { %>
		<div class="alert alert-success alert-dismissible">
			<i class="bi bi-check-circle"></i> プロフィールを更新しました。
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
		</div>
	<% } %>

	<% if (!isLoggedIn) { %>
		<div class="alert alert-info mb-3">
			<i class="bi bi-info-circle"></i> カートに追加するには <a href="login.jsp">ログイン</a> または <a href="register.jsp">新規登録</a> してください。
		</div>
	<% } %>

	
	<div class="row">
	<% for (Item item : items) { %>
		<div class="col-md-3 col-sm-6 mb-4">
			<div class="card item-card h-100">
				<img src="<%= item.getImage() %>" class="card-img-top" alt="<%= item.getItemName() %>">
				<div class="card-body">
					<h6 class="card-title"><%= item.getItemName() %></h6>
					<p class="card-text text-primary"><strong><%= StringUtil.toMoney(item.getPrice()) %></strong></p>
					<p class="card-text"><%= StringUtil.toStars(item.getRating()) %></p>
					<% if (item.getStock() > 0) { %>
						<span class="badge bg-success mb-2">在庫あり (<%= item.getStock() %>)</span>
					<% } else { %>
						<span class="badge bg-danger mb-2">在庫なし</span>
					<% } %>
					<br>
					<a href="ItemDetailController?itemid=<%= item.getItemId() %>" class="btn btn-outline-primary btn-sm">詳細</a>
					<% if (isAdmin) { %>
						<a href="ItemUpdateController?itemid=<%= item.getItemId() %>" class="btn btn-success btn-sm"><i class="bi bi-pencil"></i></a>
						<a href="ItemDeleteController?itemid=<%= item.getItemId() %>" onclick="return confirm('削除しますか？')" class="btn btn-danger btn-sm"><i class="bi bi-trash3"></i></a>
					<% } else if (isLoggedIn) { %>
						<% if (item.getStock() > 0) { %>
							<a href="CartAddController?itemid=<%= item.getItemId() %>" class="btn btn-warning btn-sm"><i class="bi bi-cart-plus"></i> カート</a>
						<% } else { %>
							<button class="btn btn-secondary btn-sm" disabled>在庫なし</button>
						<% } %>
					<% } else { %>
						<a href="login.jsp" class="btn btn-outline-secondary btn-sm"><i class="bi bi-cart-plus"></i> カート</a>
					<% } %>
				</div>
			</div>
		</div>
	<% } %>
	</div>

	<% if (items.isEmpty()) { %>
		<p class="text-center text-muted mt-4">商品が見つかりませんでした</p>
	<% } %>

</div>

</body>
</html>
