<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="shop.dao.*" %>
<%
	// 로그인 인증 분기 : 세션변수 이름 - loginCustomer
	//  loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>
<%

// 요청값 분석 => 로그인성공 => session에 loginCustomer변수를 생성
	
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	//메서드 호출
	HashMap<String, Object> loginCustomer = CustomerDAO.customerLogin(customerId, customerPw);
	
	
	if(loginCustomer==null) {	// 만약 값이없으면 로그인 실패
		
		String errMsg = URLEncoder.encode("※아이디 또는 비밀번호를 확인해주세요※","utf-8");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기
		System.out.println("로그인실패");
		
	} else {	//로그인 성공
		
		System.out.println("로그인성공");
							
		// 로그인성공시 DB값 설정 => session변수 설정
		session.setAttribute("loginCustomer", loginCustomer);
				
		// 디버깅
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
		System.out.println((String)(m.get("customerId")));		//로그인된 customerId
		System.out.println((String)(m.get("customerName")));	//로그인된 customerName
		//System.out.println((Integer)(m.get("grade")));	// 로그인된 grade
			
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}		
%>