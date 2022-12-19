<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script language="javascript">
	$(document).ready(function(){
		$("#gridList1").jqGrid({
		   	url:"${pageContext.request.contextPath}/holi/holiUsageList.ajax",
		   	mtype: "POST",
			datatype: "json",
			//postData : {'menuid':'0'},
			jsonReader : {
				root: "resultList",
				repeatitems: false
			},
			loadtext : '조회 중 입니다.',
			shrinkToFit:false,
			colModel:[ 
				{label:'휴가ID', name:'holiNo', hidden:true},
				{label:'사번', name:'pernNo', hidden:true},
				{label:'성명', name:'name', width:80, align:"center"},
				{label:'휴가 시작일', name:'holiDateFrom', width:120, align:"center"},
		   		{label:'휴가 종료일', name:'holiDateTo', width:120, align:"center"},
		   		{label:'휴가 일수', name:'holiDays', width:80, align:"center"},
		   		{label:'휴가종류코드', name:'holiType', width:80, align:"center", hidden:true},
		   		{label:'휴가 종류', name:'holiTypeName', width:80, align:"center"},
		   		{label:'비고', name:'holiEtc', align:"center"}
		   	],
		   	loadonce: true,
		   	sortable : true,
		   	showpage : false,
            rownumbers : true,
		   	rowNum: 9007199254740992,
		   	width: 800,
            height: 450,
		   	beforeRequest : function () {loadingOn();},
		   	loadComplete: function (data) {if($('#gridList1').getGridParam("records")== 0) alert('조회된 내용이 없습니다.');loadingOff();},
		   	onSelectRow : function(rowId, status, e){ // row 선택 클릭 시		   		
		   		var rowData = $("#gridList1").getRowData(rowId);
				var formData = $('#dataForm').serializeArray();

				jQuery.each(formData, function() {
					for(key in rowData) {
					    if (key == this.name) {
					    	if (this.name == "holiDateFrom" || this.name == "holiDateTo" ){
					    		$('[id=dataForm] #'+this.name).val(rowData[key].substring(0,4) + "-" + rowData[key].substring(4,6) + "-" + rowData[key].substring(6,8));
					    	} else {
					    		$('[id=dataForm] #'+this.name).val(rowData[key]);
					    	}
					    }
					}
		        });
				
		   	}
		});

		$("#gridList1").setGridWidth($('#content').width()-25, true);

		goNameSelect();
	});

	$(window).bind('resize', function() {
		$("#gridList1").setGridWidth($('#content').width()-25, true);
	}).trigger('resize');

	function goSearch() {
		var formData = $('#searchForm').serializeArray();
		$('#gridList1').clearGridData();
		$('#gridList1').setGridParam({datatype : "json",
			                          postData : formData
			             }).trigger("reloadGrid");
	}
	
	function goNameSelect() {
		$.ajax({
             type : "POST",
             url : "${pageContext.request.contextPath}/holi/selectNameList.ajax",
             async: false,
             success : function(data){
            	 if(data != null) {
            		 selectoption = "<option value=''>전체</option>";
                     $.each(data , function (i, item) {
                    	 selectoption += "<option value=" + item.name + ">" + item.name + "</option>";
                     });
                     $('[id=searchForm] #name option').remove();
                     $('[id=searchForm] #name').append(selectoption);
            	 }
             },
             error : function(XMLHttpRequest, textStatus, errorThrown){
                 alert("작업 중 오류가 발생하였습니다.")
             }
         });
	}
	
	function goSave() {
		if ($('[id=dataForm] #name').val().trim() == '') {
			alert("성명을 입력하세요");
			$('[id=dataForm] #name').focus();
			return;
		}
		
		if ($('[id=dataForm] #holiDateFrom').val().trim() == '') {
			alert("시작 일자를 입력하세요");
			$('[id=dataForm] #holiDateFrom').focus();
			return;
		}
		
		if ($('[id=dataForm] #holiDateTo').val().trim() == '') {
			alert("종료 일자를 입력하세요");
			$('[id=dataForm] #holiDateTo').focus();
			return;
		} else if ($('[id=dataForm] #holiDateTo').val() < $('[id=dataForm] #holiDateFrom').val()) {
			alert("종료 일자가 시작 일자 보다 이릅니다.");
			$('[id=dataForm] #holiDateTo').focus();
			return;
		}
		
		if ($('[id=dataForm] #holiType').val() == '') {
			alert("휴가 종류를 선택하세요");
			$('[id=dataForm] #holiType').focus();
			return;
		}
		
		var diff = diffDate($('[id=dataForm] #holiDateFrom').val(), $('[id=dataForm] #holiDateTo').val());
	    
		if ($('[id=dataForm] #holiDays').val().trim() == '') {
			alert("휴가 일수를 입력하세요");
			$('[id=dataForm] #holiDays').focus();
			return;
		} else if($('[id=dataForm] #holiDays').val() != diff && $('[id=dataForm] #holiType').val() != "TYPE02" && $('[id=dataForm] #holiType').val() != "TYPE03") {
			// 휴가 일수가 계산된 일수와 다르면서 반차가 아닐 경우 오류 알림  <휴가 일수 입력 칸을 막아놔서 사실상 없어서 되는 부분>
			alert("휴가 일수가 올바르지 않습니다");
			$('[id=dataForm] #holiDays').focus();
			return;
		} else if(1 != diff && ($('[id=dataForm] #holiType').val() == "TYPE02" || $('[id=dataForm] #holiType').val() == "TYPE03")) {
			// 계산된 일수가 1이 아닌데 반차일 경우 오류 알림 (반차는 무조건 계산된 값이 1이여야한다.)
			alert("반차를 선택할 수 없습니다");
			$('[id=dataForm] #holiDays').focus();
			return;
		}
		
		var formData = $('#dataForm').serializeArray();

		loadingOn();

		$.ajax({
             type : "POST",
             url : "${pageContext.request.contextPath}/holi/holiUsageUpdate.ajax",
             data : formData,
             async: false,             
             success : function(data){
            	 if(data != null) {
            	 	alert("정상적으로 처리되었습니다.")
            	 	goSearch();
            	 	goNameSelect();
	           		goErase();
            	 	loadingOff();
            	 }
             },
             error : function(XMLHttpRequest, textStatus, errorThrown){
                 alert(XMLHttpRequest.responseText); // 오류에 따라 뜨는 알람이 달라지기 위해
                 console.log(XMLHttpRequest.responseText);
                 loadingOff();
             }
         });
	}
	
	function goErase() {
		$('[id=dataForm]').each(function() {
			this.reset();
		});
	}
	
	function goDelete() {
		var rowid = $("#gridList1").getGridParam( "selrow" );

		if (rowid == null || rowid < 1) {
			alert("삭제할 데이터를 선택하세요");
			return;
		}

		var rowData = $("#gridList1").getRowData(rowid);

		if (!confirm("정말로 삭제하시겠습니까?")) {
			return;
		}

		loadingOn();

		$.ajax({
             type : "POST",
             url : "${pageContext.request.contextPath}/holi/holiUsageDelete.ajax",
             data : rowData,             
             async: false,
             success : function(data){
            	 if(data != null) {
            	 	alert("정상적으로 처리되었습니다.")
            	 	goSearch();
            	 	goNameSelect();
            		goErase();
	           		loadingOff();
            	 }
             },
             error : function(XMLHttpRequest, textStatus, errorThrown){
                 alert("작업 중 오류가 발생하였습니다.")
                 loadingOff();
             }
         });		
	}
	
	// 휴가 종류를 골라주면 계산된 날짜를 휴가일수에 넣어주는 함수 (반차일 때는 0.5)
	function onChangeHoliType(holiType) {
		
	    var diff = diffDate($('[id=dataForm] #holiDateFrom').val(), $('[id=dataForm] #holiDateTo').val());
	    
		if(holiType == "TYPE02" || holiType == "TYPE03") {
			$('[id=dataForm] #holiDays').val("0.5");
		} else {
			$('[id=dataForm] #holiDays').val(diff);
		}
	}
	
	// 날짜 계산 함수
	function diffDate(a, b) {
		/* var sd = a.substring(0,4) + "/" + a.substring(4,6) + "/" + a.substring(6,8);
		var ed = b.substring(0,4) + "/" + b.substring(4,6) + "/" + b.substring(6,8); */
		
		const startDate = new Date(a);
		const endDate = new Date(b);
		var diff = (endDate.getTime() - startDate.getTime());
	    diff = Math.ceil(diff / (1000 * 3600 * 24)) + 1;
	    return diff;
	}
	
	/* -------------------------팝업 창 설정------------------------------ */
	
	function popup() {
		$('#inputForm').each(function() { this.reset();});		
		$('#btn_input').attr("data-target","#modalpopup");
		
		$('#modalpopup').on('shown.bs.modal', function () {
			$('[id=inputForm] #name').trigger('focus')
		})
	}	
	
	$(document).ready(function(){
		$("#gridList2").jqGrid({
		   	url:"${pageContext.request.contextPath}/holi/holiNameList.ajax",
		   	mtype: "POST",
			datatype: "json",
			//postData : {'name': $('[id=inputForm] #name').val()},
			jsonReader : {
				root: "resultList",
				repeatitems: false
			},
			loadtext : '조회 중 입니다.',
			shrinkToFit:false,
			colModel:[ 
				{label:'성명', name:'name', width:200, align:"center"},
				{label:'사번', name:'pernNo', width:200, align:"center"}		   		
		   	],
		   	loadonce: true,
		   	sortable : true,
		   	showpage : false,
            rownumbers : true,
		   	rowNum: 9007199254740992,
		   	width: 450,
            height: 450,
		   	beforeRequest : function () {loadingOn();},
		   	loadComplete: function (data) {if($('#gridList2').getGridParam("records")== 0) alert('조회된 내용이 없습니다.');loadingOff();}
		});
		/* $("#gridList2").setGridWidth($('#content').width()-25, true); */		
	});	
	
	function goSearch2() {
		var formData = $('#inputForm').serializeArray();
		$('#gridList2').clearGridData();
		$('#gridList2').setGridParam({datatype : "json",
			                          postData : formData
			             }).trigger("reloadGrid");
	}	
	
	function dataSelect() {
		var rowid = $("#gridList2").getGridParam( "selrow" );

		if (rowid == null || rowid < 1) {
			alert("사용할 데이터를 선택하세요");
			return;
		}

		var rowData = $("#gridList2").getRowData(rowid);
		
		$('[id=dataForm] #pernNo').val(rowData['pernNo']);
		$('[id=dataForm] #name').val(rowData['name']);
		
		$('#modalpopup').modal('hide');
	}
	
	
