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
	int currentPage2 = 1;
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
<!-- ============= ================ -->
<% 	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "select goods_no goodsNo, category, count(*) cnt from goods group by category order by category asc";
	
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
<!-- =============  ================ -->

<!--  ==================== 1  ======================== -->
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
<!--  ==================== 1  ======================== -->

<!-- ============= 선택 페이징 ================ -->
<%

	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;

	String sql3 = "select count(*) cnt from goods where category = ?";

	
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1,category);
	rs3 = stmt3.executeQuery();
	
	if(rs3.next()){
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	System.out.println(lastPage+"<<==lastPage");
	
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
%>
<!-- ============= 선택 페이징 ================ -->
<%
	PreparedStatement stmt4 = null;
	ResultSet rs4 = null;
	String sql4 ="SELECT category, goods_no goodsNo, goods_title goodsTitle, filename, goods_price goodsPrice, create_date createDate FROM goods ORDER BY goods_no desc LIMIT ?,?;";
	stmt4 = conn.prepareStatement(sql4);	
	stmt4.setInt(1, startRow);
	stmt4.setInt(2, rowPerPage);
	rs4 = stmt4.executeQuery(); 
	
	System.out.println(stmt4+" = stmt4");
	
	ArrayList<HashMap<String, Object>> totalGoodsList = new ArrayList<HashMap<String, Object>>();
	while(rs4.next()) {
		HashMap<String, Object> m4 = new HashMap<String, Object>();
		m4.put("category", rs4.getString("category"));
		m4.put("goodsNo", rs4.getInt("goodsNo"));
		m4.put("goodsTitle", rs4.getString("goodsTitle"));
		m4.put("filename", rs4.getString("filename"));
		m4.put("goodsPrice", rs4.getInt("goodsPrice"));
		m4.put("createDate", rs4.getString("createDate"));
		totalGoodsList.add(m4);
		}
	
		System.out.println(totalGoodsList+"<<==totalGoodsList");	
%>
<%
		int totalRow2 = 0;
		int rowPerPage2 = 12;	
		int startRow2 = (currentPage-1) * rowPerPage2;	//시작가로줄 = 시작페이지 - 1 * 가로몇줄
				
		PreparedStatement stmt5 = null;
		ResultSet rs5 = null;
		
		String sql5 = "select count(*) cnt from goods";
		
		
		stmt5 = conn.prepareStatement(sql5);
		rs5 = stmt5.executeQuery();
		
		if(rs5.next()){
			totalRow2 = rs5.getInt("cnt");
		}
		int lastPage2 = totalRow2 / rowPerPage2;
		System.out.println(lastPage2+"<<==lastPage2");
		
		if(totalRow2 % rowPerPage2 != 0) {
			lastPage2 = lastPage2 + 1;
		}
%>
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
	a{
		text-decoration: none;
		color : black;
		}
	}
.header {
		height: 70px;
		background-color: #FF3636;
		display : flex;
		
		}
.header img{
height : 70px;
width: 150px;
}
.box {
 width: 1350px;
    margin: 0 auto;
    overflow: hidden;
    padding-top: 10px;
    background-color: white;
    display: flex; /* Flexbox 컨테이너 설정 */
    flex-wrap: wrap; /* 자식 요소가 공간을 넘으면 줄 바꿈 */
    gap: 20px; /* 자식 요소 간의 간격 설정 */
    justify-content: flex-start; /* 자식 요소를 왼쪽에서부터 시작하여 가로로 정렬 */
}
 .goodsimage1 {
flex : flex-start;
margin-left : 100px;
margin-bottom : 30px;
padding-bottom : 20px;
margin-right: ; /* 적절한 오른쪽 여백 추가 */
width: 300px; /* 적절한 너비 설정 */
text-align : center;
background-color: white;
}
</style>
<body>
<div class="header">
	<img src="./img/marioUnder.png">
	<div><a href="/shop/customer/customerLogout.jsp">로그아웃</a></div>
</div>
<div class="main">

	<!-- 서브메뉴 카테고리별 상품리스트 -->
	<div class="goodsList">
<!-- 전체상품리스트 -->	
		<a href="/shop/customer/customerGoodsList.jsp?totalRow=<%=totalRow%>">전체</a>
<!-- 선택상품리스트 -->
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
<div class="box">
		<div class="goodsimage1 " style ="border: 1px;">
		<%		
				if(category == null) {
					for(HashMap m4 : totalGoodsList) {
		%>
					<div>
						<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m4.get("goodsNo"))%>">
							<img src="/shop/upload/<%=(String)(m4.get("filename"))%>"
									style="width:300px; height:200px;"></a>
					</div>		
					<div >
						<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m4.get("goodsNo"))%>">
							<%=(String)(m4.get("category"))%>/<%=(String)(m4.get("goodsTitle"))%></a>
					</div>				
					<div>
						<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m4.get("goodsNo"))%>">
							<%=(int)(m4.get("goodsPrice"))%> 원
						</a>
					</div>
		<%			
				}
		%>	
		</div>

		<div  class="goodsimage1" style ="border: 1px;">		
		<%
			}else {
				for(HashMap m2 : goodsTitleList) {
		%>
					<div>
						<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
							<img src="/shop/upload/<%=(String)(m2.get("filename"))%>"
									style="width:300px; height:200px;"></a>
					</div>		
					<div >
						<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
							<%=(String)(m2.get("category"))%>/<%=(String)(m2.get("goodsTitle"))%>
						</a>
					</div>
					<div>
						<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
							<%=(int)(m2.get("goodsPrice"))%> 원</a>
					</div>
		
		<%		}
			}
		%>	
		</div>
</div>
<!-- ======================================= 페이징 ============================================== -->
	
	<%
	if(category == null) {			//전체 페이지를 위한 button
		if(currentPage >1) {	
	%>
<div class="container overflow: auto;">
	<div class="box">
			<div class="fixed-bottom">
				<button><a href="./customerGoodsList.jsp?currentPage=1&totalRow2=<%=totalRow2%>">
				첫 페이지</a></button>
				<button><a href="./customerGoodsList.jsp?currentPage=<%=currentPage-1%>&totalRow2=<%=totalRow2%>">
				◀◁◀</a></button>
		<%
			}
			if(currentPage<lastPage2 || currentPage ==1 ) {
		%>
				<button><a href="./customerGoodsList.jsp?currentPage=<%=currentPage+1%>&totalRow2=<%=totalRow2%>">
				▷▶▷</a></button>
				<button><a href="./customerGoodsList.jsp?currentPage=<%=lastPage2%>&totalRow2=<%=totalRow2%>">
				마지막 페이지</a></button>	
			</div>
				
				
	</div>			
</div>	
	<%
		}
	}
	else { 		//선택 페이지를 위한 button
		if(currentPage >1) {	
	%>
	<div class="box">
		<div class="fixed-bottom">
			<button><a href="./customerGoodsList.jsp?currentPage=1&category=<%=category%>">
			첫 페이지</a></button>
			<button><a href="./customerGoodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">
			◀◁◀</a></button>	
	<%
		}
		if(currentPage < lastPage) {
	%>
			<button>	<a href="./customerGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">
			▷▶▷</a></button>
			<button><a href="./customerGoodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">
			마지막 페이지</a></button>
		</div>	
	</div>
	<%
		}
			}
	%>
</body>
</html>