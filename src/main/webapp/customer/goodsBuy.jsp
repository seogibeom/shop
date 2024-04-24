<%@page import="shop.dao.*"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String customerId = request.getParameter("customerId");
	System.out.println(customerId+ "<<==customerId");
	
	int goodsNo = (Integer.parseInt(request.getParameter("goodsNo")));
	System.out.println(goodsNo+"goodsNo");
	
	int goodsPrice = (Integer.parseInt(request.getParameter("goodsPrice")));
	System.out.println(goodsPrice+"goodsPrice");
	
	//orders에 입력하는 메서드 호출
	int row = OrdersDAO.insertOrders(customerId, goodsNo, goodsPrice);
	System.out.println(row+"row");
%>
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<%
		if(row==1){
	%>
		<h1>결제 완료</h1>
		<a href="/shop/customer/customerGoodsList.jsp">홈으로 돌아가기</a>
	<%
		} else {
	%>
		<h1>결제 실패</h1>
		<a href="/shop/customer/customerGoodsList.jsp">홈으로 돌아가기</a>
	<%
			}
	%>		

</body>
</html>