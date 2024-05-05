<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>
<!-- Controller Layer -->

<!-- Session 설정값 : 입력시 로그인 customer의 custemer_id값이 필요해서... -->
<%	
	HashMap<String,Object> loginCustomer 
		= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
%>

<!-- Model Layer -->
<%
	// 디버깅
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(ordersNo+"<<=ordersNo addReviewAction.jsp");
	
		
	String scoreStar = request.getParameter("scoreStar");
	System.out.println(scoreStar+"<<=scoreStar addReviewAction.jsp");
	
	String content = request.getParameter("content");
	System.out.println(content+"<<=content addReviewAction.jsp");
	
						
	int row = 0;
	row = ReviewDAO.addReviewAction(ordersNo, content, scoreStar);
%>

<!-- Controller Layer -->
<%
	if(row == 1) {
		System.out.println("성공");
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
	} else {
		System.out.println("실패");
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
	}
	
%>