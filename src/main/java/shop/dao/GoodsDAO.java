package shop.dao;
import java.util.*;
import java.sql.*;

public class GoodsDAO {
	public static ArrayList<HashMap<String, Object>> categoryListCnt() throws Exception {
		
		ArrayList<HashMap<String, Object>> list = 
				new ArrayList<HashMap<String, Object>>();
		//DB 접근
		Connection conn = DBHelper.getConnection();
		
		// 카테고리 별 굿즈개수 // 카테고리 분기
		String sql ="select goods_no goodsNo, category, count(*) cnt from goods group by category order by category asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>(); //선언	
			m.put("category", rs.getString("category")); // 입력
			m.put("cnt", rs.getInt("cnt"));//입력
			list.add(m);// m을 list에 넣는거
			
		}
		conn.close();
		return list; // 돌려줄 값
	}
	public static ArrayList<HashMap<String, Object>> categoryPage(String category, int startRow, int rowPerPage) throws Exception {
		
		ArrayList<HashMap<String, Object>> goodsTitleList = new ArrayList<HashMap<String, Object>>();
	
		//DB 접근
		Connection conn = DBHelper.getConnection();
		int currentPage = 1;
		rowPerPage = 12;	
		startRow = (currentPage-1) * rowPerPage;
		// 리스트 화면에 보여지는 굿즈개수 // 페이징
		String sql2 = "select goods_no goodsNo, category, goods_title goodsTitle, filename, goods_price goodsPrice from goods where category = ? limit ?, ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, category);
		stmt2.setInt(2, startRow);
		stmt2.setInt(3, rowPerPage);
		ResultSet rs2 = stmt2.executeQuery();
		
		while(rs2.next()) {
			HashMap<String, Object> m2 = new HashMap<String, Object>();
			m2.put("category", rs2.getString("category"));
			m2.put("goodsNo", rs2.getInt("goodsNo"));
			m2.put("goodsTitle", rs2.getString("goodsTitle"));
			m2.put("goodsPrice", rs2.getInt("goodsPrice"));
			m2.put("filename", rs2.getString("filename"));
			goodsTitleList.add(m2);
		}
		return goodsTitleList;
	}		
	public static int categoryCnt(String category) throws Exception {
		
		int totalRow = 0;
		int rowPerPage = 12;	
		//DB 접근
		Connection conn = DBHelper.getConnection();
		// 선택별 카테고리 개수 // 라스트 페이지값 용
		String sql3 = "select count(*) cnt from goods where category = ?";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3 = conn.prepareStatement(sql3);
		stmt3.setString(1,category);
		ResultSet rs3 = stmt3.executeQuery();
		
		if(rs3.next()){
			totalRow = rs3.getInt("cnt");
		}
		int lastPage = totalRow / rowPerPage;
		System.out.println(lastPage+"<<==lastPage");
		
		if(totalRow % rowPerPage != 0) {
			lastPage = lastPage + 1;
		}
		conn.close();
		return lastPage; // 돌려줄 값
	}
	public static int insertGoods( String category, String goodsTitle, String filename, 
			int goodsPrice, int goodsAmount, String goodsContent)  throws Exception {
		int row = 0;
		
		// DB 연동
		Connection  conn = DBHelper.getConnection();
				
		String sql = "insert into goods (category, emp_id, goods_title , filename, goods_price , goods_amount , goods_content , update_date, create_date) VALUES(?, 'admin', ?, ?, ?, ?, ?, NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		stmt.setString(2, goodsTitle);
		stmt.setString(3, filename);
		stmt.setInt(4, goodsPrice);
		stmt.setInt(5, goodsAmount);
		stmt.setString(6, goodsContent);
		
		row = stmt.executeUpdate();
				
		conn.close();
		return row;
	}
	public static int deleteGoods(int goodsNo)  throws Exception {
		int row = 0;
		
		// DB 연동
		Connection  conn = DBHelper.getConnection();
		
		String sql = "DELETE FROM goods WHERE goods_no = ? "; 
			
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setInt(1, goodsNo);
		row = stmt.executeUpdate();

		conn.close();
		return row;
	}
public static ArrayList<HashMap<String, Object>> goodsOne(int goodsNo) throws Exception {
			
		ArrayList<HashMap<String, Object>> goods 
				= new ArrayList<HashMap<String, Object>>();
		//DB 접근
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT * from goods WHERE goods_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs.getString("category"));
			m.put("filename", rs.getString("filename"));
			m.put("goods_title", rs.getString("goods_title"));
			m.put("goods_content", rs.getString("goods_content"));
			m.put("goods_price", rs.getString("goods_price"));
			m.put("goods_amount", rs.getString("goods_amount"));
			goods.add(m);
			
		}
			conn.close();
			return goods;	
	}

}
	
