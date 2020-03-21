<%@ page language="java" contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="paymentList" value="${requestScope.paymentList}"/>
<c:set var="paymentListSize" value="${requestScope.paymentListSize}"/>
<c:set var="qnaList" value="${requestScope.qnaList}"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
	<script type="text/javascript">
		function qnaInfo(idx){
			location.href= "${contextPath}/qnaInfo.bo?idx=" + idx;
		}
		
		function roundtripShow(index){
			for(var i = 0 ; i < '${paymentListSize}' * 1 ; i++){
				if(i == (index *  1)){
					$("#roundtrip"+index).show();
					$("#showBtn"+index).hide();
					$(".row"+index).attr("rowspan","2");
 					$(".row"+index).attr("style","vertical-align: middle;");
				}
				else{
					$("#roundtrip"+i).hide();
					$("#showBtn"+i).show();
					$(".row"+i).attr("rowspan","1");
				}
			}
		}
		
		$(function (){
			for(var i = 0 ; i < '${paymentListSize}' * 1 ; i++){
				$("#roundtrip"+i).hide();
			}
		});
	</script>
	<title>Unread List</title>
</head>
<body>
	<br>
		<div class="container">
			<table class="table" style="text-align: center;">
				<thead>
					<tr>
						<th style="background-color: #dddddd; text-align: center;">편도 / 왕복</th>
						<th style="background-color: #dddddd; text-align: center;">항공사</th>
						<th style="background-color: #dddddd; text-align: center;">출발 공항</th>
						<th style="background-color: #dddddd; text-align: center;">도착 공항</th>
						<th style="background-color: #dddddd; text-align: center;">날짜 및 시간</th>
						<th style="background-color: #dddddd; text-align: center;">요금</th>
						<th style="background-color: #dddddd; text-align: center;">총 요금</th>
						<th style="background-color: #dddddd; text-align: center;">결제일</th>
						<th style="background-color: #dddddd; text-align: center;">포인트</th>
						<th style="background-color: #dddddd; text-align: center;">더 보기</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${paymentListSize eq 0}">
							<tr>
								<td colspan="10"> 읽지 않은 결제내역이 없습니다 </td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="paymentBean" items="${paymentList}" varStatus="i">
								<c:choose>
									<c:when test="${paymentBean.tripkind eq 'one_way'}">
										<tr>
											<td>편도</td>
											<td>${paymentBean.oneway_airlinenm}</td>
											<td>${paymentBean.oneway_depairportnm}</td>
											<td>${paymentBean.oneway_arrairportnm}</td>
											<td>${paymentBean.oneway_depdatetime}</td>
											<td>￦<fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentBean.oneway_charge}"/></td>
											<td>￦<fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentBean.totalcharge}"/></td>
											<td>${paymentBean.paymentdate}</td>
											<td>+ ￦<fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentBean.paymentpoint}"/></td>
											<td></td>	
										</tr>							
									</c:when>
									<c:otherwise>
										<tr>
											<td class="row${i.index}">왕복</td>
											<td>${paymentBean.oneway_airlinenm}</td>
											<td>${paymentBean.oneway_depairportnm}</td>
											<td>${paymentBean.oneway_arrairportnm}</td>
											<td>${paymentBean.oneway_depdatetime}</td>
											<td>￦<fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentBean.oneway_charge}"/></td>
											<td class="row${i.index}">￦<fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentBean.totalcharge}"/></td>
											<td class="row${i.index}">${paymentBean.paymentdate}</td>
											<td class="row${i.index}">+ ￦<fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentBean.paymentpoint}"/></td>
											<td class="row${i.index}"><i class="fas fa-angle-down" id="showBtn${i.index}" onclick="roundtripShow('${i.index}');"></i></td>
										</tr>
										<tr id="roundtrip${i.index}">
											<td>${paymentBean.roundtrip_airlinenm}</td>
											<td>${paymentBean.roundtrip_depairportnm}</td>
											<td>${paymentBean.roundtrip_arrairportnm}</td>
											<td>${paymentBean.roundtrip_arrdatetime}</td>
											<td>￦<fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentBean.roundtrip_charge}"/></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>						
			</table>
		</div>
		
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
								<td colspan="5"> 읽지 않은 문의내역이 없습니다</td>
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