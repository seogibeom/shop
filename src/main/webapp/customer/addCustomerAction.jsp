<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<!-- Controller Layer -->

<!-- Session 설정값 : 입력시 로그인 customer의 custemer_id값이 필요해서... -->
<%
	HashMap<String,Object> loginCustomer 
		= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
%>

<!-- Model Layer -->
<%
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	System.out.println(id+"<<=id");
	System.out.println(pw+"<<=pw");
	System.out.println(name+"<<=name");
	System.out.println(birth+"<<=birth");
	System.out.println(gender+"<<=gender");
	System.out.println(email+"<<=email");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	/*
	INSERT INTO member (member_id, member_pw, member_name, birth, gender, email, update_date, create_date)
	VALUES('admin', '1234','김첨지', '1996-12-25', 'M', 'kim1225@naver.com', NOW(), NOW());
	*/
	String sql1 = "INSERT INTO customer (customer_id, customer_pw, customer_name, birth, gender, email, update_date, create_date) VALUES(?, ?, ?, ?, ?, ?, NOW(), NOW())";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, id);
	stmt1.setString(2, pw);
	stmt1.setString(3, name);
	stmt1.setString(4, birth);
	stmt1.setString(5, gender);
	stmt1.setString(6, email);
	int row = 0;
	row = stmt1.executeUpdate();
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