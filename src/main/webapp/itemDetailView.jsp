<%@page import="aiwa.entity.User"%>
<%@page import="aiwa.util.StringUtil"%>
<%@page import="aiwa.entity.Item"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品詳細 - PrimeSound Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
	Item item = (Item) request.getAttribute("item");
	User user = (User) session.getAttribute("user");
	boolean isLoggedIn = (user != null);
	boolean isAdmin = isLoggedIn && (user.getManager() == 1);

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

	<a href="#" onclick="history.back()" class="btn btn-secondary btn-sm mb-3"><i class="bi bi-arrow-left"></i> 戻る</a>

	<div class="card p-3">
		<h5 class="mb-3"><%= item.getItemName() %></h5>
		<table class="table table-bordered">
			<tr><th style="width:25%">商品ID</th><td><%= item.getItemId() %></td></tr>
			<tr><th>価格</th><td class="text-primary"><strong><%= StringUtil.toMoney(item.getPrice()) %></strong></td></tr>
			<tr><th>評価</th><td><%= StringUtil.toStars(item.getRating()) %></td></tr>
			<tr><th>説明</th><td><%= StringUtil.toBr(item.getDetail()) %></td></tr>
			<tr><th>カテゴリー</th><td><%= item.getCategory().getCategoryName() %></td></tr>
			<tr>
				<th>在庫</th>
				<td>
					<% if (item.getStock() > 0) { %>
						<span class="badge bg-success">在庫あり (<%= item.getStock() %>)</span>
					<% } else { %>
						<span class="badge bg-danger">在庫なし</span>
					<% } %>
				</td>
			</tr>
			<tr><th>画像</th><td><img src="<%= item.getImage() %>" height="250px" style="border-radius:6px;"></td></tr>
		</table>

		<div class="text-end mt-2">
			<% if (isAdmin) { %>
				<a href="ItemUpdateController?itemid=<%= item.getItemId() %>" class="btn btn-success"><i class="bi bi-pencil-square"></i> 修正</a>
				<a href="ItemDeleteController?itemid=<%= item.getItemId() %>" onclick="return confirm('削除しますか？')" class="btn btn-danger"><i class="bi bi-trash3"></i> 削除</a>
			<% } else if (isLoggedIn) { %>
				<% if (item.getStock() > 0) { %>
					<a href="CartAddController?itemid=<%= item.getItemId() %>" class="btn btn-warning"><i class="bi bi-cart-check"></i> カートに入れる</a>
				<% } else { %>
					<button class="btn btn-secondary" disabled>在庫なし</button>
				<% } %>
			<% } else { %>
				<a href="login.jsp" class="btn btn-warning"><i class="bi bi-box-arrow-in-right"></i> ログインしてカートに追加</a>
			<% } %>
		</div>
	</div>

</div>
</body>
</html>
