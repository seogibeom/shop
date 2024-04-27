<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="shop.dao.*" %>
<%
	String empId =request.getParameter("empId");
	String active =request.getParameter("active");
	System.out.println(empId+"<<==empId");
	System.out.println(active+"<<==active");
		
	int row = EmpDAO.updateEmpOnOff(empId, active);	//모델 호출하는 코드
		if(row==1 ) {	// 변경시 성공
			response.sendRedirect("/shop/emp/empList.jsp");	
		} else {
			response.sendRedirect("/shop/emp/empList.jsp");
			}
			
%>