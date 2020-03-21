<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css?family=Noto+Serif+KR:600|Poiret+One&display=swap" rel="stylesheet">
<link href="../css/main.css" rel="stylesheet">
<title>Insert title here</title>

</head>
<body>
	<div id="imagewrap">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		<article>
			<form action="mypagePassCheckPro.jsp" method="post" id="loginForm">
				<table id="lojo">
					<tr>
				<%
					String email = (String)session.getAttribute("email");
					String nickname = (String)session.getAttribute("nickname");
					if( nickname == null){
				%>	
						<script>
							window.alert("로그인하여 주세요");
							location.href="login.jsp";
						</script>
				<% 		
					}	
					else if("방문(카카오)".equals(email)){
						%>
						<script>
							window.alert("방문(카카오)계정 수정 불가");
							location.href="../index.jsp";
						</script>
					<% 
					}
					else{
				%>
						<td>비밀번호 : <input type="password" name="passwd"><br></td>
						<td><input type="submit" value="확인"></td>
				<% 
					}
				%>
					</tr>
				</table>
			</form>
		</article>
	</div>
</body>
</html>