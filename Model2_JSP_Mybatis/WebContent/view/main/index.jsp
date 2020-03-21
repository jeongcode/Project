<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="msg" value="${requestScope.msg}" />
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css"/>

<title>ODE</title>


<script type="text/javascript">
	/* 필수값 체크 */
	function Check() {
		if( !$("#depAirportNm").val() ){											// 출발지 미선택
			alert("출발지를 선택해주세요.");
			
		}else if( !$("#arrAirportNm").val() ){										// 도착지 미선택
			alert("도착지를 선택해주세요.");
			
		}else if( !$("#depPlandTime").val() ){										// 가는날 미선택
			alert("가는날을 선택해주세요.");
		
		}else if($('#roundTrip').is(':checked')  && !$("#dep2PlandTime").val() ){	// 오는날 미선택
			alert("오는날 선택해주세요.");
		
		}else if($("#depPlandTime").val() > $("#dep2PlandTime").val()){				// 오는날이 가는날보다 빠를 경우
			alert("오는날이 가는날보다 빠를 수 없습니다.\n다시 선택해주세요.");
		
		}else{																		// submit
		
			$('#loading').show();	// 페이지 전송전까지 로딩바 실행
			
			setTimeout(function() {
				fr.submit();
			}, 500);
			
		}
	}
	
	/* 출발지 도착지 바꾸기 */
	function typeChange() {
		
		var dep = document.getElementById('depAirportNm');
		var arr = document.getElementById('arrAirportNm');
		
		var temp = dep.value;
		dep.value = arr.value;
		arr.value = temp;
	}
	
	$(function() {
		$('#loading').hide();		// 로딩바 숨김
		
		
		$('#depPlandTime').datepicker({
		    format: "yyyy/mm/dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
		    startDate: '-10d',	//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
		    autoclose : true,	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
		    templates : {
		        leftArrow: '&laquo;',
		        rightArrow: '&raquo;'
		    }, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징 
		    showWeekDays : true ,// 위에 요일 보여주는 옵션 기본값 : true
		    todayHighlight : true ,	//오늘 날짜에 하이라이팅 기능 기본값 :false 
		    toggleActive : true,	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
		    
		});//datepicker end
		

		$("#roundTrip").click(function() {	// 왕복 클릭 시 오는날 datepicker 생성
			var addCal = document.getElementById("addCal");
			addCal.innerHTML = 	'<div class="col input-group mt-3">' +
									'<div class="input-group-prepend">' +
										'<label class="input-group-text"><i class="far fa-calendar-alt" style="font-size:23px"></i></label>' +
									'</div>' +
									'<input class="input-group form-control" type="text" id="dep2PlandTime" name="dep2PlandTime"' +
											'placeholder="오는날" autocomplete="off" readonly>' +
								'</div>';
								
			$("#dep2PlandTime").datepicker({
			    format: "yyyy/mm/dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
			    startDate: '-10d',	//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
			    autoclose : true,	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
			    templates : {
			        leftArrow: '&laquo;',
			        rightArrow: '&raquo;'
			    }, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징 
			    showWeekDays : true ,// 위에 요일 보여주는 옵션 기본값 : true
			    todayHighlight : true ,	//오늘 날짜에 하이라이팅 기능 기본값 :false 
			    toggleActive : true,	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
			}); // 오는날 datepicker ( * 동적으로 생성 시 생성 후 이벤트 호출해줘야함)
			
		});
		
		$("#oneWay").click(function() {		// 편도 클릭 시 오는날 datepicker 제거
			addCal.innerHTML = '';
		});
		
		/* 인원 선택 */
		$("#adultP").click(function() {		// 성인 +1
			var num = document.getElementById("adult").innerHTML;
			
			if(num < 9){
				document.getElementById("adult").innerHTML = Number(num) + 1;
			}
			
		});
		$("#adultM").click(function() {		// 성인 -1
			var num = document.getElementById("adult").innerHTML;
			
			if(num > 1){
				document.getElementById("adult").innerHTML = Number(num) - 1;
			}
		});
		$("#childP").click(function() {		// 유아 +1
			var num = document.getElementById("child").innerHTML;
			
			if(num < 9){
				document.getElementById("child").innerHTML = Number(num) + 1;
			}
		});
		$("#childM").click(function() {		// 유아 -1
			var num = document.getElementById("child").innerHTML;
			
			if(num > 0){
				document.getElementById("child").innerHTML = Number(num) - 1;
			}
		});
		
		if('${msg}'){
			alert('${msg}');
		}
	}); // function END
	
</script>

<style type="text/css">
/*******로딩바 CSS*******/
#loading {
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	position: fixed;
	display: block;
	opacity: 0.8;
	background: white;
	z-index: 99;
	text-align: center;
}
#loading > img {
	position: absolute;
	top: 25%;
	left: 37%;
	z-index: 100;
}
/*********************/
</style>

