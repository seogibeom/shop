<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	
	// 로그인성공시 세션에 loginMember라는 변수를 만들고 값으로 로그인아이디를 저장
	
	String loginEmp = (String)(session.getAttribute("loginEmp"));
	// session.getAttribute()는 찾는변수가없으면 null값을 반환한다
	// null이면 로그아웃상태이고, null이아니면 로그인상태
	System.out.println(loginEmp + "<<==loginEmp");
	
	//loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empLoginAction.jsp");
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
	a {
		 text-decoration: none;
		
	   
	}
	.background-image {
	     background-image: url("/shop/img/ds.png" );
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

<body class="background-image" style="opacity:0.97;">
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" > 
            <div class="text-center"> <!-- text-center 클래스 추가 -->
				<h1>관리자 로그인</h1>
			</div><br>
			<form method="post" action="./empLoginAction.jsp">

	  <div class="box text-center">
	                <table>    
	                     <tr>
							<th>ID</th>
							<th><input type="text" name="empId" value="admin"></th>
						 </tr>
						 <tr>
							<th>PW</th>
							<th><input type="password" name="empPw" value="1234"></th>
							<th><button type="submit">로그인</button></th>
						 </tr>	
	           		</table>	 
           		 </div> 
		</form>
	</div>
</div>
</body>
</html>