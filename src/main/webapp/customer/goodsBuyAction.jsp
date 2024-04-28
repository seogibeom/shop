<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.*"%>
<% 

	String customerId = request.getParameter("customerId");
	System.out.println(customerId+ "<<==goodsBuyAction.jsp customerId");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo+"<<=goodsBuyAction.jsp goodsNo");
	
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	System.out.println(goodsPrice+"<<==goodsBuyAction.jsp goodsPrice");
	
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	System.out.println(goodsAmount+"<<==goodsBuyAction.jsp goodsAmount");
	
	int row = OrdersDAO.insertOrders(customerId, goodsNo, goodsPrice, goodsAmount);
	
	if(row==0) {
		System.out.println("goodsBuyAction  실패");
		response.sendRedirect("/shop/customer/goodsBuy.jsp");
	} else {
		System.out.println("goodsBuyAction  성공");
		response.sendRedirect("/shop/customer/customerInfo.jsp?customerId="+customerId);
	}
%>	