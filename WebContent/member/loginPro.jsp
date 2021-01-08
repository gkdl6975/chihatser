<%@page import="member.MemberDAO"%>
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
	// member/loginPro.jsp
	// id,pass 파라미터 가져오기
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	// MemberDAO mdao 객체생성
	MemberDAO mdao = new MemberDAO();
	// int check = userCheck(id,pass) 메서드 만들고 호출
	int check = mdao.userCheck(id, pass);
	// check==1 세션값 생성"id", id main.jsp
	// check==0 "비밀번호트림" 뒤로이동
	// check==-1 "아이디없음" 뒤로이동
	
	if (check==1){
	session.setAttribute("id",id);
	//main.jsp 이동
	response.sendRedirect("../main/main.jsp");
} else if(check==0){
	%>
	<script type="text/javascript">
	alert("비밀번호 틀림");
	history.back();//뒤로이동
	</script>
	<%
} else if(check==-1){
	%>
	<script type="text/javascript">
	alert("아이디 없음");
	history.back();//뒤로이동
	</script>
<%
}

%>
</body>
</html>