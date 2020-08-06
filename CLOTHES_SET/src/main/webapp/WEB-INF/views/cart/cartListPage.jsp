<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../template/header.jsp">
	<jsp:param value="장바구니" name="pageTitle"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	
	// 로그인 여부를 즉시 체크
	(function(){	
		var loginDTO = '${loginDTO}';
		if (loginDTO == null || loginDTO == '') {
			alert('로그인 후 사용하실수 있습니다.');
			location.href='memberLoginPage';
		} else {
			return;
		}
	})();
	
	// 체크박스 전체선택 함수
	$("#chk_all").click(function(){
		 var chk_all = $("#chk_all").prop("checked");
		 if(chk_all) {								
			$(".chk").prop("checked", true);
		 } else {
		 	$(".chk").prop("checked", false);
		 }
	});
	
	// 선택된 카트 값(카트 번호)을 삭제
	$(".selectDelete_btn").click(function(){
		
		// 체크된 항목이 하나도 없을 경우
		if ($(".chk").is(":checked") == false) {
			alert('선택한 물품이 없습니다.');
		} else {
			
		 	var confirm_val = confirm("정말 삭제하시겠습니까?");
		  
		 	if(confirm_val) {
		 		
		 		// 체크된 체크박스들의 값(cNo)을 배열에 저장 
		  		var checkArr = [];		
		   
				$(".chk:checked").each(function(){
			    	checkArr.push($(this).val());
			   	});
		    	
			   	// AJAX를 통해 DB에서도 즉시 삭제
			   	$.ajax({
				    url : "cartDeleteSelect",
				    type : "POST",
				    data : { chk : checkArr },
				    success : function(){
				    	alert('정상적으로 삭제되었습니다.');
				    	location.href = "cartListPage";
			    	},
			    	error : function() {
			    		alert('ajax 에러');
			    		location.href = "cartListPage";
			    	}
			   });
		  	} 
		}
	});
	
	// [주문하기] 버튼 클릭시
	$("#orderListPage_btn").click(function(){
		if ($(".chk").is(":checked") == false) {
			alert('선택한 물품이 없습니다.');
		} else {
			if (confirm('주문하시겠습니까?')) {
				
				$('#f').attr('action', 'orderListPage');
				$('#f').submit();
				
			}
		}
	});

});

/* 		함수 ↓↓↓ 	*/

// 취소하면 카트에 들어있는 DB(cart) 전부 삭제
function fn_cancle(f) {
	if (confirm('취소하시겠습니까?')) {
		f.action = 'cartAllDelete';
		f.submit();
	}
}

function fn_cartAmountChange( i, newAmount, productPrice, operator ) {
	
	// i == cNo (카트 항목 고유 식별자)
	// newAmount == AJAX를 통해 받아온 수정된 상품 수량
	// productPrice == 카트에 담긴 상품의 가격 (할인율 적용됨)
	// sum == 배송비를 제외한 장바구니에 담긴 모든 상품의 가격
	// totalPrice ==  배송비를 포함한 장바구니에 담긴 모든 상품의 가격
	
	// 문자열 상태의 sum("#,##0")을 가져온다
	var sumArr = $('#sumMoney').text().split(',');
	// 쉼표를 기준으로 나누어 배열에 저장한 후, 다시 합쳐 숫자로 만든다.
	var sum = '';
	sumArr.forEach( function(e) { sum += e; });
	sum = parseInt(sum);

	$('#cAmount'+i).val(newAmount);  // AJAX를 통해 받아온 데이터로 상품 수량 갱신	
	var itemTotalPrice = parseInt( newAmount * productPrice );																
	$('#cPrice'+i).text(itemTotalPrice.toLocaleString());  // 장바구니 항목 총 가격 변경
	
	// operator에 따라 sum에 가격을 더할지, 뺄지 나뉨
	sum = (operator == 'add' ? sum + productPrice : sum - productPrice);	
	
	// 장바구니에 담긴 모든 상품의 가격
	$('#sumMoney').text( sum.toLocaleString() );
	
	// 총 상품 가격에 따른 배송비
	var fee = ( sum >= 100000 ? 0 : 3000 );	
	$('#fee').text(fee); // 총 상품 가격에 따른 배송비 분리
	$('#fee + input[type="hidden"]').val(fee);
	
	// 배송비를 포함한 총 상품 가격
	var totalPrice = sum + fee;	
														
	$('#totalPrice').val(totalPrice);
	$('#totalPrice + span').text( totalPrice.toLocaleString() ); 
}

