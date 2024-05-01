<%@page import="shop.dao.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import = "java.net.*" %>
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
<!-- ====================  카테고리별 cnt ====================  -->
<% 	
	//모델 호출하는 코드	//카테고리별 cnt
		ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.categoryListCnt();

%>
<!-- ====================  카테고리별 cnt ====================  -->
	
<!--  ==================== 카테고리별 페이징  ======================== -->
<%

	 	int totalRow = 0;
		int rowPerPage = 9;	
		int startRow = (currentPage-1) * rowPerPage;
		//검색기능
		String searchWord = "";	
		if(request.getParameter("searchWord") != null) {
			searchWord = request.getParameter("searchWord");
		}
		//모델 호출하는 코드	// 카테고리별페이징
		ArrayList<HashMap<String, Object>> categoryPage = GoodsDAO.categoryPage(searchWord,category, startRow, rowPerPage);
%>
<!--  ==================== 카테고리별 페이징  ======================== -->

<!-- ====================  카테고리별 cnt ====================  -->
<%
			
		 totalRow = GoodsDAO.categoryCnt(category);
		int lastPage = totalRow / rowPerPage;		
		if(totalRow % rowPerPage != 0) {
			lastPage = lastPage + 1;
		}
%>
<!-- ====================  카테고리별 cnt ====================  -->

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

	.box {
		width: 1350px;
		margin : 0 auto;
 		overflow : hidden;
		padding-top: 10px;	     
		background-image: url("/shop/img/mbc2.png" );
         }
 	.box .goodsimage1 {
		float : left;
		margin-left : 100px;
		margin-bottom : 30px;
		padding-bottom : 20px;
		margin-right: ; /* 적절한 오른쪽 여백 추가 */
		width: 300px; /* 적절한 너비 설정 */
		text-align : center;
		background-color: white;
		opacity:0.96;    /* 투명도 */     
         }
	.box .goodsimage1 img{
		width : 250px;
        height : 200px;
         }
	.container{
        text-align: center;
          }
	.btn{
        display : flex;
        justify-content: center;
         }
     a{
        text-decoration: none;
        color : black;
         
         }
         
    .pageButton{
        margin-top: 15px;
        border: none;
        padding : 5px;
        margin-rigth : 6px;
        display : plex;
        text-align: center;
         }
	.centered {
		display: flex; /* 플렉스 컨테이너로 설정 */
		justify-content: center; /* 수평 중앙 정렬 */
		align-items: center; /* 수직 중앙 정렬 */
		height: 20px; /* 예시를 위해 높이 설정 */
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
	@font-face {
	    font-family: 'TTLaundryGothicB';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/2403-2@1.0/TTLaundryGothicB.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}
	body {
	 	font-family: 'TTLaundryGothicB';
	}
	.search {
		width:200px;
		border-radius: 10px;
	}
 
      </style>
<body>
	<!-- 메인메뉴 -->
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
			<h2><a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%></a>
			</h2>
		</div>
	<%		
			}
	%>
		</div>
</div>
<div class="box">
	<!-- 굿즈 상품목록 -->
	<%
			for(HashMap m2 : categoryPage) {
	%>
		  <div class="goodsimage1" style ="border: 1px; border-radius: 30px;">
					<div>
						<a href="/shop/emp/goodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
							<img src="/shop/upload/<%=(String)(m2.get("filename"))%>"></a>
					</div>		
					<div >
						<a href="/shop/emp/goodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
							<%=(String)(m2.get("category"))%>/<%=(String)(m2.get("goodsTitle"))%>
						</a>
					</div>
					<div>
						<a href="/shop/emp/goodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
							<%=(int)(m2.get("goodsPrice"))%> 원
						</a>
					</div>
			</div>
	<%		
			}
	%>	
</div>
<!-- ======================================= 페이징 ============================================== -->


	<div class="centered">
	<%
		if(currentPage >1) {		
	%>

			<button class="pageButton"><a href="./goodsList.jsp?currentPage=1&category=<%=category%>">
			첫 페이지</a></button>
			<button class="pageButton"><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">
			이전</a></button>	
	<%
		}
		if(currentPage < lastPage) {
	%>
			<button class="pageButton">	<a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">
			다음</a></button>
			<button class="pageButton">	<a href="./goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">
			마지막 페이지</a></button>
	<%
		}
	%>
	</div>
<br><br>
	<div class="centered">
		<form method="get" action="/shop/emp/goodsList.jsp">
			<div style="font-size: 20px;">
				<b>클럽종류 : </b>
				<input class="search" type="text" name="searchWord">
				<button style= "border-radius: 10px;" type="submit">검색</button>
			</div>
		</form>
	</div>
	<br><br>
</div><!-- main -->	

</body>
</html>