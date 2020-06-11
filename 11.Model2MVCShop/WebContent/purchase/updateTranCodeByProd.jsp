<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<title>��ǰ �����ȸ</title>

<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
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

function fncGetList(currentPage){
	$("#currentPage").val(currentPage)
	$("form").attr("mehtd", "POST").attr("action", "/product/listProduct").submit()
}

$(function(){
	
	$("#stock span:contains('�����»�ǰ�Ⱥ���')").on("click", function(){
		self.location = "/product/listProduct?menu=manage&stock=1"
	})
	
	$("#stock span:contains('�����»�ǰ����')").on("click", function(){
		self.location = "/product/listProduct?menu=manage"
	})
	
	$(".dely").on("click", function(){
		var prodNo = $(this).data("prodno")
		self.location = "/purchase/updateTranCodeByProd?tranCode=2&prodNo="+prodNo
	})
	
	$(".prodName").css("color","green")
	$("td:nth-child(2)").on("click", function(){
		var prodNo = $(this).data("prodno")
		self.location = "/product/getProduct?prodNo="+prodNo+"&menu=manage"
	})
	
	$("button:contains('�˻�')").on("click", function(){
		javascript:fncGetList('1')
	})
	
	$(" td:nth-child(6) > i").on("click", function(){
		var prodNo = $(this).next().val();
		
		$.ajax( 
							{
								url : "/product/json/getProduct/"+prodNo ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {
									//alert(status);
									//var JSONdata = JSON.stringify(JSONData);
									//alert(JSONdata)
									//alert("JSONData : \n"+JSONData);
									
									var displayValue = "<h6>"
																+"��   ǰ   �� : "+JSONData.prodName+"<br/>"
																+"��         �� : "+JSONData.price+"<br/>"
																+"�� ǰ �� �� : "+JSONData.prodDetail+"<br/>"
																+"�� �� �� �� : "+JSONData.manuDate+"<br/>"
																+"��   ��   �� : "+JSONData.regDate+"<br/>"
																+"</h6>";							
									//alert(displayValue);
									$("h6").remove();
									$( "#"+prodNo ).html(displayValue);
								}
						});
						////////////////////////////////////////////////////////////////////////////////////////////
	
	})

})

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ���� -->
<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	
		<div class="page-header text-info">
	       <h3>��ǰ ����</h3>
	    </div>
	    
	    <div class="row">
	    
	    	<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		
			<div class="col-md-6 text-right">
			<form class="form-inline" name="detailForm">
			
				<div class="form-group">
					<select name="sortCondition" class="form-control">
						<option value="0" ${!empty search.sortCondition && search.sortCondition ==0 ? "selected" : "" }>���ļ���</option>
						<option value="1" ${!empty search.sortCondition && search.sortCondition ==1 ? "selected" : "" }>���ݳ�����</option>
						<option value="2" ${!empty search.sortCondition && search.sortCondition ==2 ? "selected" : "" }>���ݳ�����</option>
					</select>
				</div>
				
				<div class="form-group">
					<select name="searchCondition" class="form-control">
					<c:if test="${param.menu=='manage' }">
						<option value="0" ${!empty search.searchCondition && search.searchCondition ==0 ? "selected" : "" }>��ǰ��ȣ</option>
					</c:if>
						<option value="1" ${!empty search.searchCondition && search.searchCondition ==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2" ${!empty search.searchCondition && search.searchCondition ==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				</div>
				
				<div class="form-group">
					<label class="sr-only" for="searchKeyword">�˻���</label>
					<input type="text" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword}" class="form-control" placeholder="�˻���" />
				</div>
				
				<button type="button" class="btn btn-default">�˻�</button>
				
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input class="mN" name="menu" type="hidden" value="manage" />
				<input type="hidden" name="stock" value="${!empty search.stock ? search.stock : ""}" />

			</form>
			</div>
		</div>
		
		<div id="stock" class="text-right">
			<span>�����»�ǰ�Ⱥ���</span>
			<span>�����»�ǰ����</span>
		</div>
		
<table class="table table-hover table-striped">
	<thead>
		<tr>
			<th align="center">No</th>
			<th align="left">��ǰ��</th>
			<th align="left">����</th>
			<th align="left">�����</th>	
			<th align="left">�������</th>
			<th align="left">��������</th>
		</tr>
	</thead>
	
	<tbody>
	
		<c:set var="i" value="0" />
		<c:forEach var="product" items="${list }">
			<c:set var="i" value="${i+1 }" />
		<tr>
			<td align="center">${i }</td>
			<c:if test="${empty product.proTranCode }">
				<td align="left" class="prodName" data-prodno="${product.prodNo}">
				${product.prodName}</td>
			</c:if>
			<c:if test="${!empty product.proTranCode }">
				<td align="left">${product.prodName}</td>		
			</c:if>
			<td align="left">${product.price }</td>
			<td align="left">${product.regDate }</td>
			<td align="left">
				<c:if test="${param.menu=='manage' }">
						<c:if test="${empty product.proTranCode }">�Ǹ���</c:if>	
						<c:if test="${product.proTranCode == '0  '}">���ſϷ�
							 <span class="dely" data-prodno="${product.prodNo }">����ϱ�</span>
						</c:if>
						<c:if test="${product.proTranCode == '1  '}"></c:if>
						<c:if test="${product.proTranCode == '2  '}">�����</c:if>
						<c:if test="${product.proTranCode == '3  '}">��ۿϷ�</c:if>
				</c:if>
				<c:if test="${!(param.menu=='manage') }">
						${empty product.proTranCode ? "�Ǹ���" : "������" }
				</c:if>
			
			</td>
			<td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  	<input type="hidden" value="${product.prodNo}">
			</td>
		</tr>
		</c:forEach>
	
	</tbody>
	
</table>

</div>

<jsp:include page="../common/pageNavigator_new.jsp"/>
<!--  ������ Navigator �� -->

</body>
</html>

