<%@ page language="java" contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp"%>
<c:set var="qnaList" value="${requestScope.qnaList}"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		function qnaInfo(idx){
			location.href= "${contextPath}/qnaInfo.bo?idx=" + idx;
		}
	</script>
	<title>QnaList</title>
</head>
<body>
	<br>
	<div class="container">
			<table class="table table-hover" style="text-align: center;">
				<thead>
					<tr>
						<th style="background-color: #dddddd; text-align: center;">작성자</th>
						<th style="background-color: #dddddd; text-align: center;">제목</th>
						<th style="background-color: #dddddd; text-align: center;">작성일</th>
						<th style="background-color: #dddddd; text-align: center;">답변 유무</th>
						<th style="background-color: #dddddd; text-align: center;">바로 가기</th>
					</tr>
				</thead>
				<tbody id="qnaListTable">
					<c:choose>
						<c:when test="${qnaList.size() eq 0}">
							<tr>
								<td colspan="5"> 작성한 문의내역이 없습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="qnaBean" items="${qnaList}">
								<tr>
									<td>${qnaBean.nickname}</td>
									<td>${qnaBean.title}</td>
									<td>${qnaBean.writedate}</td>
									<td>
									<c:choose>
										<c:when test="${qnaBean.admincheck eq 1}">
											<p style="color: green; font-family: bold;"> 답변 완료 </p>
										</c:when>
										<c:otherwise>
											<p style="color: red; font-family: bold;"> 답변 미완료 </p>
										</c:otherwise>
									</c:choose>
									</td>
									<td>
										<input type="button" class="btn btn-primary" value="바로가기" onclick="qnaInfo('${qnaBean.idx}');" >
			 						</td>
								</tr>
							</c:forEach>						
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
	</div>
</body>
</html>