<%@page import="gallery.GalleryBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>회원가입</title>
	<script language="javascript" src="//code.jquery.com/jquery-3.4.1.min.js"></script>
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
				table-layout: auto;
				padding-left : 200px;
				padding-top : 150px;
				display: table;
				border-spacing: 2px;
 			}
			div#comment{
				width: 800px;
				table-layout: fixed;
				padding-left : 200px;
			}
			div#comment>textarea{
				margin-left : 50px;
			}
			div#comment>input{
				margin-top : 10px;
				margin-left: 90px;
			}
			#commentDelBtn{
				margin-right: 80px;
			}
			#image{
				width: 500px;
				height : 300px;
			}
			#f{
				padding-left : 50px;
			}
</style>
<%
	request.setCharacterEncoding("UTF-8");
	String nickname = (String)session.getAttribute("nickname");
	String email = (String)session.getAttribute("email");
	if(nickname == null || email == null){
%>
	<script>
		location.href="../member/login.jsp";
	</script>
<%
	}
	GalleryBean gBean = (GalleryBean)request.getAttribute("gBean");
	int num = gBean.getNum();
	String writerEmail = gBean.getEmail();
	String passwd = gBean.getPasswd();
	String writerNickname = gBean.getNickname();
	String subject = gBean.getSubject();
	String content = gBean.getContent();
	String file = gBean.getFile();
	
	String realPath = request.getContextPath();

%>
<script type="text/javascript">
	function galleryOwnDel(){
	<%
		if(!writerEmail.equals(email)){
			%>
				window.alert("자신의 글이 아닙니다");
			<%
		}
		else{
			%>
			var boardPasswd = document.galleryForm.galleryPasswd.value;
				if(boardPasswd == <%= passwd %>){
					var form = document.galleryForm;
					form.method = "post";
					form.action = "galleryDelPro.jsp"
					form.submit();
				}
				else{
					window.alert("비밀번호가 틀렸습니다");
				}
			<%
		}
	%>
	
	}
	function galleryOwnMod(){
		<%
		if(!writerEmail.equals(email)){
			%>
				window.alert("자신의 글이 아닙니다");
			<%
		}
		else{
			%>
			var boardPasswd = document.galleryForm.galleryPasswd.value;
				if(boardPasswd == <%= passwd %>){
					var form = document.galleryForm;
					form.method = "post";
					form.action = "galleryReWrite.jsp?num=<%=num%>";
					form.submit();
				}
				else{
					window.alert("비밀번호가 틀렸습니다");
				}
			<%
		}
	%>
	}
</script>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
		<form action="#" method="post" name="galleryForm" id="galleryForm">
			<table id="galleryTable">

				<tr>
					<td>이메일</td>
					<td id="f"><input type="text" name="email" value="<%= writerEmail %>" readonly></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td id="f"><input type="text" name="nickname" value="<%= writerNickname %>" readonly></td>
				</tr>				
				<tr>
					<td>글제목</td>
					<td id="f"><input type="text" name="subject" value="<%= subject %>" readonly></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td id="f"><textarea rows="13" cols="40" name="content" readonly><%= content %></textarea> </td>
				</tr>
				<tr>
					<td><a href="galleryDownPro.jsp?file=<%= gBean.getFile() %>">이미지</a></td>
					<td id="f"><img src="<%=realPath %>/upload/<%=gBean.getFile() %>" id="image"> </td>
				</tr>
			</table>
			<div id="table_search">
			<input type="button" value="글 삭제" class="btn"
						onclick="galleryOwnDel()">
				<input type="button" value="글 수정" class="btn"
						onclick="galleryOwnMod()"> 
				<input type="hidden" value="<%= num %>" name="num">
				<input type="hidden" value="<%= file %>" name="originFile">
				<input type="password" value="" placeholder="게시글 비밀번호 입력" name="galleryPasswd" required>
				<br>
				<input type="button" value="글 목록" class="btn" 
					 	onclick="location.href='gallery.jsp'">
			</div>
		</form>	
	</article>
	</div>
  </body>
</html>
