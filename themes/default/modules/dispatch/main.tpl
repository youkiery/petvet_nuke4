<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<style>
.ui-datepicker-trigger {
	display: none;
}
</style>

<div class="modal fade" id="download-modal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<label class="row" style="width: 100%;">
					<div class="col-sm-6">Ngày bắt đầu</div>
					<div class="col-sm-12">
						<input type="text" value="{excelf}" class="form-control" id="excelf">
					</div>
				</label>
		
				<label class="row" style="width: 100%;">
					<div class="col-sm-6">Ngày kết thúc</div>
					<div class="col-sm-12">
						<input type="text" value="{excelt}" class="form-control" id="excelt">
					</div>
				</label>

				<label style="width: 30%"> <input type="checkbox" class="po" id="index" checked> STT </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="title" checked> Tên công văn </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="catid" checked> Chủ đề </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="type" checked> Loại công văn </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="from_time" checked> Ngày gửi </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="code" checked> Số công văn </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="from_org"> Đơn vị soạn </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="to_org"> Đơn vị nhận </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="from_depid"> Tên phòng gửi </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="from_signer"> Người ký </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="date_iss"> Ngày ban hành </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="date_first"> Ngày có hiệu lực </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="date_die"> Ngày hết hiệu lực </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="content"> Trích yếu công văn </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="statusid"> Trạng thái </label>
				<label style="width: 30%"> <input type="checkbox" class="po" id="deid"> Phòng ban nhận </label>

				<div class="text-center">
					<button class="btn btn-info" onclick="download(1)">
						Tải về
					</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- BEGIN: btn_timkiem -->
<a class="btn btn-primary" href="{SE_LINK}">{LANG.sereach}</a>
<!-- END: btn_timkiem -->

<!-- BEGIN: admin -->
<div style="float: right" class="form-inline">
	<input type="text" class="form-control" id="fromTime" value="{fromTime}" autocomplete="off">
	<input type="text" class="form-control" id="endTime" value="{endTime}" autocomplete="off">
	<button class="btn btn-warning" onclick="downloadCustomize()">
		<span class="glyphicon glyphicon-download"></span>
	</button>
	<button class="btn btn-info" onclick="download()">
		<span class="glyphicon glyphicon-download"></span>
	</button>
</div>
<!-- END: admin -->

<script type="text/javascript">var pro_del_cofirm = "{LANG.product_del_cofirm}";</script>

