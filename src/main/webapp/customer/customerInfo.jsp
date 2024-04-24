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
	System.out.println(customerId+ "<<==customerId");
%>
<%
	ArrayList<HashMap<String, Object>> list = CustomerDAO.customerInfo(customerId);
	System.out.println(list+"<<==list");
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
     
        <div class="text-center"> <!-- text-center 클래스 추가 -->
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
					for(HashMap<String, Object> m :list) {
				%>	
						<tr>			
							<th><%=(String)(m.get("customerName"))%></th>
							<th><%=(String)(m.get("birth"))%></th>
							<th><%=(String)(m.get("gender"))%></th>
							<th><%=(String)(m.get("email"))%></th>
						</tr>
				<%
					}
				%>	
				</table>
			</div>
	</div>
</div>
	<hr>
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >   
      <div class="loginImg"></div>
        <div class="text-center"> <!-- text-center 클래스 추가 -->
			<h1>주문/배송 내역</h1>
		</div><br>
			<div class="box text-center">
				<table class="table">
					<tr>
						<th><h3>배송중</h3></th>
					</tr>	
				</table>
			</div>
	</div>
</div>
		
</body>
</html>