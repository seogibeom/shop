package shop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class EmpDAO {
	// emp ? ~ ? 출력하는 코드(페이징)
	public static ArrayList<HashMap<String, Object>> empList(int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		//DB연동
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT  emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();	//쿼리가 실행되었을때 rs로 값을 넣는것
		
		while(rs.next()) {	// rs 가 실행되었을때
			HashMap<String, Object> m = new HashMap<String, Object>(); // 해쉬맵 값초기화
			m.put("empId", rs.getString("empId"));	// rs값에서 가져온값 <String, Object> 모양대로 집어넣기
			m.put("empName", rs.getString("empName"));
			m.put("empJob", rs.getString("empJob"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("active", rs.getString("active"));
			list.add(m);	// m뭉텅이를 list에 담는것
		}
		conn.close();	// DB연동 해제
		return list;	// 자원반납
	}
	// emp 개인정보 출력하는 메서드
	public static ArrayList<HashMap<String, Object>> empOne(String empId) throws Exception {
		ArrayList<HashMap<String, Object>> one = new ArrayList<HashMap<String, Object>>();
			
		//DB연동
		Connection conn = DBHelper.getConnection();
			
		String sql = " SELECT * from emp WHERE emp_id = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);

		ResultSet rs = stmt.executeQuery();	//쿼리가 실행되었을때 rs로 값을 넣는것
			
		while(rs.next()) {	// rs 가 실행되었을때				
			HashMap<String, Object> m = new HashMap<String, Object>(); // 해쉬맵 값초기화
			m.put("emp_id", rs.getString("emp_id"));	// rs값에서 가져온값 <String, Object> 모양대로 집어넣기
			m.put("grade", rs.getString("grade"));
			m.put("emp_name", rs.getString("emp_name"));
			m.put("emp_job", rs.getString("emp_job"));
			m.put("hire_date", rs.getString("hire_date"));
			m.put("update_date", rs.getString("update_date"));
			m.put("create_date", rs.getString("create_date"));
			one.add(m);	// m뭉텅이를 list에 담는것	
				
			}
			conn.close();	// DB연동 해제
			return one;	// 자원반납
		}
	// emp 총 개수 출력하는 메서드
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
	// emp 등록하는 메서드 (emp회원가입)
	public static int insertEmp( String empId, String empPw, String empName, String empJob, String hireDate)  throws Exception {
		int row = 0;
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql = "insert into emp(emp_id empId, emp_pw empPw, emp_name empName, emp_job empJob, hire_date hireDate) VALUES(?, password(?), ?, ?, ?)";
		PreparedStatement stmt =  conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJob);
		stmt.setString(5,  hireDate);
		
		row = stmt.executeUpdate();	// 쿼리가 실행된것을 row에 넣는것
									// 정상적으로 실행 되었으면 row는 1이된다. 실패시 값이 변하지않으므로 0 그대로
		
		conn.close();
		return row;
	}
		// HashMap<String, Object> : null이면 로그인실패, 아니면 성공
		// String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw		
		// 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("admin", "1234");
	// emp 로그인
	public static HashMap<String, Object> empLogin(String empId, String empPw)throws Exception {
		System.out.println(empId+"<<= empDAO.empLogin param empId");
		System.out.println(empPw+"<<= empDAO.empLogin param empPw");
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql = "select emp_id empId, emp_name empName, grade "
				+ " from emp where active='ON' and emp_id =? and emp_pw = password(?) ";
		
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
	// emp Active OnOff해주는 메서드
	public static int updateEmpOnOff(String  empId, String active)  throws Exception {
		System.out.println(empId+"<<=DAO empId");	
		System.out.println(active+ "<<=DAO active");	
		int row = 0;
		// DB 접근
		Connection  conn = DBHelper.getConnection();
		
		String sql =  "UPDATE emp SET active  = ? WHERE emp_id = ?";
		PreparedStatement stmt =  conn.prepareStatement(sql);
		stmt.setString(1, active);
		stmt.setString(2, empId);
		row = stmt.executeUpdate();
		if(active.equals("ON")) {
			sql = " UPDATE emp SET active = 'OFF' WHERE emp_id = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, empId);
			row = stmt.executeUpdate();
		}if(active.equals("OFF")) {
			sql =  "UPDATE emp SET active  = 'ON' WHERE emp_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, empId);
			row = stmt.executeUpdate();
		}				
		conn.close();
		return row;
	}
	
}
