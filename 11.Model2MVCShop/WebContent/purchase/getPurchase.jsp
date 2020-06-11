<%@ page contentType="text/html; charset=euc-kr"%>

<html>
<head>
<title>���Ż���ȸ</title>

<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
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
	$("button:contains('Ȯ��')").on("click", function(){
		history.go(-1)
	})
	
	$("button:contains('����')").on("click", function(){
		var tranNo = $(this).data("tranno")
		location.href = "/purchase/updatePurchase?tranNo="+tranNo
	})
	
	
})
</script>


</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ���� -->
<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

	<div class="page-header">
	    <h3 class=" text-info">���Ż���ȸ</h3>
	</div>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
		<div class="col-xs-8 col-md-4" id="prodNo">${purchase.purchaseProd.prodNo }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>�����ھ��̵�</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.buyer.userId }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>���Ź��</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.paymentOption=='1  '? "���ݱ���" : "�ſ뱸��" }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>�������̸�</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.receiverName }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>�����ڿ���ó</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.receiverPhone }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>�������ּ�</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.divyAddr }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>���ſ�û����</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.divyRequest }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.divyDate }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>�ֹ���</strong></div>
		<div class="col-xs-8 col-md-4">${purchase.orderDate }</div>
	</div><hr>
	
	<div class="row">
		<div class="col-md-12 text-center ">
			<button type="button" class="btn btn-primary"  data-tranno="${purchase.tranNo}">����</button>
			<button type="button" class="btn btn-primary">Ȯ��</button>
		</div>
	</div>
</body>
</html>