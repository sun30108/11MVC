<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<html>
<head>
<title>상품 목록조회</title>

<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
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
//검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  

function fncGetList(currentPage){
	$("#currentPage").val(currentPage)
	$("form").attr("mehtd", "POST").attr("action", "/product/listProduct").submit()
}

//스크롤로 추가된 부분 펑션으로 작동되게함
function moveProduct(prodNo){
	var menu = $(".mN").val().trim()
	self.location = "/product/getProduct?prodNo="+prodNo+"&menu="+menu
}

$(function(){
	
	var menu = $(".mN").val().trim()
	
	$("#stock span:contains('재고없는상품안보기')").on("click", function(){
		self.location = "/product/listProduct?menu="+menu+"&stock=1"
	})
	
	$("#stock span:contains('재고없는상품보기')").on("click", function(){
		self.location = "/product/listProduct?menu="+menu
	})
	
	$("button:contains('검색')").on("click", function(){
		fncGetList('1')
	})
	
	$(".prodName").css("color","green")
	$(".prodName").on("click", function(){
		var prodNo = $(this).data("prodno")
		self.location = "/product/getProduct?prodNo="+prodNo+"&menu="+menu
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
																+"상   품   명 : "+JSONData.prodName+"<br/>"
																+"상품이미지 : <img src=\"../images/uploadFiles/"+JSONData.fileName+"\"><br/>"
																+"가         격 : "+JSONData.price+"<br/>"
																+"상 품 정 보 : "+JSONData.prodDetail+"<br/>"
																+"제 조 일 자 : "+JSONData.manuDate+"<br/>"
																+"등   록   일 : "+JSONData.regDate+"<br/>"
																+"</h6>";							
									//alert(displayValue);
									$("h6").remove();
									$( "#"+prodNo ).html(displayValue);
								}
						});
						////////////////////////////////////////////////////////////////////////////////////////////
	
	})
	
	//무한스크롤
	var page = $("#currentPage").val();
	$(window).scroll(function() {
                // 맨 밑으로 스크롤이 갔을경우 if문을 탑니다.
                if($(window).scrollTop() == $(document).height() - $(window).height()) {
                	
                		if(page == null || page ==""){
                			page = 1;
                		}
                		page++;
                		
                		$.ajax(
                				{
                					url : "/product/json/listProduct/" ,
    								method : "POST" ,
    								dataType : "json" ,
    								headers : {
    									"Accept" : "application/json",
    									"Content-Type" : "application/json"
    								},
    								data : JSON.stringify({
    									currentPage : page
    								}),
    								success : function(JSONData , status) {
    									//alert(status);
    									//var JSONdata = JSON.stringify(JSONData);
    									//alert(JSONdata)
    									//alert("JSONData : \n"+JSONData);
    									for(var i = 0; i<JSONData.list.length; i++){
    									var result = "";
    										if(JSONData.list[i].proTranCode==null){
    											result = "<td align=\"left\" style=\"color:green\" onclick=\"moveProduct("+JSONData.list[i].prodNo+")\" class=\"prodName\" >"+JSONData.list[i].prodName+"</td>"
    										}else{
    											result = "><td align=\"left\">"+JSONData.list[i].prodName+"</td>"
    										}
    									var displayValue = "<tr>"
    									+"<td align=\"center\"></td>"
    									+result
    									+"<td align=\"left\">"+JSONData.list[i].price+"</td>"
    									+"<td align=\"left\">"+JSONData.list[i].regDate+"</td>"
    									+"<td align=\"left\"></td>"
    									+"<td align=\"left\"></td>"
    								 	+"</tr>";
    									$( "#plusProd" ).append(displayValue);
    									}
    								}
                				})
                }
            }); 
 	//////
	
	$(".dely").on("click", function(){
		var prodNo = $(this).data("prodno")
		self.location = "/purchase/updateTranCodeByProd?tranCode=2&prodNo="+prodNo
	})
})

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- 툴바 -->
<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	
		<div class="page-header text-info">
	       <h3>${param.menu=='manage'? "상품 관리" : "상품 목록조회" }</h3>
	    </div>
	    
	    <div class="row">
	    
	    	<div class="col-md-6 text-left">
		    	<p class="text-primary" >
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		
			<div class="col-md-6 text-right">
			<form class="form-inline" name="detailForm">
			
				<div class="form-group">
					<select name="sortCondition" class="form-control">
						<option value="0" ${!empty search.sortCondition && search.sortCondition ==0 ? "selected" : "" }>정렬순서</option>
						<option value="1" ${!empty search.sortCondition && search.sortCondition ==1 ? "selected" : "" }>가격높은순</option>
						<option value="2" ${!empty search.sortCondition && search.sortCondition ==2 ? "selected" : "" }>가격낮은순</option>
					</select>
				</div>
				
				<div class="form-group">
					<select name="searchCondition" class="form-control">
					<c:if test="${param.menu=='manage' }">
						<option value="0" ${!empty search.searchCondition && search.searchCondition ==0 ? "selected" : "" }>상품번호</option>
					</c:if>
						<option value="1" ${!empty search.searchCondition && search.searchCondition ==1 ? "selected" : "" }>상품명</option>
						<option value="2" ${!empty search.searchCondition && search.searchCondition ==2 ? "selected" : "" }>상품가격</option>
					</select>
				</div>
				
				<div class="form-group">
					<label class="sr-only" for="searchKeyword">검색어</label>
					<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				</div>
				
				<button type="button" class="btn btn-default">검색</button>
				
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input class="mN" name="menu" type="hidden" value="${param.menu}" />
				<input type="hidden" name="stock" value="${!empty search.stock ? search.stock : ""}" />

			</form>
			</div>
		</div>
		
		<div id="stock" class="text-right">
			<span>재고없는상품안보기</span>
			<span>재고없는상품보기</span>
		</div>
		
<table class="table table-hover table-striped">
	<thead>
		<tr>
			<th align="center">No</th>
			<th align="left">상품명</th>
			<th align="left">가격</th>
			<th align="left">등록일</th>	
			<th align="left">현재상태</th>
			<th align="left">간략정보</th>
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
						<c:if test="${empty product.proTranCode }">판매중</c:if>	
						<c:if test="${product.proTranCode == '0  '}">구매완료
							 <span class="dely" data-prodno="${product.prodNo }">배송하기</span>
						</c:if>
						<c:if test="${product.proTranCode == '1  '}"></c:if>
						<c:if test="${product.proTranCode == '2  '}">배송중</c:if>
						<c:if test="${product.proTranCode == '3  '}">배송완료</c:if>
				</c:if>
				<c:if test="${!(param.menu=='manage') }">
						${empty product.proTranCode ? "판매중" : "재고없음" }
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
<!--  페이지 Navigator 끝 -->

<div class="container">
<table id="plusProd" class="table table-hover table-striped">
</table>
</div>
</body>
</html>

