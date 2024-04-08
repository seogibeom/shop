<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "select category from category";
	
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList =
			new ArrayList<HashMap<String, Object>>();
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>(); //선언	  //해시맵은 원피스와천원을 묶은것 <맵은 한묶음>
		m.put("category", rs.getString("category")); // 입력
		categoryList.add(m);// 이건 집어넣는거
	}
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