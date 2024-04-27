<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>
<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- Session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서... -->
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
%>

<!-- Model Layer -->
<%
	String category = request.getParameter("category");
	System.out.println(category +"<<==category");
	
	String goodsTitle = request.getParameter("goodsTitle");
	System.out.println(goodsTitle +"<<==goodsTitle");
	
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	System.out.println(goodsPrice +"<<==goodsPrice");
	
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	System.out.println(goodsAmount +"<<==goodsAmount");
	
	String goodsContent = request.getParameter("goodsContent");
	System.out.println(goodsContent +"<<==goodsContent");
	
	Part part = request.getPart("goodsImg");
	String originalName = part.getSubmittedFileName();
	// 원본이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx); // .png
	
	UUID uuid = UUID.randomUUID(); // UUID는 중복될수없는이름
	String filename = uuid.toString().replace("-","");
	filename = filename + ext;
	
	System.out.println(filename +"<<==filename");
	
	/*
	INSERT INTO goods(
	category, emp_id, goods_title, goods_price, goods_amount, goods_content, update_date, create_date
	) VALUES(
	'주술회전', 'admin', '고죠사토루 피규어', '50000', '50', '귀하다 귀해!!', NOW(),NOW());
	*/
	int row = GoodsDAO.insertGoods(category,  goodsTitle,  filename, 
			 goodsPrice,  goodsAmount,  goodsContent);
	
	if(row == 1) { // insert 성공하면 파일업로드
		//part => 1) is => 2) os => 3)빈파일 
		// 1)
		InputStream is = part.getInputStream();
		// 3) + 2)
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename); //빈파일
		OutputStream os = Files.newOutputStream(f.toPath()); // os + file
		is.transferTo(os);
		
		os.close();
		is.close();
	}
	/*	파일삭제API
		File df = new File(filePath, rs.getString("filename"));
		df.delete()
	*/
%>

<!-- Controller Layer -->
<%
	if(row == 1) {
		System.out.println("성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else {
		System.out.println("실패");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	}
	// response.sendRedirect("/shop/emp/goodsList.jsp");
%>