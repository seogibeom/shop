<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
	
%>
<div>
	<span>
		<a href="/shop/customer/customerInfo.jsp?customerId=<%=(String)(loginMember.get("customerId"))%>">
		<%=(String)(loginMember.get("customerName"))%> 님🪪</a>
	</span>
	<span>
		<a href="/shop/customer/customerGoodsList.jsp">🏠H O M E🏠</a>
	</span>
</div>