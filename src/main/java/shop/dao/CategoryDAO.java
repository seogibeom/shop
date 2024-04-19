package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;


public class CategoryDAO {
	public static ArrayList<HashMap<String, Object>> category() throws Exception {
		
		ArrayList<HashMap<String, Object>> categoryList
				= new ArrayList<HashMap<String, Object>>();
			
			// DB 접근
			Connection  conn = DBHelper.getConnection();
				
			String sql = "select category from category";
				
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
				
			while(rs.next()){
				HashMap<String, Object> m = new HashMap<String, Object>(); //선언	  //해시맵은 키와 키값을 묶은것 <배열>
				m.put("category", rs.getString("category")); // 입력
				categoryList.add(m);
			}
			
			conn.close();
			return categoryList;
		}
	
	public static int addCategory(String category) throws Exception {
		
			int row = 0;
			
			// DB 접근
			Connection  conn = DBHelper.getConnection();
				
			String sql = "INSERT INTO category(category,create_date) VALUES(?, NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			System.out.println(stmt+"<<==stmt");
			
			row = stmt.executeUpdate();
			
			
			conn.close();
			return row;	
			}
}
