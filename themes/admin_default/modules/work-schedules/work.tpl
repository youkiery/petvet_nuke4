<!-- BEGIN: main -->
<div class="msg_show"></div>
<div id="detail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.work_detail}</h4>
      </div>
      <div class="modal-body" id="detail_content">

      </div>
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">
          {lang.g_cencal}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="edit-change" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.work_detail}</h4>
      </div>
      <div class="modal-body" id="detail_content">

      </div>
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">
          {lang.g_cencal}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="edit" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.work_edit}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return edit()">
          <div class="form-group">
            <label> {lang.work_name} </label>
            <input class="form-control" type="text" id="name-edit">
          </div>
          <div class="form-group">
            <label> {lang.work_starttime} </label>
            <div class="input-group date" data-provide="datepicker">
              <input type="text" class="form-control" id="starttime-edit" readonly>
              <div class="input-group-addon">
                  <span class="glyphicon glyphicon-th"></span>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label> {lang.work_endtime} </label>
            <div class="input-group date" data-provide="datepicker">
              <input type="text" class="form-control" id="endtime-edit" readonly>
              <div class="input-group-addon">
                  <span class="glyphicon glyphicon-th"></span>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label> {lang.work_customer} </label>
            <input class="form-control" type="text" id="customer-edit">
          </div>
          <div class="form-group">
            <label> {lang.work_depart} </label>
            <input class="form-control" type="text" id="depart-edit">
          </div>
          <div class="form-group">
            <label> {lang.work_employ} </label>
            <input class="form-control" type="text" id="employ-edit">
          </div>
          <div class="form-group">
            <label> {lang.work_process} </label>
            <input class="form-control" type="text" id="process-edit">
          </div>
          <button class="btn btn-info">
            {lang.work_submit}
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">
          {lang.g_cencal}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="remove" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.work_remove}</h4>
      </div>
      <div class="modal-body">
        <button class="btn btn-info" onclick="remove()" data-dismiss="modal">
          {lang.g_remove}
        </button>
        <button class="btn btn-info" data-dismiss="modal">
          {lang.g_cencal}
        </button>
      </div>
    </div>
  </div>
</div>

<form onsubmit="return search(event)">
  <div class="row">
    <div class="form-group col-md-6">
      <label>
        {lang.gf_time}
      </label>
      <select id="time" class="form-control">
        <!-- BEGIN: time_option -->
        <option value="{time_value}">{time_name}</option>
        <!-- END: time_option -->
      </select>
    </div>
    <div class="form-group col-md-6">
      <label>
        {lang.gf_starttime}
      </label>
      <input type="text" id="starttime-filter" class="form-control" readonly>
    </div>
    <div class="form-group col-md-6">
      <label>
        {lang.gf_endtime}
      </label>
      <input type="text" id="endtime-filter" class="form-control" readonly>
    </div>
    <div class="form-group col-md-6">
      <label>
        {lang.gf_sort}
      </label>
      <select id="sort" class="form-control">
        <!-- BEGIN: sort_option -->
        <option value="{sort_value}">{sort_name}</option>
        <!-- END: sort_option -->
      </select>
    </div>
  </div>
  <div class="form-group">
    <button class="btn btn-info">
      {lang.g_filter}
    </button>
  </div>
</form>

<table class="table">
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>
      <th>
        {lang.work_name}
      </th>
      <th>
        {lang.work_starttime}
      </th>
      <th>
        {lang.work_endtime}
      </th>
      <th>
        {lang.work_customer}
      </th>
      <th>
        {lang.work_depart}
      </th>
      <th>
        {lang.work_employ}
      </th>
      <th>
        {lang.work_process}
      </th>
      <th>
      </th>
    </tr>
  </thead>
  <tbody id="content">
    {content}
  </tbody>
</table>
<form onsubmit="return save()">
  <div class="form-group">
    <label> {lang.work_name} </label>
    <input class="form-control" type="text" id="name">
  </div>
  <div class="form-group">
    <label> {lang.work_starttime} </label>
    <div class="input-group date" data-provide="datepicker">
      <input type="text" class="form-control" id="starttime" readonly>
      <div class="input-group-addon">
          <span class="glyphicon glyphicon-th"></span>
      </div>
    </div>
  </div>
  <div class="form-group">
    <label> {lang.work_endtime} </label>
    <div class="input-group date" data-provide="datepicker">
      <input type="text" class="form-control" id="endtime" readonly>
      <div class="input-group-addon">
          <span class="glyphicon glyphicon-th"></span>
      </div>
    </div>
  </div>
  <div class="form-group">
    <label> {lang.work_customer} </label>
    <input class="form-control" type="text" id="customer">
  </div>
  <div class="form-group">
    <label> {lang.work_depart} </label>
    <input class="form-control" type="text" id="depart">
  </div>
  <div class="form-group">
    <label> {lang.work_employ} </label>
    <input class="form-control" type="text" id="employ">
  </div>
  <div class="form-group">
    <label> {lang.work_process} </label>
    <input class="form-control" type="text" id="process">
  </div>
  <button class="btn btn-info">
    {lang.work_submit}
  </button>
</form>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  var base_url = script_name + "?nv=" + nv_module_name + "&op=";
  $('#starttime, #endtime, #starttime-edit, #endtime-edit, #starttime-filter, #endtime-filter').datepicker({
    format: 'dd/mm/yyyy'
  });

  function search(e) {
    e.preventDefault();
  }

  function edit(e) {
    e.preventDefault();
  }

  function remove(e) {
    e.preventDefault();
  }

  function detail(id) {
    $.post(
      base_url + "work",
      {action: "detail_content", id: id},
      (response, status) => {
        var data = JSON.parse(response);
        if (data["status"]) {
          $detail
        }
        else if (data["error"]) {
          alert_msg(data["error"])
        }
        else {
          alert_msg("{lang.g_error}")
        }
      }
    )
    $("#detail_content").html()
  }
</script>
<!-- END: main -->
