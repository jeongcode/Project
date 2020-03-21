<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp" %>
<c:set var="msg" value="${requestScope.msg}" />
<c:set var="qnaBean" value="${requestScope.qnaBean}" />
<c:set var="replyBean" value="${requestScope.replyBean}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>QnA</title>
<script type="text/javascript">

	$(function (){
		$("#rewriteBtnArea").hide();
		
		$("#rewriteBtn").click(function (){				// 수정 하기 버튼 클릭 시 수정 완료 , 수정 취소 버튼 활성화 , 수정 하기 버튼 비 활성화
			$("#rewriteBtnArea").show();
			$("#rewriteBtn").hide();
			$("#qnaTitle").attr("disabled",false);
			$("#qnaContent").attr("disabled",false);
		});
		
		$("#rewriteCancelBtn").click(function (){		// 수정 취소 버튼 클릭 시 수정 완료 , 수정 취소 버튼 비 활성화 , 수정 하기 버튼 활성화
			$("#rewriteBtnArea").hide();
			$("#rewriteBtn").show();
			$("#qnaTitle").attr("disabled",true);
			$("#qnaContent").attr("disabled",true);
			$("#qnaTitle").val('${qnaBean.title}');
			$("#qnaContent").val('${qnaBean.content}');
		});
		
		$("#rewriteSubmitBtn").click(function(){
			$("#qnaTitle").attr("disabled",true);
			$("#qnaContent").attr("disabled",true);
			$("#rewriteBtnArea").hide();
			$("#rewriteBtn").show();
	    	$.ajax({
	    		type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
	            url:"${contextPath}/qnaRewrite.bo",//요청할 서블릿의 매핑주소 또는 JSP의 주소 
	            data:{"idx" : '${qnaBean.idx}',
	            	  "title" : $("#qnaTitle").val(),
	            	  "content" : $("#qnaContent").val()},//서블릿 또는 JSP페이지로 요청할 데이터 설정
	            success:function(result){
	           		if(result == 1){
	           			alert("수정 완료");
	           		}
	            }
			});
		});
		
		$("#deleteBtn").click(function (){
			location.href = "${contextPath}/qnaDelete.bo?idx=" + '${qnaBean.idx}';			
		});

		$("#replyDelBtn").click(function (){
			location.href = "${contextPath}/replyDelete.bo?idx=" + '${qnaBean.idx}';			
		});
		
		
		if('${msg}'){
			alert('${msg}');
		}
	});
</script>
<style type="text/css">
	#articleForm {
		font-family: sans-serif; 
		font-size: 25px; 
		color: teal;
		margin-top: 50px;
		}
	#btnArea{
		margin-left: 1500px;
	}
</style>
</head>
<body>
		<form id="articleForm">
			<table class="table" id="notice" style="margin-left:auto; margin-right:auto; width:80%; text-align:center; font-size: 20px;" >
				<tr>
					<td style="border-top: none; width:25%; text-align:left;"><b>문의No.</b></td>
					<td style="border-top: none; width:25%; text-align: left; margin-left: 90px;">${qnaBean.idx}</td>
				</tr>
				<tr>
					<td style="text-align:left;"><b>고객명</b></td>
					<td style="text-align: left; margin-left: 90px;">${qnaBean.nickname}</td>
					<td style="width:30px;"><b>문의일</b></td>
					<td style="width:30px; text-align:left;">${qnaBean.writedate}</td>
				</tr>		
				<tr>
					<td style="width:30px%; text-align:left;"><b>문의사항</b></td>
					<td colspan="3" style="text-align:left;"><input type="text" name="qnaTitle" id="qnaTitle" value="${qnaBean.title}" disabled style="width:100%; border: none; text-align: left; background-color: #ffffff;" ></td>
				</tr>	
				<tr>
					<td style="width:30px; text-align:left;"><b>문의내용</b></td>
					<td colspan="3">
						<textarea rows="15" cols="100" name="qnaContent" id="qnaContent" disabled style="padding-left:0px; padding-right:30px; text-align: left; border:none; width:102%; height: 300px; background-color:#ffffff;">${qnaBean.content}</textarea>
					</td>
				</tr>				
			</table>
			<div id="btnArea">
				<c:if test="${qnaBean.admincheck ne '1' && qnaBean.email eq sessionEmail}">
					<input type="button" class="btn btn-primary" id="rewriteBtn" value="수정하기">
				</c:if>
				<div id="rewriteBtnArea">
					<input type="button" class="btn btn-primary" id="rewriteSubmitBtn" value="수정완료">
					<input type="button" class="btn btn-primary" id="rewriteCancelBtn" value="수정취소">
				</div>
				<c:if test="${qnaBean.nickname eq sessionNickname && qnaBean.email eq sessionEmail}">
					<input type="button" class="btn btn-primary" id="deleteBtn" value="문의내역 삭제하기">
				</c:if>
			</div>
			
		<c:if test="${replyBean ne null}">
			<p style="text-align: left; margin-left: 400px;">답변 내용 &nbsp;  [ ${replyBean.writedate} ]</p>
			<textarea class="form-control" rows="15" cols="100" style="margin-left: 400px; width: 1000px;" disabled>${replyBean.content}</textarea>
			<c:if test="${sessionNickname eq '관리자' }">
				<input class="btn btn-primary" type="button" id="replyDelBtn" value="답변 삭제" style="margin-left: 400px;"/>
			</c:if>
		</c:if>
		</form>
				
		<c:if test="${qnaBean.admincheck ne '1' && sessionNickname eq '관리자'}">
			<form id="articleForm" action="${contextPath}/replyWrite.bo" method="post">
				<input type="hidden" name="idx" value="${qnaBean.idx}">
				<p  style="text-align: left; margin-left:400px;">문의사항에 답변 드립니다.</p>
				<textarea class="form-control" rows="15" cols="100" placeholder="답변 내용" id="replyTextArea" name="replyTextArea" style="margin-left: 400px; width: 1000px;" ></textarea>
				<input type="submit" value="답변 작성" class="btn btn-primary" style="margin-left: 400px;">
			</form>
		</c:if>
		
</body>
</html>