package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class OrdersDAO {
	// 고객의 자신의 주문을 확인(페이징)
	public static ArrayList<HashMap<String, Object>> selectOrdersListByCustomer(
			String mail, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		String sql ="select o.orders_no ordersNo, o.goods_no goodsNo,"
				+ "o.goods_no goodsNo, g.goods_title goodsTitle, - - -- - -- "
				+ "from orders o inner join goods g"
				+ "on o.goods_no = g.goods_no"
				+ "where o.mail = ?"
				+ "order by o.orders_no desc"
				+ "offset ? rows fetch next ? rows only";
		
		return list;
	}
	
	// 관리자 전체주문을 확인(페이징)
	public static ArrayList<HashMap<String, Object>> selectOrdersListAll(
			 int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		String sql ="select o.orders_no ordersNo, o.goods_no goodsNo,"
				+ "o.goods_no goodsNo, g.goods_title goodsTitle, - - -- - --"
				+ "from orders o inner join goods g"
				+ "on o.goods_no = g.goods_no"
				+ "order by o.orders_no desc"
				+ "offset ? rows fetch next ? rows only";
		
		return list;
	}
	public static int insertOrders(String customerId,int goodsNo,int goodsPrice)  throws Exception {
		
		int row = 0;
							
		// DB 연동
		Connection  conn = DBHelper.getConnection();
				
		String sql = "INSERT INTO orders(customer_id, goods_no, goods_price) VALUES(?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, goodsPrice);
		
		row = stmt.executeUpdate();
		if(row==1) {
			int row2 = 0;
			sql = null;
			sql = "update goods set goods_amount = goods_amount - 1 where goods_no = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql);
			stmt2.setInt(1, goodsNo);
			
			row2 = stmt2.executeUpdate();
		}
		conn.close();
		return row;
	}
}
