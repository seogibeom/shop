<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginCustomer
	
	// 로그인성공시 세션에 loginCustomer라는 변수를 만들고 값으로 로그인아이디를 저장
	
	String loginCustomer = (String)(session.getAttribute("loginCustomer"));
	// session.getAttribute()는 찾는변수가없으면 null값을 반환한다
	// null이면 로그아웃상태이고, null이아니면 로그인상태
	System.out.println(loginCustomer + "<<==loginCustomer");
	
	//loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerLoginAction.jsp");
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
<form method="post" action="./customerLoginAction.jsp">
	<div>
		id : <input type="text" name="customerId">
	</div>
	<div>
		pw : <input type="password" name="customerPw">
				<button type="submit">로그인</button>
	</div>
</form>
	<div>
		<a href="./addCustomerForm.jsp">회원가입</a>
	</div>
</body>
</html>