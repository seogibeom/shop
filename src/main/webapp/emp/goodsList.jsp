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
/*
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	
	SELECT category, goods_title
	FROM goods
	WHERE category ='나루토';
	
	int totalRow = 0;
	int rowPerPage = 12;	
	int startRow = (currentPage-1) * rowPerPage;	//시작가로줄 = 시작페이지 - 1 * 가로몇줄
	
	String sql ="select goods_no goodsNo, category, count(*) cnt from goods group by category order by category asc";
	String sql2 = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_price goodsPrice from goods where category = ? limit ?, ?";
	String sql3 = "select count(*) cnt from goods where category = ?";
	
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
*/

	 	int totalRow = 0;
		int rowPerPage = 9;	
		int startRow = (currentPage-1) * rowPerPage;
		//모델 호출하는 코드	// 카테고리별페이징
		ArrayList<HashMap<String, Object>> categoryPage = GoodsDAO.categoryPage(category, startRow, rowPerPage);
%>
<!--  ==================== 카테고리별 페이징  ======================== -->

<!-- ====================  카테고리별 cnt ====================  -->
<%

/*	PreparedStatement stmt3 = null;
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
*/				
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
            *{
            margin: 0px; padding :0px;
            }
            .header {
             display: flex; 
             align-items: center; /* 수직으로 가운데 */
             justify-content: center; /* 수평으로 가운데 */
             height: 70px; 
             background-color: green;
             
         }
            .header a {
             text-decoration: none;
             color : white;
             font-size: 20px;
           margin-right: 50px;
         }

         .header img {
             margin-right: 50px; /* 이미지 오른쪽 여백을 설정하여 링크와 간격을 설정했음. */
             width: 145px; height: 70px;
             display: block; margin-right: auto; margin-left: 0;
         }
         .box {
            width: 1350px;
            margin : 0 auto;
            overflow : hidden;
            padding-top: 10px;
            background-color: white;
         
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
         .allAtag{
            border: 2px solid #005766;
            background-color : #489FAE;
            color : white;
            text-align : center;
            padding: 2px;
            margin-right: 10px;
         }
         .headList {

         font-size: 30px;
         text-shadow: -2px 0 #000, 0 2px #000, 2px 0 #000, 0 -2px #000;
         color : #FFE400;
         }
         .headList2 {
   
         font-size: 30px;
         text-shadow: -2px 0 #000, 0 2px #000, 2px 0 #000, 0 -2px #000;
         color : red;
         }
         
         button{
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
 
      </style>
<body>
	<!-- 메인메뉴 -->
<div class="header">
	<div>
		<a href="/shop/emp/empLogout.jsp">로그아웃</a>
	</div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>
   <div class="main">
      <div class="container">
         <div class="subList">
           <br><span><h1>B R A N D</h1></span><br>
	<!-- 카테고리별 굿즈리스트 -->
			
	<%
			for(HashMap m : categoryList) {
	%>
	<h2>
			<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage%>&category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%></a>
	</h2>
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
		  <div class="goodsimage1" style ="border: 1px;">
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
		if(currentPage >1) {		//선택 페이지를 위한 button
	%>

			<button><a href="./goodsList.jsp?currentPage=1&category=<%=category%>">
			첫 페이지</a></button>
			<button><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">
			이전</a></button>	
	<%
		}
		if(currentPage < lastPage) {
	%>
			<button>	<a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">
			다음</a></button>
			<button>	<a href="./goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">
			마지막 페이지</a></button>
	<%
		}
	%>
	</div>
<br><br>
</div><!-- main -->	

</body>
</html>