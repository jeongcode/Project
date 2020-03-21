<%@page import="board.CommentDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>게시판</title>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
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
			table#boardTable {
				width: 800px;
				table-layout: auto;
				padding-left : 200px;
				padding-top : 150px;
				display: table;
				border-spacing: 2px;
 			}
			.pageDiv{
				padding-top: 20px;
				margin-left: 430px;
			}
			.pageDiv a{
				margin-left: 10px;
				font-size: 1.5em;
			}
			.tno{
				width : 70px;
			}

			
</style>
<script type="text/javascript">
<% 
	BoardDAO bDao = new BoardDAO();	
	BoardBean bBean = new BoardBean();
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "0";
	}
	int currentPage = Integer.parseInt(pageNum);	
%>
function boardSearch(){
	var sel = document.getElementById("selectVal");
	var searchVal = document.getElementById("searchVal");
	var val = sel.options[selectVal.selectedIndex].value;
}
</script>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
			<table id="boardTable">
				<%
				int boardSize = bDao.boardSizeCheck();
				%>
				<tr>
					<td colspan="4">게시글 수 : <%= boardSize %> </td>
				</tr>
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>

				<%
				//currentPage = 넘겨 받는 페이지 쪽 수
				//boardSize = 게시판 총 글 수
				//size = 한 페이지에 출력할 글 수
				//transPage = 게시판 총 글 수의 size로 나눈 값 (SQL 리스트 검색 시 시작 번호를 지정할 값)
					int size = 10;
					int transPage = 0;
					if(currentPage > 1){
						transPage = (boardSize / size);
						for(int i = 0 ; i < transPage ; i++){
							currentPage += 9;
						}
					}
					else{
						currentPage = (currentPage > 0 ?  +10 : 0 );
					}
					ArrayList<BoardBean> arr = bDao.boardListCheck(currentPage,size);
					if(arr.size() == 0){
				%>
					<tr>
						<td></td>
						<td rowspan="4"> 게시글이 없습니다 </td>
					</tr>
				<% 
					}
					else{
					CommentDAO cDao = new CommentDAO();
					for(int i = 0 ; i < arr.size() ; i++){
						BoardBean checkBean = arr.get(i);
						int num = checkBean.getNum();
						int commentSize = cDao.commentSizeCheck(num);
		// board list 체크 할 시 board 테이블과 reply 테이블을 union을 사용하여 
		// reg_lev가 0이면 기본 게시글로 처리 하고 0 이상이면 답글로 처리한다
						if(checkBean.getReg_lev() == 0){
				%>
					<tr>					
						<td> <%= num %></td>
						<td class="left"> <a href="boardIntoPro.jsp?num=<%= num %>"><%= checkBean.getSubject() %> &nbsp;[<%=commentSize%>] </a></td>
						<td> <%= checkBean.getNickname() %> </td>
						<td> <%= new SimpleDateFormat("yyyy/MM/dd").format(checkBean.getDate()) %> </td>
						<td> <%= checkBean.getReadcount() %> </td>
					</tr>
				<% 		
						}
						else{
							int reg_lev = checkBean.getReg_lev();
				%>
					<tr>
						<td></td>
						<td class="left"><img src="../images/level.gif"><img src="../images/re.gif"> <a href="replyIntoPro.jsp?num=<%= num %>&lev=<%= reg_lev %>"><%= checkBean.getSubject() %> </a></td>
						<td> <%= checkBean.getNickname() %> </td>
						<td> <%= new SimpleDateFormat("yyyy/MM/dd").format(checkBean.getDate()) %> </td>
						<td> <%= checkBean.getReadcount() %> </td>
					</tr>
				<%
						 }
						}
					}
				%>
				
			</table>
			<form id="table_search" action="boardSearch.jsp" method="post">
				<select id="selectVal" name="selectVal">
					<option value="subject">제목</option>
					<option value="nickname">별명</option>
				</select>
				<input type="text" id="searchVal" name="searchVal" class="input_box" required> 
				<input type="submit" value="검색" class="btn">
			<%
				String email = (String)session.getAttribute("email");	
				String nickname = (String)session.getAttribute("nickname");
				if(email != null && nickname != null && !"방문(카카오)".equals(email)){
			%>
				<input type="button" value="글 쓰기" onclick="location.href='boardWrite.jsp'">
			<%
				}
				//currentPage = 넘겨 받는 페이지 쪽 수
				//boardSize = 게시판 총 글 수
				//size = 한 페이지에 출력할 글 수
				//divPage = 출력할 페이지 쪽 수
				int divPage = 0 ;
				for(int i = 0 ; i < boardSize / size + 1 ; i++){
					divPage++;
				}
			%>
			</form>
			<div class="clear"></div>
			<div class="pageDiv">
			<% 
					if(divPage > 0){
						for(int i = 1 ; i <= divPage ; i++){
			%>
							<a href="board.jsp?pageNum=<%= i-1 %>"><%= i %></a>
			<%
						}
					}
			%>
			</div>
			
		</article>
	
  </body>
</html>
