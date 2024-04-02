<%@ page import="org.apache.catalina.connector.Response"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	
	// 로그인성공시 세션에 loginMember라는 변수를 만들고 값으로 로그인아이디를 저장
	
	String loginMember = (String)(session.getAttribute("loginMember"));
	// session.getAttribute()는 찾는변수가없으면 null값을 반환한다
	// null이면 로그아웃상태이고, null이아니면 로그인상태
	System.out.println(loginMember + "<<==loginMember");
	
	//loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect("/shop/emp/empLoginAction.jsp");
		return;
	}
	//1. 요청값 분석
		String errMsg = request.getParameter("errMsg");
%>
<%

	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<h1>로그인</h1>
<form method="post" action="./empLoginAction.jsp">
	<div>
		id : <input type="text" name="empId">
	</div>
	<div>
		pw : <input type="password" name="empPw" >
				<button type="submit">로그인</button>
	</div>
</form>
</body>
</html>