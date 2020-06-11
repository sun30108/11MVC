<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
<title>구매정보 수정</title>

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

<script type="text/javascript" src="../javascript/calendar.js"></script>
<script type="text/javascript">

$(function(){
	$("button[name='cancel']").on("click", function(){
		history.go(-1)		
	})
	
	$("input[name='divyDate']").on("click", function(){
		show_calendar("document.updatePurchase.divyDate", document.updatePurchase.divyDate.value)		
	})
	$("button[name='change']").on("click", function(){
		$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase").submit()
	})
})

</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<!-- 툴바 -->
<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

<form name="updatePurchase" class="form-horizontal">
<input type="hidden" name="tranNo" value="${purchase.tranNo}" />

	<div class="page-header text-center">
		<h1 class=" text-info">구매정보수정</h1>
	</div>
	
	<div class="form-group">
		<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="userId" name="userId" value="${purchase.buyer.userId }" >
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
			<input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}" >
		</div>
	</div>
	
	<div class="form-group">
		<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone}" >
		</div>
	</div>
	
	<div class="form-group">
		<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}" >
		</div>
	</div>
	
	<div class="form-group">
		<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}" >
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
	      <button name="change" type="button" class="btn btn-primary"  >수 &nbsp;정</button>
		  <button name="cancel" type="button" class="btn btn-primary"  >취 &nbsp;소</button>
		</div>
	</div>
	
</form>
</div>

</body>
</html>