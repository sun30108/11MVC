<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>���� �����ȸ</title>

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
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit()
	}
	$(function(){
		
		$("span:contains('���ǵ���')").on("click",function(){
			var tranNo = $(this).data("tranno")
			//alert(tranNo)
			location.href = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=3"
		})
		
		$(".No").on("click",function(){
			var tranNo = $(this).data("tranno")
			//alert(tranNo)
			location.href = "/purchase/getPurchase?tranNo="+tranNo
		})
		$(".No").css("color", "green")
		
		
		$("td:nth-child(2)").on("click", function(){
			var userId = $(this).text().trim()
			location.href = "/user/getUser?userId="+userId
		})
		$("td:nth-child(2)").css("color", "red")
		
		
	})
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ���� -->
<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
<form class="form-inline" name="detailForm">
<input type="hidden" id="currentPage" name="currentPage" value=""/>
	
		<div class="page-header text-info">
	       <h3>���� �����ȸ</h3>
	    </div>
	    
	    <div class="row">
	    
	    	<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		</div>

<table class="table table-hover table-striped">

	<thead>
		<tr>
			<th align="center">No</th>
			<th align="left">ȸ��ID</th>
			<th align="left">ȸ����</th>
			<th align="left">��ȭ��ȣ</th>	
			<th align="left">�����Ȳ</th>
			<th align="left">��������</th>
		</tr>
	</thead>
	
	<tbody>
	
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list }">
	<c:set var="i" value="${i+1 }" />
	<tr>
		<td align="left">
			<c:if test="${purchase.tranCode=='0  ' }">
			<span class="No" data-tranno="${purchase.tranNo}">${i }</span>
			</c:if>
			<c:if test="${!(purchase.tranCode=='0  ') }">
			${i }			
			</c:if>
		</td>
		<td align="left">
			${purchase.buyer.userId}
		</td>
		<td align="left">${purchase.receiverName }</td>
		<td align="left">${purchase.receiverPhone }</td>
		<td align="left">����
						<c:if test="${purchase.tranCode=='0  ' }">���ſϷ�</c:if>
						<c:if test="${purchase.tranCode=='1  ' }"></c:if>
						<c:if test="${purchase.tranCode=='2  ' }">�����</c:if>
						<c:if test="${purchase.tranCode=='3  ' }">��ۿϷ�</c:if>
				���� �Դϴ�.</td>
		<td align="left" >
					<c:if test="${purchase.tranCode=='0  ' }"></c:if>
					<c:if test="${purchase.tranCode=='1  ' }"></c:if>
					<c:if test="${purchase.tranCode=='2  ' }">
					<span data-tranno="${purchase.tranNo}">���ǵ���</span>
					</c:if>
					<c:if test="${purchase.tranCode=='3  ' }"></c:if>
		</td>
	</tr>
	</c:forEach>
	
	</tbody>
	
</table>

<jsp:include page="../common/pageNavigator_new.jsp"/>
<!--  ������ Navigator �� -->

</form>
</div>

</body>
</html>

