<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String checkId = request.getParameter("checkId");
	if(checkId == null) {
		checkId = "";
	}
	String ck = request.getParameter("ck");
	if(ck == null) {
		ck = "";
	}
	
	String msg = "";
	if(ck.equals("T")) {
		msg = "사용가능한 아이디 입니다";
	} else if(ck.equals("F")) {
		msg = "이미 아이디가 존재합니다";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"></link>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<style>
	table {
	    margin-left:auto; 
	    margin-right:auto;
	}
	.background-image {
		background-image: url('/shop/img/mbc.png');
	    background-size: 500px; 
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
<body class="background-image" style="opacity:0.95;">
<div class="row">
	<div class="col-2"></div>
    <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >   
    <div class="loginImg"></div>
    	<div class="text-center"> <!-- text-center 클래스 추가 -->
			<h1>회원가입</h1>
	 	</div><br>
			
		<table>
<form method="post" action="/shop/customer/checkIdAction.jsp">	
			<tr>
					
				<th>아이디 : </th>
				<th><input type="text" name="checkId" value="<%=checkId%>"></th>					 
				<td><button type="submit"><b>중복확인</b></button> <span> <%=msg%></span></td>
			</tr>
</form>		
<form method="post" action="/shop/customer/addCustomerAction.jsp">
			 <%
				if(ck.equals("T")) {
		 	 %>
					<tr>
						<th><input type="hidden" value="<%=checkId%>" name="id"  readonly="readonly"></th>
					</tr>
			 <%
				} else {
			 %>
					 <tr>							 
					 	<th><input type="hidden" value="" name="id" readonly="readonly"></th>
					 </tr>	
			 <%
				}
			 %>	
					 <tr>
						 <th>비밀번호 : </th>
						 <th><input type="password" name="pw"></th>
					 </tr>
					  <tr>
						 <th>이름 : </th>
						 <th><input type="text" name="name"></div></th>
					 </tr>
					  <tr>
						 <th>생일 : </th>
						 <th><input type="date" name="birth"></div></th>
					 </tr>
					  <tr>
						 <th>성별 : </th>
						 <th><input type="radio" name="gender" value="m">남
							 <input type="radio" name="gender" value="f">여</th>
					 </tr>
					 <tr>
					 	<th>email :	</th>
					 	<th><input type="email" name="email"></th>
					 </tr>					
					 <tr>
					 	<td>
							<button class="btn btn-primary" type="submit">가입</button>
						</td>
					 </tr>
</form>
		</table>

	</div>
</div>
</body>
</html>