<!-- BEGIN: main -->
<style>
  #ui-datepicker-div {
    z-index: 10000 !important;
  }
</style>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>
<div id="reman"></div>
<div id="usgupdate" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
				<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/congnghe/images/vaccine/contact_edit.png')" class="vac_icon" onclick="update_customer(g_customerid)">
					<img src="/themes/default/images/vaccine/trans.png" title="Sửa khách hàng"> 
				</div>
				<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/congnghe/images/vaccine/pet_edit.png')" class="vac_icon" tooltip="Sửa thú cưng" onclick="update_pet(g_petid, g_pet)">
					<img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng"> 
				</div>
      </div>
      <div class="modal-body">
				<form onsubmit="return update_usg(event)" autocomplete="off">
					<div>
							{lang.usg_update}
							<span id="e_notify" style="display: none;"></span>
					</div>
					<div class="row">
						<div class="form-group col-md-8">
							<label>{lang.usgcome}</label>
							<div class="input-group date" data-provide="datepicker">
								<input type="text" class="form-control" id="cometime2" value="{now}" readonly>
								<div class="input-group-addon">
										<span class="glyphicon glyphicon-th"></span>
								</div>
							</div>
						</div>
						<div class="form-group col-md-8">
							<label>{lang.usgcall}</label>
							<div class="input-group date" data-provide="datepicker">
								<input type="text" class="form-control" id="calltime2" value="{now}" readonly>
								<div class="input-group-addon">
										<span class="glyphicon glyphicon-th"></span>
								</div>
							</div>
						</div>
						<div class="form-group col-md-8">
							<label>{lang.exbirth}</label>
							<input class="form-control" id="exbirth" type="number">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-12">
							<label>{lang.birthday}</label>
							<div class="input-group date" data-provide="datepicker">
								<input type="text" class="form-control" id="birth" value="{now}" readonly>
								<div class="input-group-addon">
										<span class="glyphicon glyphicon-th"></span>
								</div>
							</div>
						</div>
						<div class="form-group col-md-12">
							<label>{lang.birth}</label>
							<input class="form-control" id="birthnumber" type="number">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-8">
							<label>{lang.firstvac}</label>
							<div class="input-group date" data-provide="datepicker">
								<input type="text" class="form-control" id="firstvac" value="{now}" readonly>
								<div class="input-group-addon">
										<span class="glyphicon glyphicon-th"></span>
								</div>
							</div>
						</div>
						<div class="form-group col-md-8">
							<label>{lang.vaccine}</label>
							<select class="form-control" id="vaccine_status"> </select>
						</div>
						<div class="form-group col-md-8">
							<label>{lang.recall}</label>
							<div class="input-group date" data-provide="datepicker">
								<input type="text" class="form-control" id="recall" value="{now}" readonly>
								<div class="input-group-addon">
										<span class="glyphicon glyphicon-th"></span>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label>{lang.doctor}</label>
						<select class="form-control" name="doctor" id="doctor2">
								<!-- BEGIN: doctor3 -->
								<option value="{doctor_value}">{doctor_name}</option>
								<!-- END: doctor3 -->
							</select>
						</div>
						<div class="form-group">
							<label>{lang.image}</label>
							<input class="form-control" class="input inmax" type="text" name="hinhanh" id="image2" disabled>
							<div class="icon upload" type="button" value="{lang.chonanh}" name="selectimg" ></div>
							<br>
						</div>
						<div class="form-group">
							<label>{lang.note}</label>
							<textarea class="form-control" id="note2" rows="3"></textarea>
						</div>
						<div class="form-group text-center">
							<button class="btn btn-info" id="btn_usg_update">
								{lang.submit}
							</button>
						</div>
					</form>
			</div>
		</div>
  </div>
</div>

<form method="GET">
	<input type="hidden" name="nv" value="{nv}">
	<input type="hidden" name="op" value="{op}">
	<div class="row">
		<div class="form-group col-md-8">
				<label>{lang.keyword}</label>
				<input class="form-control" type="text" name="keyword" id="keyword" value="{keyword}" placeholder="{lang.keyword}">
		</div>
		<div class="form-group col-md-8">
			<label>{lang.startday}</label>
			<div class="input-group date" data-provide="datepicker">
				<input type="text" class="form-control" id="from" name="from" value="{from}" readonly>
				<div class="input-group-addon">
						<span class="glyphicon glyphicon-th"></span>
				</div>
			</div>
		</div>
		<div class="form-group col-md-8">
				<label>{lang.endday}</label>
				<div class="input-group date" data-provide="datepicker">
					<input type="text" class="form-control" id="to" name="to" value="{to}" readonly>
					<div class="input-group-addon">
							<span class="glyphicon glyphicon-th"></span>
					</div>
				</div>
		</div>
	</div>
	<div class="row">
		<div class="form-group col-md-12">
			<label>{lang.sort}</label>
			<select class="form-control" name="sort" id="sort">
				<!-- BEGIN: sort -->
				<option value="{sort_value}" {sort_check}>{sort_name}</option>
				<!-- END: sort -->
			</select>
		</div>
		<div class="form-group col-md-12">
			<label>{lang.count}</label>
			<select class="form-control" name="filter" id="time">
				<!-- BEGIN: time -->
				<option value="{time_value}" {time_check}>{time_name}</option>
				<!-- END: time -->
			</select>
		</div>
	</div>
	<div class="form-group text-center">
		<button class="btn btn-info">
			{lang.filter}
		</button>
	</div>
