<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	/*
Ex) SELECT * from goods
	WHERE goods_no = '500' ;
	
	String sql = "SELECT * from goods WHERE goods_no = ? ";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, goodsNo);
	rs = stmt.executeQuery();
	
	if(rs.next()){
		System.out.println("성공");
	} else {
		System.out.println("실패");
	}*/
	ArrayList<HashMap<String, Object>> goods = GoodsDAO.goodsOne(goodsNo);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<style>

</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<body>
	
<div class="container">
	<div class="box">
		<div style="width:300px; height:250px;
						 margin:auto; margin-top:20px; ">
<h1>상세보기</h1>	
	<%
			for(HashMap m :  goods) {
	%>			 
			<div><%=(String)(m.get("category"))%></div>
			<div><img src="/shop/upload/<%=(String)(m.get("filename"))%>"
						style="width:600px; height:400px;">
			</div>
				<div><%=(String)(m.get("goods_title"))%></div>
				<div><%=(String)(m.get("goods_content"))%></div>
				<div><%=(String)(m.get("goods_price"))%></div>
				<div><%=(String)(m.get("goods_amount"))%></div>
	<%
			}
	%>
					
			<div>
				<a href="./deleteGoods.jsp?goodsNo=<%=goodsNo%>">삭제</a> <!-- 삭제시키려면 링크에 굿즈넘버를 넣어야함 -->
			</div>
		</div>
	</div>
</div>
	
	
</body>
</html>