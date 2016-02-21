<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- 最新編譯和最佳化的 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<!-- 選擇性佈景主題 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css" rel="stylesheet">
<!-- 最新編譯和最佳化的 JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

<link href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/css/ui.jqgrid.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/js/jquery.jqGrid.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/plugins/jquery.contextmenu.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/js/i18n/grid.locale-tw.js"></script>

<style>
	#expensesForm{
		padding-top: 80px;
		padding-left: 15px;
	}
    #expensesForm input{
        padding-left: 5px;
    }
</style>

<title>Sample</title>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">Bootstrap theme</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="active"><a href="#">Home</a></li>
				<li><a href="#about">About</a></li>
				<li><a href="#contact">Contact</a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dropdown
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Action</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li class="dropdown-header">Nav header</li>
						<li><a href="#">Separated link</a></li>
						<li><a href="#">One more separated link</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</nav>
	<form id = "expensesForm" style="width:70%">
		<input id="billDate" placeholder="請款日" required="" autofocus="" type="text">
		<input id="realDate" placeholder="發生日期" required="" autofocus="" type="text">
        <input id="billStore" placeholder="請款店家" required="" autofocus="" type="text">
        <input id="realStore" placeholder="發生店家" required="" autofocus="" type="text">
        <input id="source" placeholder="支出去向" required="" autofocus="" type="text">
        <input id="accountIteam" placeholder="項目" required="" autofocus="" type="text">
        <input id="detail" placeholder="支出內容" required="" autofocus="" type="text">
        <input id="payee" placeholder="請款人" required="" autofocus="" type="text">
        <input id="workTime" placeholder="時間" required="" autofocus="" type="text">
        <input id="workType" placeholder="班別" required="" autofocus="" type="text">
        <input id="price" placeholder="單價" required="" autofocus="" type="text">
        <input id="quantity" placeholder="數量" required="" autofocus="" type="text">
        <input id="unit" placeholder="單位" required="" autofocus="" type="text">
        <input id="amt" placeholder="金額" required="" autofocus="" type="text">
		<br/>
		<input class="btn btn-info" type="button" value="新增" onclick="addUser();"/>
	</form>
</body>
<br><br><br>
<body>
<table id="expensesGrid" class="table table-striped"><tbody></tbody></table>
</body>
<script>
	$( document ).ready(function() {
	    initExpensesGrid();
	    findAll();
	});

	
	function initExpensesGrid(){
		
		$("#expensesGrid").jqGrid({
		      datatype: "local",
		      height: "auto",  // Grid高度
		      autowidth: true, // 自動欄寬
		      rownumbers: true,
		      multiSort : true,
		      multiselect: true,
		      colNames:['請款日','發生日期', '請款店家', '發生店家','支出去向','項目','支出內容','請款人','時間','班別','單價','數量','單位','金額'],
		      colModel:[
		        {name:'billDate',index:'billDate'},
		        {name:'realDate',index:'realDate'},
		        {name:'billStore',index:'billStore'},
		        {name:'realStore',index:'realStore'},
		        {name:'source',index:'source'},
		        {name:'accountIteam',index:'accountIteam'},
		        {name:'detail',index:'detail'},
		        {name:'payee',index:'payee'},
		        {name:'workTime',index:'workTime'},
		        {name:'workType',index:'workType'},
		        {name:'price',index:'price'},
		        {name:'quantity',index:'quantity'},
		        {name:'unit',index:'unit'},
		        {name:'amt',index:'amt'}
		       ],
		       
		      caption: "Expenses data grid",
		      rowNum:10,  // 由Server取回10筆
		      rowList:[10,20,30],  // 每頁顯示筆數
		      beforeSelectRow: function(rowid, e) // 單選
		      {
		          jQuery("#expensesGrid").jqGrid('resetSelection');
		          return(true);
		      },
		      onSelectRow: onSelectGridRow
		});  // jqGrid
	}
	
	function onSelectGridRow(id){
		var row = $("#expensesGrid").jqGrid('getRowData', id)
		
		for (var o in row) {
			$("#"+o).val(row[o]);
		}
	}

	function findAll(){
	    $.ajax({
	        type: 'GET',
	        url: "/song/expenses/queryAll",
	        dataType: "json", // data type of response

	        success: function(expensesList){
	        	for(var i in expensesList){
	        		$("#expensesGrid").jqGrid('addRowData',i+1,expensesList[i]);
	        	}
	        },

	         error:function(xhr, ajaxOptions, thrownError){
	            alert(xhr.status);
	            alert(thrownError);
	         }
	    });
	}

	function addUser(){
		$.ajax({
	        type: 'POST',
	        contentType: 'application/json',
	        url: "/song/expenses/add",
	        dataType: "json",
	        data: formToJSON(),
	        success: function(expensesList){
	            alert('add ok!');
	            $('#expensesGrid').jqGrid('clearGridData');
	        	for(var i in expensesList){
	        		$("#expensesGrid").jqGrid('addRowData',i+1,expensesList[i]);
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown){
	            alert('addExpenses error: ' + textStatus);
	        }
	    });
	}

	function formToJSON() {
		return JSON.stringify({
	        "billDate": new Date($('#billDate').val()),
	        "realDate": new Date($('#realDate').val()),
	        "billStore": $('#billStore').val(),
	        "realStore": $('#realStore').val(),
	        "source": $('#source').val(),
	        "accountIteam": $('#accountIteam').val(),
	        "detail": $('#detail').val(),
	        "payee": $('#payee').val(),
	        "workTime": $('#workTime').val(),
	        "workType": $('#workType').val(),
	        "price": $('#price').val(),
	        "quantity": $('#quantity').val(),
	        "unit": $('#unit').val(),
	        "amt": $('#amt').val()
	        });
	}
</script>


</html>
