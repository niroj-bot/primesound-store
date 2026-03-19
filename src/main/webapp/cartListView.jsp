<%@page import="aiwa.entity.User"%>
<%@page import="aiwa.util.StringUtil"%>
<%@page import="aiwa.entity.Item"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>カート - PrimeSound Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
	ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");
	User user = (User) session.getAttribute("user");
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
		<span class="text-white"><a href="ProfileController" class="text-white text-decoration-none"><i class="bi bi-person-circle"></i> <%= user.getUserName() %>さん</a></span>
		<a href="CartListController" class="btn btn-outline-warning btn-sm">
			<i class="bi bi-cart3"></i> カート
			<% if (cartCount > 0) { %><span class="badge bg-warning text-dark"><%= cartCount %></span><% } %>
		</a>
		<a href="SaleListController" class="btn btn-outline-light btn-sm"><i class="bi bi-clock-history"></i> 購入履歴</a>
		<a href="LogoutController" class="btn btn-outline-danger btn-sm"><i class="bi bi-box-arrow-right"></i> ログアウト</a>
	</div>
</nav>

<div class="container mt-4">

	<h4 class="mb-3"><i class="bi bi-cart3"></i> ショッピングカート</h4>

	<% if (cart == null || cart.size() == 0) { %>
		<div class="alert alert-warning">カートに商品がありません</div>
		<a href="ItemListController" class="btn btn-primary">買い物を始める</a>
	<% } else { %>
		<table class="table table-bordered table-striped">
			<thead class="table-dark">
				<tr>
					<th>画像</th>
					<th>商品名</th>
					<th>価格</th>
					<th>数量</th>
					<th>小計</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<% int total = 0; %>
			<% for (Item item : cart) { %>
				<tr>
					<td><img src="<%= item.getImage() %>" height="70px"></td>
					<td><%= item.getItemName() %></td>
					<td><%= StringUtil.toMoney(item.getPrice()) %></td>
					<td><%= item.getAmount() %></td>
					<td><%= StringUtil.toMoney(item.getPrice() * item.getAmount()) %></td>
					<td>
						<a href="CartDeleteController?itemid=<%= item.getItemId() %>" class="btn btn-danger btn-sm"><i class="bi bi-dash-circle"></i></a>
						<a href="CartAddController?itemid=<%= item.getItemId() %>" class="btn btn-primary btn-sm"><i class="bi bi-plus-circle"></i></a>
					</td>
				</tr>
			<% total += item.getPrice() * item.getAmount(); %>
			<% } %>
			</tbody>
		</table>

		<div class="text-end mb-3">
			<strong>合計：<%= StringUtil.toMoney(total) %></strong>
		</div>
		<div class="d-flex justify-content-between">
			<a href="ItemListController" class="btn btn-secondary"><i class="bi bi-bag"></i> 買い物を続ける</a>
			<a href="SaleInsertController" class="btn btn-primary"><i class="bi bi-credit-card"></i> 購入する</a>
		</div>
	<% } %>

</div>
</body>
</html>
