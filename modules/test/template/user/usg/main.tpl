<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/modules/core/js/vhttp.js"></script>
<script type="text/javascript"
	src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>

<style>
	td {
		font-size: 0.8em;
	}

  th {
    position: sticky;
    top: 0px;
    background: white;
    z-index: 10;
    border-bottom: 1px solid black;
    text-align: center;
    vertical-align: inherit !important;
  }
</style>

{modal}

<!-- BEGIN: manager -->
<div class="form-group" style="float: right;">
	<button class="btn btn-info" onclick="insertModal()">
		Thêm phiếu siêu âm
	</button>
</div>
<div style="clear: both;"></div>
<!-- END: manager -->

<div class="form-group">
	<a href="/{module_name}/{op}/?type=1{filter_param}" class="{type_button1} btn" role="button">
		Danh sách gần sinh
	</a>
	<a href="/{module_name}/{op}/?type=2{filter_param}" class="{type_button2} btn" role="button">
		Danh sách đã sinh
	</a>
	<a href="/{module_name}/{op}/?type=3{filter_param}" class="{type_button3} btn" role="button">
		Danh sách tiêm phòng
	</a>
	<!-- BEGIN: manager2 -->
	<a href="/{module_name}/{op}/?type=4{filter_param}" class="{type_button4} btn" role="button">
		Danh sách quản lý
	</a>
	<!-- END: manager2 -->
</div>

<div id="content">
	{content}
</div>
<script>
	var g_id = -1
	var g_customerid = -1
	var g_petid = -1
	var g_pet = ""
	var blur = true;
	var g_customer = -1;
	var customer_data = [];
	var customer_list = [];
	var customer_name = document.getElementById("customer_name");
	var customer_phone = document.getElementById("customer_phone");
	var customer_address = document.getElementById("customer_address");
	var pet_info = document.getElementById("pet_info");
	var pet_note = document.getElementById("pet_note");
	var suggest_name = document.getElementById("customer_name_suggest");
	var suggest_phone = document.getElementById("customer_phone_suggest");
	var esc = encodeURIComponent;

	var global = {
	// 	type: {select_status},
		id: 0,
	// 	recall: '{recall_date}'
	}

	$('.date').datepicker({
		format: 'dd-mm-yyyy'
	});

	function insertModal() {
		$("#insert-modal").modal('show')
	}

	function editNote(id) {
		var answer = prompt("Ghi chú: ", trim($("#note_v" + id).text()));
		if (answer) {
			$.post(
				"",
				{action: "edit-note", note: answer, id: id},
				(response, status) => {
					checkResult(response, status).then(data => {
						$("#note_v" + id).text(answer);
					})
				}
			)
		}
	}


	function checkData() {
		return {
			customer: g_customer,
			pet: $("#pet_info").val(),
			usgtime: $("#ngaysieuam").val(),
			expecttime: $("#calltime").val(),
			expectnumber: $("#expectnumber").val(),
			doctor: $("#doctor").val(),
			note: $("#note").val()
		}
	}

	// thêm siêu âm
	// khách hàng và thú cưng bắt buộc phải chọn
	function usgInsertSubmit() {
		sdata = checkData()
		if (sdata['customer'] <= 0) alert_msg('Chưa chọn khách hàng')
		else if (sdata['pet'] <= 0) alert_msg('Chưa chọn thú cưng')
		else {
			freeze()
			vhttp.check('', { action: 'insert-usg', data: sdata }).then(data => {
				$("#content").html(data['html'])
				// xóa dữ liệu
				$("#customer_name").val('')
				$("#customer_phone").val('')
				$("#customer_address").val('')
				$("#pet_info").html('')
				$("#ghichu").val('')
				g_customer = -1
				$("#content").html(data['html'])
				$("#insert-modal").modal('hide')
				defreeze()
			}, () => { defreeze() })
		}
	}

	function changeRecall(id, type) {
		freeze()
		vhttp.check('', { action: 'change-recall', id: id, type: type }).then(data => {
			$("#content").html(data['html'])
			defreeze()
		}, () => { defreeze() })
	}

	function birth(id) {
		global.id = id
		$("#birth-modal").modal('show')
	}

	function birthSubmit() {
		freeze()
		vhttp.check('',
			{
				action: 'birth',
				id: global['id'],
				number: $("#birth-number").val(),
				time: $("#birth-time").val()
			}
		).then(data => {
			$("#content").html(data['html'])
			$("#birth-modal").modal('hide')
			defreeze()
		}, () => { defreeze() })
	}

	function vaccineRecall(id) {
		global['id'] = id
		$("#vaccine-modal").modal('show')
	}

	function vaccineSubmit() {
		freeze()
		vhttp.check('',
			{
				action: 'vaccine',
				id: global['id'],
				disease: $("#birth-disease").val(),
				doctor: $("#birth-doctor").val(),
				time: $("#birth-time").val()
			}
		).then(data => {
			$("#content").html(data['html'])
			$("#vaccine-modal").modal('hide')
			defreeze()
		}, () => { defreeze() })
	}

	function rejectRecall(id) {
		global['id'] = id
		$("#reject-modal").modal('show')
	}

	function rejectSubmit() {
		freeze()
		vhttp.checkelse('',
			{
				action: 'reject',
				id: global['id']
			}
		).then(data => {
			$("#content").html(data['html'])
			$("#reject-modal").modal('hide')
			defreeze()
		}, () => { defreeze() })
	}

	function update(id) {
		global['id'] = id
		freeze()
		vhttp.check('', { action: "get-update", id: id }).then(data => {
			$("#usgtime").val(data['data']['usgtime'])
			$("#expecttime").val(data['data']['expecttime'])
			$("#expectnumber2").val(data['data']['expectnumber'])
			$("#birthtime").val(data['data']['birthtime'])
			$("#birthnumber").val(data['data']['number'])
			$("#vaccinetime").val(data['data']['vaccinetime'])
			$("#doctor2").val(data['data']['doctorid'])
			$("#note2").val(data['data']['note'])
			$("#update-modal").modal('show')
			defreeze()
		}, () => { defreeze() })
	}

	function update_usg() {
		sdata = {
			usgtime: $("#usgtime").val(),
			expecttime: $("#expecttime").val(),
			expectnumber: $("#expectnumber2").val(),
			birthtime: $("#birthtime").val(),
			number: $("#birthnumber").val(),
			vaccinetime: $("#vaccinetime").val(),
			doctorid: $("#doctor2").val(),
			note: $("#note2").val()
		}
		freeze()
		vhttp.check('', { action: "update-usg", id: global['id'], data: sdata }).then(data => {
			alert_msg('Đã lưu thông tin')
			$("#content").html(data['html'])
			$("#update-modal").modal('hide')
			defreeze()
		}, () => { defreeze() })
	}

	suggest_init()
</script>
<!-- END: main -->