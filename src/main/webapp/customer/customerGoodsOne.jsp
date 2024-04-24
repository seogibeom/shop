<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	//customerId 불러오는 메서드
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));

	String customerId = request.getParameter("customerId");
	System.out.println(customerId+ "<<==customerId");
	//굿즈넘버가 ?인 제품 출력하는 메서드
	ArrayList<HashMap<String, Object>> goods = GoodsDAO.goodsOne(goodsNo);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<style>
	body {
	  
	      background-image: url('/shop/img/mbc8.png');
   		  background-size: 1200px; 
	  /*  background-size: cover; 화면에 꽉 차도록 배경 이미지 크기 조정 */
           
	}
	.text-background1 {
  	 	 background-color: white;
  	 	 opacity:0.9;
   		 padding: 10px; /* 텍스트 주위에 여백을 추가하여 가독성 향상 */
    	 display: inline-block; /* 인라인 블록 요소로 설정하여 이미지와 크기를 맞춤 */
  		 width: 600px; /* 이미지의 너비와 동일하게 설정 */
  		 font-size: 30px;
  	 }
  	 .text-background2 {
  	 	 color : white;
  	 	 background-color: #0B7946;
  	 	 opacity:0.9;
   		 padding: 10px; /* 텍스트 주위에 여백을 추가하여 가독성 향상 */
    	 display: inline-block; /* 인라인 블록 요소로 설정하여 이미지와 크기를 맞춤 */
  		 width: 600px; /* 이미지의 너비와 동일하게 설정 */
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<body>
	
<div class="container" >
	<div class="box">
		<div style="width:400px; height:300px;
					margin:350px; margin-top:20px; ">
	<%
			for(HashMap m :  goods) {
	%>		
		
			<div class="text-background2"><h1><%=(String)(m.get("category"))%></h1></div>	 
			
			<div><img src="/shop/upload/<%=(String)(m.get("filename"))%>"
						style="width:600px; height:500px;">
			</div>
			<div class="text-background1"><%=(String)(m.get("goods_title"))%></div>
			<div class="text-background1"><%=(String)(m.get("goods_content"))%></div>
			<div class="text-background1">가격 : <%=(String)(m.get("goods_price"))%>원</div>
			<div class="text-background1">남은 수량 : <%=(String)(m.get("goods_amount"))%></div>
			<div>
				<button><a style=" text-decoration: none; color : black;" 
								href="/shop/customer/goodsBuy.jsp?goodsNo=<%=goodsNo%>
								&goodsPrice=<%=(String)(m.get("goods_price"))%>
								&customerId=<%=(String)(loginMember.get("customerId"))%>">구매</a>
				</button>
			</div>
		
	<%
			}
	%>		
			
		</div>
	</div>
</div>
	
	
</body>
</html>