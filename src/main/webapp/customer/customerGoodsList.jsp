<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Controller Layer -->
<%
	// 인증분기	 : 세션변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
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
	int startRow = (currentPage-1) * rowPerPage;	//시작가로줄 = 시작페이지 - 1 * 가로몇줄
	String sql2 = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_price goodsPrice from goods where category = ? limit ?, ?";
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
		m2.put("goodsNo", rs2.getInt("goodsNo"));
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
	PreparedStatement stmt4 = null;
	ResultSet rs4 = null;
	String sql3 = "select count(*) cnt from goods where category = ?";
	
	
	
	
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1,category);
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
	
	</div>
	
	<!-- 서브메뉴 카테고리별 상품리스트 -->
	<div>
		<%
			for(HashMap m : categoryList) {
		%>
				<a href="/shop/customer/customerGoodsList.jsp?currentPage=<%=currentPage%>&category=<%=(String)(m.get("category"))%>">
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
					
				<div style="width:300px; height:250px; float:left;
						 margin-right:20px; margin-top:20px; ">
					<div>
						<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
							<img src="/shop/upload/<%=(String)(m2.get("filename"))%>"
									style="width:300px; height:200px;">
						</a>
					</div>		
					<div >
						<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
							<%=(String)(m2.get("category"))%>/<%=(String)(m2.get("goodsTitle"))%>
						</a>
					</div>
					
					<div></div>
					<div>
						<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
							<%=(int)(m2.get("goodsPrice"))%> 원
						</a>
					</div>

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
			<a href="./customerGoodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">
			◀◁◀</a>	
	<%
		}
		if(currentPage < lastPage) {
	%>
			<a href="./customerGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">
			▷▶▷</a>
		</div>
	<%
		}
	%>
	</ul>
</nav>	
</body>
</html>