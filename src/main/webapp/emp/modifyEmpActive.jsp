<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%
	String empId =request.getParameter("empId");
	String active =request.getParameter("active");
	System.out.println(empId+"<<==empId");
	System.out.println(active+"<<==active");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	PreparedStatement stmt2 = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	if(active.equals("OFF")){
		String sql = "UPDATE emp SET active  = 'ON' WHERE emp_id = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		System.out.println(stmt+"<<==stmt");
		int row = 0;
		row = stmt.executeUpdate();
			if(row==1 ) {
				System.out.println("변경");
				response.sendRedirect("/shop/emp/empList.jsp");
			}  else {
				System.out.println("변경실패");
				response.sendRedirect("/shop/emp/empList.jsp");
			}
	}
		if(active.equals("ON")){
				String sql2 = "UPDATE emp SET active  = 'OFF' WHERE emp_id = ?";
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setString(1, empId);
				System.out.println(stmt2+"<<==stmt2");
				int row2 = 0;
				row2 = stmt2.executeUpdate();
					if(row2==1 ) {
						System.out.println("변경");
						response.sendRedirect("/shop/emp/empList.jsp");
					}  else {
						System.out.println("변경실패");
						response.sendRedirect("/shop/emp/empList.jsp");
					}
		}	
	
%>