<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>갤러리 글쓰기</title>
	<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<!-- 구글 폰트  -->
	<link href="https://fonts.googleapis.com/css?family=Noto+Serif+KR:600|Poiret+One&display=swap" rel="stylesheet">
	<link href="../css/main.css" rel="stylesheet">
<style type="text/css">
			#wrap{
				width: 971px;
				text-align: left;
				margin: 0 auto 0 auto;
				min-height: 750px;
				height: 1000px;
				background-image: url(../images/shadow.png);
				background-repeat-x : no-repeat;
				background-repeat-y : repeat;
			}
			#table_search{
				padding-left : 360px;
				padding-top : 20px;
			}
			table#galleryTable {
				width: 800px;
				table-layout: fixed;
				padding-left : 200px;
				padding-top : 150px;
				display: table;
				border-spacing: 2px;
 			}
			table#fileTable{
				width: 800px;
				table-layout: fixed;
				padding-left : 200px;
				padding-top : 30px;
				display: table;
				border-spacing: 2px;
			}
			#holder{
				width:200px;
				height:100px;
			}
</style>
<%
	String nickname = (String)session.getAttribute("nickname");
	String email = (String)session.getAttribute("email");
	if(nickname == null || email == null){
%>
	<script>
		location.href="../member/login.jsp";
	</script>
<%
	}
%>
<script type="text/javascript">
$(function() {
    $("#imgInput").on('change', function(){
        readURL(this);
    });
});

function readURL(input) {
    if (input.files) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#holder').attr('src', e.target.result);
        }

      reader.readAsDataURL(input.files[0]);
    }
}
</script>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
	<!-- enctype="multipart/form-data" -->
		<form action="galleryWritePro.jsp" method="post" enctype="multipart/form-data" >
			<table id="galleryTable">

				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value="<%= email %>" readonly></td>
				</tr>
				<tr>
					<td>별명</td>
					<td><input type="text" name="nickname" value="<%= nickname %>" readonly></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd" required></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" required></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td><textarea rows="13" cols="40" name="content"></textarea> </td>
				</tr>
				<tr>
					<td>이미지 등록</td>
					<td><input type="file" name="file" id="imgInput" required></td>
					<td><img id="holder" src="#" ></td>
				</tr>											
			</table>
			
			<div id="table_search">
				<input type="submit" value="글쓰기" class="btn"> 
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글목록" class="btn" 
					   onclick="location.href='gallery.jsp'">
			</div>
			</form>
 -->	</article>
	</div>
  </body>
</html>
