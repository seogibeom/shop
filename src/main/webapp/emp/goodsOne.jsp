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
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.categoryListCnt();
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
		justify-content: center; /* 수평 */
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
		<a href="/shop/emp/empLogout.jsp">로그아웃</a>
	</div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>
<div class="main">
      <div class="container">
         <div class="subList">
	 	 <br><span><h1>B R A N D</h1></span><br>
	  
		<%
			for(HashMap m : categoryList) {
		%>
		<div class="category">
			<h2><a href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%></a>
			</h2>
		</div>	
		<%		
			}
		%>
		</div>		
	</div>
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
			<div><%=(String)(m.get("goods_title"))%></div>
			<div><%=(String)(m.get("goods_content"))%></div>
			<div>가격 : <%=(String)(m.get("goods_price"))%>원</div>
			<div>남은 수량 : <%=(String)(m.get("goods_amount"))%></div>
		</div>	
			<div>
				<button><a href="./deleteGoods.jsp?goodsNo=<%=goodsNo%>">삭제</a></button> <!-- 삭제시키려면 링크에 굿즈넘버를 넣어야함 -->
			</div>
		</div>
	<%
		}
	%>
						
	</div>
</div>
	
	
</body>
</html>