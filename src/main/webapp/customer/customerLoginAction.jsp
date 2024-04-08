<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import="java.util.*" %>
<%
	//0. 로그인 인증 분기 : 세션변수 이름 - loginCustomer
	//  loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>
<%

//1. 요청값 분석 => 로그인성공 => session에 loginCustomer변수를 생성
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "select customer_id customerId, customer_name customerName from customer where customer_id = ? and customer_pw = ?";
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerId);
	stmt.setString(2, customerPw);
	rs = stmt.executeQuery();
	
	if(rs.next()) {
		//로그인 성공
		System.out.println("로그인성공");
		// 하나의 세션변수안에 여러개의 값을 저장하기위해  HashMap타입을 사용
		HashMap<String, Object> loginCustomer = new HashMap<String, Object> ();
		loginCustomer.put("customerId", rs.getString("customerId"));
		loginCustomer.put("customerName", rs.getString("customerName"));
		//loginEmp.put("grade", rs.getInt("grade"));
	
		// 로그인성공시 DB값 설정 => session변수 설정
		session.setAttribute("loginCustomer", loginCustomer);
		
		// 디버깅
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
		System.out.println((String)(m.get("customerId")));		//로그인된 customerId
		System.out.println((String)(m.get("customerName")));	//로그인된 customerName
		//System.out.println((Integer)(m.get("grade")));	// 로그인된 grade
		
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	} else {
		//로그인 실패
		String errMsg = URLEncoder.encode("※아이디 또는 비밀번호를 확인해주세요※","utf-8");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기
		System.out.println("로그인실패");
	}		
%>