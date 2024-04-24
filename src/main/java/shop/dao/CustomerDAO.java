package shop.dao;

import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.net.*;
import java.util.*;

public class CustomerDAO {
	
	//customer목록을 출력하는 메서드
	public static ArrayList<HashMap<String, Object>> customerList(int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연동
		Connection  conn = DBHelper.getConnection();
		
		String sql = "SELECT  customer_id customerId, customer_name customerName, birth, gender, email from customer order by create_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("customerId", rs.getString("customerId"));
			m.put("customerName", rs.getString("customerName"));
			m.put("birth", rs.getString("birth"));
			m.put("gender", rs.getString("gender"));
			m.put("email", rs.getString("email"));
			list.add(m);
		}
		conn.close();
		return list;
	}
	//customer총 개수 출력하는 메서드
	public static int customerCnt() throws Exception {
		
		int count = 0;
		// DB연동
		Connection conn = DBHelper.getConnection();
		
		String  sql = "select count(*) cnt from customer";
		PreparedStatement stmt = null;
		ResultSet rs2 = null;
		stmt = conn.prepareStatement(sql);
		rs2 = stmt.executeQuery();
		
		if(rs2.next()) {
			count = rs2.getInt("cnt");
		}
		conn.close();
		return count;
	}	
	//customer 개인정보 출력하는 메서드
	public static ArrayList<HashMap<String, Object>> customerInfo(String customerId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연동
		Connection  conn = DBHelper.getConnection();
		
		String sql = "SELECT customer_id customerId, customer_name customerName, birth, gender, email from customer WHERE customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("customerId", rs.getString("customerId"));
			m.put("customerName", rs.getString("customerName"));
			m.put("birth", rs.getString("birth"));
			m.put("gender", rs.getString("gender"));
			m.put("email", rs.getString("email"));
			list.add(m);
		}
		conn.close();
		return list;
	}
}
