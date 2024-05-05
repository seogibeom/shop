<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*"%>

<!-- Controller Layer -->
<%
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
	HashMap<String,Object> loginMember 
	= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));

%>

<!-- Model Layer -->
<%
	// 카테고리 선택시 불러올 카테고리 메서드
	ArrayList<HashMap<String, Object>> categoryList = CategoryDAO.category();
	
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(ordersNo+"<<= ordersNo addReviewForm.jsp");
	
	// goods_content 불러오는 메서드
	ArrayList<HashMap<String, Object>> goods = ReviewDAO.addReviewGoods(ordersNo);
	System.out.println(goods+"<<=goods addReviewForm.jsp");
	
	// 후기 중복방지하는 메서드
	ArrayList<HashMap<String, Object>> review = ReviewDAO.ckReview(ordersNo);
	System.out.println(review+"<<=review addReviewForm.jsp");
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"></link>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	table {
	    margin-left:auto; 
	    margin-right:auto;
	    
	}
	.header {
	    display: flex; 
	    align-items: center; /* 수직으로 가운데 */
	    justify-content: start; /* 수평으로 가운데 */
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
   
 
    table {
        border-collapse: collapse; /* 테이블 셀 경계를 합칩니다. */
    }
    table td, table th {
        padding: 10px; /* 텍스트와 셀 경계 사이의 간격을 조절합니다. */
        white-space: nowrap; /* 텍스트가 한 줄로 표시되도록 설정합니다. */
        padding: 10px; /* 텍스트와 셀 경계 사이의 간격을 조절합니다. */
 	}
 	.centered {
        display: flex; /* 플렉스 컨테이너로 설정 */
        justify-content: center; /* 수평 중앙 정렬 */
        align-items: center; /* 수직 중앙 정렬 */
        height: 20px; /* 예시를 위해 높이 설정 */
        }
     button{
        margin-top: 15px;
        border: none;
        padding : 5px;
        margin-rigth : 6px;
        display : plex;
        text-align: center;
        background-color: #0B7946;
        border-radius: 12px;
        color: white;
        
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

<div class="row">
      <div class="col-2"></div>
      <div class="mt-5  bg-black border shadow p-3 mb-5 bg-body-tertiary rounded " > 
	  <%
	  	for(HashMap m : review) {
	  		if((String)m.get("ordersNo")!=null) {
	  %>  
	  			<div class="text-center">
				<h1>후기를 이미 작성하셨습니다</h1>
				</div><br>
	  
	  <%
	  		}
	  	}
	  %>   
	     
	        <div class="text-center">
				<h1>후기 작성</h1>
			</div><br>
			<form method="post"  action="/shop/customer/addReviewAction.jsp">
			<table>
				<tr>
					<td><input type="hidden" name="customerId" value="<%=(String)(loginMember.get("customerId"))%>"></td>					
				</tr>
				<tr>
					<th>주문번호 :</th>
					<td><input type="text" name="ordersNo" value="<%=ordersNo%>"></td>					
				</tr>

				<%
					for(HashMap m : goods) {
				%>
				<tr>
					<th>모델 :</th>
					<td><input type="text" name="goodsContent" value="<%=(String)(m.get("goodsContent"))%>"></td>					
				</tr>
				<tr>
					<th>모델번호 :</th>
					<td><input type="text" name="goodsNo" value="<%=(String)(m.get("goodsNo"))%>"></td>					
				</tr>
				<%
					}
				%>
				<tr>
					<th>별점 :</th>
					<td>	
						<select name="scoreStar">
							<option value="">선택</option>
							<option value="★">★</option>
							<option value="★★">★★</option>
							<option value="★★★">★★★</option>
							<option value="★★★★">★★★★</option>
							<option value="★★★★★">★★★★★</option>						
						</select>
					</td>
				</tr>	
				<tr>
					<th>내용 :</th>
					<td><textarea rows="5" cols="50" name="content"></textarea></td>	
					<td><button type="submit">작성</button></td>
				</tr>
			</table>	
			</form>		
	</div>
</div>
	
</body>
</html>