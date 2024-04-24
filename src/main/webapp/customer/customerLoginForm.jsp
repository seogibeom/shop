<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginCustomer
	
	// 로그인성공시 세션에 loginCustomer라는 변수를 만들고 값으로 로그인아이디를 저장
	
	String loginCustomer = (String)(session.getAttribute("loginCustomer"));
	// session.getAttribute()는 찾는변수가없으면 null값을 반환한다
	// null이면 로그아웃상태이고, null이아니면 로그인상태
	System.out.println(loginCustomer + "<<==loginCustomer");
	
	//loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerLoginAction.jsp");
		return;
	}
	//1. 요청값 분석
		String errMsg = request.getParameter("errMsg");
%>
<%

	

%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"></link>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
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
     background-image: url("/shop/img/ds.png" );
     background-size: 1000px;
     background-position: center; /* 이미지를 가운데 정렬 */
}  
</style>
<body class="background-image" style="opacity:0.97;">
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" > 
            <div class="text-center"> <!-- text-center 클래스 추가 -->
				<h1>로그인</h1>
			</div><br>
               <form method="post" action="./customerLoginAction.jsp">
                  <div class="box text-center">
	                <table>    
	                     <tr>
							<th>ID</th>
							<th><input type="text" name="customerId"></th>
						 </tr>
						 <tr>
							<th>PW</th>
							<th><input type="password" name="customerPw"></th>
							<th><button type="submit">로그인</button></th>
						 </tr>	
			             <tr>
			              	<th><br><a href="./addCustomerForm.jsp">회원가입</a></th>
	           			 </tr>
	           		</table>	 
           		 </div> 
               </form>
        <!-- col-8마지막 -->
      <div class="col-2"></div>
	</div>
</div>

</body>
</html>