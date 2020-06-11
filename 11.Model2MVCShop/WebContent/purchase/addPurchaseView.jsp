<%@ page contentType="text/html; charset=euc-kr" %>


<html>
<head>

<title>Insert title here</title>

<script type="text/javascript" src="../javascript/calendar.js"></script>
<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
<style>
body {
	padding-top: 50px;
}
</style>

<script type="text/javascript" src="../javascript/calendar.js"></script>

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

function fncAddPurchase() {
	$("form").attr("method","POST").attr("action","/purchase/addPurchase").submit()
}

$(function(){
	
	$("button[name='cancel']").on("click", function(){
		history.go(-1)
	})
	
	$("button[name='purchase']").on("click", function(){
		fncAddPurchase()
	})
	
	$("input[name='divyDate']").on("click", function(){
		show_calendar("document.addPurchase.divyDate", document.addPurchase.divyDate.value)	
	})
	
})
</script>
</head>

<body>

<!-- 툴바 -->
<jsp:include page="/layout/toolbar.jsp" />

<div class="container" >

<form name="addPurchase" class="form-horizontal">

	<div class="page-header text-center">
		<h1 class=" text-info">상품상세조회</h1>
	</div>
	
	<div class="form-group">
		<label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="prodNo" name="prodNo" value="${product.prodNo }" readonly="readonly">
		</div>
	</div>

	<div class="form-group">
		<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName }" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail }" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate }" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="price" name="price" value="${product.price }" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="regDate" name="regDate" value="${product.regDate }" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="userId" name="userId" value="${user.userId}" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		<div class="col-sm-4">
			<select name="paymentOption" id="paymentOption" class="form-control" >
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}" >
		</div>
	</div>
	
	<div class="form-group">
		<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}" >
		</div>
	</div>
	
	<div class="form-group">
		<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}" >
		</div>
	</div>
	
	<div class="form-group">
		<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="" >
		</div>
	</div>
	
	<div class="form-group">
		<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="divyDate" name="divyDate" value="" >
		</div>
	</div>
	
	<div class="form-group">
	    <div class="col-sm-offset-4  col-sm-4 text-center">
	      <button name="purchase" type="button" class="btn btn-primary"  >구 &nbsp;매</button>
		  <button name="cancel" type="button" class="btn btn-primary"  >취 &nbsp;소</button>
		</div>
	</div>
	
	<input type="hidden" name="prodNo" value="${product.prodNo}" />

</form>

</body>
</html>