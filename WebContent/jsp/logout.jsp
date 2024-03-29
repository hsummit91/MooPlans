<%@ page import="java.io.*,java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="refresh" content="0; url=../index.html" />
<title>Logged Out</title>
<style type="text/css">
@-webkit-keyframes up {
  0%, 100% {
    transform: rotate(0);
  }
  50% {
    transform: rotate(-30deg);
  }
}
@-moz-keyframes up {
  0%, 100% {
    transform: rotate(0);
  }
  50% {
    transform: rotate(-30deg);
  }
}
@-o-keyframes up {
  0%, 100% {
    transform: rotate(0);
  }
  50% {
    transform: rotate(-30deg);
  }
}
@keyframes up {
  0%, 100% {
    transform: rotate(0);
  }
  50% {
    transform: rotate(-30deg);
  }
}
@-webkit-keyframes down {
  0%, 100% {
    transform: rotate(0);
  }
  50% {
    transform: rotate(30deg);
  }
}
@-moz-keyframes down {
  0%, 100% {
    transform: rotate(0);
  }
  50% {
    transform: rotate(30deg);
  }
}
@-o-keyframes down {
  0%, 100% {
    transform: rotate(0);
  }
  50% {
    transform: rotate(30deg);
  }
}
@keyframes down {
  0%, 100% {
    transform: rotate(0);
  }
  50% {
    transform: rotate(30deg);
  }
}
@-webkit-keyframes r-to-l {
  100% {
    margin-left: -1px;
  }
}
@-moz-keyframes r-to-l {
  100% {
    margin-left: -1px;
  }
}
@-o-keyframes r-to-l {
  100% {
    margin-left: -1px;
  }
}
@keyframes r-to-l {
  100% {
    margin-left: -1px;
  }
}
body {
  background: #000;
  overflow: hidden;
  margin: 0;
}
body .pacman:before, body .pacman:after {
  content: '';
  position: absolute;
  background: #FFC107;
  width: 100px;
  height: 50px;
  left: 50%;
  top: 50%;
  margin-left: -50px;
  margin-top: -50px;
  border-radius: 50px 50px 0 0;
  -webkit-animation: up 0.4s infinite;
  -moz-animation: up 0.4s infinite;
  -o-animation: up 0.4s infinite;
  animation: up 0.4s infinite;
}
body .pacman:after {
  margin-top: -1px;
  border-radius: 0 0 50px 50px;
  -webkit-animation: down 0.4s infinite;
  -moz-animation: down 0.4s infinite;
  -o-animation: down 0.4s infinite;
  animation: down 0.4s infinite;
}
body .dot {
  position: absolute;
  left: 50%;
  top: 50%;
  width: 10px;
  height: 10px;
  margin-top: -5px;
  margin-left: 30px;
  border-radius: 50%;
  background: #ccc;
  z-index: -1;
  box-shadow: 30px 0 0 #ccc, 60px 0 0 #ccc, 90px 0 0 #ccc, 120px 0 0 #ccc, 150px 0 0 #ccc;
  -webkit-animation: r-to-l 0.4s infinite;
  -moz-animation: r-to-l 0.4s infinite;
  -o-animation: r-to-l 0.4s infinite;
  animation: r-to-l 0.4s infinite;
}

</style>
<script type="text/javaScript">
	function disableBackButton() {
		window.history.forward();
	}
	setTimeout("disableBackButton()", 0);
	
	function redirect(){
		window.location.replace("../index.html");
	}
</script>
</head>
<body onload="redirect();disableBackButton()">
<div class="pacman"></div>
<div class="dot"></div>
</body>
</html>