<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8"); //한글안깨지게
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; 
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));//삭제시킬 굿즈넘버를 받아옴
	System.out.println(goodsNo+"<<==goodsNo"); //디버깅
	
	/*
ex)	DELETE FROM goods
	WHERE goods_no = '509';
	*/
	String sql = "DELETE FROM goods WHERE goods_no = ? "; // 삭제쿼리 sql에 대입
	
	PreparedStatement stmt = null; //프리페어는 쿼리를 실행시키는 역할 그걸 stmt에 대입
	stmt = conn.prepareStatement(sql); // 실행되는거
	stmt.setInt(1, goodsNo);
	int row = stmt.executeUpdate();
	if(row == 0){
		System.out.println("삭제실패"); 
	} else {
		System.out.println("삭제성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
		return;
	}
	
%>