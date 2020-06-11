<%@ page contentType="text/html; charset=euc-kr"%>

<html>
<head>
<title>��ǰ���</title>

<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
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
	function fncAddProduct() {
		//Form ��ȿ�� ����
		var name = $("input[name='prodName']").val()
		var detail = $("input[name='prodDetail']").val()
		var manuDate = $("input[name='manuDate']").val()
		var price = $("input[name='price']").val()

		if (name == null || name.length < 1) {
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (detail == null || detail.length < 1) {
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (manuDate == null || manuDate.length < 1) {
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (price == null || price.length < 1) {
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		$("form").attr("method", "POST").attr("action", "/product/addProduct").submit()
	}

	$(function() {
		$("button.btn.btn-primary").on("click", function() {
			fncAddProduct()
		})

	})

	$(function() {
		$("a.btn.btn-primary").on("click", function() {
			$("form")[0].reset()
		})

		$("input[name='manuDate']").on("click",function() {
					show_calendar("document.detailForm.manuDate",document.detailForm.manuDate.value)
		})
	})
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<!-- ���� -->
	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
	
		<form name="detailForm" enctype="multipart/form-data" class="form-horizontal">

			<div class="page-header text-center">
				<h1 class=" text-info">��ǰ���</h1>
			</div>

			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�� ǰ ��</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" placeholder="��ǰ��" >
				</div>
			</div>
				
			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="��ǰ����" >
				</div>
			</div>
				
			<div class="form-group">
				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="Ŭ��!" >
				</div>	
			</div>
				
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price" placeholder="����" >
				</div>
			</div>
				
			<div class="form-group">
				<label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
				<div class="col-sm-4">
					<input type="file" class="btn btn-info" id="file" name="file">
				</div>
			</div>
				
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
				  <a class="btn btn-primary" href="#" role="button">�� &nbsp;��</a>
				</div>
			</div>
	
		</form>
	</div>
</body>
</html>