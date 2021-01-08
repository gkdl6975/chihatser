<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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

request.setCharacterEncoding("utf-8");
//id, pass, name 폼에서 파라미터 가져와서 변수 저장
String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String email2=request.getParameter("email2");
String phone=request.getParameter("phone");
String address1=request.getParameter("address1");
String address2=request.getParameter("address2");
String address3=request.getParameter("address3");
String address4=request.getParameter("address4");
String address5=request.getParameter("address5");

//MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
//int check = userCheck(id,pass) 메서드 만들고 호출
int check=mdao.userCheck(id, pass);
//check==1  아이디비밀번호 일치  신호 1받아서  
//        MemberBean mb 객체 생성  멤버변수 <= 파라미터 값 저장
//        3단계update4단계실행  updateMember(mb)  
//        main.jsp이동

if(check==1) {
	MemberBean mb = new MemberBean();
	mb.setId(id);
	mb.setPass(pass);
	mb.setName(name);
	mb.setAddress1(address1);
	mb.setAddress2(address2);
	mb.setAddress3(address3);
	mb.setAddress4(address4);
	mb.setAddress5(address5);
	mb.setEmail(email+email2);
	mb.setPhone(phone);
	
	
	mdao.updateMember(mb);
	response.sendRedirect("../main/main.jsp");
} else if (check==0) { //check==0  아이디일치비밀번호틀림 신호0받아서  "비밀번호 틀림" 뒤로이동 
	%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back(); // 뒤로이동 
	</script>
	<%
} else{
	

//나머지 check==-1  아이디틀림  신호-1받아서  "아이디없음" 뒤로이동
	%>
	<script type="text/javascript">
			alert("아이디 없음");
			history.back(); // 뒤로이동 
	</script>
	<%
}
%>
</body>
</html>