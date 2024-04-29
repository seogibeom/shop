<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	String empId = request.getParameter("empId");
	System.out.println(empId+"<<= empId empOne.jsp");
	
	ArrayList<HashMap<String, Object>> empInfo = EmpDAO.empOne(empId);
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
	.box {
  		text-align: center; /* 내용을 가운데 정렬합니다. */
       }
	.logout-link {
        margin-left: 40px; /* 로그아웃 링크 좌측 여백 설정 */
        }
	.header {
        display: flex; 
        align-items: center; /* 수직 */
        justify-content: center; /* 수평 */
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
      <div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded ">   
     
        <div class="text-center">
		<h1>직원 정보</h1>
		</div><br>
			<div class="box text-center">
				<table class="table">
					<tr>
						<th>아이디</th>
						<th>등급</th>
						<th>이름</th>
						<th>직위</th>
						<th>입사일</th>
						<th>수정일</th>
						<th>가입일</th>
					</tr>	
				<%
					for(HashMap<String, Object> m : empInfo) {
				%>	
						<tr>							
							<td><%=(String)(m.get("emp_id"))%></td>					
							<td><%=(String)(m.get("grade"))%></td>
							<td><%=(String)(m.get("emp_name"))%></td>
							<td><%=(String)(m.get("emp_job"))%></td>
							<td><%=(String)(m.get("hire_date"))%></td>
							<td><%=(String)(m.get("update_date"))%></td>
							<td><%=(String)(m.get("create_date"))%></td>
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