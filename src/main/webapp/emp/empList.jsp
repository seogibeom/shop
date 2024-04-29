<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	// request 분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
%>
<!-- Model Layer -->
<%	
	// JDBC API 종속된 자료구조 모델 ResultSet ==>> 기본 API 자료구조(ArrayList)로 변경
	int rowPerPage = 10;
	int startRow = (currentPage-1) * rowPerPage;
	//메서드 호출값 list에 저장
	ArrayList<HashMap<String, Object>> list = EmpDAO.empList(startRow, rowPerPage);
	
	//메서드호출값 empCnt에 저장
	int empCnt = EmpDAO.empCnt();	//totalRow값 empList cnt
	System.out.println(empCnt + "<<==enpCnt");
	
	int lastPage = empCnt / rowPerPage;
	System.out.println(lastPage+"<<==lastPage");
	
	if(empCnt % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + "<<==lastPage");
		

	
	
%>
<!-- View Layer -->
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
	 a{
        text-decoration: none;
        color : black;
         }
     .onOff{
     	text-decoration: none;
        color : #0B7946;
     }
   
     tr:nth-child(odd) th {
        background-color: #0B7946; /* 짝수 행 배경색 */
        color: white;
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
     button{
        margin-top: 15px;
        border: none;
        padding : 5px;
        margin-rigth : 6px;
        display : plex;
        text-align: center;        
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
	<!--  empMenu.jsp include : 주체(서버) vs redirect(주체 : 클라이언트) -->
	<!-- 주체가 서버이기때문에 include 할때는 절대주소가  /shop/.. 부터 시작하지않는다 -->
<div class="header">
	<a href="/shop/emp/empLogout.jsp">로그아웃</a>
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
</div>

<form method="post" action="/shop/emp/modifyEmpActive.jsp">
<div class="row">
      <div class="col-2"></div>
      <div class="mt-5  bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" > 
        <div class="text-center">
			<h1>사원목록</h1>
		</div><br>
		<table border ="1">
				<tr>
					<th>사원아이디</th>
					<th>사원이름</th>
					<th>직급</th>
					<th>입사일</th>
					<th>active</th>
				</tr>
		<%
				for(HashMap<String, Object> m : list) {
		%> 
					<tr>											
						<td>
							<a href="/shop/emp/empOne.jsp?empId=<%=(String)m.get("empId")%>">
															<%=(String)m.get("empId")%></a>
						</td>
						<td><%=(String)m.get("empName")%></td>
						<td><%=(String)m.get("empJob")%></td>
						<td><%=(String)m.get("hireDate")%></td>
						<td>
		<%
						HashMap<String, Object> sm = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
									
						if((Integer)(sm.get("grade")) > 0) {
							
		%>
								<a class="onOff" href='modifyEmpActive.jsp?active=<%=(String)m.get("active")%>&empId=<%=(String)m.get("empId")%>'>
										<%=(String)m.get("active")%></a>
		<%
									}
						
		%>
						</td>
					</tr>
		<%		
				}
		%>
		</table>
		<div class="centered">
			<%
				if(currentPage > 1) {
			%>
			
				<button><a href="./empList.jsp?currentPage=1">
					첫 페이지</a></button>		
				<button><a href="./empList.jsp?currentPage=<%=currentPage-1%>">
					이전</a></button>					
			<%	
				}	if(currentPage < lastPage) {
			%>
				<button><a href="./empList.jsp?currentPage=<%=currentPage+1%>">
					다음</a></button>
				<button><a href="./empList.jsp?currentPage=<%=lastPage%>">
				 	마지막 페이지</a></button>
			
		<%
				}
		%>
		</div>
		<div class="col-2"></div>
	</div>
</div>
</form>
</body>
</html>