<%@ page contentType="text/html; charset=euc-kr"%>

<html>
<head>
<title>상품등록</title>

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
	function fncAddProduct() {
		//Form 유효성 검증
		var name = $("input[name='prodName']").val()
		var detail = $("input[name='prodDetail']").val()
		var manuDate = $("input[name='manuDate']").val()
		var price = $("input[name='price']").val()

		if (name == null || name.length < 1) {
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		if (detail == null || detail.length < 1) {
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if (manuDate == null || manuDate.length < 1) {
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if (price == null || price.length < 1) {
			alert("가격은 반드시 입력하셔야 합니다.");
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

	<!-- 툴바 -->
	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
	
		<form name="detailForm" enctype="multipart/form-data" class="form-horizontal">

			<div class="page-header text-center">
				<h1 class=" text-info">상품등록</h1>
			</div>

			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명" >
				</div>
			</div>
				
			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="상품정보" >
				</div>
			</div>
				
			<div class="form-group">
				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="클릭!" >
				</div>	
			</div>
				
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price" placeholder="가격" >
				</div>
			</div>
				
			<div class="form-group">
				<label for="file" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
				<div class="col-sm-4">
					<input type="file" class="btn btn-info" id="file" name="file">
				</div>
			</div>
				
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary"  >등 &nbsp;록</button>
				  <a class="btn btn-primary" href="#" role="button">취 &nbsp;소</a>
				</div>
			</div>
	
		</form>
	</div>
</body>
</html>