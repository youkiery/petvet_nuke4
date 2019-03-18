<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">

<div id="msgshow" class="msgshow"></div>
<div id="reman"></div>

<div id="vaccineupdate" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
				{lang.disease_title}
      </div>
      <div class="modal-body">
				<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/congnghe/images/vaccine/contact_edit.png')" class="vac_icon" onclick="update_customer(g_customerid)">
				<img src="/themes/default/images/vaccine/trans.png" title="Sửa khách hàng"> 
			</div>
			<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/congnghe/images/vaccine/pet_edit.png')" class="vac_icon" tooltip="Sửa thú cưng" onclick="update_pet(g_petid, g_pet)">
				<img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng"> 
			</div>
			<form onsubmit="return editvac()" autocomplete="off">
					<div class="form-group">
						<label>{lang.disease}</label>
						<select id="disease2" class="form-control" style="text-transform: capitalize;" name="disease">
							<!-- BEGIN: option2 -->
							<option value="{disease_id}">
								{disease_name}
							</option>
							<!-- END: option2 -->
						</select>
					</div>
					<div class="form-group">
						<label>{lang.vaccome}</label>
						<div class="input-group date" data-provide="datepicker">
							<input type="text" class="form-control" id="cometime2" value="{now}" readonly>
							<div class="input-group-addon">
									<span class="glyphicon glyphicon-th"></span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label>{lang.vaccall}</label>
						<div class="input-group date" data-provide="datepicker">
							<input type="text" class="form-control" id="calltime2" value="{now}" readonly>
							<div class="input-group-addon">
									<span class="glyphicon glyphicon-th"></span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label>{lang.doctor2}</label>
						<select class="form-control" id="doctor2">
							<!-- BEGIN: doctor2 -->
							<option value="{doctorid}">{doctorname}</option>
							<!-- END: doctor2 -->
						</select>
					</div>
					<div class="form-group">
						<label>{lang.note}</label>
						<textarea class="form-control" id="note2" rows="3" style="width: 98%;"></textarea>
					</div>
					<div class="form-group text-center">
						<input class="btn btn-info" type="submit" value="{lang.submit}">
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
			<label> {lang.keyword} </label>
			<input class="form-control" type="text" name="keyword" id="keyword" value="{keyword}" placeholder="{lang.keyword}">
		</div>
		<div class="form-group col-md-8">
			<label> {lang.startday} </label>
			<div class="input-group date" data-provide="datepicker">
				<input type="text" class="form-control" id="from" name="from" value="{from}" readonly>
				<div class="input-group-addon">
						<span class="glyphicon glyphicon-th"></span>
				</div>
			</div>
		</div>
		<div class="form-group col-md-8">
			<label> {lang.endday} </label>
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
			<label> {lang.sort} </label>
			<select class="form-control col-md-12" name="sort" id="sort">
				<!-- BEGIN: sort -->
				<option value="{sort_value}" {sort_check}>{sort_name}</option>
				<!-- END: sort -->
			</select>
		</div>
		<div class="form-group col-md-12">
			<label> {lang.count} </label>
			<select class="form-control" name="filter" id="time">
				<!-- BEGIN: time -->
				<option value="{time_value}" {time_check}>{time_name}</option>
				<!-- END: time -->
			</select>
		</div>
	</div>
	<button class="btn btn-info">
		{lang.filter}
	</button>
</form>

<img class="anchor" src="/themes/default/images/vaccine/add.png" alt="{lang.themsieuam}" title="themsieuam" onclick="$('#add').toggle(500)">
<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/contact_add_small.png')" class="vac_icon" onclick="addCustomer()">
	<img src="/themes/default/images/vaccine/trans.png" title="Thêm khách hàng"> 
</div>
<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/pet_add.png')" class="vac_icon" tooltip="Thêm thú cưng" onclick="addPet()">
	<img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng"> 
</div>
<form id="add" onsubmit="return vaccine()" autocomplete="off">
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
				<select class="form-control" id="pet_disease" class="vac_select_max" style="text-transform: capitalize;" name="disease">
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
					<input type="text" class="form-control" id="pet_calltime" value="{now}" readonly>
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
				<textarea class="form-control" id="pet_note" rows="3">{lang.note}</textarea>
			</div>
		</div>
		<div class="form-group text-center">
			<input class="btn btn-info" type="submit" value="{lang.submit}">
		</div>
	</div>
</form>


<div id="html_content">
	{content}
</div>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<script>
	var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
	var adlink = "/admin/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
	var blur = true;
	var g_customerid = -1
	var g_petid = -1
	var g_pet = ""

	var g_customer = -1;
	var g_id = -1;
	var customer_data = [];
	var customer_list = [];
	var customer_name = document.getElementById("customer_name");
	var customer_phone = document.getElementById("customer_phone");
	var customer_address = document.getElementById("customer_address");
	var pet_info = document.getElementById("pet_info");
	var pet_note = document.getElementById("pet_note");
	var suggest_name = document.getElementById("customer_name_suggest");
	var suggest_phone = document.getElementById("customer_phone_suggest");

	$('#pet_cometime, #pet_calltime, #cometime2, #calltime2, #from, #to').datepicker({
    format: 'dd/mm/yyyy'
  });

	function open_edit(event, id) {
		g_id = id
		$.post(
			adlink + "vaccine",
			{action: "getvac", id: id},
			(response, status) => {
				data = JSON.parse(response)
				if (data) {
					g_id = id
					g_pet = data.petname
					g_customerid = data.customerid
					$("#doctor2").val(data.doctorid);
					$("#disease2").val(data.diseaseid);
					$("#cometime2").val(data.cometime);
					$("#calltime2").val(data.calltime);
					$("#note2").val(data.note);
				}
			})
	}

	function xoasieuam(id) {
		var answer = confirm("Xóa bản ghi này?");
		if (answer) {
			$.post(
				"",
				{action: "remove_vaccine", id: id},
				(data, status) => {
					if (data) {
						window.location.reload()
					}
				}
			)	
		}
	}

	function vaccine() {
		msg = "";
		if(!customer_name) {
			msg = "Chưa nhập tên khách hàng!"
		} else if(!customer_phone.value) {
			msg = "Chưa nhập số điện thoại!"
		} else if(!pet_info.value) {
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
						window.location.reload()
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
				showMsg(msg);
			})
		}
		showMsg(msg);
		return false;
	}

	function editvac() {
		msg = "";
		if (!$("#disease2").val()) {
			msg = "Chưa có loại tiêm phòng!";
		} else if (!$("#cometime2").val()) {
			msg = "Chưa có thời gian tiêm phòng";
		} else if (!$("#calltime2").val()) {
			msg = "Chưa có ngày tái chủng!";
		}
		else {
			$.post(
				adlink + "vaccine",
				{action: "editvac", id: g_id, diseaseid: $("#disease2").val(), cometime: $("#cometime2").val(), calltime: $("#calltime2").val(), note: $("#note2").val(), doctorid: $("#doctor2").val()},
				(response, status) => {
					data = JSON.parse(response)
					if (data) {
						window.location.reload()
					}
				}
			)
		}
		showMsg(msg);
		return false;
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
