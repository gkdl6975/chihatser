<!DOCTYPE html>
<html>

<head>
<title>W3.CSS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta content="text/html; charset=iso-8859-2" http-equiv="Content-Type">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.mySlides {display:none;}
</style>
</head>

<body>


<div class="w3-content w3-section" style="max-width:1300px" >
  <a href ="https://recruit.lotte.co.kr/apply/announcement/detail/20070858?compcd=?id=bookmark1000" target="_blank">
  <img class="mySlides" src="../images/bb.PNG" style="width:100%"  width="1300" height="240"></a>
  <a href="https://recruit.lotte.co.kr/apply/announcement/detail/20070858?compcd=40006&_t=1601258774749" target="_blank">
  <img class="mySlides" src="../images/top_title.jpg" style="width:100%"  width="1300" height="240"></a>
  <a href="https://gamevilcom2us-recruit.com/" >
  <img class="mySlides" src="../images/aas.PNG" style="width:100%"  width="1300" height="240"></a>
</div>

<script>
var myIndex = 0;
carousel();

function carousel() {
  var i;
  var x = document.getElementsByClassName("mySlides");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  myIndex++;
  if (myIndex > x.length) {myIndex = 1}    
  x[myIndex-1].style.display = "block";  
  setTimeout(carousel, 2000); // 2초마다 이미지 변경
}
</script>

</body>
</html>
