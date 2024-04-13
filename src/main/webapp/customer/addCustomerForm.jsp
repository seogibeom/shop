<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String checkId = request.getParameter("checkId");
	if(checkId == null) {
		checkId = "";
	}
	String ck = request.getParameter("ck");
	if(ck == null) {
		ck = "";
	}
	
	String msg = "";
	if(ck.equals("T")) {
		msg = "사용가능한 아이디 입니다";
	} else if(ck.equals("F")) {
		msg = "이미 아이디가 존재합니다";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>

	<form method="post" action="/shop/customer/checkIdAction.jsp">
		아이디 중복확인 : <input type="text" name="checkId" value="<%=checkId%>">
					<span><%=msg%></span> <button type="submit">중복확인</button>
	</form>
	
	<form method="post" action="/shop/customer/addCustomerAction.jsp">
	<%
		if(ck.equals("T")) {
	%>
		<div>아이디 : <input type="text" value="<%=checkId%>" name="id"  readonly="readonly"></div>
	 <%
		} else {
	 %>	
		<div>아이디 : <input type="text" value="" name="id" readonly="readonly"></div>
	 <%
		}
	 %>	
		<div>비밀번호 : 		<input type="password" name="pw"></div>
		<div>이름 : 			<input type="text" name="name"></div>
		<div>생일 : 			<input type="date" name="birth"></div>
		<div>성별 : 		
							<input type="radio" name="gender" value="m">남
							<input type="radio" name="gender" value="f">여
		</div>
		<div>email :	
							<input type="email" name="email">
				<!-- 		<select name="email2">
							<option disabled selected>이메일을 선택해주세요</option>
							<option value="naver">naver.com</option>
							<option value="daum">daum.net</option>
							<option value="gmail">gmail.com</option>
							<option value="non">직접입력</option>
						</select> 
				-->	
						
		</div>
		<div>			<button type="submit">입력</button></div>
	</form>
</body>
</html>