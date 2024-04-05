<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Controller Layer -->
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
	
	String category = request.getParameter("category");
	/*
		null이면 
		select * from goods
		null이 아니면
		select * from goods where category=?
	*/
%>

<!-- Model Layer -->
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "select category, count(*) cnt from goods group by category order by goods_price asc";
	
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	ArrayList<HashMap<String, Object>> categoryList =
			new ArrayList<HashMap<String, Object>>();
	
	while(rs1.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>(); //선언	  //해시맵은 원피스와천원을 묶은것 <맵은 한묶음>
		m.put("category", rs1.getString("category")); // 입력
		m.put("cnt", rs1.getInt("cnt"));//입력
		categoryList.add(m);// 이건 집어넣는거
	}
	// 디버깅
	System.out.println(categoryList+"<<==categoryList");
%>

<%
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	/*
	SELECT category, goods_title
	FROM goods
	WHERE category ='나루토';
	*/	
	int totalRow = 0;
	int rowPerPage = 12;
	int startRow = (currentPage-1) * rowPerPage;
	String sql2 = "select category, goods_title goodsTitle, filename, goods_price goodsPrice from goods where category = ? limit ?, ?";
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, category);
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	rs2 = stmt2.executeQuery();
	ArrayList<HashMap<String, Object>> goodsTitleList =
			new ArrayList<HashMap<String, Object>>();
	
	while(rs2.next()) {
		HashMap<String, Object> m2 = new HashMap<String, Object>();
		m2.put("category", rs2.getString("category"));
		m2.put("goodsTitle", rs2.getString("goodsTitle"));
		m2.put("goodsPrice", rs2.getInt("goodsPrice"));
		m2.put("filename", rs2.getString("filename"));
		goodsTitleList.add(m2);
	}
	// 디버깅
	System.out.println(goodsTitleList+"<<==goodsTitleList");
%>

<!-- ============= 페이징 ================ -->
<%

	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	String sql3 = "select count(*) cnt from goods";
	
	
	
	stmt3 = conn.prepareStatement(sql3);
	rs3 = stmt3.executeQuery();
	
	
	if(rs3.next()){
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
%>
<!-- ============= 페이징 ================ -->
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	.box {
		margin: margin-left 50px;
		text-align : center;

	}
</style>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div>
	
	</div>
	
	<!-- 서브메뉴 카테고리별 상품리스트 -->
	<div>
		<%
			for(HashMap m : categoryList) {
		%>
				<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>)
				</a>	
		<%		
			}
		%>
	</div>
	<!-- 굿즈 상품목록 -->
		

		<%
			for(HashMap m2 : goodsTitleList) {
		%>
		<div class="container">
			<div class="box">
				<div style="width:300px; height:250px; border:1px solid red; float:left;
						 margin-right:20px; margin-top:50px; ">
		<%
				if(category.equals("나루토")) {
		%>
					<div>
						<img alt="" src="/shop/upload/nrt.png" style="width: 300px; height: 200px;">
					</div>
		<%
				}
				if(category.equals("원피스")) {
		%>
					<div>
						<img alt="" src="/shop/upload/opc.png" style="width: 300px; height: 200px;">
					</div>
		<%
				}
				if(category.equals("블리치")) {
		%>
					<div>
						<img alt="" src="/shop/upload/blc.png" style="width: 300px; height: 200px;">
					</div>
		<%
				}
				if(category.equals("드래곤볼")) {
		%>
					<div>
						<img alt="" src="/shop/upload/drg.png" style="width: 300px; height: 200px;">
					</div>
		<%
				}
				if(category.equals("주술회전")) {
		%>
					<div>
						<img alt="" src="/shop/upload/jsh.png" style="width: 300px; height: 200px;">
					</div>
		<%
				}
		%>				
					<div ><%=(String)(m2.get("category"))%>/<%=(String)(m2.get("goodsTitle"))%></div>
					<div></div>
					<div><%=(int)(m2.get("goodsPrice"))%> 원</div>

				</div>
			</div>
		</div>
		<%		
			}
		%>	
<!-- ======================================= 페이징 ============================================== -->
<nav>
	<ul>
	<%
		if(currentPage > 1) {
	%>
		<div>
			<a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">
			◀◁◀</a>	
	<%
		}
		if(currentPage < lastPage) {
	%>
			<a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">
			▷▶▷</a>
		</div>
	<%
		}
	%>
	</ul>
</nav>	
</body>
</html>