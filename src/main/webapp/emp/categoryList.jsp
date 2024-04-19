<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	ArrayList<HashMap<String, Object>> categoryList = CategoryDAO.category();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<h1>카테고리목록</h1>
	<%
		for(HashMap m : categoryList) {
	%>
		<div><%=(String)(m.get("category"))%></div>
	<%
		}
	%>
	<hr>
	<form method="post" action="/shop/emp/addCategory.jsp">
		<div>
			카테고리 추가 : <input type="text" name="addCategory"> <button type="submit">등록</button>
		</div>
	</form>	
</body>
</html>