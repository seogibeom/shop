<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	//0. 로그인 인증 분기 : 세션변수 이름 - loginEmp
	//  loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<%
	// controller
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	//모델 호출하는 코드
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empId, empPw);
	
	if(loginEmp==null) {
		//로그인 실패
		System.out.println("로그인실패");
		String errMsg = URLEncoder.encode("※아이디 또는 비밀번호를 확인해주세요※","utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기
		
	} else {
		//로그인 성공
		System.out.println("로그인성공");
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/shop/emp/empList.jsp");
		
	}		
%>