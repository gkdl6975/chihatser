package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	// 1,2 디비연결 메서드
		public Connection getConnection() throws Exception{
			// 예외처리를 함수 호출하는 곳에서 처리하도록 설정
			Connection con=null;
			// JDBC 프로그램 설치
//			 // 1단계 - JDBC프로그램안에 Driver 프로그램 가져오기
//			 Class.forName("com.mysql.jdbc.Driver");
//			 // 2단계 - DriverManager 자바프로그램이 Driver 프로그램을 가지고 디비서버 접속
//			 //        => 접속정보 저장
//			 String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
//			 String dbUser="jspid";
//			 String dbPass="jsppass";
//			 con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
			
			Context init=new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
			con=ds.getConnection();
			
			return con;
		}
		// // 접근지정자 리턴값없음 insertMember(mb주소값 받을 변수) 메서드만들기
		public void insertMember(MemberBean mb) {
			Connection con=null;
			ResultSet rs=null;
			PreparedStatement pstmt2=null;
			PreparedStatement pstmt=null;
			try {
				//1,2단계
				con=getConnection();
				//3 sql
				String sql="insert into member(id,pass,name,date,email,phone,address1,address2,address3,address4,address5) values(?,?,?,?,?,?,?,?,?,?,?)";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setString(1, mb.getId());  //parameterIndex ? 물음표 순서 ,값저장된 변수
				 pstmt.setString(2, mb.getPass());
				 pstmt.setString(3, mb.getName());
				 pstmt.setTimestamp(4, mb.getDate());
				 pstmt.setString(5, mb.getEmail());
				 pstmt.setString(6, mb.getPhone());
				 pstmt.setString(7, mb.getAddress1());
				 pstmt.setString(8, mb.getAddress2());
				 pstmt.setString(9, mb.getAddress3());
				 pstmt.setString(10, mb.getAddress4());
				 pstmt.setString(11, mb.getAddress5());
				// 4 실행
				 pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리, 기억장소 해제
				if(rs!=null) try{rs.close();}catch(SQLException ex){}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
				if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
				if(con!=null) try{con.close();}catch(SQLException ex){}
			}
		}
		
		// int check = userCheck(id,pass)
		public int userCheck(String id,String pass) {
			Connection con=null;
			ResultSet rs=null;
			PreparedStatement pstmt2=null;
			PreparedStatement pstmt=null;
			int check=-1;
			try {
				//1,2단계
				con=getConnection();
				//3
				String sql="select * from member where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				// 4
				rs=pstmt.executeQuery();
				//5
				if(rs.next()) {
					if(pass.equals(rs.getString("pass"))) {
						check=1;
					}else {
						check=0;
					}
				}else {
					check=-1;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리, 기억장소 해제
				if(rs!=null) try{rs.close();}catch(SQLException ex){}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
				if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
				if(con!=null) try{con.close();}catch(SQLException ex){}
			}
			return check;
		}
		// getMember(id)
		public MemberBean getMember(String id) {
			Connection con=null;
			ResultSet rs=null;
			PreparedStatement pstmt2=null;
			PreparedStatement pstmt=null;
			MemberBean mb=null;
			try {
				//1,2단계
				con=getConnection();
				//3
				String sql="select * from member where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				// 4
				rs=pstmt.executeQuery();
				//5
				if(rs.next()) {
					// 객체생성(기억장소할당)
					mb=new MemberBean();
					// set 멤버변수 <- rs 가져와서 저장
					mb.setId(rs.getString("id"));
					mb.setPass(rs.getString("pass"));
					mb.setName(rs.getString("name"));
					mb.setDate(rs.getTimestamp("date"));
					mb.setEmail(rs.getString("email"));
					mb.setAddress1(rs.getString("address1"));
					mb.setAddress2(rs.getString("address2"));
					mb.setAddress3(rs.getString("address3"));
					mb.setAddress4(rs.getString("address4"));
					mb.setAddress5(rs.getString("address5"));
					mb.setPhone(rs.getString("phone"));
					mb.setMobile(rs.getString("mobile"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리, 기억장소 해제
				if(rs!=null) try{rs.close();}catch(SQLException ex){}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
				if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
				if(con!=null) try{con.close();}catch(SQLException ex){}
			}
			return mb;
		}
		
		// 리턴값없음 updateMember(mb) 만들고  호출
		public void updateMember(MemberBean mb) {
			Connection con=null;
			ResultSet rs=null;
			PreparedStatement pstmt2=null;
			PreparedStatement pstmt=null;
			try {
				//1,2단계
				con=getConnection();
				//3 sql
				String sql="update member set name=?,email=?,phone=?,address1=?,address2=?,address3=?,address4=?,address5=? where id=?";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setString(1, mb.getName());
				 pstmt.setString(2, mb.getEmail());
				 pstmt.setString(3, mb.getPhone());
				 pstmt.setString(4, mb.getAddress1());
				 pstmt.setString(5, mb.getAddress2());
				 pstmt.setString(6, mb.getAddress3());
				 pstmt.setString(7, mb.getAddress4());
				 pstmt.setString(8, mb.getAddress5());
				 pstmt.setString(9, mb.getId());  //parameterIndex ? 물음표 순서 ,값저장된 변수
				 // 4 실행
				 pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리, 기억장소 해제
				if(rs!=null) try{rs.close();}catch(SQLException ex){}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
				if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
				if(con!=null) try{con.close();}catch(SQLException ex){}
			}
		}
		
		// dupCheck(wid)
		public int dupCheck(String wid) {
			Connection con=null;
			ResultSet rs=null;
			PreparedStatement pstmt2=null;
			PreparedStatement pstmt=null;
			int check=0;
			try {
				//1,2단계
				con=getConnection();
				//3
				String sql="select * from member where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, wid);
				// 4
				rs=pstmt.executeQuery();
				//5
				if(rs.next()) {
					check=1; //아이디 있음 , 아이디 중복
				}else {
					check=0; // 아이디 없음, 아이디 사용가능
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리, 기억장소 해제
				if(rs!=null) try{rs.close();}catch(SQLException ex){}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
				if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
				if(con!=null) try{con.close();}catch(SQLException ex){}
			}
			return check;
		}
		
}//클래스
