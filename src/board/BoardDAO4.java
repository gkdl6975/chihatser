package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO4 {
	// 1,2 디비연결 메서드
			public Connection getConnection() throws Exception{
				// 예외처리를 함수 호출하는 곳에서 처리하도록 설정
				Connection con=null;
				// JDBC 프로그램 설치
//				 // 1단계 - JDBC프로그램안에 Driver 프로그램 가져오기
//				 Class.forName("com.mysql.jdbc.Driver");
//				 // 2단계 - DriverManager 자바프로그램이 Driver 프로그램을 가지고 디비서버 접속
//				 //        => 접속정보 저장
//				 String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
//				 String dbUser="jspid";
//				 String dbPass="jsppass";
//				 con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
				
				//커넥션 풀(Connection Pool)
				// 데이터베이스와 연결된 Connection객체를 미리 생성하여 Pool(풀,기억장소) 저장
				// 필요할때마다 풀에 접근하여 Connection객체 사용, 작업 끝나면 반환
				// 프로그램은 서버에 미리 설치
				// 1. WebContent META-INF context.xml 만들어 미리 자원준비
				// 2. DAO 자원이름을 불러서 사용
				// 장점 : 속도 증가 , 수정시 하나의 파일 context.xml수정 
				Context init=new InitialContext();
				DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
				con=ds.getConnection();
				return con;
			}
			
			public void insertBoard(BoardBean bb) {
				Connection con=null;
				ResultSet rs=null;
				PreparedStatement pstmt2=null;
				PreparedStatement pstmt=null;
				try {
					// 1,2 단계 디비연결 메서드 호출
					 con=getConnection();
					//3단계 num구하기 기존글에서 최대 num 값을 구해서 +1 
						String sql2="select max(num) from board4";
						pstmt2=con.prepareStatement(sql2);
						//4단계 실행 => rs 저장
						rs=pstmt2.executeQuery();
						//5단계 rs 첫행이동 max(num) 가져오기 +1
						int num=0;
						if(rs.next()){
							num=rs.getInt("max(num)")+1;
						}
						
						// 3단계 - 접속정보를 이용해서 insert sql 구문 만들고 실행할수 있는 자바프로그램 생성
						String sql="insert into board4(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,?,?)";
						pstmt=con.prepareStatement(sql);
						pstmt.setInt(1, num);  //parameterIndex ? 물음표 순서 ,값저장된 변수
						pstmt.setString(2, bb.getName());
						pstmt.setString(3, bb.getPass());
						pstmt.setString(4, bb.getSubject());
						pstmt.setString(5, bb.getContent());
						pstmt.setInt(6, bb.getReadcount());
						pstmt.setTimestamp(7, bb.getDate());
						//file추가
						pstmt.setString(8, bb.getFile());
						
						// 4단계 - sql실행  (insert, update, delete)
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
			public List getBoardList(int startRow, int pageSize) {
				Connection con=null;
				ResultSet rs=null;
				PreparedStatement pstmt2=null;
				PreparedStatement pstmt=null;
				// 여러개 바구니는 저장할 기억장소만들기(배열형태로 자바에 만든 프로그램)
				List boardList=new ArrayList(); 
				try {
					// 1,2 단계 디비연결 메서드 호출
					 con=getConnection();
					// 3단계 - 접속정보를 이용해서 select sql 구문 만들고 실행할수 있는 자바프로그램 생성
//			        최근글이 맨위로 보이게 데이터 가져오기 (num기준 내림차순 정렬해서 가져오기)
//			String sql="select * from board order by num desc";
			String sql="select * from board4 order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			// 4단계 - sql구문 실행(select) => 결과 저장
			rs=pstmt.executeQuery();
				//5단계  rs첫행으로 이동  num pass name 열 가져와서 하나의 바구니에 저장
			while(rs.next()) {
				//첫번째 행 게시판 글 하나  => 자바빈 바구니에 저장
				BoardBean bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				//file추가
				bb.setFile(rs.getString("file"));
				// 배열에 첫번째 칸에 바구니 하나 저장
				boardList.add(bb);
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
				return boardList;
			}
			
			public List getBoardList(int startRow, int pageSize,String search) {
				Connection con=null;
				ResultSet rs=null;
				PreparedStatement pstmt2=null;
				PreparedStatement pstmt=null;
				// 여러개 바구니는 저장할 기억장소만들기(배열형태로 자바에 만든 프로그램)
				List boardList=new ArrayList(); 
				try {
					// 1,2 단계 디비연결 메서드 호출
					 con=getConnection();
					// 3단계 - 접속정보를 이용해서 select sql 구문 만들고 실행할수 있는 자바프로그램 생성
//			        최근글이 맨위로 보이게 데이터 가져오기 (num기준 내림차순 정렬해서 가져오기)
//			String sql="select * from board order by num desc";
//			String sql="select * from board where subject like '%검색어%' order by num desc limit ?,?";
			String sql="select * from board4 where subject like ? order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,"%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			// 4단계 - sql구문 실행(select) => 결과 저장
			rs=pstmt.executeQuery();
				//5단계  rs첫행으로 이동  num pass name 열 가져와서 하나의 바구니에 저장
			while(rs.next()) {
				//첫번째 행 게시판 글 하나  => 자바빈 바구니에 저장
				BoardBean bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				//file추가
				bb.setFile(rs.getString("file"));
				// 배열에 첫번째 칸에 바구니 하나 저장
				boardList.add(bb);
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
				return boardList;
			}
			
			// int count = getBoardCount() 메서드 만들기 호출	
			public int getBoardCount() {
				Connection con=null;
				ResultSet rs=null;
				PreparedStatement pstmt2=null;
				PreparedStatement pstmt=null;
				int count=0;
				try {
					// 1,2 단계 디비연결 메서드 호출
					 con=getConnection();
					//3단계 게시판 글 전체 개수   select count(*) from board 
					String sql2="select count(*) from board4";
					pstmt2=con.prepareStatement(sql2);
					//4단계 실행 => rs 저장
					rs=pstmt2.executeQuery();
					//5단계 rs 첫행이동 count(*) 가져오기 
					if(rs.next()){
						count=rs.getInt("count(*)");
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
				return count;
			}
			
			// int count = getBoardCount() 메서드 만들기 호출	
			public int getBoardCount(String search) {
				Connection con=null;
				ResultSet rs=null;
				PreparedStatement pstmt2=null;
				PreparedStatement pstmt=null;
				int count=0;
				try {
					// 1,2 단계 디비연결 메서드 호출
					con=getConnection();
					//3단계 게시판 글 전체 개수   select count(*) from board 
//					String sql2="select count(*) from board where subject like '%검색어%'";
					String sql2="select count(*) from board4 where subject like ?";
					pstmt2=con.prepareStatement(sql2);
					pstmt2.setString(1,"%"+search+"%");
					//4단계 실행 => rs 저장
					rs=pstmt2.executeQuery();
					//5단계 rs 첫행이동 count(*) 가져오기 
					if(rs.next()){
							count=rs.getInt("count(*)");
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
					return count;
				}
						
			
			//리턴할형 BoardBean bb = getBoard(num) 메서드 만들고 호출
			public BoardBean getBoard(int num) {
				Connection con=null;
				ResultSet rs=null;
				PreparedStatement pstmt2=null;
				PreparedStatement pstmt=null;
				BoardBean bb=null;
				try {
					// 1,2 단계 디비연결 메서드 호출
					 con=getConnection();
					// 3단계 - 접속정보를 이용해서 select sql 구문 만들고 실행할수 있는 자바프로그램 생성
//					        num에 해당하는 게시판 글 가져오기
					String sql="select * from board4 where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, num);
					// 4단계 - sql구문 실행(select) => 결과 저장
					rs=pstmt.executeQuery();
					// 5단계 - 결과 저장 => 출력    
					// if 첫행으로 이동 데이터 있으면  열을 찾아서 출력
					if(rs.next()){
						bb=new BoardBean();
						bb.setNum(rs.getInt("num"));
						bb.setName(rs.getString("name"));
						bb.setPass(rs.getString("pass"));
						bb.setSubject(rs.getString("subject"));
						bb.setContent(rs.getString("content"));
						bb.setReadcount(rs.getInt("readcount"));
						bb.setDate(rs.getTimestamp("date"));
						//file추가
						bb.setFile(rs.getString("file"));
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
				return bb;
			}
			
			//bdao.updateReadcount(num);
			public void updateReadcount(int num) {
				Connection con=null;
				ResultSet rs=null;
				PreparedStatement pstmt2=null;
				PreparedStatement pstmt=null;
				try {
					// 1,2 단계 디비연결 메서드 호출
					 con=getConnection();
					//조회수   1 증가
					// 3단계  조회수= 기존조회수+1
					String sql2="update board4 set readcount=readcount+1 where num=?";
					pstmt2=con.prepareStatement(sql2);
					pstmt2.setInt(1, num);  //parameterIndex ? 물음표 순서 ,값저장된 변수
					// 4단계 - sql실행  (insert, update, delete)
					pstmt2.executeUpdate();
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
			
			// int check = numCheck(BoardBean ) 메서드 만들고 호출
			public int numCheck(BoardBean bb) {
				Connection con=null;
				ResultSet rs=null;
				PreparedStatement pstmt2=null;
				PreparedStatement pstmt=null;
				int check=-1;
				try {
					// JDBC 프로그램 설치
					// 1,2 단계 디비연결 메서드 호출
					 con=getConnection();
					// 3단계 - 접속정보를 이용해서 select sql 구문 만들고 실행할수 있는 자바프로그램 생성
					String sql="select * from board4 where num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, bb.getNum());
					// 4단계 - sql구문 실행(select) => 결과 저장
					rs=pstmt.executeQuery();
					// 5단계 - 결과 저장 => 
					// rs.next() 다음행이동 했을때 데이터가 있으면  true / 데이터가 없으면 false
					if(rs.next()){
						// "폼에서 가져온 비밀번호".equals("디비에서 가져온 비밀번호")
						if(bb.getPass().equals(rs.getString("pass"))){
							check=1; //num 비밀번호 일치
						}else{
							check=0;//비밀번호틀림
						}
					}else {
						check=-1;	//num 틀림
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
			
			// updateBoard(bb);
			public void updateBoard(BoardBean bb){
				Connection con=null;
				ResultSet rs=null;
				PreparedStatement pstmt2=null;
				PreparedStatement pstmt=null;
				try {
					// 1,2 단계 디비연결 메서드 호출
					 con=getConnection();
					// 3단계 - 접속정보를 이용해서 insert sql 구문 만들고 실행할수 있는 자바프로그램 생성
						String sql="update board4 set name=?,subject=?,content=?,file=? where num=?";
						pstmt=con.prepareStatement(sql);
						pstmt.setString(1, bb.getName());
						pstmt.setString(2, bb.getSubject());
						pstmt.setString(3, bb.getContent());
						pstmt.setString(4, bb.getFile());
						pstmt.setInt(5, bb.getNum());  //parameterIndex ? 물음표 순서 ,값저장된 변수
						// 4단계 - sql실행  (insert, update, delete)
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
			
			// deleteBoard(bb);
					public void deleteBoard(BoardBean bb){
						Connection con=null;
						ResultSet rs=null;
						PreparedStatement pstmt2=null;
						PreparedStatement pstmt=null;
						try {
							// 1,2 단계 디비연결 메서드 호출
							 con=getConnection();
							// 3단계 - 접속정보를 이용해서 delete sql 구문 만들고 실행할수 있는 자바프로그램 생성
								String sql="delete from board4 where num=?";
								pstmt=con.prepareStatement(sql);
								pstmt.setInt(1, bb.getNum());  //parameterIndex ? 물음표 순서 ,값저장된 변수
								// 4단계 - sql실행  (insert, update, delete)
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



}
