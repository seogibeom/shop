<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%

		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		//====================================================로그인인증================================================//
		//현재값이 OFF아니고 ON이다 ==> OFF변경후 loginForm으로 리다이렉트
		
		String checkId = request.getParameter("checkId");
				
		String sql2 = "select customer_id customerId from customer where customer_id = ?";
		// 결과가 있으면 이미 이날짜에 일기가있다 ==>> 이날짜로는 입력하면안된다
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, checkId);
		rs2 = stmt2.executeQuery();
		if(rs2.next()) {
			// 아이디 사용 불가능 이미존재함
			response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId="+checkId+"&ck=F");
		} else {
			// 아이디 사용 가능
			response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId="+checkId+"&ck=T");
		}
		
%>