<%@ page contentType="text/html; charset=euc-kr"%>

<html>
<head>
<title>구매상세조회</title>

<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 50px;
        }
   	</style>

<!-- jQuery, bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<script type="text/javascript">

$(function(){
	$("button:contains('확인')").on("click", function(){
		history.go(-1)
	})
	
	$("button:contains('수정')").on("click", function(){
		var tranNo = $(this).data("tranno")
		location.href = "/purchase/updatePurchase?tranNo="+tranNo
	})
	
	
})
</script>


</head>

<body bgcolor="#ffffff" text="#000000">

<!-- 툴바 -->
<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

	<div class="page-header">
	    <h3 class=" text-info">구매상세조회</h3>
	</div>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>물품번호</strong></div>
		<div class="col-xs-8 col-md-4" id="prodNo">${purchase.purchaseProd.prodNo }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>구매자아이디</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.buyer.userId }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>구매방법</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.paymentOption=='1  '? "현금구매" : "신용구매" }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>구매자이름</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.receiverName }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>구매자연락처</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.receiverPhone }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>구매자주소</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.divyAddr }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>구매요청사항</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.divyRequest }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>배송희망일</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.divyDate }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>주문일</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.orderDate }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-md-12 text-center ">
			<button type="button" class="btn btn-primary"  data-tranno="${purchase.tranNo}">수정</button>
			<button type="button" class="btn btn-primary">확인</button>
		</div>
	</div>
</body>
</html>