<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>

function selEmail(email){
	if(email != "직접입력"){
		document.getElementById("email2").value = email;
		document.getElementById("email2").readOnly = true;
	}else{
		document.getElementById("email2").readOnly = false;
		document.getElementById("email2").value = "";
                document.getElementById("email2").focus();
	}
}
</script>
<input type="text" name="email2" id="email2" onfocus="inInput(this)" onblur="outInput(this)"/>
<select onfocus="inInput(this)" onblur="outInput(this)" onChange="selEmail(this.value)">
	<option onselect="focus">직접입력</option>
	<option value="@naver.com">naver.com</option>
	<option value="@google.com">google.com</option>
	<option value="@daum.net">daum.net</option>
</select>
</body>
</html>