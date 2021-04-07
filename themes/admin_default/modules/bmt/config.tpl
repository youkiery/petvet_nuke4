<!-- BEGIN: main -->
<div class="msgshow" id="msgshow"></div>
<form class="vac_form" onsubmit="return filter()">
  <div class="form-group">
    <label>
      {lang.config_filter}
    </label>
    <select class="form-control" id="config_filter">
      <!-- BEGIN: filter -->
      <option value="{time_value}" {filter_select}>{time_name}</option>
      <!-- END: filter -->
    </select>
  </div>
  <div class="form-group">
    <label>
      {lang.config_recall}
    </label>
    <select class="form-control" id="config_recall">
      <!-- BEGIN: recall -->
      <option value="{time_value}" {recall_select}>{time_name}</option>
      <!-- END: recall -->
    </select>
  </div>
  <div class="form-group">
    <label>
      {lang.config_expect}
    </label>
    <select class="form-control" id="config_expect">
      <!-- BEGIN: expect -->
      <option value="{time_value}" {expect_select}>{time_name}</option>
      <!-- END: expect -->
    </select>
  </div>
  <div class="form-group">
    <label>
      {lang.config_exrecall}
    </label>
    <select class="form-control" id="config_exrecall">
      <!-- BEGIN: exrecall -->
      <option value="{time_value}" {exrecall_select}>{time_name}</option>
      <!-- END: exrecall -->
    </select>
  </div>
  <div class="form-group">
    <label>
      {lang.config_redrug}
    </label>
    <select class="form-control" id="config_redrug">
      <!-- BEGIN: redrug -->
      <option value="{time_value}" {redrug_select}>{time_name}</option>
      <!-- END: redrug -->
    </select>
  </div>
  <div class="form-group">
    <label>
      {lang.config_overtime_from}
    </label>
    <select class="form-control" id="config_hour_from">
      <!-- BEGIN: hour_from -->
      <option value="{hour_value}" {hour_from_select}>{hour_name}</option>
      <!-- END: hour_from -->
    </select>
    <select class="form-control" id="config_minute_from">
      <!-- BEGIN: minute_from -->
      <option value="{minute_value}" {minute_from_select}>{minute_name}</option>
      <!-- END: minute_from -->
    </select>
  </div>
  <div class="form-group">
    <label>
      {lang.config_overtime_from}
    </label>
    <select class="form-control" id="config_hour_end">
      <!-- BEGIN: hour_end -->
      <option value="{hour_value}" {hour_end_select}>{hour_name}</option>
      <!-- END: hour_end -->
    </select>
    <select class="form-control" id="config_minute_end">
      <!-- BEGIN: minute_end -->
      <option value="{minute_value}" {minute_end_select}>{minute_name}</option>
      <!-- END: minute_end -->
    </select>
  </div>
  <input type="submit" class="btn btn-info" value="{lang.save}">
</form>
<script>
  var link = "/admin/index.php?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=config&act=post";
  function filter() {
		$.post(
			link,
			{action: "save", filter: $("#config_filter").val(), recall: $("#config_recall").val(), exrecall: $("#config_exrecall").val(), expect: $("#config_expect").val(), redrug: $("#config_redrug").val(), hour_from: $("#config_hour_from").val(), minute_from: $("#config_minute_from").val(), hour_end: $("#config_hour_end").val(), minute_end: $("#config_minute_end").val()},
			(data, status) => {
			    data = JSON.parse(data);
          alert_msg(data["notify"])
			}
		)
    return false;
  }

</script>
<!-- END: main -->
