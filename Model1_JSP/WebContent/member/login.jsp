<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=chorme"/>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Noto+Serif+KR:600|Poiret+One&display=swap" rel="stylesheet">
<link href="../css/main.css" rel="stylesheet">
<title>Insert title here</title>
<style type="text/css">
	td{
		font-size: 1.2em;
	}
	input{
		font-size: 1.0em;
	}
</style>
</head>
<body>
	<div id="imagewrap">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>

	<form action="loginPro.jsp" method="post" id="loginForm">
		<table id="lojo">
			<tr>
				<td> Email </td>
				<td><input type="email" name="useremail" required></td>
			</tr>
			<tr>
				<td> Password </td>
				<td><input type="password" name="userpasswd" required></td>
			</tr>
			<tr>
				<td><input type="submit" value="login"></td>
			</tr>
			<tr>	
					<td><img id="kakao-login-btn" src="../images/kakao_login_btn_small.png" style="cursor: pointer"></td>
					<td><a href="http://developers.kakao.com/logout"></a></td>
			</tr>
		</table>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('04e5f9977ea3d35053cd0376d061d424');
    // 카카오 로그인 버튼을 생성합니다.
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
        Kakao.API.request({
        	url:'/v1/user/me',
        	success:function(res){
/* 		        alert(JSON.stringify(authObj));
	        	alert(JSON.stringify(res));
 */	        	console.log(res.id);
	        	console.log(res.properties['nickname']);
	        	console.log(authObj.access_token);
				location.href="loginPro.jsp?kakaoAuth=yes";
			}
        })
      },
      fail: function(err) {
         alert("로그인 실패");
      }
    });
  //]]>
</script>
	</form>
	</div>
</body>
</html>