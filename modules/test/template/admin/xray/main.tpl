<!-- BEGIN: main -->
<p> Đang thực hiện phân quyền </p>
<!-- END: main -->
<style>
  #ui-datepicker-div {
    z-index: 10000 !important;
  }
</style>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>

<div id="treatupdate" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div>
          {lang.treat_update}
        </div>
      </div>
      <div class="modal-body">
        <div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/contact_edit.png')" class="vac_icon" onclick="update_customer(g_customerid)">
          <img src="/themes/default/images/vaccine/trans.png" title="Sửa khách hàng"> 
        </div>
        <div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/pet_edit.png')" class="vac_icon" tooltip="Thêm thú cưng" onclick="update_pet(g_petid, g_pet)">
          <img src="/themes/default/images/vaccine/trans.png" title="Sửa thú cưng"> 
        </div>
        <form onsubmit="return update_treat(event)" autocomplete="off">
          <div class="form-group">
            <label>
              {lang.treatcome}
            </label>
            <div class="input-group date" data-provide="datepicker">
              <input type="text" class="form-control" id="ngaysieuam" value="{now}" readonly>
              <div class="input-group-addon">
                  <span class="glyphicon glyphicon-th"></span>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label>
              {lang.doctor}
            </label>
              <select class="form-control" name="doctor" id="doctor3">
                <!-- BEGIN: doctor3 -->
                <option value="{doctorid}">{doctorname}</option>
                <!-- END: doctor3 -->
              </select>
          </div>
          <div class="form-group text-center">
              <input class="btn btn-info" type="submit" value="{lang.submit}">
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="treatdetail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <div id="info">
          <p>
            {lang.petname}: 
            <span id="petname"></span>
          </p>
          <p>
            {lang.customer}: 
            <span id="customer"></span>
          </p>
          <p>
            {lang.phone}: 
            <span id="phone"></span>
          </p>
          <p>
            {lang.treatcome}: 
            <span id="luubenh"></span>
          </p>
          <p>
            {lang.doctor2}: 
            <span id="doctor"></span>
          </p>
        </div>
        <div class="treating">
          <span id="treating" style="float: right;"></span>
            <form onsubmit="return themtreating(event)">
              <div class="input-group date" data-provide="datepicker">
								<input type="text" class="form-control" id="ngaytreating" value="{now}" readonly>
								<div class="input-group-addon">
										<span class="glyphicon glyphicon-th"></span>
								</div>
							</div>
              <button class="btn btn-info">
                {lang.add}
              </button>
            </form>
            <div id="dstreating">
              
            </div>
            <div id="treating">
              <form onsubmit="return luutreating(event)" id="qltreating">
                <input class="form-control" type="text" id="nhietdo" placeholder="{lang.nhietdo}">
                <input class="form-control" type="text" id="niemmac" placeholder="{lang.niemmac}">
                <input class="form-control" type="text" id="khac" placeholder="{lang.khac}">
                <input class="form-control" type="text" id="dieutri" placeholder="{lang.dieutri}">
                <br>
                <label for="doctorx">{lang.doctor}</label>
                <select class="form-control" name="doctorx" id="doctorx"> 
                  <!-- BEGIN: doctor -->
                  <option value="{doctorid}"> {doctorname} </option>
                  <!-- END: doctor -->
                </select>
                <label for="tinhtrang">{lang.tinhtrang}</label>
                <select class="form-control" name="tinhtrang" id="tinhtrang2"> 
                  <!-- BEGIN: status_option -->
                  <option value="{status_value}"> {status_name} </option>
                  <!-- END: status_option -->
                </select>
                <label for="xetnhiem">{lang.xetnghiem}</label>
                <select class="form-control" name="xetnghiem" id="xetnghiem"> 
                  <option value="0"> {lang.non} </option>
                  <option value="1"> {lang.have} </option>
                </select>
                <button class="btn btn-info">
                  {lang.submit}
                </button>
                <input type="button" class="btn btn-info" onclick="ketthuc(1)" value="{lang.trihet}">
                <input type="button" class="btn btn-info" onclick="ketthuc(2)" value="{lang.dachet}">
                <input type="button" class="btn btn-info" onclick="tongket(1)" value="{lang.tongket}" data-toggle="modal" data-target="#treatinsult">
              </form>
            </div>
        </div>
      </div>
    </div>
  </div>
</div>
  
<div id="treatinsult" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="modal-body">
            <div id="vac2_header"></div>
            <div id="vac2_body"></div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="summary-on" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-inline">
          <input class="form-control" id="summary-on-start" type="text" value="{sumstart}" autocomplete="off">
          <input class="form-control" id="summary-on-end" type="text" value="{sumend}" autocomplete="off">
          <button class="btn btn-info" onclick="summaryOnShow()">
            Xem tổng kết
          </button>
        </div>
        <div id="summary-content">
          {summaryon}
        </div>
      </div>
    </div>
  </div>
