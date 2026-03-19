<%@page import="aiwa.entity.Sale"%>
<%@page import="aiwa.entity.User"%>
<%@page import="aiwa.util.StringUtil"%>
<%@page import="aiwa.entity.Item"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>購入履歴 - PrimeSound Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
	ArrayList<Sale> sales = (ArrayList<Sale>) request.getAttribute("sales");
	User user = (User) session.getAttribute("user");
	boolean isAdmin = (user != null) && (user.getManager() == 1);

	ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");
	int cartCount = 0;
	if (cart != null && !isAdmin) {
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
	</div>
</nav>

<div class="container mt-4">

	<h4 class="mb-3"><i class="bi bi-clock-history"></i> 購入履歴</h4>

	<% if (sales == null || sales.size() == 0) { %>
		<div class="alert alert-warning">購入履歴がありません</div>
		<a href="ItemListController" class="btn btn-primary">買い物を始める</a>
	<% } else { %>
		<table class="table table-bordered table-striped">
			<thead class="table-dark">
				<tr>
					<th>購入日時</th>
					<th>画像</th>
					<% if (isAdmin) { %><th>ユーザー名</th><% } %>
					<th>商品名</th>
					<th>価格</th>
					<th>数量</th>
					<th>小計</th>
				</tr>
			</thead>
			<tbody>
			<% for (Sale sale : sales) { %>
				<tr>
					<td><%= StringUtil.toDate(sale.getSaleDate()) %></td>
					<td><img src="<%= sale.getItem().getImage() %>" height="60px"></td>
					<% if (isAdmin) { %><td><%= sale.getUser().getUserName() %></td><% } %>
					<td><%= sale.getItem().getItemName() %></td>
					<td><%= StringUtil.toMoney(sale.getItem().getPrice()) %></td>
					<td><%= sale.getAmount() %></td>
					<td><%= StringUtil.toMoney(sale.getItem().getPrice() * sale.getItem().getAmount()) %></td>
				</tr>
			<% } %>
			</tbody>
		</table>
	<% } %>

</div>
</body>
</html>
