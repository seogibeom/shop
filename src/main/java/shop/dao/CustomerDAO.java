package shop.dao;

import java.sql.*;
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
		
		String sql = "SELECT  customer_id customerId, customer_name customerName, birth, gender, email, create_date createDate "
					+ " from customer order by create_date desc limit ?, ?";
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
			m.put("createDate", rs.getString("createDate"));
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
	// customer 로그인 메서드
	public static HashMap<String, Object> customerLogin(String customerId, String customerPw)throws Exception {
		System.out.println(customerId+"<<= CustomerDAO.customerLogin param customerId");
		System.out.println(customerPw+"<<= CustomerDAO.customerLogin param customerPw");
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql = "select customer_id customerId, customer_name customerName "
					+ " from customer where customer_id = ? and customer_pw = password(?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setString(2, customerPw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("customerId", rs.getString("customerId"));
			resultMap.put("customerName", rs.getString("customerName"));
		}
		conn.close();
		return resultMap;
	}
	// customer 회원가입 하는 메서드
	public static int addCustomer( String id, String pw, String name, String birth, 
								String gender, String email) throws Exception {
		int row = 0;
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO customer ("
					+ "	customer_id, customer_pw, customer_name, birth, gender, email, update_date, create_date) "
					+ "	VALUES(?, password(?), ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt =  conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		stmt.setString(3, name);
		stmt.setString(4, birth);
		stmt.setString(5, gender);
		stmt.setString(6, email);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	// 아이디 중복확인 해주는 메서드
	public static String ckId(String checkId)throws Exception {
		System.out.println(checkId+"<<= CustomerDAO.chId param checkId");
		
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql = "select customer_id customerId from customer where customer_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, checkId);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			checkId = rs.getString("customerId");
		}
		conn.close();
		return checkId;
	}
	
	// 아이디 찾아주는 메서드
		public static String findId(String customerName, String email)throws Exception {
			System.out.println(customerName+"<<= CustomerDAO.findId param customerName");
			System.out.println(email+"<<= CustomerDAO.findId param email");
			
			String id = null;
			
			// DB 접근
			Connection  conn = DBHelper.getConnection();
			
			String sql = "SELECT customer_id customerId FROM customer WHERE customer_name = ? AND email = ? ";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerName); //쿼리가 실행되었을때 위에서 받아온 값을 쿼리에 대입
			stmt.setString(2, email);			
			ResultSet rs = stmt.executeQuery();
			
			if(rs.next()) {	//쿼리가 실행되었을때 id에 값을 넣음			
				id = rs.getString("customerId");
			}
			
			conn.close();
			return id;	
		}
	
}
