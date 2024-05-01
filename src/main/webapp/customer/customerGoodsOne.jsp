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
	// 굿즈넘버가 ?인 제품 출력하는 메서드
	ArrayList<HashMap<String, Object>> goods = GoodsDAO.goodsOne(goodsNo);
	// 카테고리 리스트 출력하는 메서드
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.categoryListCnt();
	// 후기 리스트 출력하는 메서드
	ArrayList<HashMap<String, Object>> list = ReviewDAO.reviewList(goodsNo);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>	
	@font-face {
		font-family: 'TTLaundryGothicB';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/2403-2@1.0/TTLaundryGothicB.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}
	body {
	   	font-family: 'TTLaundryGothicB';

           
		}
	.box {
    	display: flex;
   		justify-content: center; /* 수평 중앙 정렬 */
	    align-items: center; /* 수직 중앙 정렬 */
	    width: 100%; /* 또는 필요한 너비로 설정 */
	    height: 100vh; /* 또는 필요한 높이로 설정 */
	    background-image: url('/shop/img/mbc8.png');
	    background-size: cover; /* 배경 이미지를 요소에 맞게 늘림 (비율 유지) */
	    background-repeat: no-repeat; /* 배경 이미지 반복 제거 */
}
	.box2 {
    	display: flex;
   		justify-content: center; /* 수평 중앙 정렬 */
		width: 100%; /* 또는 필요한 너비로 설정 */
}
	.review{
		background-image: url('/shop/img/mbc8.png');
	    background-size: cover; /* 배경 이미지를 요소에 맞게 늘림 (비율 유지) */
	    background-repeat: no-repeat; /* 배경 이미지 반복 제거 */
	
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
  	 	background-color: black;
  	 	opacity:0.9;
   		padding: 10px; /* 텍스트 주위에 여백을 추가하여 가독성 향상 */
    	display: inline-block; /* 인라인 블록 요소로 설정하여 이미지와 크기를 맞춤 */
  		width: 600px; /* 이미지의 너비와 동일하게 설정 */
  		border-top-left-radius: 20px; /* 좌측 상단 모서리 둥글게 */
    	border-top-right-radius: 20px; /* 우측 상단 모서리 둥글게 */
  		 }
	.header {
		display: flex; 
		align-items: center; /* 수직 */
		justify-content: start; /* 수평 */
		height: 70px; 
		background-color: #0B7946;   
         }
	.header a {
		text-decoration: none;
		color : white;
		font-size: 20px;
		margin-right: 50px;
         }
	 a{
        text-decoration: none;
        color : black;
         
         }
	.category {
		float : left;     
		margin-left : 100px;
		margin-bottom : 30px;
        padding-bottom : 20px;
        margin-right: ; /* 적절한 오른쪽 여백 추가 */
           }
    .logout-link {
        margin-left: 40px; /* 로그아웃 링크 좌측 여백 설정 */
        }
    .container{
        text-align: center;
          }        
</style>
<body>	
<div class="header">
	
	<div class="logout-link">
		<a href="/shop/customer/customerLogout.jsp">로그아웃</a>
	</div>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
</div>
<div class="main">
      <div class="container">
         <div class="subList">
	  <br><span><h1>B R A N D</h1></span><br>
	  
		<%
			for(HashMap m : categoryList) {
		%>
		<div class="category">
			<h2><a href="/shop/customer/customerGoodsList.jsp?currentPage=1&category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%></a>
			</h2>
		</div>	
		<%		
			}
		%>
	</div>		
</div>
<form method="post" action="/shop/customer/goodsBuy.jsp">
	<div class="box">		
	<%
			for(HashMap m :  goods) {
	%>		
		<div>
			<div class="text-background2"><h1><%=(String)(m.get("category"))%></h1></div>	 
			
			<div><img src="/shop/upload/<%=(String)(m.get("filename"))%>"
						style="width:600px; height:500px;">
			</div>
			<div class="text-background1">
				<div>모델번호 : <%=goodsNo%></div>
				<div>클럽 종류 : <%=(String)(m.get("goods_title"))%></div>
				<div>모델 : <%=(String)(m.get("goods_content"))%></div>
				<div>가격 : <%=(String)(m.get("goods_price"))%>원</div>
				<div>남은 수량 : <%=(String)(m.get("goods_amount"))%></div>
			</div>
				
			<div>구매 수량 : <input type="number" name="buyGoodsAmount" style="width : 50px;"></div>				
			<div><input type="hidden" name="customerId" 
								value="<%=(String)(loginMember.get("customerId"))%>"></div>
			<div><input type="hidden" name="goodsNo" value="<%=goodsNo%>"></div>
			<div><input type="hidden" name="goodsPrice" value="<%=(String)(m.get("goods_price"))%>"></div>													
					
			<div><button type="submit">구매</button></div>
					
											
		</div>
	<%
			}
	%>		
			
		
	</div>
	<br><br>
<div class="row review">
      <div class="col-2"></div>
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >   
        <div class="text-center">
			<h1>구매 후기</h1>
		</div>
			<div class="box2 text-center">
				<table class="table">
					<tr>
						<th>아이디</th>
						<th>모델번호</th>
						<th>별점</th>
						<th>내용</th>
						<th>작성일</th>
					</tr>
					<%
						for(HashMap m : list){
					%>										
						<tr>
							<th><%=(String)(loginMember.get("customerId"))%></th>
							<th><%=(String)(m.get("goodsNo"))%></th>
							<th><%=(String)(m.get("scoreStar"))%></th>
							<th><%=(String)(m.get("content"))%></th>
							<th><%=(String)(m.get("createDate"))%></th>
						</tr>
					<%
						}
					%>	
				</table>
			</div>
	</div>
</div>
</form>	
</div>
	
	
</body>
</html>