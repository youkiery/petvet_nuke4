<!-- BEGIN: main -->
<style>
	#doctor_red ul {
		list-style-type: decimal;
		max-height: 640px;
		overflow-y: scroll;
	}
	#doctor_red ul li {
		padding: 8px 4px;
    margin-top: 1px;
		border-bottom: 1px solid #ddd;
	}
</style>
<div style="float: left;width: 40%;text-align: center;border: 1px solid #aaa;padding: 1px;">
	<form onsubmit="return doctoradd()">
		<div style="text-align: left;background: #ddd;height: 2em;line-height: 2em;padding: 4px;margin-bottom: 1px;">
			{lang.doctor_manager}
		</div>
		<div>
			<input class="form-control" type="text" id="doctor_name" placeholder="{lang.doctor_name}">
		</div>
		<div>
			<input class="btn btn-info" type="submit" id="doctor_add" value="{lang.add}">
		</div>	
	</form>
	<div id="e_notify" style="display: none;"></div>
</div>
<div style="float: right; width: calc(60% - 20px);border: 1px solid #aaa;padding: 1px;">
	<div style="background: #ddd;height: 2em;line-height: 2em;padding: 4px;margin-bottom: 1px;">
		{lang.doctor_list}
	</div>
	<div id="doctor_red">
		{list}
	</div>
</div>
<script>
	var link = script_name + "?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=doctor";
	function edit(index) {
		var name = prompt("Nhập tên bác sĩ", trim($("#name_" + index).text()));
		var msg = "";
		
		if (name) {
			$.get(
				link + "&action=doctoredit&doctor=" + name + "&id=" + index,
				(data, status) => {
					data = JSON.parse(data);
					switch (data["status"]) {
						case 1:
							window.location.reload()
						break;
						case 2:
							msg = "Tên này đã đươc sử dụng!";
						break;
						default:
							msg = "Có lỗi xảy ra!";
					}
				}
			)
		}
		if(msg) showMsg(msg);
	}

	function del(index) {
		var answer = confirm("Xóa bác sĩ: " + trim($("#name_" + index).text()) + "?");
		var msg = "";
		if (answer) {
			$.post(
				link,
				{action: "doctordel", id: index},
				(data, status) => {
					data = JSON.parse(data);
					switch (data["status"]) {
						case 1:
							window.location.reload()
						break;
						case 2:
							msg = "Tên này đã đươc sử dụng!";
						break;
						default:
							msg = "Có lỗi xảy ra!";
					}
					showMsg(msg);
				}
			)
		}
	}

	function doctoradd() {
		doctor = trim($("#doctor_name").val());
		msg = "";
		if(trim(doctor)) {
			$.get(
				link + "&action=doctoradd&doctor=" + doctor,
				(data, status) => {
					data = JSON.parse(data);
					switch (data["status"]) {
						case 1:
							window.location.reload()
						break;
						case 2:
							msg = "Tên này đã đươc sử dụng!";
						break;
						default:
							msg = "Có lỗi xảy ra!";
					}
					showMsg(msg);
				}
			)
		} else {
			msg = "Tên vẫn còn trống kìa";
			grinError($("#doctor_name"));
		}
		showMsg(msg);
		return false;
	}
</script>
<!-- END: main -->
