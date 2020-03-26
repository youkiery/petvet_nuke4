<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<div id="msgshow" class="msgshow"></div>
<style>
		#ui-datepicker-div {
			z-index: 10000 !important;
		}
	</style>
<div style="float: right;">
	<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/contact_add_small.png')" class="vac_icon" onclick="addCustomer()">
		<img src="/themes/default/images/vaccine/trans.png" title="Thêm khách hàng"> 
	</div>
	<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/pet_add.png')" class="vac_icon" tooltip="Thêm thú cưng" onclick="addPet()">
		<img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng"> 
	</div>
</div>
<br>
<form onsubmit="return themluubenh(event)" autocomplete="off">
	<h2>
			{lang.treat_title}
			<span id="e_notify" style="display: none;"></span>
	</h2>
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
		<div class="form-group col-md-12">
			<label>{lang.petname}</label>
			<select class="form-control" id="pet_info" style="text-transform: capitalize;" name="petname"></select>
		</div>
		<div class="form-group col-md-12">
			<label>{lang.treatcome}</label>
			<div class="input-group date" data-provide="datepicker">
				<input type="text" class="form-control" id="ngayluubenh" value="{now}" readonly>
				<div class="input-group-addon">
						<span class="glyphicon glyphicon-th"></span>
				</div>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label>{lang.temperate} </label>
		<input class="form-control" type="text" id="temperate">
	</div>
	<div class="form-group">
		<label>{lang.eye} </label>
		<input class="form-control" type="text" id="eye">
	</div>
	<div class="form-group">
		<label>{lang.other} </label>
		<input class="form-control" type="text" id="other">
	</div>
	<div class="form-group">
		<label>{lang.treating} </label>
		<input class="form-control" type="text" id="treating2">
	</div>
	<div class="row">
		<div class="form-group col-md-12">
			<label>{lang.doctor2} </label>
			<select class="form-control" name="doctor" id="doctor">
				<!-- BEGIN: doctor -->
				<option value="{doctor_value}">{doctor_name}</option>
				<!-- END: doctor -->
			</select>
		</div>
		<div class="form-group col-md-12">
			<label>{lang.pet_status}</label>
			<select class="form-control" name="tinhtrang" id="tinhtrang2">
				<!-- BEGIN: status -->
				<option value="{status_value}">{status_name}</option>
				<!-- END: status -->
			</select>
		</div>
	</div>
	<div class="form-group text-center">
		<input class="btn btn-info" type="submit" value="{lang.submit}">
	</div>
</form>
<script>
		var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
		var blur = true;
		var g_customer = -1;
		var customer_data = [];
		var customer_list = [];
		var g_index = -1
		var customer_name = document.getElementById("customer_name");
		var customer_phone = document.getElementById("customer_phone");
		var customer_address = document.getElementById("customer_address");
		var pet_info = document.getElementById("pet_info");
		var pet_note = document.getElementById("pet_note");
		var suggest_name = document.getElementById("customer_name_suggest");
		var suggest_phone = document.getElementById("customer_phone_suggest");

	$('#ngayluubenh').datepicker({
		format: 'dd/mm/yyyy',
        changeMonth: true,
        changeYear: true
	});

	function themluubenh(event) {
    event.preventDefault();
    // return false;
		msg = "";
		if(!customer_name) {
			msg = "Chưa nhập tên khách hàng!"
		} else if(!customer_phone.value) {
			msg = "Chưa nhập số điện thoại!"
		} else if(!pet_info.value) {
			msg = "Khách hàng chưa có thú cưng!"
		} else {
			$.post(
				link + "themluubenh",
				{"customer": customer_name.value, "phone": customer_phone.value, "address": customer_address.value, petid: pet_info.value, doctorid: $("#doctor").val(), cometime: $("#ngayluubenh").val(), note: $("#ghichu").val(), status: $("#tinhtrang2").val(), treating: $("#treating2").val(), eye: $("#eye").val(), other: $("#other").val(), temperate: $("#temperate").val()},
				(data, status) => {
					data = JSON.parse(data);
					if (data["status"] == 1) {
            alert_msg(data["data"]);
            customer_list[g_index]["customer"] = customer_name;
            customer_list[g_index]["phone"] = customer_phone;
            g_index = -1;
						customer_name.value = "";
						customer_phone.value = "";
						customer_address.value = "";
						pet_info.innerHTML = "";
						$("#temperate").val("");
						$("#eye").val("");
						$("#other").val("");
						$("#treating2").val("");
						g_customer = -1;
					}
					else {
						msg = data["data"];
						showMsg(msg);
					}
				}
			)
		}
		showMsg(msg);
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
		if(blur) {
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
		if(blur) {
			suggest_phone.style.display = "none";
		}
	})

</script>
<!-- END: main -->
