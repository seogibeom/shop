package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class OrdersDAO {
	// 주문정보 출력하는 메서드 (customer)
	public static ArrayList<HashMap<String, Object>> selectOrdersListByCustomer(
			String customerId) throws Exception {
		System.out.println(customerId+"customerId");
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		// DB연동
		Connection conn = DBHelper.getConnection();
				
		String sql ="select o.orders_no ordersNo, o.goods_no goodsNo, o.customer_id customerId, o.state state, "
				+ " g.goods_title goodsTitle, g.goods_content goodsContent, o.goods_amount ordersAmount "
				+ " from orders o inner join goods g "
				+ " on o.goods_no = g.goods_no "
				+ " WHERE o.customer_id = ? "
				+ " order by o.orders_no desc "
				+ " LIMIT 0,10";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>(); 
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("goodsContent", rs.getString("goodsContent"));
			m.put("state", rs.getString("state"));
			m.put("ordersAmount", rs.getString("ordersAmount"));
			list.add(m);			
		}
		conn.close();
		return list; 
	}		
	
	// 관리자가 전체주문을 확인하는 메서드
	public static ArrayList<HashMap<String, Object>> selectOrdersListAll(
			 int startRow, int rowPerPage) throws Exception {
		// 매개값 디버깅
		System.out.println(startRow + "<<== startRow selectOrdersListAll");
		System.out.println(rowPerPage + "<<== rowPerPage selectOrdersListAll");
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연동
		Connection conn = DBHelper.getConnection();
		
		String sql ="select o.orders_no ordersNo, o.goods_no goodsNo, o.customer_id customerId, category, g.emp_id empId, "
				+ " g.goods_title goodsTitle, g.goods_content goodsContent, g.goods_price goodsPrice, "
				+ " g.goods_amount goodsAmount, o.state state "
				+ " from orders o inner join goods g "
				+ " on o.goods_no = g.goods_no "
				+ " order by o.orders_no desc limit ?, ? ";
				
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>(); 
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("customerId", rs.getString("customerId"));
			m.put("category", rs.getString("category"));
			m.put("empId", rs.getString("empId"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("goodsContent", rs.getString("goodsContent"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("goodsAmount", rs.getInt("goodsAmount"));
			m.put("state", rs.getString("state"));
			list.add(m);			
		}
		conn.close();
		return list; // 돌려줄 값
	}
	// orders 총개수
	public static int ordersCnt() throws Exception {
		
		// DB 연동
		Connection conn = DBHelper.getConnection();
		
		String  sql = "select count(*) cnt from orders";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		int count = 0;
		if(rs.next()) {
			count = rs.getInt("cnt");
		}
		conn.close();
		return count;
		
	}	
	// 주문 클릭시 orders에 입력되고 goods_amount가 -? 로 업데이트 되는 메서드
	public static int insertOrders(String customerId,int goodsNo,
								int goodsPrice, int goodsAmount) throws Exception {
		System.out.println(customerId+"<<= customerId insert메서드");
		System.out.println(goodsNo+"<<= goodsNo insert메서드");
		System.out.println(goodsPrice+"<<= goodsPrice insert메서드");
		System.out.println(goodsAmount+"<<= goodsAmount insert메서드");
		int row = 0;
							
		// DB 연동
		Connection conn = DBHelper.getConnection();
				
		String sql = "INSERT INTO orders(customer_id, goods_no, goods_price, goods_amount) VALUES(?, ?, ?, ?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, goodsPrice);
		stmt.setInt(4, goodsAmount);
		
		row = stmt.executeUpdate();
		if(row==1) {
			int row2 = 0;
			sql = null;
			sql = "update goods set goods_amount = goods_amount - ? where goods_no = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql);
			stmt2.setInt(1, goodsAmount);
			stmt2.setInt(2, goodsNo);
			
			row2 = stmt2.executeUpdate();
		}
		conn.close();
		return row;
	}
	// ordersList state 변경하는 메서드
	public static int updateOdersState(int ordersNo, String state) throws Exception {
		// 매개값 디버깅
		System.out.println(ordersNo+"<<= OrdersDAO.updateOdersState param ordersNo");
		System.out.println(state+"<<= OrdersDAO.updateOdersState param state");
		int row = 0;
		// DB연동
		Connection conn = DBHelper.getConnection();		
		PreparedStatement stmt = null;
		
		// 받아온 state 값이 결제완료 이면		
		if(state.equals("결제완료")) {
			//orders_no 가 ? 인것을 배송중으로 업데이트
			String sql = "UPDATE orders SET state = '배송중' WHERE orders_no = ?";	
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);
			row = stmt.executeUpdate();
		// 받아온 state 값이 배송중 이면	
		} if(state.equals("배송중")) {
			//orders_no 가 ? 인것을 배송완료로 업데이트
			String sql = "UPDATE orders SET state = '배송완료' WHERE orders_no = ?";	
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);
			row = stmt.executeUpdate();
		}
		conn.close();
		return row;
	}
	// orders 총개수
	public static int ordersAmount(String customerId, int ordersNo) throws Exception {
		
		// DB 연동
		Connection conn = DBHelper.getConnection();
		
		String  sql = "select goods_amount goodsAmount FROM orders WHERE customer_id = ? AND orders_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, customerId);
		stmt.setInt(2, ordersNo);
		ResultSet rs = stmt.executeQuery();
		int goodsAmount = 0;
		if(rs.next()) {
			goodsAmount = rs.getInt("goodsAmount");
		}
		conn.close();
		return goodsAmount;
		
	}	
	
}
