<%@ page contentType="text/html; charset=euc-kr"%>

<html>
<head>

<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
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
	$("button:contains('����')").on("click", function(){
		var prodNo = $("#prodNo").text().trim()
		location.href = "/purchase/addPurchase?prodNo="+prodNo
	})
})

$(function(){
	$("button:contains('����')").on("click", function(){
		history.go(-1)		
	})
})

</script>


<title>Insert title here</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ���� -->
<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

	<div class="page-header">
	    <h3 class=" text-info">��ǰ����ȸ</h3>
	</div>

<form name="detailForm">
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
		<div class="col-xs-8 col-md-4" id="prodNo">${product.prodNo}</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodName }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
		<div class="col-xs-8 col-md-4">
		<img src="../images/uploadFiles/${product.fileName }"></div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodDetail }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
		<div class="col-xs-8 col-md-4">${product.manuDate }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>����</strong></div>
		<div class="col-xs-8 col-md-4">${product.price }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>�������</strong></div>
		<div class="col-xs-8 col-md-4">${product.regDate }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-md-12 text-center ">
			<button type="button" class="btn btn-primary">����</button>
			<button type="button" class="btn btn-primary">����</button>
		</div>
	</div>

</form>

</div>



</body>
</html>