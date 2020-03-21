<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function userCheck(){

		var boardPasswd = document.reWritePassChkForm.boardPasswd.value;
		var originPasswd = opener.document.boardForm.originPasswd.value;
		if(boardPasswd == originPasswd){
			window.alert("비밀번호 동일");
			window.close();
			location.href = "boardReWrite.jsp";
		}
 	}
</script>
</head>
<body>
	<form name="reWritePassChkForm">
		<table>
			<tr>
				<td> 비밀번호 : <input type="text" placeholder="비밀번호 재입력" name="boardPasswd" required></td>
				<td> <input type="button" value="확인" onclick="userCheck()"> </td>
				<td> <input type="button" value="닫기" onclick="window.close()"> </td>
			</tr>
		</table>
	</form>

</body>
</html>