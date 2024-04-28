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
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
%>
<%	

	
	int rowPerPage = 10;
	int startRow = (currentPage-1) * rowPerPage;
	
	ArrayList<HashMap<String, Object>> list= OrdersDAO.selectOrdersListAll(startRow, rowPerPage);
	
	
	int ordersCnt = OrdersDAO.ordersCnt();	//totalRow값 ordersList cnt
	System.out.println(ordersCnt + "<<==ordersCnt");
	
	int lastPage = ordersCnt / rowPerPage;
	System.out.println(lastPage+"<<==lastPage");
	
	if(ordersCnt % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + "<<==lastPage");
	
	
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
	 a{
        text-decoration: none;
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
	.b {
		text-decoration: none;
        color : black;		
	}
</style>

<body>
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
			<h1>주문목록</h1>
		</div><br>

			<table border="1">
				<tr>
					<th>주문 번호</th>
					<th>상품 번호</th>
					<th>고객 아이디</th>
					<th>브랜드</th>
					<th>판매 사원</th>
					<th>클럽 종류</th>
					<th>클럽 모델</th>
					<th>가격</th>
					<th>남은 수량</th>
					<th>주문/배송 상태</th>
				</tr>
				<%
				 	
					for(HashMap<String, Object> m : list) {
						
				%>
				<tr >
					<td><%=m.get("ordersNo")%></td>
					<td><%=m.get("goodsNo")%></td>
					<td><%=m.get("customerId")%></td>
					<td><%=m.get("category")%></td>
					<td><%=m.get("empId")%></td>
					<td><%=m.get("goodsTitle")%></td>
					<td><%=m.get("goodsContent")%></td>
					<td><%=m.get("goodsPrice")%></td>
					<td><%=m.get("goodsAmount")%></td>					
					<td>
				<%
							if(m.get("state").equals("배송완료")) {		//배송완료 상태일 시 a태그 비활성화
				%>	
								배송완료
				<%
							}else {		//배송완료를 제외한 상태일 시 a태그 활성화
				%>									
								<a href="/shop/emp/ordersState.jsp?ordersNo=<%=m.get("ordersNo")%>
											&state=<%=m.get("state")%>"><%=m.get("state")%></a>
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
			
				<button><a class="b" href="/shop/emp/ordersList.jsp?currentPage=1">
					첫 페이지</a></button>		
				<button><a class="b" href="/shop/emp/ordersList.jsp?currentPage=<%=currentPage-1%>">
					이전</a></button>					
			<%	
				}	if(currentPage < lastPage) {
			%>
				<button><a class="b" href="/shop/emp/ordersList.jsp?currentPage=<%=currentPage+1%>">
					다음</a></button>
				<button><a class="b" href="/shop/emp/ordersList.jsp?currentPage=<%=lastPage%>">
				 	마지막 페이지</a></button>			
		<%
				}
		%>
		</div>
			   <div class="col-2"></div>
	</div>
</div>
</body>
</html>