<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*"%>


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
<!-- ============= 리스트값 설정 ================ -->
<% 	

	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.categoryListCnt();
%>
<!-- ============= 리스트값 설정 ================ -->

<!--  ==================== row값 설정  ======================== -->
<%
	int totalRow = 0;
	int rowPerPage = 9;	
	int startRow = (currentPage-1) * rowPerPage;	//시작가로줄 = 시작페이지 - 1 * 가로몇줄
	
	ArrayList<HashMap<String, Object>> categoryPage = GoodsDAO.categoryPage(category, startRow, rowPerPage);
%>
<!--  ==================== row값 설정  ======================== -->

<!-- =============  페이징 ================ -->
<%
	 totalRow = GoodsDAO.categoryCnt(category);
	int lastPage = totalRow / rowPerPage;		
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
%>
<!-- =============  페이징 ================ -->
<!-- =============  아이디 ================ -->
<% 
	String customerId = request.getParameter("customerId");
	System.out.println(customerId+ "<<==customerId");
	ArrayList<HashMap<String, Object>> list = CustomerDAO.customerInfo(customerId);
%>	
	
<!-- =============  아이디 ================ -->

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
         
         button{
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
	<!-- 굿즈 상품목록 -->
<div class="box">		
	<%
		for(HashMap m2 : categoryPage) {
	%>
		<div class="goodsimage1" style ="border: 1px;border-radius: 30px;">
				<div>
					<a href="/shop/customer/customerGoodsOne.jsp?
							goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">								
						<img src="/shop/upload/<%=(String)(m2.get("filename"))%>"></a>									
				</div>				
				<div >
					<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
						[ <%=(String)(m2.get("category"))%> ]  <%=(String)(m2.get("goodsTitle"))%>
					</a>
				</div>
				<div>
					<a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
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
	
			<button><a href="./customerGoodsList.jsp?currentPage=1&category=<%=category%>">
			첫 페이지</a></button>
			<button><a href="./customerGoodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">
			이전</a></button>	
	<%
		}
		if(currentPage < lastPage) {
	%>
			<button>	<a href="./customerGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">
			다음</a></button>
			<button><a href="./customerGoodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">
			마지막 페이지</a></button>
	<%
		}
	%>
	</div>
	<br><br>
</div>
</body>
</html>