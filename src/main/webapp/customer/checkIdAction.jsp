<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "shop.dao.*" %>
<%

		String checkId = request.getParameter("checkId");


		String ck = CustomerDAO.ckId(checkId);
		if(ck==null) {
			
			// 아이디 사용 가능
			response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId="+checkId+"&ck=T");
		} else {
			// 아이디 사용 불가능 이미존재함
			response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkId="+checkId+"&ck=F");
		}
		
%>