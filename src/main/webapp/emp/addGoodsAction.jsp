<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- Session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서... -->
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
%>

<!-- Model Layer -->
<%
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsContent = request.getParameter("goodsContent");
	
	System.out.println(category +"<<==category");
	System.out.println(goodsTitle +"<<==goodsTitle");
	System.out.println(goodsPrice +"<<==goodsPrice");
	System.out.println(goodsAmount +"<<==goodsAmount");
	System.out.println(goodsContent +"<<==goodsContent");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	/*
	INSERT INTO goods(
	category, emp_id, goods_title, goods_price, goods_amount, goods_content, update_date, create_date
) VALUES(
	'주술회전', 'admin', '고죠사토루 피규어', '50000', '50', '귀하다 귀해!!', NOW(),NOW());
	*/
	String sql1 = "insert into goods (category, emp_id, goods_title , goods_price , goods_amount , goods_content , update_date, create_date) VALUES(?, 'admin', ?, ?, ?, ?, NOW(),NOW())";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, category);
	stmt1.setString(2, goodsTitle);
	stmt1.setInt(3, goodsPrice);
	stmt1.setInt(4, goodsAmount);
	stmt1.setString(5, goodsContent);
	int row = 0;
	row = stmt1.executeUpdate();
%>

<!-- Controller Layer -->
<%
	if(row==1) {
		System.out.println("성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else {
		System.out.println("실패");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	}
	// response.sendRedirect("/shop/emp/goodsList.jsp");
%>