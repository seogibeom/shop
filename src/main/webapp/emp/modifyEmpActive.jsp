<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="shop.dao.*" %>
<%
	String empId =request.getParameter("empId");
	String active =request.getParameter("active");
	System.out.println(empId+"<<==empId");
	System.out.println(active+"<<==active");
		
	if(active.equals("ON")){		//active가 ON 일 경우 OFF으로 전환
		int OffRow = EmpDAO.updateEmpOFF(empId);	//모델 호출하는 코드
			if(OffRow==1 ) {	
				// OffRow 변경시 성공
				response.sendRedirect("/shop/emp/empList.jsp");	
			}  else {
				response.sendRedirect("/shop/emp/empList.jsp");
			}
		}
	
	if(active.equals("OFF")){		//active가 OFF 일 경우 ON으로 전환
		int OnRow = EmpDAO.updateEmpON(empId); 		//모델 호출하는 코드
			if(OnRow==1 ) {
				// OnRow 변경시 성공
				response.sendRedirect("/shop/emp/empList.jsp");
			}  else {
				response.sendRedirect("/shop/emp/empList.jsp");
			}
		}	
	
%>