<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import="java.util.*" %>
<%
	//0. 로그인 인증 분기 : 세션변수 이름 - loginEmp
	//  loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<%

//1. 요청값 분석 => 로그인성공 => session에 loginMember변수를 생성
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "select emp_id empId, emp_name empName, grade from emp where active='ON' and emp_id =? and emp_pw = password(?) ";
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	rs = stmt.executeQuery();
	
	if(rs.next()) {
		//로그인 성공
		System.out.println("로그인성공");
		// 하나의 세션변수안에 여러개의 값을 저장하기위해  HashMap타입을 사용
		HashMap<String, Object> loginEmp = new HashMap<String, Object> ();
		loginEmp.put("empId", rs.getString("empId"));
		loginEmp.put("empName", rs.getString("empName"));
		loginEmp.put("grade", rs.getInt("grade"));
	
		// 로그인성공시 DB값 설정 => session변수 설정
		session.setAttribute("loginEmp", loginEmp);
		
		// 디버깅
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
		System.out.println((String)(m.get("empId")));		//로그인된 empId
		System.out.println((String)(m.get("empName")));	//로그인된 empName
		System.out.println((Integer)(m.get("grade")));	// 로그인된 grade
		
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	} else {
		//로그인 실패
		String errMsg = URLEncoder.encode("※아이디 또는 비밀번호를 확인해주세요※","utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기
		System.out.println("로그인실패");
	}		
%>