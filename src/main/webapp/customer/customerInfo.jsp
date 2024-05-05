<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="shop.dao.*"%>

<%
	// 인증분기	 : 세션변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
	String customerId = request.getParameter("customerId");
	System.out.println(customerId+ "<<== customerId info.jsp");
%>
<%	// customerId 받아와서 개인정보 출력하는 메서드
	ArrayList<HashMap<String, Object>> infoList = CustomerDAO.customerInfo(customerId);
	System.out.println(infoList+"<<== infoList info.jsp");
	
	// customerId 받아와서 주문정보 출력하는 메서드
	ArrayList<HashMap<String, Object>> ordersList = OrdersDAO.selectOrdersListByCustomer(customerId);
	System.out.println(ordersList+"<<== ordersList info.jsp");
	
	// my후기 출력하는 메서드
	ArrayList<HashMap<String, Object>> reviewList = ReviewDAO.myReview(customerId);
	System.out.println(reviewList+"<<== reviewList info.jsp");
	
		
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"></link>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<title></title>
</head>
<style>
	.box {
  		text-align: center; /* 내용을 가운데 정렬합니다. */
       }
	.logout-link {
        margin-left: 40px; /* 로그아웃 링크 좌측 여백 설정 */
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
	.background-image {
		background-image: url('/shop/img/mbc6.png');
   		background-size: 650px; 
  		background-position: center; /* 이미지를 가운데 정렬 */
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
		tr:nth-child(odd) th {
        background-color: #0B7946; /* 짝수 행 배경색 */
        color: white;
    }
	a{
        text-decoration: none;
        color : black;        
    }  
</style>

<body class= "background-image">
<div class="header">
	<div class="logout-link">
		<a href="/shop/customer/customerLogout.jsp">로그아웃</a>
	</div>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
</div>
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded ">   
     
        <div class="text-center">
		<h1>개인 정보</h1>
		</div><br>
			<div class="box text-center">
				<table class="table">
					<tr>
						<th>이름</th>
						<th>생일</th>
						<th>성별</th>
						<th>이메일</th>
					</tr>	
				<%
					for(HashMap<String, Object> m :infoList) {
				%>	
						<tr>
									
							<td><%=(String)(m.get("customerName"))%></td>
							<td><%=(String)(m.get("birth"))%></td>
							<td><%=(String)(m.get("gender"))%></td>
							<td><%=(String)(m.get("email"))%></td>
							
						</tr>
				<%
					}
				%>	
				</table>
			</div>
	</div>
</div>
	<br>
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >   
        <div class="text-center">
			<h1>주문/배송 내역</h1>	<!--  최신 10개까지만 출력되게 설정했음 -->
		</div><br>
			<div class="box text-center">
				<table class="table">
					<tr>
						<th>모델번호</th>
						<th>클럽종류</th>
						<th>모델</th>						
						<th>주문수량</th>
						<th>주문/배송 상태</th>
						<th>후기</th>
					</tr>						
					
					<%
						for(HashMap<String, Object> m :ordersList) {							
					%>
						<tr>
							<td><%=(String)(m.get("goodsNo"))%></td>				
							<td><%=(String)(m.get("goodsTitle"))%></td>
							<td><%=(String)(m.get("goodsContent"))%></td>
							<td><%=(String)(m.get("ordersAmount"))%></td>
							<td><%=(String)(m.get("state"))%></td>
						<%
							if(m.get("state").equals("배송완료")) {
						%>	
								<td><a href="/shop/customer/addReviewForm.jsp?ordersNo=<%=(String)(m.get("ordersNo"))%>">후기 작성 🖊️</a></td>
						<%
							} else {
						%>
								<td>-</td>
						<%
							}
						%>	
																					
						</tr>
					<%
						}
					%>	
							
					

				</table>
			</div>
	</div>
</div>
<br>
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded ">   
     
        <div class="text-center">
		<h1>my 후기</h1>
		</div><br>
			<div class="box text-center">
				<table class="table">
					<tr>
						<th>주문번호</th>
						<th>모델번호</th>
						<th>별점</th>
						<th>내용</th>
						<th>작성일</th>
					</tr>	
				<%
					for(HashMap m : reviewList) {
				%>	
						<tr>
							<td><%=(String)(m.get("ordersNo"))%></td>
							<td><%=(String)(m.get("goodsNo"))%></td>
							<td><%=(String)(m.get("scoreStar"))%></td>
							<td><%=(String)(m.get("content"))%></td>
							<td><%=(String)(m.get("createDate"))%></td>
						</tr>
				<%
					}
				%>	
				</table>
			</div>
	</div>
</div>
	<br>		
</body>
</html>