</div>
  
<form method="GET" class="form-inline">
	<input type="hidden" name="nv" value="vaccine">
  <input type="hidden" name="op" value="treat">
      <input class="form-control" type="text" name="keyword" id="keyword" value="{keyword}" placeholder="{lang.keyword}">
      <label>
        {lang.startday}
      </label>
      <div class="input-group date" data-provide="datepicker">
        <input type="text" class="form-control" id="from" name="from" value="{from}" 1 readonly>
        <div class="input-group-addon">
            <span class="glyphicon glyphicon-th"></span>
        </div>
    </div>
      <label>
        {lang.endday}
      </label>
      <div class="input-group date" data-provide="datepicker">
        <input type="text" class="form-control" id="to" name="to" value="{to}" readonly>
        <div class="input-group-addon">
            <span class="glyphicon glyphicon-th"></span>
        </div>
    </div>
  <div class="row">
    <div class="form-group col-md-12">
      <label>
        {lang.sort}
      </label>
      <select class="form-control" name="sort" id="sort">
        <!-- BEGIN: sort -->
        <option value="{sort_value}" {sort_check}>{sort_name}</option>
        <!-- END: sort -->
      </select>
    </div>
    <div class="form-group col-md-12">
      <label>
        {lang.count}
      </label>
      <select class="form-control" name="filter" id="time">
        <!-- BEGIN: time -->
        <option value="{time_value}" {time_check}>{time_name}</option>
        <!-- END: time -->
      </select>
    </div>
  </div>
  <div class="form-group">
    <button class="btn btn-info">
      {lang.filter}
    </button>
  </div>
</form>
<button class="btn btn-info" style="float: right" onclick="summaryOnclick()">
  Tổng kết
</button>

<img class="anchor" src="/themes/default/images/vaccine/add.png" alt="{lang.themsieuam}" title="themsieuam" onclick="$('#add').toggle(500)">
<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/contact_add_small.png')" class="vac_icon" onclick="addCustomer()">
	<img src="/themes/default/images/vaccine/trans.png" title="Thêm khách hàng"> 
</div>
<div style="width: 32px; height: 32px; cursor: pointer; display: inline-block; background-image: url('/themes/default/images/vaccine/pet_add.png')" class="vac_icon" tooltip="Thêm thú cưng" onclick="addPet()">
	<img src="/themes/default/images/vaccine/trans.png" title="Thêm thú cưng"> 
</div>
<form id="add" onsubmit="return themluubenh(event)" autocomplete="off">
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
      <label>{lang.ngayluubenh}</label>
      <div class="input-group date" data-provide="datepicker">
        <input type="text" class="form-control" id="ngayluubenh" value="{now}" readonly>
        <div class="input-group-addon">
            <span class="glyphicon glyphicon-th"></span>
        </div>
      </div>
		</div>
	</div>
	<div class="row">
		<div class="form-group col-md-12">
			<label>{lang.doctor2} </label>
			<select class="form-control" name="doctor" id="doctor2">
				<!-- BEGIN: doctor -->
						<option value="{doctorid}">{doctorname}</option>
				<!-- END: doctor -->
			</select>
		</div>
		<div class="form-group col-md-12">
			<label>{lang.tinhtrang}</label>
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

<div id="html_content">
	{content}