<form action="{FORM_ACTION}" method="get">
	<!-- BEGIN: timkiem -->
	<div style= "margin-bottom: 10px; margin-top: 10px;">
		<input type="hidden" name ='nv' value="{MODULE_NAME}">
		<input type="hidden" name ='op' value="{OP}">
		<input type="hidden" name ='se' value="1">
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<td> {LANG.type} </td>
				<td>
				<select class="form-control" name="type">
					<!-- BEGIN: typeid -->
					<option value="{LISTTYPES.id}"{LISTTYPES.selected}>{LISTTYPES.name}</option>
					<!-- END: typeid -->
				</select></td>
			</tr>
			<tr>
				<td> {LANG.dis_name} </td>
				<td><input name="title" class="form-control" style="width: 200px" size="15" value="{s_title}"></td>
			</tr>
			<tr>
			<tr>
				<td> {LANG.dis_de} </td>
				<td>
          <select class="form-control" name="depart" id="depart">
            <!-- BEGIN: depart -->
            <option value="{depart_id}" {depart_check}>{depart_name}</option>
            <!-- END: depart -->
          </select>
        </td>
			</tr>
			<tr>
				<td> {LANG.dis_code} </td>
				<td><input name="code" class="form-control" style="width: 200px" size="15" value="{code}"></td>
			</tr>
			<tr>
				<td> {LANG.dis_code_ex} </td>
				<td><input name="excode" class="form-control" style="width: 200px" size="15" value="{excode}"></td>
				<input name="tab" type="hidden" class="form-control" value="{tab}">
			</tr>
			<tr>
				<td> {LANG.dis_content} </td>
				<td><textarea class="form-control" name="content">{content}</textarea></td>
			</tr>
			<tr>
				<td> {LANG.dis_person} </td>
				<td>
				<select class="form-control" style="width: 200px" name="from_signer" id="from_signer_{LISSIS.id}" onchange="nv_link('{LISSIS.id}');" >
					<!-- BEGIN: from_signer -->
					<option value="{LISSIS.id}"{LISSIS.selected}>{LISSIS.name}</option>
					<!-- END: from_signer -->
				</select><span id="hienthi"> {position} </span></td>
			</tr>
			<tr>
				<td>{LANG.chos_dis} </td>
				<td class="form-inline">
					<label>
					{LANG.from}
					<input class="form-control" value="{FROM}" type="text" id="from" name="from" readonly="readonly" style="width:100px" />
					{LANG.to}
					<input class="form-control" value="{TO}" type="text" id="to" name="to" readonly="readonly" style="width:100px" />
					</label>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center"><input class="btn btn-primary" type="submit" value="Search" name="timkiem"></td>
			</tr>

		</table>
	</div>

	<!-- END: timkiem -->

	<!-- BEGIN: error -->
	<div class="alert alert-danger">
		{ERROR}
	</div>
	<!-- END: error -->

	<!-- BEGIN: redden -->
	<button class="btn {cattype}" onclick="change(event, {catid})">
		{catname}
	</button>
	<!-- END: redden -->

	<!-- BEGIN: data -->
	<table class="table table-striped table-bordered table-hover">
		<caption>
			{TABLE_CAPTION}
		</caption>
		<thead>
			<tr>
				<th> {LANG.dis_date_re} </th>
				<th> {LANG.dis_name} </th>
				<th> {LANG.dis_code} </th>
				<th> {LANG.dis_souce} </th>
				<th> {LANG.dis_to_org} </th>
				<th> {LANG.file} </th>
			</tr>
		</thead>
		<tbody>
			<!-- BEGIN: row -->
			<tr>
				<td> {ROW.from_time} </td>
				<td> {ROW.title} </td>
				<td><a href="{ROW.link_code}">{ROW.code}</a></td>
				<td> {ROW.from_org} </td>
				<td> {ROW.to_org} </td>
				<td>
					<!-- BEGIN: loop1 -->
					<a href="{FILEUPLOAD}" title="Download"><em class="fa fa-download">&nbsp;</em></a>
					<!-- END: loop1 -->
				</td>
			</tr>
			<!-- END: row -->
		<tbody>
			<!-- BEGIN: generate_page -->
			<tr>
				<td colspan="5"> {GENERATE_PAGE} </td>
			</tr>
			<!-- END: generate_page -->
	</table>
	<!-- END: data -->
</form>

<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript">
	var fromTime = $("#fromTime")
	var endTime = $("#endTime")
	var excelf = $("#excelf")
	var excelt = $("#excelt")
	var downloadModal = $("#download-modal")

	$("#from, #to, #fromTime, #endTime, #excelf, #excelt").datepicker({
		showOn : "both",
		dateFormat : "dd.mm.yy",
		changeMonth : true,
		changeYear : true,
		showOtherMonths : true,
		buttonImage : nv_base_siteurl + "assets/images/calendar.gif",
		buttonImageOnly : true
	});

	function downloadCustomize() {
		excelf.val(fromTime.val())
		excelt.val(endTime.val())
		downloadModal.modal('show')		
	}

	function download(customize = 0) {
		var extra = '&fromTime=' + fromTime.val() + '&endTime=' + endTime.val()
		if (customize) {
			extra = '&fromTime=' + excelf.val() + '&endTime=' + excelt.val() + '&data=' + checkExcel()
		}
		var link = '/index.php?' + nv_name_variable + '=' + nv_module_name + '&excel=1' + extra
		window.open(link)
	}

	function checkExcel() {
    var list = []
    $('.po').each((index, checkbox) => {
      if (checkbox.checked) {
        list.push(checkbox.getAttribute('id'))
      }
    })
    return list
  }

  function change(e, tabid) {
	e.preventDefault()
	x = strHref.split('?')
	if (x[1]) {
		y = x[1].split('&')
		check = 0
		y.forEach((item, index) => {
			if (item.search('tab') >= 0) {
				check = 1
				strHref = strHref.replace(item, 'tab=' + tabid)
			}		
		});
		if (!check) {
			strHref += '&tab=' + tabid
		}
	}
	else {
		strHref = 'http://' + strHref.replace('http://', '').replace('https://', '').split('/')[0]
		strHref += '/index.php?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=' + nv_func_name + '&tab=' + tabid
	}
	window.location.replace(strHref);
  }

</script>

<!-- END: main -->