<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	ArrayList<HashMap<String, Object>> categoryList = CategoryDAO.category();
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
	    justify-content: center; /* 수평으로 가운데 */
	    height: 70px; 
	    background-color: #0B7946;
	}
	.header a {
	    text-decoration: none;
	    color : white;
	    font-size: 20px;
	    margin-right: 50px;
	}

        /* 짝수 번째 행 */
    tr:nth-child(even) td {
        background-color: #f2f2f2; /* 짝수 행 배경색 */
    }

    /* 홀수 번째 행 */
    tr:nth-child(odd) td {
        background-color: #ffffff; /* 홀수 행 배경색 */
    }
 
    table {
        border-collapse: collapse; /* 테이블 셀 경계를 합칩니다. */
    }
    table td, table th {
        border: 1px solid black; /* 셀에 테두리를 만듭니다. */
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
    .centered2 {
        display: flex; /* 플렉스 컨테이너로 설정 */
        justify-content: center; /* 수평 중앙 정렬 */
        }
    .centered3 {
        display: flex; /* 플렉스 컨테이너로 설정 */
        justify-content: center; /* 수평 중앙 정렬 */
        align-items: center; /* 수직 중앙 정렬 */
        height: 20px; /* 예시를 위해 높이 설정 */
        vertical-align: middle;
        }
     button{
       
        border: none;
        padding : 5px;
        margin-left : 6px;
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
<body>
<div class="header">
	<a href="/shop/emp/empLogout.jsp">로그아웃</a>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
</div>
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5  bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" > 
        <div class="text-center">
			<h1>카테고리목록</h1>
		</div><br>
		<%
			for(HashMap m : categoryList) {
		%>
				<div class="centered2"><h3><%=(String)(m.get("category"))%></h3></div>
		<%
			}
		%>
	<hr>
		<form method="post" action="/shop/emp/addCategory.jsp">
			<div class="centered3">
				카테고리 추가 : <input type="text" name="addCategory"><button type="submit">등록</button>
			</div>
		</form>
		</div>	
</div>		
</body>
</html>