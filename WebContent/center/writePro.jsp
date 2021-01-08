<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// request 한글처리
// request.setCharacterEncoding("utf-8");
// 파일업로드 
//1. cos.jar 
//설치  http://www.servlets.com 
// COS File Upload Library
// cos-20.08.zip 압축풀기   cos-20.08 - lib -cos.jar
// 이클립스 WebContent - WEB-INF - cos.jar
// 2 cos.jar안에  MultipartRequest 파일 객체생성-파일업로드 
// MultipartRequest multi=new MultipartRequest(request,파일업로드폴더,파일크기,한글처리,동일파일이름처리);
// WebContent - upload 폴더 만들기 파일업로드폴더 (물리적인 경로)
String uploadPath=request.getRealPath("/upload");
System.out.println(uploadPath);
// 파일크기 10M 
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// request -> multi
// name, pass, subject, content 파라미터 가져오기
String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
// int readcount = 0 //조회수
int readcount = 0;
// 글쓴날짜 <= 현시스템에 날짜시간을 가져오기
Timestamp date=new Timestamp(System.currentTimeMillis());
// 업로드된 파일이름 가져오기
String file=multi.getFilesystemName("file");

// 게시판글을 하나의 바구니(자바빈)에 저장
// 패키지 board 파일이름 BoardBean  
// 멤버변수 num name, pass, subject, content,readcount,date,file 정의
// BoardBean bb 객체생성
BoardBean bb=new BoardBean();
// bb set메서드 호출 <= 파라미터 값 저장
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setReadcount(readcount);
bb.setDate(date);
// file추가
bb.setFile(file);


// 게시판 데이터베이스 작업 
// 패키지 board 파일이름 BoardDAO
// 리턴값없음 insertBoard(bb바구니주소값) 메서드 만들기
// BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// insertBoard(bb) 메서드 호출
bdao.insertBoard(bb);

// 글목록 이동 
response.sendRedirect("notice.jsp");
%>
</body>
</html>










