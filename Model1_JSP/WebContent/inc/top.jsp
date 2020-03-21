<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>
	#redCircle{
		width:15px;
		height:15px;
	}
</style>	
		<% 
			String readCheck = (String)session.getAttribute("read");
			String nickname = (String)session.getAttribute("nickname");
			if(nickname == null){
		%>
				<div id="loginjoinbox">
					<a href="../index.jsp" id="lojo"> HOME </a><br>
					<a href="../member/login.jsp" id="lojo"> LOGIN </a><br> 
					<a href="../member/resistration.jsp" id="lojo"> JOIN </a>
				</div>
		<%		
			}
			else{
		%>		
				<div id="loginjoinbox">
					<a href="#" id="lojo"> <%= nickname %> 님 환영합니다 </a><br>
					<a href="../index.jsp" id="lojo"> HOME </a><br>
					<a href="../member/logoutPro.jsp" id="lojo"> LOGOUT </a><br>
				<!-- 마이페이지 구현 요망 -->
					<a href="../member/mypagePassCheck.jsp" id="lojo"> MY PAGE</a>
				</div>
		<%		
			}
		%>
				<div class="clear"></div>
				<nav id="topmenu">
					<ul>
						<li><a href="../board/board.jsp">게시판</a></li>
						<li><a href="../notice/notice.jsp">공지사항</a></li>
						<li><a href="../gallery/gallery.jsp">갤러리</a></li>
						<li id="chat"><a href="../chat/chat.jsp">채팅
				<%			
							if("NOREAD".equals(readCheck)){
				%>
							<img id="redCircle" src="../images/redcircle.png">
				<%	
							}
				%>
					</a>
					</li>
				</nav>
		
