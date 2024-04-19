package shop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class EmpDAO {
	public static ArrayList<HashMap<String, Object>> empList(int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		Connection  conn = DBHelper.getConnection();
		
		String sql = "SELECT  emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("empId", rs.getString("empId"));
			m.put("empName", rs.getString("empName"));
			m.put("empJob", rs.getString("empJob"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("active", rs.getString("active"));
			list.add(m);
		}
		conn.close();
		return list;
	}
	public static int empCnt() throws Exception {
		
		Connection conn = DBHelper.getConnection();
		
		String  sql = "select count(*) cnt from emp";
		PreparedStatement stmt = null;
		ResultSet rs2 = null;
		stmt = conn.prepareStatement(sql);
		rs2 = stmt.executeQuery();
		int count = 0;
		if(rs2.next()) {
			count = rs2.getInt("cnt");
		}
		return count;
		
	}	
	public static int insertEmp( String empId, String empPw, String empName, String empJob, String hireDate)  throws Exception {
		int row = 0;
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql = "insert into emp(emp_id empId, emp_pw empPw, emp_name empName, emp_job empJob, hire_date hireDate) VALUES(?, ?, ?, ?, ?)";
		PreparedStatement stmt =  conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJob);
		stmt.setString(5,  hireDate);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
		// HashMap<String, Object> : null이면 로그인실패, 아니면 성공
		// String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw
		
		// 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("admin", "1234");
	public static HashMap<String, Object> empLogin(String empId, String empPw)
												throws Exception {
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql = "select emp_id empId, emp_name empName, grade from emp where active='ON' and emp_id =? and emp_pw = password(?) ";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
		}
		conn.close();
		return resultMap;
	}
	public static int updateEmpON(String  empId)  throws Exception {
		int row = 0;
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql =  "UPDATE emp SET active  = 'ON' WHERE emp_id = ?";
		PreparedStatement stmt =  conn.prepareStatement(sql);
		stmt.setString(1, empId);
				
		row = stmt.executeUpdate();
		if(row==1 ) {
			System.out.println("변경");
		}  else {
			System.out.println("변경실패");
		}
		
		conn.close();
		return row;
	}
	public static int updateEmpOFF(String  empId)  throws Exception {
		int row = 0;
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql =  "UPDATE emp SET active  = 'OFF' WHERE emp_id = ?";
		PreparedStatement stmt =  conn.prepareStatement(sql);
		stmt.setString(1, empId);
				
		row = stmt.executeUpdate();
		if(row==1 ) {
			System.out.println("변경");
		}  else {
			System.out.println("변경실패");
		}
		
		conn.close();
		return row;
	}
}
