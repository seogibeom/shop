<%@page import="shop.dao.*"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String customerId = request.getParameter("customerId");
	System.out.println(customerId+ "<<==customerId");
	
	int goodsNo = (Integer.parseInt(request.getParameter("goodsNo")));
	System.out.println(goodsNo+"goodsNo");
	
	int goodsPrice = (Integer.parseInt(request.getParameter("goodsPrice")));
	System.out.println(goodsPrice+"goodsPrice");
	
	//orders에 입력하는 메서드 호출
	int row = OrdersDAO.insertOrders(customerId, goodsNo, goodsPrice);
	System.out.println(row+"row");
%>
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<style>
table {
	    margin-left:auto; 
	    margin-right:auto;
	    
	    
	}
	a {
		 text-decoration: none;
		
	   
	}
	.background-image {
	     
	     background-size: 1000px;
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

<body class="background-image">
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" > 

	 	 <div class="box text-center">
	                
	                <table>
	            <%
					if(row==1){
				%>  
	                     <tr>
							<th><h1>결제 완료</h1></th>
						 </tr>
						 <tr>
							<th><a href="/shop/customer/customerGoodsList.jsp"><h2>홈으로 돌아가기</h2></a></th>
						 </tr>
				<%
					} else {
				%>	
						 <tr>
							<th><h1>결제 실패</h1></th>
						 </tr>
						 <tr>
							<th><a href="/shop/customer/customerGoodsList.jsp"><h2>홈으로 돌아가기</h2></a></th>
						 </tr>
				<%
						}
				%>
			
	           		</table>	 
           	 </div> 
		
	</div>
</div>
</body>

</html>