</script>
	<div class="cart wrap">
		<h2 class="page-title">${loginDTO.mId }님 장바구니</h2>
		<c:choose>
			<c:when test="${empty list }">
	        	<div class="notice">장바구니가 비었습니다.</div>
	    	</c:when>
			<c:otherwise>
				<form id="f">
					<div class="checkDelete">
						<label class="chk_all"><input type="checkbox" id="chk_all" /> 전체 선택</label>
						<input type="button" class="selectDelete_btn" value="선택 항목 삭제" />
					</div>
			
					<div class="cartList">
						<table>
							<thead>
								<tr>
									<th colspan="3">상품</th>
									<th>수량</th>
									<th>주문금액</th>
								</tr>
							</thead>
							<tbody>
							
								<c:forEach var="cJVO" items="${list }" varStatus="status">
									<script type="text/javascript">
										$(document).ready(function(){
											var i = '${cJVO.cNo }'; // 각 장바구니 항목의 식별자
											var productPrice = parseInt('${cJVO.productPrice }'); // 할인율 적용된 상품 가격
											var sAmount = parseInt('${cJVO.sAmount}'); // 각 장바구니 항목의 재고량
											var cAmount = parseInt($('#cAmount'+i).val()); // 장바구니에 담긴 수량
											var productTotalPrice = productPrice * cAmount; // 장바구니 항목의 총 가격 (상품가격 * 담은 수량)											
																						
											/** 장바구니 수량 더하기 **/
											$('#plusBtn'+i).click( function(){
												
												// 재고보다 작거나 같은 숫자만 가능
												if($('#cAmount'+i).val() >= sAmount) {
													alert('현재 재고(' + sAmount + ')보다 많은 수를 입력할 수 없습니다');
													return;
												}
												
												$.ajax({
													url: 'cartPlusCalc'
													, type: "get"
													, dataType: "JSON"
													, data: { 
														cAmount : $('#cAmount'+i).val()
														, cNo : '${cJVO.cNo}'
														}
													, success: function( responseObj ) {
														// AJAX 통신으로 변경된 수량을 받는다
														var newAmount = responseObj.result
														fn_cartAmountChange( i, newAmount, productPrice, "add" );
													}
												}); // ajax end
											});	// click event handler end
											
											/** 장바구니 수량 빼기 **/
											$('#minusBtn'+i).click( function(){
												if($('#cAmount'+i).val() <= 1) {
													alert('1보다 작은 수는 넣을 수 없습니다.');
													return;
												}
												$.ajax({
													url: 'cartMinusCalc'
													, type: "get"
													, dataType: "JSON"
													, data: { 
														cAmount : $('#cAmount'+i).val()
														, cNo : '${cJVO.cNo}'
														}
													, success: function( responseObj ) {
														var newAmount = responseObj.result
														fn_cartAmountChange( i, newAmount, productPrice, "subtract" );
													}
												}); // ajax end
											}); // click event handler end
											
											
											var sumMoney = parseInt('${sumMoney}');	 // 전체 상품 가격
											var totalPrice = parseInt('${total}');   // 배송비를 포함한 전체 가격'
											
											$('#sumMoney').text( sumMoney.toLocaleString() );
											$('#totalPrice').val( totalPrice );
											$('#totalPrice + span').text( totalPrice.toLocaleString() );
											
											// 장바구니 항목 하나의 총 상품 금액 (상품 가격 * 장바구니 수량)
											$('#cPrice'+i).text( productTotalPrice.toLocaleString() );				
											
											// 전체선택 해제여부
											$("#chk").click(function() {
												if($("input[name='chk']:checked").length == ${status.index + 1}){
													$("#chk_all").prop("checked", true);
												} else {
													$("#chk_all").prop("checked", false);
												}
											});
											
										}); // load event handler end
												
									</script>
									<!-- 수량 변경 -->
										<tr>
											<td>
												<input type="checkbox" id="chk" class="chk" name="chk" value="${cJVO.cNo }"/> <!-- 선택 박스 하나라도 미클릭시 전체선택 체크박스 해제 -->
											</td>
											<td>
												<div class="product-img small" style="background-image: url('resources/product_photos/${cJVO.pFilename}')">
													<img class="blind" src="resources/product_photos/${cJVO.pFilename}" alt="제품 이미지">
												</div>
											</td>
											<td>
												<ul class="order-prod-info">
													<li>${cJVO.pName }</li>
													<li>사이즈 : ${cJVO.cSize }</li>
												</ul>												
												<input type="hidden" name="cSize" value="${cJVO.cSize }" />
											</td>
											<td>
												<div class="cAmount-box">
													<button  id="minusBtn${cJVO.cNo }" class="cAmountBtn" type="button"><i class="fas fa-minus-circle"></i></button>
													<input class="cAmount" type="text" id="cAmount${cJVO.cNo }" name="cAmount" value="${cJVO.cAmount}" readonly="readonly"> 
													<button  id="plusBtn${cJVO.cNo }" class="cAmountBtn" type="button"><i class="fas fa-plus-circle"></i></button>
												</div>												
											</td>
											<td>												
												<span class="productTotalPrice" id="cPrice${cJVO.cNo }"></span>
												<input type="hidden" name="cNo" value="${cJVO.cNo }" />												
												<input type="hidden" id="pPrice${cJVO.cNo }" name="pPrice" value="${cJVO.pPrice * (1-(cJVO.pDisrate/100)) }" /> <!-- 상품 가격(할인율 적용) -->
												<input type="button" value="바로주문" onclick="location.href='cOrderQuick?cNo=${cJVO.cNo}'" /> <!-- 바로 주문 버튼 -->
											</td>
										</tr>
										
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- 현재 카트에 담긴 모든 것 -->
					<!--  -->
					<table class="result-box">
						<tr>
							<td>총 상품금액</td>
							<td></td>
							<td>배송비</td>
							<td></td>
							<td>총 결제예상 금액</td>
						</tr>
						<tr>
							<td><span class="bold" id="sumMoney"></span></td>
							<td><span class="operator"> + </span></td>
							<td>
								<span class="bold" id="fee">${fee }</span>
								<input type="hidden" name="fee" value="${fee }"/>
							</td>
							<td><span class="operator"> = </span></td>
							<td>
								<input type="hidden" name="totalPrice"  id="totalPrice" readonly="readonly"/>
								<span>${total }</span>원
							</td>
						</tr>
					</table>
					<div class="btn-box">
						<input type="button" id="orderListPage_btn" value="주문하기" />&nbsp;&nbsp;
						<input type="button" value="취소하기" onclick="fn_cancle(this.form)" />
					</div>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
<%@ include file="../template/footer.jsp" %>