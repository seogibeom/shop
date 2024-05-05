package shop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class ReviewDAO {
	
	// 굿즈넘버가 ? 일떄 리뷰 호출하는 메서드
	public static ArrayList<HashMap<String, Object>> reviewList(int goodsNo) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		System.out.println(goodsNo+"<<= goodsNo reviewList 메서드");
		// DB연동
		Connection conn = DBHelper.getConnection();
	
		String sql = " SELECT o.goods_no goodsNo, r.score_star scoreStar, r.content, r.create_date createDate, r.orders_no ordersNo "
				+ " FROM review r INNER JOIN orders o "
				+ " ON r.orders_no = o.orders_no "
				+ " WHERE goods_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);	
		
		stmt.setInt(1, goodsNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsNo", rs.getString("goodsNo"));
			m.put("scoreStar", rs.getString("scoreStar"));
			m.put("content", rs.getString("content"));
			m.put("createDate", rs.getString("createDate"));
			m.put("ordersNo", rs.getString("ordersNo"));
			list.add(m);
		}
		conn.close();
		return list;
		}
	// 주문번호가 ? 일때 굿즈 출력하는 메서드
	public static ArrayList<HashMap<String, Object>> addReviewGoods(int ordersNo) throws Exception {
		ArrayList<HashMap<String, Object>> goods = new ArrayList<HashMap<String, Object>>();
		System.out.println(ordersNo+"<<= ordersNo addReviewContent 메서드");
		// DB연동
		Connection conn = DBHelper.getConnection();
	
		String sql = "SELECT * "
				+ " FROM orders o INNER JOIN goods g "
				+ " ON o.goods_no = g.goods_no "
				+ " WHERE orders_no = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);	
		
		stmt.setInt(1, ordersNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsContent", rs.getString("goods_content"));
			m.put("goodsNo", rs.getString("goods_no"));
			goods.add(m);
		}
		conn.close();
		return goods;
		}
	// 상품 등록하는 메서드
		public static int addReviewAction(int ordersNo, String content, String scoreStar)  throws Exception {
			
			int row = 0;
			
			// DB 연동
			Connection  conn = DBHelper.getConnection();
					
			String sql =  " INSERT INTO review"
						+ "	(orders_no, content, score_star, create_date, update_date)"
						+ " VALUES"
						+ " (?, ?, ?, NOW(),NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);		
			stmt.setString(2, content);
			stmt.setString(3, scoreStar);
									
			row = stmt.executeUpdate();
					
			conn.close();
			return row;
		}
		
		// review에 order_no이 ? 인것을 출력하는 메서드 / 후기등록 중복방지
		public static ArrayList<HashMap<String, Object>> ckReview(int ordersNo) throws Exception {
			ArrayList<HashMap<String, Object>> goods = new ArrayList<HashMap<String, Object>>();
			System.out.println(ordersNo+"<<= ordersNo ckReview 메서드");
			// DB연동
			Connection conn = DBHelper.getConnection();
		
			String sql = " SELECT orders_no ordersNo, content, score_star scoreStar, create_date createDate"
					   + " from review WHERE orders_no = ? ";
			
			PreparedStatement stmt = conn.prepareStatement(sql);	
			
			stmt.setInt(1, ordersNo);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m2 = new HashMap<String, Object>();
				m2.put("ordersNo", rs.getString("ordersNo"));
				m2.put("content", rs.getString("content"));
				m2.put("scoreStar", rs.getString("scoreStar"));
				m2.put("createDate", rs.getString("createDate"));
				goods.add(m2);
			}
			conn.close();
			return goods;
			}
		
		// customerInfo.jsp에 my후기 출력하는 메서드
		public static ArrayList<HashMap<String, Object>> myReview(String customerId) throws Exception {
			ArrayList<HashMap<String, Object>> goods = new ArrayList<HashMap<String, Object>>();
			System.out.println(customerId+"<<= ordersNo ckReview 메서드");
			// DB연동
			Connection conn = DBHelper.getConnection();
				
			String sql = " SELECT o.goods_no goodsNo, r.orders_no ordersNo, r.content content, r.score_star scoreStar, r.create_date createDate "
						+ " from review  r INNER JOIN orders o "
						+ " ON r.orders_no = o.orders_no "
						+ " WHERE customer_id = ? "
						+ " ORDER BY create_date DESC LIMIT 0,10 ";
					
			PreparedStatement stmt = conn.prepareStatement(sql);	
					
			stmt.setString(1, customerId);
			ResultSet rs = stmt.executeQuery();
				
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("goodsNo", rs.getString("goodsNo"));
				m.put("ordersNo", rs.getString("ordersNo"));
				m.put("content", rs.getString("content"));
				m.put("scoreStar", rs.getString("scoreStar"));
				m.put("createDate", rs.getString("createDate"));
				goods.add(m);
			}
			conn.close();
			return goods;
			}
	
}
