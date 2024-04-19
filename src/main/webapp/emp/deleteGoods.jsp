<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="shop.dao.GoodsDAO"%>
<%
	request.setCharacterEncoding("utf-8"); //한글안깨지게
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));//삭제시킬 굿즈넘버를 받아옴
	System.out.println(goodsNo+"<<==goodsNo"); //디버깅
	
	/*
ex)	DELETE FROM goods
	WHERE goods_no = '509';
	*/
	int row = GoodsDAO.deleteGoods(goodsNo);
	if(row == 0){
		System.out.println("삭제실패"); 
	} else {
		System.out.println("삭제성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
		return;
	}
	
%>