<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(ordersNo+"<<=ordersState.jsp");
	String state = request.getParameter("state");
	System.out.println(state+"<<=ordersState.jsp");
	
	int row = OrdersDAO.updateOdersState(ordersNo, state);
	System.out.println(row+"<<=ordersState.jsp");
	
	if(row==1){
		response.sendRedirect("/shop/emp/ordersList.jsp");
	} else {
		response.sendRedirect("/shop/emp/ordersList.jsp");
	}
%>