</form>
<img class="anchor" src="/themes/default/images/vaccine/add.png" alt="{lang.themsieuam}" title="themsieuam" onclick="$('#add').toggle(500)">
<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/contact_add_small.png')" class="vac_icon" onclick="addCustomer()">
	<img src="/themes/default/images/vaccine/trans.png" title="Thêm khách hàng"> 
</div>
<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/pet_add.png')" class="vac_icon" tooltip="Thêm thú cưng" onclick="addPet()">
	<img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng"> 
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
			<div class="form-group col-md-10">
				<label>{lang.petname}</label>
				<select class="form-control" id="pet_info" style="text-transform: capitalize;" name="petname"></select>
			</div>
			<div class="form-group col-md-7">
				<label>{lang.usgcome}</label>
				<div class="input-group date" data-provide="datepicker">
					<input type="text" class="form-control" id="ngaysieuam" value="{now}" readonly>
					<div class="input-group-addon">
							<span class="glyphicon glyphicon-th"></span>
					</div>
				</div>
			</div>
			<div class="form-group col-md-7">
				<label>{lang.usgcall}</label>
				<div class="input-group date" data-provide="datepicker">
					<input type="text" class="form-control" id="calltime" value="{now}" readonly>
					<div class="input-group-addon">
							<span class="glyphicon glyphicon-th"></span>
					</div>
				</div>
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
				<select class="form-control" name="doctor" id="doctor">
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
			<input class="btn btn-info" type="submit" value="{lang.submit}" data-dismiss="modal">
		</div>
	</div>
</form>

<div id="html_content">
	{content}
</div>
<script>
	var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
	var adlink = "/admin/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
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

	$('#cometime2, #calltime2, #calltime, #ngaysieuam, #recall, #birth, #firstvac, #from, #to').datepicker({
    format: 'dd/mm/yyyy'
  });


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

	function xoasieuam(id) {
		var answer = confirm("Xóa bản ghi này?");
		if (answer) {
			$.post(
				"",
				{action: "xoasieuam", id: id},
				(data, status) => {
					data = JSON.parse(data);
					if (data) {
						window.location.reload()
					}
				}
			)	
		}
	}

	function update_usg(e) {
		e.preventDefault()
		$.post(
			adlink + "sieuam",
			{action: "update_usg", id: g_id, cometime: $("#cometime2").val(), calltime: $("#calltime2").val(), doctorid: $("#doctor2").val(), note: $("#note2").val(), image: $("#image2").val(), birth: $("#birthnumber").val(), exbirth: $("#exbirth").val(), recall: $("#recall").val(), vaccine: $("#vaccine_status").val(), birthday: $("#birth").val(), firstvac: $("#firstvac").val(), customer: g_customerid},
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
		if(!customer_name) {
			msg = "Chưa nhập tên khách hàng!"
		} else if(!customer_phone.value) {
			msg = "Chưa nhập số điện thoại!"
		} else if(!pet_info.value) {
			msg = "Khách hàng chưa có thú cưng!"
		} else {
			$.post(
				link + "themsieuam",
				{petid: pet_info.value, doctorid: $("#doctor").val(), cometime: $("#ngaysieuam").val(), calltime: $("#calltime").val(), image: $("#hinhanh").val(), note: $("#note").val()},
				(data, status) => {
					data = JSON.parse(data);
					if (data["status"] == 1) {
						window.location.reload();
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

	function update(e, id) {
		g_id = id
		$("#btn_usg_update").attr("disabled", true);
		// $("#birth").attr("disabled", true);
		// $("#birthnumber").attr("disabled", true);
		$("#firstvac").attr("disabled", true);
		$("#vaccine_status").attr("disabled", true);
		$("#recall").attr("disabled", true);
		$.post(
			adlink + "sieuam",
			{action: "usg_info", id: g_id},
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
