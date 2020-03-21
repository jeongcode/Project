<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>회원가입</title>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<!-- 구글 폰트  -->
	<link href="https://fonts.googleapis.com/css?family=Noto+Serif+KR:600|Poiret+One&display=swap" rel="stylesheet">
	<link href="../css/main.css" rel="stylesheet"><script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
			#addForm{
				padding-left : 370px;
				padding-top : 170px;
			}
			input{
				font-size: 1.2em;
			}
			label{
				font-size: 1.2em;
			}
</style>

<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>

<script type="text/javascript">
	var passCheck = false;
	var emailCheck = false;
	var emailAuthCheck = false;
		function test(){
			window.alert(emailCheck);
			window.alert(passCheck);
		}		
		function allPassCheck(){
			if(passCheck == false){
				window.alert("비밀번호를 확인하여주세요");
				return false;
			}
			else if(document.addForm.name.value == ""){
				window.alert("이름을 입력 하여주세요");
				return false;
			}
			else if(document.addForm.nickname.value == ""){
				window.alert("별명을 입력 하여주세요");
				return false;
			}
			else if(document.addForm.postcode.value == ""){
				window.alert("주소를 검색 하여주세요");
				return false;
			}
			else if(document.addForm.tel.value == ""){
				window.alert("휴대폰 번호를 입력 하여주세요");
				return false;
			}
			else if(emailAuthCheck == false){
				window.alert("이메일 인증을 하여주세요");
				return false;
			}
			else{
				document.addForm.method = "post";
				document.addForm.action = "addPro.jsp";
				document.addForm.submit();
			}
		}
		//패스워드 확인
		function emailDuplChk(){
			$.ajax(
					{
						type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
						async:true,//비동기식으로 처리할지의 여부를 설정(false인경우 동기식으로 처리)
				  		url:"emailDuplCheckPro.jsp",//요청할 서블릿의 매핑주소 또는 JSP의 주소  		
				  		data:{"email" : $('#InputEmail').val() },//서블릿 또는 JSP페이지로 요청할 데이터 설정
				  		success:function(data){
								if($.trim(data) == "OK"){
									$("#emailCheckResult").css("color","green");
									$("#emailCheckResult").text("아이디 사용 가능");
									emailCheck = true;
								}			  			
								else{
									$("#emailCheckResult").css("color","red");
									$("#emailCheckResult").text("아이디 사용 불가");
									emailCheck = false;
								}
				  		}
					}
				  );
		}
		function pass_Check(){
			if($("#inputPassword1").val() != ""){
				if($("#inputPassword1").val() == $("#inputPassword2").val()){
					$("#passwdCheckResult").css("color","green");
					$("#passwdCheckResult").text("비밀번호 일치");
					passCheck= true;
				}
				else{
					$("#passwdCheckResult").css("color","red");
					$("#passwdCheckResult").text("비밀번호 불일치");
					passCheck= false;
				}
			}
		} 	
		// 공백 체크 후 제거
		function spaceCheck(obj){
			var text = $(obj).val().replace(/\s/gi,"");
			$(obj).val(text);
	    }
		//이메일 유효성 검사 후 이메일 인증번호 전송
		function emailTest(){
			var email = document.addForm.email.value;
			var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
			if (!getMail.test(email)) {
				window.alert("이메일 재입력");
				return false;
			}
			else{
				emailCheck = true;
				var screenW = screen.availWidth;
				var screenH = screen.availHeight;
				var popW = 500;
				var popH = 200;
				var posH = popW;
				var posW = (screenW-popW) / 2;
				var useremail = document.addForm.email.value;
				myWindow = window.open("emailAuthCheckPro.jsp?useremail="+useremail,"_blank",
						'location=no,toolbar=no,scrollbars=no,width='+ popW +',height=' + popH +',top=' + posH + ',left=' + posW );
			}
		}
		<%
			String nickname = (String) session.getAttribute("nickname");
			if(nickname != null){
		%>
			location.href="logoutPro.jsp";
		<%
			}
		%>
</script>
 </head>
  <body>
  <div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
   	 <article>
          <form role="form" action="addPro.jsp" id="addForm" name="addForm">
            <div>
              <label for="InputEmail">이메일 주소</label><br>
              <input type="text"  id="InputEmail" placeholder="이메일 주소" name="email" onblur="emailDuplChk()" onkeyup="spaceCheck(this);">
              <input type="button" name="emailChkBtn" onclick="emailTest();" value="이메일 인증"> <br>
              <span id="emailCheckResult"></span>
            </div>
            <div >
              <label for="InputPassword1">비밀번호</label><br>
              <input type="password" id="inputPassword1" placeholder="비밀번호" name="passwd" onkeyup="pass_Check();">
            </div>
            <div >
              <label for="InputPassword2">비밀번호 확인</label><br>
              <input type="password"  id="inputPassword2" placeholder="비밀번호 확인" name="passwd2" onkeyup="pass_Check();" >
           	  <br><span id="passwdCheckResult"> </span>
            </div>
            <div >
              <label for="username">이름</label><br>
              <input type="text"  id="name" placeholder="이름을 입력해 주세요" name="name" onkeyup="spaceCheck(this);">
            </div>
            <div >
              <label for="username">별명</label><br>
              <input type="text"  id="nickname" placeholder="별명을 입력해 주세요" name="nickname" onkeyup="spaceCheck(this);">
            </div>      
            <div>
              <label for="InputAddress">주소</label><br>
              <input type="text" id="postcode" name="postcode" placeholder="우편번호">
			  <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			  <input type="text" id="roadAddress" name="roadAddress" placeholder="도로명주소">
		      <input type="text" id="jibunAddress" name="jibunAddress" placeholder="지번주소">
			  <span id="guide" style="color:#999;display:none"></span><br>
			  <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
			  <input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목">
            </div>
            <div >
              <label for="username">휴대폰</label><br>
              <div >
                <input type="tel" id="tel" placeholder="- , 공백 없이 입력해 주세요" name="tel" onkeyup="spaceCheck(this);">
              </div>
            </div>
            <div >
            </div>
            <div>
            <br>
            <!-- TODO 회원가입시 모든 조건 사항 확인 함수 작성 -->
              <button type="button" onclick="allPassCheck()" >회원가입</button>
              <button type="button" onclick="location.href='../index.jsp'">가입취소</button>
            </div>
          </form>

	</article>
	</div>
  </body>
</html>
