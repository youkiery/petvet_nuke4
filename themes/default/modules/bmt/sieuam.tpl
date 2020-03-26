<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>
<div style="float: right;">
	<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/contact_add_small.png')" class="vac_icon" onclick="addCustomer()">
		<img src="/themes/default/images/vaccine/trans.png" title="Thêm khách hàng"> 
	</div>
	<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/pet_add.png')" class="vac_icon" tooltip="Thêm thú cưng" onclick="addPet()">
		<img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng"> 
	</div>
</div>
<br>
<form id="add" onsubmit="return themsieuam(event)" autocomplete="off">
	<div class="form-detail">
		<h2>
			{lang.usg_title}
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
			<div class="form-group col-md-6">
				<label>{lang.petname}</label>
				<select class="form-control" id="pet_info" style="text-transform: capitalize;" name="petname"></select>
			</div>
			<div class="form-group col-md-6">
				<label>{lang.usgcome}</label>
				<div class="input-group date" data-provide="datepicker">
					<input type="text" class="form-control" id="ngaysieuam" value="{now}" readonly>
					<div class="input-group-addon">
							<span class="glyphicon glyphicon-th"></span>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<label>{lang.usgcall}</label>
				<div class="input-group date" data-provide="datepicker">
					<input type="text" class="form-control" id="calltime" value="{dusinh}" readonly>
					<div class="input-group-addon">
							<span class="glyphicon glyphicon-th"></span>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<label>{lang.usgexbirth}</label>
				<input type="number" class="form-control" id="exbirth" value="0">
			</div>
		</div>
		<div class="form-group">
			<label>{lang.image}</label>
			<input class="form-control" type="text" name="hinhanh" id="hinhanh" disabled>
			<div class="icon upload" type="button" value="{lang.selimage}" name="selectimg" ></div>
			<br>
		</div>
		<div class="row">
			<div class="form-group col-md-12">
				<label>{lang.doctor}</label>
				<select class="form-control" name="doctor" id="doctor" style="width: 90%;">
					<!-- BEGIN: doctor -->
					<option value="{doctor_value}">{doctor_name}</option>
					<!-- END: doctor -->
				</select>
			</div>
			<div class="form-group col-md-12">
				<label>{lang.note}</label>
				<textarea class="form-control" id="ghichu" rows="3"></textarea>
			</div>
		</div>
		<div class="form-group text-center">
			<input class="btn btn-info" type="submit" value="{lang.submit}">
		</div>
	</div>
</form>
<script>
	var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
	var adlink = "/adminpet/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
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

	function xoasieuam(id) {
		var answer = confirm("Xóa bản ghi này?");
		if (answer) {
			$.post(
				"",
				{action: "xoasieuam", id: id},
				(data, status) => {
					data = JSON.parse(data);
					if (data["status"]) {
						window.location.reload()
					}
				}
			)	
		}
	}

	function themsieuam(event) {
		event.preventDefault();
		msg = "";
		if(!customer_name) {
			msg = "Chưa nhập tên khách hàng!"
		} else if(!customer_phone.value) {
			msg = "Chưa nhập số điện thoại!"
		} else if(!pet_info.value) {
			msg = "Khách hàng chưa có thú cưng!"
		} else {
			$.post(
				link + "themsieuam",
				{petid: pet_info.value, doctorid: $("#doctor").val(), cometime: $("#ngaysieuam").val(), calltime: $("#calltime").val(), image: $("#hinhanh").val(), note: $("#note").val(), exbirth: $("#exbirth").val()},
				(data, status) => {
					data = JSON.parse(data);
					if (data["status"] == 1) {
						alert_msg("Đã lưu vào lịch báo siêu âm");
            customer_list[g_index]["customer"] = customer_name.value
            customer_list[g_index]["address"] = customer_address.value
            g_index = -1;
						customer_name.value = ""
						customer_phone.value = ""
            customer_address.value = ""
						pet_info.innerHTML = ""
						$("#hinhanh").val("");
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

	suggest_init()
	$('#calltime, #ngaysieuam').datepicker({
   	format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
	});

	$("div[name=selectimg]").click(function(){
		var area = "hinhanh";
		var path= "{NV_UPLOADS_DIR}/{module_name}";	
		var currentpath= "{CURRENT}";						
		var type= "image";
		nv_open_browse_file("{NV_BASE_ADMINURL}index.php?{NV_NAME_VARIABLE}=upload&popup=1&area=" + area+"&path="+path+"&type="+type+"&currentpath="+currentpath, "NVImg", "850", "400","resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
		return false;
	});
</script>
<!-- END: main -->
