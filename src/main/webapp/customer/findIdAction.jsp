<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import ="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "shop.dao.*" %>
<%@ page import ="java.net.URLEncoder"%>
<%
	String customerName = request.getParameter("customerName");
	String email = request.getParameter("email");
	
	String id = CustomerDAO.findId(customerName, email);
	System.out.println(id+"<<=action.jsp");
	
	if(id==null){
		String errMsg = URLEncoder.encode("※이름 또는 이메일를 확인해주세요※","utf-8");
		response.sendRedirect("/shop/customer/findIdForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기
	} else {
		response.sendRedirect("/shop/customer/findIdForm.jsp?id="+id);
	}
%>