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
	String id = request.getParameter("id");
	System.out.println(id+"<<=id");
	
	String pw = request.getParameter("pw");
	System.out.println(pw+"<<=pw");
	
	String name = request.getParameter("name");
	System.out.println(name+"<<=name");
	
	String birth = request.getParameter("birth");
	System.out.println(birth+"<<=birth");
	
	String gender = request.getParameter("gender");
	System.out.println(gender+"<<=gender");
	
	String email = request.getParameter("email");
	System.out.println(email+"<<=email");
						
	int row = 0;
	row = CustomerDAO.addCustomer(id, pw, name, birth, gender, email);
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