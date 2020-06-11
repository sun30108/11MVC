<%@ page contentType="text/html; charset=euc-kr"%>

<html>
<head>

<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 50px;
        }
   	</style>

<!-- jQuery, bootstrap -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css" >
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" ></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<script type="text/javascript">

$(function(){
	$("button:contains('구매')").on("click", function(){
		var prodNo = $("#prodNo").text().trim()
		location.href = "/purchase/addPurchase?prodNo="+prodNo
	})
})

$(function(){
	$("button:contains('이전')").on("click", function(){
		history.go(-1)		
	})
})

</script>


<title>Insert title here</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- 툴바 -->
<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

	<div class="page-header">
	    <h3 class=" text-info">상품상세조회</h3>
	</div>

<form name="detailForm">
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
		<div class="col-xs-8 col-md-4" id="prodNo">${product.prodNo}</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodName }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
		<div class="col-xs-8 col-md-4">
		<img src="../images/uploadFiles/${product.fileName }"></div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodDetail }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
		<div class="col-xs-8 col-md-4">${product.manuDate }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
		<div class="col-xs-8 col-md-4">${product.price }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
		<div class="col-xs-8 col-md-4">${product.regDate }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-md-12 text-center ">
			<button type="button" class="btn btn-primary">구매</button>
			<button type="button" class="btn btn-primary">이전</button>
		</div>
	</div>

</form>

</div>



</body>
</html>