</head>
<body>
	<!-- 로딩바 -->
	<div id="loading">	
		<img src="../../images/airplane_loading.gif" alt="loading">
	</div>
	<!-- 로딩바 END -->

	<!-- 항공권 조회 -->
	<form action="${contextPath}/airplaneSearch.do" name="fr" id="fr">
		<div class="container p-5 m-auto bg-warning">
			<h1>ODE GANO</h1>
			<!-- 편도/왕복 선택 -->
			<div class="btn-group mb-3">
				<div class="custom-control custom-radio custom-control-inline">
					<input type="radio" id="oneWay" name="tourType" class="custom-control-input" checked>
					<label class="custom-control-label" for="oneWay">편도</label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input type="radio" id="roundTrip" name="tourType" class="custom-control-input" value="roundTrip">
					<label class="custom-control-label" for="roundTrip">왕복</label>
				</div>
			</div>
			<!-- 편도/왕복 선택 END -->
			<!-- 공항 및 날짜 선택 -->
			<div class="row row-cols-2">
				<!-- 출발지 -->
				<div class="col input-group">
					<div class="input-group-prepend">
						<label class="input-group-text">
						<i class='fas fa-plane-departure'></i></label>
					</div>
					<select class="custom-select" id="depAirportNm" name="depAirportNm">
						<option value="">출발지</option>
						<option value="NAARKJK">군산</option>
						<option value="NAARKJJ">광주</option>
						<option value="NAARKSS">김포</option>
						<option value="NAARKPK">김해</option>
						<option value="NAARKTN">대구</option>
						<option value="NAARKJB">무안</option>
						<option value="NAARKPS">사천</option>
						<option value="NAARKNY">양양</option>
						<option value="NAARKJY">여수</option>
						<option value="NAARKPU">울산</option>
						<option value="NAARKNW">원주</option>
						<option value="NAARKSI">인천</option>
						<option value="NAARKPC">제주</option>
						<option value="NAARKTU">청주</option>
						<option value="NAARKTH">포항</option>
					</select>
					
					<div class="input-group-prepend">
						<label class="btn input-group-text" onclick="typeChange()">
						<i class='fas fa-exchange-alt'></i></label>
					</div>
				</div>
				<!-- 도착지 -->
				<div class="col input-group">
					<div class="input-group-prepend">
						<label class="input-group-text">
						<i class='fas fa-plane-arrival'></i></label>
					</div>
					<select class="custom-select" id="arrAirportNm" name="arrAirportNm">
						<option value="">도착지</option>
						<option value="NAARKJK">군산</option>
						<option value="NAARKJJ">광주</option>
						<option value="NAARKSS">김포</option>
						<option value="NAARKPK">김해</option>
						<option value="NAARKTN">대구</option>
						<option value="NAARKJB">무안</option>
						<option value="NAARKPS">사천</option>
						<option value="NAARKNY">양양</option>
						<option value="NAARKJY">여수</option>
						<option value="NAARKPU">울산</option>
						<option value="NAARKNW">원주</option>
						<option value="NAARKSI">인천</option>
						<option value="NAARKPC">제주</option>
						<option value="NAARKTU">청주</option>
						<option value="NAARKTH">포항</option>
					</select>
				</div>
				<!-- 가는날 -->
				<div class="col input-group mt-3">
					<div class="input-group-prepend">
						<label class="input-group-text"><i class='far fa-calendar-alt' style='font-size:23px'></i></label>
					</div>
					<input class="input-group form-control" type="text" id="depPlandTime" name="depPlandTime" 
						   maxlength="20" placeholder="가는날" readonly>
				</div>
				<!-- 오는날 -->
				<div id="addCal"></div>
			</div>
			<!-- 공항 및 날짜 선택 END -->
			<div class="row row-cols-2">
				<!-- 인원 선택 -->
				<div class="col input-group mt-3">
					<div class="input-group-prepend">
						<label class="input-group-text">성인</label>
						<label id="adultP" class="input-group-text btn"><i class='fa fa-plus'></i></label>
						<label id="adult" class="input-group-text">1</label>
						<label id="adultM" class="input-group-text btn"><i class="fa fa-minus"></i></i></label>
						&nbsp;&nbsp;
						<label class="input-group-text">유아</label>
						<label id="childP" class="input-group-text btn"><i class='fa fa-plus'></i></label>
						<label id="child" class="input-group-text">0</label>
						<label id="childM" class="input-group-text btn"><i class="fa fa-minus"></i></i></label>
					</div>
				</div>
				<!-- 인원 선택 END -->
				<!-- 조회버튼 -->
				<div class="col mt-3 d-flex justify-content-end">
					<input type="button" class="btn btn-dark" value="항공권 검색" onclick="Check()">
				</div>
				<!-- 조회버튼 END -->
			</div>
		</div>
	</form>
	<!-- 항공권 조회 END -->
</body>
</html>










