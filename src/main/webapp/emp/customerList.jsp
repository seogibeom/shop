<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%

	int currentPage = 1;

	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
%>
<!-- Model Layer -->
<%	
	// JDBC API 종속된 자료구조 모델 ResultSet ==>> 기본 API 자료구조(ArrayList)로 변경
	int rowPerPage =10;
	int startRow = (currentPage-1) * rowPerPage;
	//메서드 호출값 list에 저장
	ArrayList<HashMap<String, Object>> list = CustomerDAO.customerList(startRow, rowPerPage);
	
	//메서드호출값 customerCnt에 저장
	int customerCnt = CustomerDAO.customerCnt();	//totalRow값 customerList cnt
	System.out.println(customerCnt + "<<==customerCnt");
	
	int lastPage = customerCnt / rowPerPage;
	System.out.println(lastPage+"<<==lastPage");
	
	if(customerCnt % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + "<<==lastPage");
%>
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<!--  empMenu.jsp include : 주체(서버) vs redirect(주체 : 클라이언트) -->
	<!-- 주체가 서버이기때문에 include 할때는 절대주소가  /shop/.. 부터 시작하지않는다 -->
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

<form method="post" action="/shop/emp/modifyEmpActive.jsp">
<h1>고객목록</h1>
	<table border ="1">
				<tr>
					<th>customerId</th>
					<th>customerName</th>
					<th>birth</th>
					<th>gender</th>
					<th>email</th>
				</tr>
		<%
				for(HashMap<String, Object> m : list) {
		%> 
				<tr>
					<td><%=(String)m.get("customerId")%></td>
					<td><%=(String)m.get("customerName")%></td>
					<td><%=(String)m.get("birth")%></td>
					<td><%=(String)m.get("gender")%></td>
					<td><%=(String)m.get("email")%></td>
				</tr>
		<%		
				}
		%>
	</table>
	
		<%
				if(currentPage > 1) {
		%>
			<div>
				<a href="./customerList.jsp?currentPage=1">
					첫 페이지</a>		
				<a href="./customerList.jsp?currentPage=<%=currentPage-1%>">
					이전</a>					
		<%	
				}	if(currentPage < lastPage) {
		%>
				<a href="./customerList.jsp?currentPage=<%=currentPage+1%>">
					다음</a>
				<a href="./customerList.jsp?currentPage=<%=lastPage%>">
				 	마지막 페이지</a>
			</div>
		<%
				}
		%>
</form>
</body>
</html>