</script>

<div class="float-left w-100">
	<div class="page-header">
		<h4><i class="bi bi-info-square-fill"></i> 휴가 사용 내역</h4>
	</div>
		
	<p></p>
	<form class="form-inline" id="searchForm" name="searchForm">
   		<div class="input-group mb-2 mr-sm-2">
     		<div class="input-group-prepend">
       			<div class="input-group-text">년도</div>
     		</div>
  		    <select class="form-control" id="years" name="years" style="width:150px">  	
  		    	<option value="">전체</option>	      		    	
  		    	<c:forEach var="yearList" items="${yearList}" varStatus="status">
					<option value="${yearList.years}">${yearList.years}</option>
				</c:forEach>
  		    </select>
   		</div>
   		<div class="input-group mb-2 mr-sm-2">
     		<div class="input-group-prepend">
       			<div class="input-group-text">성명</div>
     		</div>
     		<select class="form-control" id="name" name="name" style="width:150px"></select>     		
   		</div>
   		
		<button type="button" class="btn btn-sm btn-info mb-2" onclick="javascript:goSearch()"><i class="bi bi-search"></i> 조회</button>
	</form>
	<p></p>
		
	<table id="gridList1"></table>
	
	<p></p>

	<form id="dataForm" name="dataForm">
		<div class="form-row" >
			<div class="form-group required control-label">				
				<label for="pernNo"><i class="bi bi-check2-circle"></i> 성명</label>
				<input type="hidden" class="form-control" id="holiNo" name="holiNo" value="0">
				<input type="hidden" class="form-control" id="pernNo" name="pernNo">
				<div class="form-row" >
					&nbsp;<input type="text" class="form-control" id="name" name="name" maxlength="5" style="width: 150px" readonly>				
					&nbsp;<button type="button" class="btn btn-sm btn-primary" id="btn_input"	name="btn_input" data-toggle="modal" onclick="javascript:popup()"><i class="bi bi-search"></i> 성명 조회</button>
				</div>
			</div>			
		</div>
		<div class="form-row">
			<div class="form-group required control-label">
				<label for="holiDateFrom"><i class="bi bi-check2-circle"></i> 시작 일자</label>
				<input type="date" class="form-control" id="holiDateFrom" name="holiDateFrom" max="9999-12-31" style="width: 150px" oninput="onChangeHoliType($('[id=dataForm] #holiType').val());" /> 
				<!-- <input type="text" class="form-control" id="holiDateFrom" name="holiDateFrom" maxlength="8" style="width: 150px" placeholder="YYYYMMDD"> -->
			</div>
			&nbsp;
			<div class="form-group required control-label">
				<label for="holiDateTo"><i class="bi bi-check2-circle"></i> 종료 일자</label> 
				<input type="date" class="form-control" id="holiDateTo" name="holiDateTo" max="9999-12-31" style="width: 150px" oninput="onChangeHoliType($('[id=dataForm] #holiType').val());" />
				<!-- <input type="text" class="form-control" id="holiDateTo" name="holiDateTo" maxlength="8" style="width: 150px" placeholder="YYYYMMDD"> -->
			</div>
		</div>
		<div class="form-row">
			<div class="form-group required control-label">
				<label for="codeNm"><i class="bi bi-check2-circle"></i> 휴가 종류</label> 
				<select	class="form-control" id="holiType" name="holiType" onchange="onChangeHoliType(this.value)" style="width: 150px">
					<option value="">선택</option>
					<c:forEach var="holiTypeList" items="${holiTypeList}" varStatus="status">
						<option value="${holiTypeList.code}">${holiTypeList.holiType}</option>
					</c:forEach>					
				</select>
			</div>
			&nbsp;
			<div class="form-group required control-label">
				<label for="holiDays"><i class="bi bi-check2-circle"></i> 휴가 일수</label>
				<input type="text" class="form-control" id="holiDays" name="holiDays" maxlength="3" style="width: 150px" readonly>				
			</div>
		</div>
		<div class="form-row">
			<div class="form-group control-label">
				<label for="holiEtc"><i class="bi bi-check2-circle"></i> 비고</label>
				<input type="text" class="form-control" id="holiEtc" name="holiEtc"	maxlength="100" style="width: 150px">
			</div>
		</div>
	</form>

	<p>
		<button type="button" class="btn btn-sm btn-primary" onclick="javascript:goErase()"><i class="bi bi-x"></i> 초기화</button>
		<button type="button" class="btn btn-sm btn-primary" onclick="javascript:goSave()"><i class="bi bi-save"></i> 수정 및 저장</button>
		<button type="button" class="btn btn-sm btn-primary" onclick="javascript:goDelete();"><i class="bi bi-trash"></i> 삭제</button>
	</p>	
</div>




<div class="modal fade" id="modalpopup" name="modalpopup" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><b><i class="bi bi-clipboard-plus"></i> 성명 조회</b></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<form class="form-inline" id="inputForm" name="inputForm" onsubmit="return false">
		  <div class="form-group required control-label">
	   		<div class="input-group mb-2 mr-sm-2">
    	 		<div class="input-group-prepend">
      	 			<div class="input-group-text">성명</div>
     			</div>     			
     			<input type="text" class="form-control" id="name" name="name" style="width:150px" onkeyup="if(window.event.keyCode==13){goSearch2()}">
   			</div>
			<button type="button" class="btn btn-sm btn-info mb-2" onclick="javascript:goSearch2()"><i class="bi bi-search"></i> 조회</button>
		  </div>
		</form>
		<table id="gridList2"></table>		
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-sm btn-primary" onclick="javascript:dataSelect()"><i class="bi bi-pencil-fill"></i> 선택</button>        
        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal"><i class="bi bi-x"></i> 닫기</button>
      </div>
    </div>
  </div>
</div>