</div>
<script>
	var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
	var adlink = "/admin/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
	var blur = true;
	var g_customer = -1;
	var g_id = -1
	var g_customerid = -1
	var g_petid = -1
	var g_pet = ""
	var customer_data = [];
	var customer_list = [];
	var customer_name = document.getElementById("customer_name");
	var customer_phone = document.getElementById("customer_phone");
	var customer_address = document.getElementById("customer_address");
	var pet_info = document.getElementById("pet_info");
	var pet_note = document.getElementById("pet_note");
	var suggest_name = document.getElementById("customer_name_suggest");
	var suggest_phone = document.getElementById("customer_phone_suggest");
  var summaryOn = $("#summary-on")
  var summaryOnContent = $("#summary-content")
  var summaryOnStart = $("#summary-on-start")
  var summaryOnEnd = $("#summary-on-end")

  var lid = -1;
  var g_ltid = -1;
  var g_id = -1;
  var d_treating = []
  var g_ketqua = -1;
  var vac_index = 0;

  $('#ngaysieuam, #ngayluubenh, #ngaytreating, #from, #to, #summary-on-start, #summary-on-end').datepicker({
    format: 'dd/mm/yyyy'
  });

  function summaryOnclick() {
    summaryOn.modal('show')
  }

  function summaryOnShow() {
		$.post(
			strHref,
			{action: "summary-on", starttime: summaryOnStart.val(), endtime: summaryOnEnd.val()},
			(response, status) => {
        checkResult(response, status).then(data => {
          summaryOnContent.html(data['html'])
        }, () => {})
			}
		)
  }

	function update_treat(e) {
		e.preventDefault()

		$.post(
			adlink + "treat",
			{action: "update_treat", id: g_id, cometime: $("#ngaysieuam").val(), doctorid: $("#doctor3").val()},
			(response, status) => {
				var data = JSON.parse(response)
				if (data["status"]) {
					g_id = -1
					window.location.reload()
				}
			}
		)
	}


  function update(e, id) {
		g_id = id
    vac_index = 1;
    
		$.post(
			adlink + "treat",
			{action: "treat_info", id: g_id},
			(response, status) => {
				var data = JSON.parse(response);
				if (data["status"]) {
          g_customerid = data["data"]["customerid"]
					g_petid = data["data"]["petid"]
					
					g_pet = trim(e.target.parentElement.parentElement.children[1].innerText)
					$("#ngaysieuam").val(data["data"]["cometime"])					
					$("#doctor3").val(data["data"]["doctorid"])					
				}
			}
		)
  }

  $("#html_content tbody tr td[class]").click((e) => {
    lid = e.currentTarget.parentElement.getAttribute("id");
    vac_index = 1;
    $("#vac_info").fadeIn();
    $("#reman").show();
    $.post(
      link + "luubenh",
      {action: "thongtinluubenh", id: lid},
      (response, status) => {
        response = JSON.parse(response)
        if (response["status"]) {
          data = response["data"]
          $("#petname").text(data["petname"])
          $("#customer").text(data["customer"])
          $("#phone").text(data["phone"])
          $("#luubenh").text(data["cometime"])
          $("#doctor").text(data["doctor"])
          var h_treating = ""
          g_ketqua = data["ketqua"];
          
          if (data["treating"]) {
            if (data["ketqua"] > 0) {
              $("#qltreating input").attr("disabled", "disabled");
              $("#qltreating select").attr("disabled", "disabled");
              $(".submitbutton").attr("disabled", "disabled");
            }
            else {
              $("#qltreating input").removeAttr("disabled", "");
              $("#qltreating select").removeAttr("disabled", "");
              $(".submitbutton").removeAttr("disabled", "");
            }
            select = -1;
            d_treating = data["treating"]
            $("#dstreating").html("")
            data["treating"].forEach(e => {
              select ++
              var ngay = e["time"] * 1000;
              g_ltid = e["id"]
              g_id = select
              html = "<span onclick='xemtreating(" + g_ltid + ", " + select +")'>" + e["time"] + "</span> ";
              $("#dstreating").html($("#dstreating").html() + html)
            })
            
            $("#nhietdo").val(data["treating"][select]["temperate"])
            $("#niemmac").val(data["treating"][select]["eye"])
            $("#khac").val(data["treating"][select]["other"])
            $("#dieutri").val(data["treating"][select]["treating"])
            $("#xetnghiem").val(data["treating"][select]["examine"])
            $("#treating").text(data["treating"][select]["time"])
            $("#tinhtrang2").val(data["treating"][select]["status"])
            $("#doctorx").val(data["treating"][select]["doctorx"])
          }
          else {
            d_treating = []
            $("#qltreating input").attr("disabled", "disabled");
            $("#qltreating select").attr("disabled", "disabled");
            $("#dstreating").html("")
            $("#nhietdo").val("")
            $("#niemmac").val("")
            $("#khac").val("")
            $("#dieutri").val("")
            $("#xetnghiem").val(0)
            $("#treating").text("")
            $("#tinhtrang2").val(0)
            $("#doctorx").val(0)
          }
        }
      }
    )
  })

  function tongket() {
    vac_index = 2;
    var body = ""
    var addition = "<p><b>{lang.tongngay} " + d_treating.length + " </b></p>"
    d_treating.forEach((treating, index) => {
      body += "<tr><td style='width: 20%'>" + treating["time"] + "</td><td style='width: 50%'><b>{lang.nhietdo}</b>: " + treating["temperate"] + "<br><b>{lang.niemmac}</b>: " + treating["eye"] + "<br><b>{lang.khac}</b>: " + treating["other"] + "</td><td style='width: 30%'>" + treating["treating"] + "</td></tr>"
    }) 
    var html = 
    "<table class='table table-bordered'><thead><tr><th><span id='tk_khachhang'>" + $("#customer").text() + "</span> / <span id='tk_thucung'>" + $("#petname").text() + "</span></th><th>{lang.trieuchung}</th><th>{lang.dieutri}</th></tr></thead><tbody>" + body + "</tbody><tfoot><tr><td colspan='3'>" + addition + "</td></tr></tfoot></table>"
    $("#vac2_body").html(html)
  }

  function themtreating(e) {
    e.preventDefault();
    $.post(
      link + "luubenh",
      {action: "themtreating", time: $("#ngaytreating").val(), id: lid},
      (response, status) => {
        response = JSON.parse(response)
        switch (response["status"]) {
          case 1:
            // thành công
            var data = response["data"]
            d_treating.push(data)
            
            id = d_treating.length - 1
            g_ltid = data["id"]
            g_id = id
            $("#nhietdo").val(d_treating[id]["temperate"])
            $("#niemmac").val(d_treating[id]["eye"])
            $("#khac").val(d_treating[id]["other"])
            $("#dieutri").val(d_treating[id]["treating"])
            $("#xetnghiem").val(d_treating[id]["examine"])
            $("#treating").text(d_treating[id]["time"])
            $("#tinhtrang2").val(d_treating[id]["status"])

            html = "<span onclick='xemtreating(" + d_treating[id]["id"] + ", " + g_id + ")'>" + data["time"] + "</span>";
            $("#dstreating").html($("#dstreating").html() + html)
            $("#qltreating input").removeAttr("disabled", "");
            $("#qltreating select").removeAttr("disabled", "");
          break;
          case 2:
            // đã tồn tại ngày hôm nay
            
          break;
          default:
        }
        // if () {
        // }
      }
    )
  }

  function xemtreating(ltid, id) {
    g_ltid = ltid;
    g_id = id;
    
    $("#nhietdo").val(d_treating[id]["temperate"])
    $("#niemmac").val(d_treating[id]["eye"])
    $("#khac").val(d_treating[id]["other"])
    $("#dieutri").val(d_treating[id]["treating"])
    $("#xetnghiem").val(d_treating[id]["examine"])
    $("#treating").text(d_treating[id]["time"])
    $("#tinhtrang2").val(d_treating[id]["status"])
  }

	function delete_treat(id) {
		var answer = confirm("Xóa bản ghi này?");
		if (answer) {
			$.post(
				link + "luubenh",
				{action: "delete_treat", id: id},
				(response, status) => {
					response = JSON.parse(response);
					
					if (response["status"]) {
						window.location.reload()
					}
				}
			)    
		}
	}

  function ketthuc(val) {
    $.post(
      link + "luubenh",
      {action: "trihet", id: lid, val: val},
      (response, status) => {
        response = JSON.parse(response);
        if (response["status"]) {
          $("#" + lid).css("background", response["data"]["color"])
          $("#" + lid + " .tinhtrang").text(response["data"]["insult"])
          $("#vac_info").fadeOut();
          $("#reman").hide();
        }
      }
    )    
  }

  function luutreating(e) {
    e.preventDefault();
    var nhietdo = $("#nhietdo").val();
    var niemmac = $("#niemmac").val();
    var khac = $("#khac").val();
    var xetnghiem = $("#xetnghiem").val();
    var dieutri = $("#dieutri").val();
    var tinhtrang = $("#tinhtrang2").val();
    var doctorx = $("#doctorx").val();
    
    $.post(
      link + "luubenh",
      {action: "luutreating", id: g_ltid, temperate: nhietdo, eye: niemmac, other: khac, examine: xetnghiem, treating: dieutri, status: tinhtrang, doctorx: doctorx},
      (response, status) => {
        response = JSON.parse(response);
        if (response["status"]) {
          alert_msg("Đã lưu");
          $("#" + lid).css("background", response["data"]["color"])
          $("#" + lid + " .suckhoe").text(response["data"]["status"])
          d_treating[g_id]["temperate"] = temperate
          d_treating[g_id]["eye"] = eye
          d_treating[g_id]["other"] = other
          d_treating[g_id]["examine"] = examine
          d_treating[g_id]["treating"] = treating
          d_treating[g_id]["status"] = status
          d_treating[g_id]["doctorx"] = doctorx
        }
      }
    )    
  }


	function xoasieuam(id) {
		var answer = confirm("Xóa bản ghi này?");
		if (answer) {
			$.post(
				"",
				{action: "xoasieuam", id: id},
				(data, status) => {
					data = JSON.parse(data);
					if (data["status"]) {
						$("#html_content").html(data["data"]);
						alert_msg("Đã xóa bản ghi");
					}
				}
			)	
		}
	}

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
				{"customer": customer_name.value, "phone": customer_phone.value, "address": customer_address.value, petid: pet_info.value, doctorid: $("#doctor2").val(), cometime: $("#ngayluubenh").val(), note: $("#ghichu").val(), status: $("#tinhtrang2").val(), doctorx: $("#doctor2").val()},
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

  suggest_init()

</script>
<!-- END: main -->
