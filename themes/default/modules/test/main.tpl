<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>

<div id="vac_notify"
	style="display: none; position: fixed; top: 0; right: 0; background: white; padding: 8px; border: 1px solid black; z-index: 1000;">
</div>
<div style="float: right;">
	<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/contact_add_small.png')"
		class="vac_icon" onclick="addCustomer()">
		<img src="/themes/default/images/vaccine/trans.png" title="Thêm khách hàng">
	</div>
	<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/pet_add.png')"
		class="vac_icon" tooltip="Thêm thú cưng" onclick="addPet()">
		<img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng">
	</div>
</div>
<br>
<form onsubmit="return vaccine()" autocomplete="off">
	<div class="form-detail">
		<h2> {lang.disease_title} <span id="e_notify" style="color: red; display: none;"></span> </h2>
		<div class="row">
			<div class="form-group col-md-7">
				<div>
					<label>{lang.customer}</label>
					<div class="relative">
						<input class="form-control" id="customer_name" type="text" name="customer">
						<div id="customer_name_suggest" class="suggest"></div>
					</div>
				</div>
			</div>
			<div class="form-group col-md-7">
				<div>
					<label>{lang.phone}</label>
					<div class="relative">
						<input class="form-control" id="customer_phone" type="number" name="phone">
						<div id="customer_phone_suggest" class="suggest"></div>
					</div>
				</div>
			</div>
			<div class="form-group col-md-10">
				<label>{lang.address}</label>
				<input class="form-control" id="customer_address" type="text" name="address">
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-6">
				<label>{lang.petname}</label>
				<select class="form-control" id="pet_info" style="text-transform: capitalize;" name="petname"></select>
			</div>
			<div class="form-group col-md-6">
				<label>{lang.disease}</label>
				<select class="form-control" id="pet_disease" class="vac_select_max" style="text-transform: capitalize;"
					name="disease">
					<!-- BEGIN: option -->
					<option value="{disease_id}">
						{disease_name}
					</option>
					<!-- END: option -->
				</select>
			</div>
			<div class="form-group col-md-6">
				<label>{lang.vaccome}</label>
				<div class="input-group date" data-provide="datepicker">
					<input type="text" class="form-control" id="pet_cometime" value="{now}" readonly>
					<div class="input-group-addon">
						<span class="glyphicon glyphicon-th"></span>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<label>{lang.vaccall}</label>
				<div class="input-group date" data-provide="datepicker">
					<input type="text" class="form-control" id="pet_calltime" value="{calltime}" readonly>
					<div class="input-group-addon">
						<span class="glyphicon glyphicon-th"></span>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-group col-md-12">
				<label>{lang.vacdoctor}</label>
				<select class="form-control" id="doctor">
					<!-- BEGIN: doctor -->
					<option value="{doctorid}">{doctorname}</option>
					<!-- END: doctor -->
				</select>
			</div>
			<div class="form-group col-md-12">
				<label>{lang.note}</label>
				<textarea class="form-control" id="pet_note" rows="3" style="width: 98%;"></textarea>
			</div>
		</div>
		<div class="form-group text-center">
			<input class="btn btn-info" type="submit" value="{lang.submit}">
		</div>
	</div>
</form>
<script>
	var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=main&act=post";
	var blur = true;
	var customer_data = [];
	var customer_list = [];
	var g_index = -1;
	var g_customer = -1;
	var customer_name = document.getElementById("customer_name");
	var customer_phone = document.getElementById("customer_phone");
	var customer_address = document.getElementById("customer_address");
	var pet_info = document.getElementById("pet_info");
	var pet_disease = document.getElementById("pet_disease");
	var pet_cometime = document.getElementById("pet_cometime");
	var pet_calltime = document.getElementById("pet_calltime");
	var pet_note = document.getElementById("pet_note");
	var suggest_name = document.getElementById("customer_name_suggest");
	var suggest_phone = document.getElementById("customer_phone_suggest");

	$('#pet_calltime, #pet_cometime').datepicker({
		format: 'dd/mm/yyyy',
		changeMonth: true,
		changeYear: true
	});

	function vaccine() {
		msg = "";
		if (!customer_name) {
			msg = "Chưa nhập tên khách hàng!"
		} else if (!customer_phone.value) {
			msg = "Chưa nhập số điện thoại!"
		} else if (!pet_info.value) {
			msg = "Khách hàng chưa có thú cưng!"
		} else if (!pet_disease.value) {
			msg = "Chưa có loại tiêm phòng!";
		} else if (!pet_cometime.value) {
			msg = "Chưa có thời gian tiêm phòng";
		} else if (!pet_calltime.value) {
			msg = "Chưa có ngày tái chủng!";
		}
		else {
			var data = ["action=insertvac", "customer=" + customer_name.value, "phone=" + customer_phone.value, "address=" + customer_address.value, "petid=" + pet_info.value, "diseaseid=" + pet_disease.value, "cometime=" + pet_cometime.value, "calltime=" + pet_calltime.value, "note=" + pet_note.value, "doctorid=" + document.getElementById("doctor").value];
			fetch(link, data).then((response) => {
				response = JSON.parse(response);
				switch (response["status"]) {
					case 2:
						msg = "Đã lưu vào lịch báo tiêm phòng";
						customer_list[g_index]["customer"] = customer_name.value
						customer_list[g_index]["address"] = customer_address.value
						g_index = -1;
						customer_name.value = ""
						customer_phone.value = ""
						customer_address.value = ""
						pet_info.innerHTML = ""
						pet_note.value = ""

						break;
					case 3:
						msg = "Thú cưng không tồn tại!";
						break;
					case 4:
						msg = "Khách hàng không tồn tại!";
						break;
					case 5:
						msg = "lỗi không xác định!";
						break;
					default:
						msg = "lỗi không xác định!"
				}
				alert_msg(msg);
			})
		}
		if (msg) {
			alert_msg(msg);
		}
		return false;
	}

	customer_name.addEventListener("keyup", (e) => {
		showSuggest(e.target.getAttribute("id"), true);
	})

	customer_phone.addEventListener("keyup", (e) => {
		showSuggest(e.target.getAttribute("id"), false);
	})

	suggest_name.addEventListener("mouseenter", (e) => {
		blur = false;
	})
	suggest_name.addEventListener("mouseleave", (e) => {
		blur = true;
	})
	customer_name.addEventListener("focus", (e) => {
		suggest_name.style.display = "block";
	})
	customer_name.addEventListener("blur", (e) => {
		if (blur) {
			suggest_name.style.display = "none";
		}
	})
	suggest_phone.addEventListener("mouseenter", (e) => {
		blur = false;
	})
	suggest_phone.addEventListener("mouseleave", (e) => {
		blur = true;
	})
	customer_phone.addEventListener("focus", (e) => {
		suggest_phone.style.display = "block";
	})
	customer_phone.addEventListener("blur", (e) => {
		if (blur) {
			suggest_phone.style.display = "none";
		}
	})

</script>
<!-- END: main -->