package shop.dao;

import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class CustomerGoodsDAO {
	
	// 상품 주문 or 취소시 수정할 수량
	// /customer/addOrdersAction.jsp or dropOrdersAction.jsp
	// param : int(상품번호), int(변경할 수량  + or -   )
	public static int updateGoodsAmount(int goodsNo, int amount) throws Exception {
		int row = 0;
		// DB연동
		Connection conn = DBHelper.getConnection();
	
		String sql = null;	// 쿼리초기화
		//PreparedStatement stmt = null; //쿼리실행 초기화
		
		// ResultSet rs = null; // select 문의 결과를 저장하는 객체  초기화
		// delelte , update insert 성공/실패만 select는 값이 넘어감
		sql =  " update goods "
			+ " set goods_amount = ?, update_date = sysdate" 	//sysdate==NOW()
			+ " where goods_no = ? ";		
		
		PreparedStatement stmt =  conn.prepareStatement(sql);
		stmt.setInt(1, amount);
		stmt.setInt(2, goodsNo);	
				
		row = stmt.executeUpdate();
		if(row==0) {
			System.out.println("실패");
		} else {
			System.out.println("성공");
		}
		return row;
	}
	

	// 상품 상세보기 => 주문
	// /customer/goodsOne.jsp
	// param : int(goods_no)
	// return : Goods => HashMap
	// 해쉬맵은 프라이머리키 같은 키값을 가져올때 // 굿즈넘버도 키값임 키값에 여러가지를 뽑아올때 해쉬맵도 배열같은거임
	public static HashMap<String, Object> selectGoodsOne(int goodsNo) throws Exception{
		HashMap<String, Object> map = null;
		
		Connection conn = DBHelper.getConnection();
		String sql = null;	// 쿼리초기화
		PreparedStatement stmt = null; //쿼리실행 초기화		
		ResultSet rs = null; // select 문의 결과를 저장하는 객체  초기화
		
		 sql = "select *"
			+ " from goods"
			+ " where goods_no = ?" ;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
	
		rs = stmt.executeQuery();
		
		// JDBC Result(자바에서 일반적이지 않은 자료구조) 
		// => (자바에서 평이한 자료구조) Collections API 타입 => List, Set, Map
		while(rs.next()) {		//선택된 굿즈넘버에 보여지고싶은 값을 아래에 받아와서 m 에 넣고 m을 list에 넣는다
			HashMap<String, Object> m = new HashMap<String, Object> ();
			m.put("goods_no", rs.getString("goods_no"));
			m.put("category", rs.getString("category"));
			m.put("filename", rs.getString("filename"));
			m.put("goods_content", rs.getString("goods_content"));
			m.put("goods_price", rs.getString("goods_price"));
			m.put("goods_amount", rs.getString("goods_amount"));	
		}
		
		return map;
	}
		
	//미완성
	// 고객 로그인후 상품목록 페이지
	// /customer/goodsList.jsp
	// param : void
	// return : Goods(일부속성) 의 배열 => ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> selectGoodsList(String category, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		// DB연동
		Connection conn = DBHelper.getConnection();
		//값초기화
		String sql = null; 	//쿼리 초기화
		PreparedStatement stmt = null;	//쿼리실행 초기화
		ResultSet rs = null;		//select 문의 // 결과를 저장하는 객체  초기화
		
		if(category != null || category.equals("")) {
			
			sql = 	"select goods_no goodsNo, category, goods_title goodsTitle, goods_price goodsPrice "
					+ "from goods"
					+ "where category = ?"
					+ "order by goods_no desc"
					+ "offset ? rows fetch next ? rows only";
						// ?번 째 부터 ?번째 까지 출력
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, category);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
			
		} else {
			
			sql = 	"select goods_no goodsNo, category, goods_title goodsTitle, goods_price goodsPrice "
					+ "from goods"
					+ "order by goods_no desc"
					+ "offset ? rows fetch next ? rows only";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		}
		
		return list;
	}

}
