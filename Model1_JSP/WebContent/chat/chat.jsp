<%@page import="chat.ChatDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>채팅</title>
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
			#frame{
				padding-top: 300px;
				padding-left: 180px;
				overflow: hidden;
			}
			#chatuserTable{
				
			}
			#chatuserForm{
				margin-left: 300px;
				margin-top: 10px;
			}
			#redCircle{
				width:15px;
				height:15px;
			}


</style>
<%
	String email = (String)session.getAttribute("email");
	String nickname = (String)session.getAttribute("nickname");
	if(email == null || nickname == null){
%>
		<script>
			location.href="../member/login.jsp";
		</script>
<% 
	}
	if("방문(카카오)".equals(email)){
	%>
		<script>
			window.alert("방문(카카오)계정 채팅 불가");
			location.href="../index.jsp";
		</script>
	<% 
	}
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
</script>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
	<%
		MemberDAO mDao = new MemberDAO();
		ChatDAO cDao = new ChatDAO();
		String toID = email;
	//	세션에서 얻어온 로그인 한 사람의 이메일을 매개변수로 전달하여 자신을 제외한 다른 사람들의 아이디를 조회
		ArrayList<MemberBean> arr = mDao.memberCheck(email);
		for(int i = 0 ; i < arr.size() ; i++){
			MemberBean mBean = arr.get(i);
			int chatSize = cDao.chatSizeCheck(email, mBean.getEmail());
	// 유저별 읽음 체크
			int chatUserReadCheck = cDao.chatUserReadCheck(toID, mBean.getEmail());
			
	%>
		<form action="userChat.jsp" id="chatuserForm" name="chatuserForm" method="post">
			<table id="chatuserTable">
				<tr>
					<td><%= mBean.getNickname() %></td>
					<td>[ <%= mBean.getName() %> ]</td> 
					<td>( <%= mBean.getEmail() %> )</td>
					<td> 채팅 메세지 : <%= chatSize %> </td>
					<td><input type="hidden" value="<%= mBean.getNickname() %>" name="selNickname"></td>
					<td><input type="hidden" value="<%= mBean.getName() %>" name="selName"></td>
					<td><input type="hidden" value="<%= mBean.getEmail() %>" name="selEmail"></td>
					<td><input type="submit" value="메세지" name="chatBtn"></td>
	<%
					if(chatUserReadCheck > 0){
	%>
					<td><img src="../images/redcircle.png" id="redCircle"></td>
	<%
					}
	%>
				</tr>	
			</table>
		</form>	
	<%		
		}
	%>
			

	</article>
	</div>
  </body>
</html>
