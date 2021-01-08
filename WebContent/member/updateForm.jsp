<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 
</head>
<body>

<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<%
// String id =(String) 세션값 가져오기
	String id = (String)session.getAttribute("id");
// MemberDAO mdao 객체생성
	MemberDAO mdao = new MemberDAO();
// MemberBean mb = getMember(id) 메서드 만들고 호출
	MemberBean mb = mdao.getMember(id);
	String email = mb.getEmail();
	String[] cutEmail = email.split("@");
	

%>
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
<form action="updatePro.jsp" id="join" method="post" name="fr">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" value="<%=id%>" readonly><br>
<label>Password</label>
<input type="password" name="pass"><br>
<label>Retype Password</label>
<input type="password" name="pass2"><br>
<label>Name</label>
<input type="text" name="name" value="<%=mb.getName()%>"><br>
<label>E-Mail</label>
<input type="text" name="email" value="<%=cutEmail[0]%>">
<input type="text" name="email2" id="email2" value="@<%=cutEmail[1] %>" onfocus="inInput(this)" onblur="outInput(this)"/>
<select onfocus="inInput(this)" onblur="outInput(this)" onChange="selEmail(this.value)">
	<option onselect="focus" value="<%=cutEmail[1]%>">직접입력</option>
	<option value="@naver.com"
	<%if(cutEmail[1].equals("naver.com")){%> selected ="selected" <%} %>>naver.com</option>
	<option value="@google.com"
	<%if(cutEmail[1].equals("google.com")){%> selected ="selected"<%} %>	>gmail.com</option>
	<option value="@daum.net"
	<%if(cutEmail[1].equals("daum.net")){%> selected ="selected"<%} %>	>daum.net</option>
	</select>
<br>
</fieldset>
<fieldset>
<legend>Optional</legend>
<label>주소</label>
<input type="text" name="address1" id="sample4_postcode" placeholder="우편번호" readOnly="true" value="<%=mb.getAddress1()%>">
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="dup"><br>
<label></label>
<input type="text" name="address2" id="sample4_roadAddress" placeholder="도로명주소"readOnly="true" value="<%=mb.getAddress2()%>">
<input type="text" name="address3" id="sample4_jibunAddress" placeholder="지번주소"readOnly="true" value="<%=mb.getAddress3()%>">
<span id="guide" style="color:#999;display:none"></span><br>
<label></label>
<input type="text" name="address4" id="sample4_extraAddress" placeholder="참고항목"readOnly="true" value="<%=mb.getAddress4()%>">
<input type="text" name="address5"id="sample4_detailAddress" placeholder="상세주소" value="<%=mb.getAddress5()%>">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<br>
<label>휴대전화</label>
<input type="text" name="phone" value="<%=mb.getPhone()%>"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons" align="center">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>