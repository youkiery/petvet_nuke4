<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>

<style>
	.btn-default {
		color: #333 !important;
	}
</style>

{modal}

<div class="form-group" style="float: right;">
	<button class="btn btn-info" onclick="overflowModal()">
		Danh sách quá ngày
	</button>
	<!-- <button class="btn btn-info" onclick="filterModal()">
		Lọc danh sách
	</button> -->
	<button class="btn btn-info" onclick="insertModal()">
		Thêm phiếu siêu âm
	</button>
</div>
<div style="clear: both;"></div>

<div class="form-group">
	<!-- BEGIN: type -->
	<a href="{type_link}" class="{type_button} btn" role="button">
		{type_name}
	</a>
	<!-- END: type -->
</div>

<div id="html_content">
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
		type: {select_status},
		id: 0,
		recall: '{recall_date}'
	}

	$('.date').datepicker({
		format: 'dd-mm-yyyy'
	});

	function insertModal() {
		$("#insert-modal").modal('show')
	}
	function filterModal() {
		$("#filter-modal").modal('show')
	}
	function overflowModal() {
		$("#overflow-modal").modal('show')
	}

	$("#vaccine_status").change((e) => {
		if (e.currentTarget.value == 4) {
			$("#recall").attr("disabled", false);
		}
		else {
			$("#recall").attr("disabled", true);
		}
	})

	$("#birthnumber").change((e) => {
		if (e.currentTarget.value.length > 0) {
			$("#firstvac").attr("disabled", false);
			$("#vaccine_status").attr("disabled", false);
		}
	})

	function removeUsg(id) {
		var answer = confirm("Xóa bản ghi này?");
		if (answer) {
			$.post(
				"",
				{ action: "remove-usg", id: id },
				(response, status) => {
					checkResult(response, status).then(data => {
						$("#html_content").html(data['html'])
					})
				}
			)
		}
	}

	function overflowFilter() {
		$.post(
			"",
			{ action: "overflow", data: {
					keyword: $("#overflow-keyword").val(),
					from: $("#overflow-from").val(),
					end: $("#overflow-end").val()
				} 
			},
			(response, status) => {
				checkResult(response, status).then(data => {
					$("#overflow-content").html(data['html'])
				})
			}
		)
	}

	function update_usg(e) {
		e.preventDefault()
		$.post(
			"",
			{ action: "update_usg", id: g_id, cometime: $("#cometime2").val(), calltime: $("#calltime2").val(), doctorid: $("#doctor2").val(), note: $("#note2").val(), image: $("#image2").val(), birth: $("#birthnumber").val(), exbirth: $("#exbirth").val(), recall: $("#recall").val(), vaccine: $("#vaccine_status").val(), birthday: $("#birth").val(), firstvac: $("#firstvac").val(), customer: g_customerid },
			(response, status) => {
				var data = JSON.parse(response)
				if (data["status"]) {
					$("#usgupdate").modal("toggle");
					g_id = -1
					window.location.reload()
				}
			}
		)
	}

	function themsieuam(event) {
		event.preventDefault();
		msg = "";
		if (!customer_name) {
			msg = "Chưa nhập tên khách hàng!"
		} else if (!customer_phone.value) {
			msg = "Chưa nhập số điện thoại!"
		} else if (!pet_info.value) {
			msg = "Khách hàng chưa có thú cưng!"
		} else {
			$.post(
				"",
				{ action: 'insert-usg', petid: pet_info.value, doctorid: $("#doctor").val(), cometime: $("#ngaysieuam").val(), calltime: $("#calltime").val(), image: "", note: $("#note").val() },
				(data, status) => {
					data = JSON.parse(data);
					if (data["status"] == 1) {
						window.location.reload();
					}
				}
			)
		}
		alert_msg(msg);
		return false;
	}

	function changeStatus(id, type) {
		if ((global['type'] == 0 && type == 0)) {
			// alert_msg('');
		}
		else if ((global['type'] == 2 && type == 1)) {
			recall(id)
		}
		else {
			$.post(
				"",
				{ action: "change-status", data: {
						id: id,
						type: type
					}
				},
				(response, status) => {
					checkResult(response, status).then(data => {
						alert_msg('Đã thay đổi trạng thái');
						$("#html_content").html(data['html'])
					})
				}
			)
		}
	}

	function recall(id, disease) {
		global.id = id
		global.disease = disease
		$("#recall-recall").val(global.recall)
		$("#recall-modal").modal('show')
	}

	function recallSubmit() {
		sdata = {
			id: global.id,
			birth: $("#recall-birth").val(),
			doctor: $("#recall-doctor").val(),
			recall: $("#recall-recall").val()
		}
		$.post(
			"",
			{ action: "recall", data: sdata
			},
			(response, status) => {
				checkResult(response, status).then(data => {
					alert_msg('Đã thay đổi trạng thái');
					$("#html_content").html(data['html'])
					$("#recall-modal").modal('hide')
				})
			}
		)
	}

	function changeVaccineStatus(id, type) {
		if (global['type'] == 0 && type == 0) {
			// alert_msg('');
		}
		else if (global['type'] == 2 && type == 1) {
			birth(id);
			// $("#usgrecall").modal("toggle")
		}
		else {
			$.post(
				"",
				{ action: "change-vaccine-status", data: {
						id: id,
						type: type
					}
				},
				(response, status) => {
					checkResult(response, status).then(data => {
						alert_msg('Đã thay đổi trạng thái');
						$("#html_content").html(data['html'])
					})
				}
			)
		}
	}

	function birth(id) {
		global.id = id
		$("#birth-recall").val(global.recall)
		$("#birth-modal").modal('show')
	}

	function birthRecall() {
		sdata = {
			id: global.id,
			doctor: $("#birth-doctor").val(),
			disease: $("#birth-disease").val(),
			petname: $("#birth-petname").val(),
			recall: $("#birth-recall").val()
		}
		if (!sdata['petname'].length) {
			sdata['petname'] = 'Chưa đề tên'
		}
		$.post(
			"",
			{ action: "birth-recall", data: sdata
			},
			(response, status) => {
				checkResult(response, status).then(data => {
					alert_msg('Đã thay đổi trạng thái');
					$("#html_content").html(data['html'])
					$("#birth-modal").modal('hide')
				})
			}
		)
	}

	function filterSubmit() {
		keyList = (window.location.search.slice(1, window.location.search.length)).split('&')
		http = {}
		keyList.forEach(keystring => {
			data = keystring.split('=')
			http[data[0]] = data[1]
		});
		$(".filter").each((index, item) => {
			http[item.getAttribute('name')] = item.value
			// http[item.getAttribute('name')] = item.value.replace(/\//g, '-')
		})
		
		http = window.location.origin + window.location.pathname + '?' + Object.keys(http).map(k => esc(k) + '=' + esc(http[k])).join('&')
		window.location.replace(http)
	}

	function update(e, id) {
		g_id = id
		$("#btn_usg_update").attr("disabled", true);
		// $("#birth").attr("disabled", true);
		// $("#birthnumber").attr("disabled", true);
		$("#firstvac").attr("disabled", true);
		$("#vaccine_status").attr("disabled", true);
		$("#recall").attr("disabled", true);
		$.post(
			"",
			{ action: "usg_info", id: g_id },
			(response, status) => {
				var data = JSON.parse(response);
				if (data["status"]) {
					$("#btn_usg_update").attr("disabled", false);
					g_customerid = data["data"]["customerid"]
					g_petid = data["data"]["petid"]

					g_pet = trim(e.target.parentElement.parentElement.children[1].innerText)
					$("#cometime2").val(data["data"]["cometime"])
					$("#calltime2").val(data["data"]["calltime"])
					$("#doctor2").val(data["data"]["doctorid"])
					$("#note2").val(data["data"]["note"])
					$("#image2").val(data["data"]["image"])
					$("#birthnumber").val(data["data"]["birth"])
					$("#birth").val(data["data"]["birthday"])
					$("#exbirth").val(data["data"]["exbirth"])
					$("#vaccine_status").html(data["data"]["vaccine"])
					if (data["data"]["birth"] > 0) {
						$("#firstvac").attr("disabled", false);
						$("#firstvac").val(data["data"]["firstvac"]);
						$("#vaccine_status").attr("disabled", false);
						if (data["data"]["recall"] > 0 || data["data"]["vacid"] == 4) {
							$("#recall").attr("disabled", false);
							$("#recall").val(data["data"]["recall"])
						}
					}
				}
			}
		)
	}

	suggest_init()
</script>
<!-- END: main -->