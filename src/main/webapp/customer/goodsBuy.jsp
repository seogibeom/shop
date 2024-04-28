<%@page import="shop.dao.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String customerId = request.getParameter("customerId");
	System.out.println(customerId+ "<<==goodsBuy.jsp customerId");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println(goodsNo+"<<=goodsBuy.jsp goodsNo");
	
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	System.out.println(goodsPrice+"<<==goodsBuy.jsp goodsPrice");
	
	int buyGoodsAmount = Integer.parseInt(request.getParameter("buyGoodsAmount"));
	System.out.println(buyGoodsAmount+"<<==goodsBuy.jsp buyGoodsAmount");
	
	int totalPrice = buyGoodsAmount * goodsPrice;
	
	ArrayList<HashMap<String, Object>> list = CustomerDAO.customerInfo(customerId);
%>
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
	
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
	a {
		text-decoration: none;
  
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


</style>

<body class= "background-image">
<div class="header">
	<div class="logout-link">
		<a href="/shop/customer/customerLogout.jsp">로그아웃</a>
	</div>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include>
</div>
<form method="post" action="/shop/customer/goodsBuyAction.jsp">
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded ">        
	        <div class="text-center">
			<h1>주문서</h1>
			</div><br>		
			<div>
				<table class="table">	               
					 <tr>
						<th>구매자 아이디</th>
						<td><%=customerId%></td>
					 	<input type="hidden" value="<%=customerId%>" name="customerId">
					 </tr>
				<%
				for(HashMap m :  list) {
				%>
					 <tr>
						<th>구매자 이름</th>
						<td><%=(String)(m.get("customerName"))%></td>
					 </tr>
					 <tr>
						<th>구매자 이메일</th>
						<td><%=(String)(m.get("email"))%></td>
					 </tr>
				<%
				}
				%>
					 <tr>
						<th>모델 번호</th>
						<td><%=goodsNo%></td>
						<input type="hidden" value="<%=goodsNo%>" name="goodsNo">
					 </tr>
					 <tr>
						<th>제품 가격</th>
						<td><%=goodsPrice%></td>
						<input type="hidden" value="<%=goodsPrice%>" name="goodsPrice">
					 </tr>
					 <tr>
						<th>구매 수량</th>
						<td><%=buyGoodsAmount%></td>
						<input type="hidden" value="<%=buyGoodsAmount%>" name="goodsAmount">
					 </tr>
					 <tr>
						<th>합산 금액</th>
						<td><%=totalPrice%></td>
					 </tr>				 
	           	</table>
			</div>
	</div>
<br>
	<div class="row">
	<div class="col-2"></div>
		<div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >   			  
			<div class="text-center">
				<h1>결제 방법</h1>	
			</div>
			<br>
			<div class="box text-center">
				<table class="table">
					<tr>
						<th>카드결제 <input type="radio" value="카드 결제" name="charge">				
								<select>
									<option selected="selected">선택</option>
									<option>신한은행</option>
									<option>국민은행</option>
									<option>우리은행</option>
									<option>기업은행</option>
								</select>
						</th>
						<th>&nbsp;</th>
						<th>카카오페이 <input type="radio" value="카카오페이" name="charge"></th>
					</tr>

					<tr>	
						<th>네이버페이 <input type="radio" value="네이버페이" name="charge"></th>
						<th>&nbsp;</th>										
						<th>페이코 <input type="radio" value="페이코" name="charge"></th>
					</tr>
				</table>
			<div class="text-center">
				<button type="submit">결제</button>
			</div>
			</div>
        </div>		
	</div>
</div>
</form>
</body>

</html>