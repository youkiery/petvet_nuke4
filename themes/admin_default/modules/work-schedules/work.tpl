<!-- BEGIN: main -->
<div class="msg_show" id="msg_show"></div>
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

<div id="insert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body" id="detail_content">
        <form onsubmit="return save(event)">
          <div class="form-group">
            <label> {lang.work_name} </label>
            <input class="form-control" type="text" id="name">
          </div>
          <!-- <div class="form-group"> -->
            <!-- <label> {lang.work_customer} </label> -->
            <!-- <select class="form-control" id="customer"> -->
              <!-- BEGIN: customer_option -->
              <!-- <option value="{customer_value}">{customer_name}</option> -->
              <!-- END: customer_option -->
            <!-- </select> -->
          <!-- </div> -->
          <div class="form-group">
            <label> {lang.work_depart} </label>
            <select class="form-control" id="depart">
              <!-- BEGIN: depart_option -->
              <option value="{depart_value}">{depart_name}</option>
              <!-- END: depart_option -->
            </select>
          </div>
          <div class="form-group">
            <label> {lang.user} </label>
            <select class="form-control" id="user">
              <!-- BEGIN: user_option -->
              <option value="{user_value}">{user_name}</option>
              <!-- END: user_option -->
            </select>
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
            <label> {lang.work_process} </label>
            <input class="form-control" type="number" id="process" min="0" max="100">
          </div>
          <div class="form-group">
            <label> {lang.work_note} </label>
            <input class="form-control" type="text" id="note">
          </div>
          <button class="btn btn-info">
            {lang.work_submit}
          </button>
        </form>
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
        <form onsubmit="return edit_submit(event)">
          <div class="form-group">
            <label> {lang.work_name} </label>
            <input class="form-control" type="text" id="edit_name">
          </div>
          <!-- <div class="form-group"> -->
            <!-- <label> {lang.work_customer} </label> -->
            <!-- <select class="form-control" id="edit_customer"> -->

            <!-- </select> -->
          <!-- </div> -->
          <div class="form-group">
            <label> {lang.work_depart} </label>
            <select class="form-control" id="edit_depart">

            </select>
          </div>
          <div class="form-group">
            <label> {lang.user} </label>
            <select class="form-control" id="edit_user">

            </select>
          </div>
          <div class="form-group">
            <label> {lang.work_starttime} </label>
            <div class="input-group date" data-provide="datepicker">
              <input type="text" class="form-control" id="edit_starttime" readonly>
              <div class="input-group-addon">
                  <span class="glyphicon glyphicon-th"></span>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label> {lang.work_endtime} </label>
            <div class="input-group date" data-provide="datepicker">
              <input type="text" class="form-control" id="edit_endtime" readonly>
              <div class="input-group-addon">
                  <span class="glyphicon glyphicon-th"></span>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label> {lang.work_process} </label>
            <input class="form-control" type="number" id="edit_process" min="0" max="100">
          </div>
          <div class="form-group">
            <label> {lang.work_note} </label>
            <input class="form-control" type="text" id="edit_note">
          </div>
          <button class="btn btn-info">
            {lang.work_update}
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="remove" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.work_remove}</h4>
      </div>
      <div class="modal-body text-center">
        <button class="btn btn-danger" onclick="remove_submit()" data-dismiss="modal">
          {lang.g_remove}
        </button>
      </div>
    </div>
  </div>
</div>

<!-- <form onsubmit="return search(event)">
  <div class="row">
    <div class="form-group col-md-6">
      <label>
        {lang.gf_time}
      </label>
      <select id="time" class="form-control"> -->
        <!-- BEGIN: time_option -->
        <!-- <option value="{time_value}">{time_name}</option> -->
        <!-- END: time_option -->
      <!-- </select>
    </div>
    <div class="form-group col-md-6">
      <label>
        {lang.gf_starttime}
      </label>
      <input type="text" id="starttime-filter" class="form-control" value="{starttime}" readonly>
    </div>
    <div class="form-group col-md-6">
      <label>
        {lang.gf_endtime}
      </label>
      <input type="text" id="endtime-filter" class="form-control" value="{endtime}" readonly>
    </div>
    <div class="form-group col-md-6">
      <label>
        {lang.gf_sort}
      </label>
      <select id="sort" class="form-control"> -->
        <!-- BEGIN: sort_option -->
        <!-- <option value="{sort_value}">{sort_name}</option> -->
        <!-- END: sort_option -->
      <!-- </select>
    </div>
  </div>
  <div class="form-group">
    <button class="btn btn-info">
      {lang.g_filter}
    </button>
  </div>
</form> -->

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
      <!-- <th>
        {lang.work_customer}
      </th> -->
      <th>
        {lang.work_employ}
      </th>
      <th>
        {lang.work_depart}
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
<button class="btn btn-info" data-toggle="modal" data-target="#insert">
  {lang.g_insert}
</button>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  var today = {today};
  var userid = -1
  var g_id = -1
  $('#starttime, #endtime, #edit_starttime, #edit_endtime, #starttime-filter, #endtime-filter').datepicker({
    format: 'dd/mm/yyyy'
  });

  function search(e) {
    e.preventDefault();
  }

  function edit(id) {
    g_id = id
    $.post(
      strHref,
      {action: "get_work", id: g_id},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#edit_name").val(data["content"])
          $("#edit_starttime").val(data["starttime"])
          $("#edit_endtime").val(data["endtime"])
          // $("#edit_customer").html(data["customer"])
          $("#edit_depart").html(data["depart"])
          $("#edit_user").html(data["user"])
          $("#edit_note").html(data["note"])
          $("#edit_save_user").val(data["username"])
          $("#edit_process").val(data["process"])
          userid = data["userid"]
          $("#edit").modal("show")
        }
        alert_msg(data["notify"])
      }
    )
  }

  function remove(id) {
    g_id = id
    $("#remove").modal("show")
  }

  function remove_submit() {
    $.post(
      strHref,
      {action: "remove", id: g_id},
      (response) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#remove").modal("hide")
        }
        alert_msg(data["notify"])
      }
    )
  }

  function detail(id) {
    $.post(
      strHref,
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

  function save(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "save", content: $("#name").val(), starttime: $("#starttime").val(), endtime: $("#endtime").val(), /*customer: $("#customer").val(),*/ userid: $("#user").val(), depart: $("#depart").val(), process: $("#process").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#insert").modal("hide")
        }
        alert_msg(data["notify"])
      }
    )
  }

  function edit_submit(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "edit", id: g_id, content: $("#edit_name").val(), starttime: $("#edit_starttime").val(), endtime: $("#edit_endtime").val(), /*customer: $("#edit_customer").val(),*/ userid: $("#edit_user").val(), depart: $("#edit_depart").val(), note: $("#edit_note").val(), process: $("#edit_process").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#edit").modal("hide")
        }
        alert_msg(data["notify"])
      }
    )
  }

  // $("#save_user, #edit_save_user").blur(() => {
  //   setTimeout(() => {
  //     $(".suggest").hide()
  //   }, 200)
  // })

  // $("#save_user, #edit_save_user").focus(() => {
  //   $(".suggest").show()
  // })

  // $("#save_user").keyup(e => {
  //   clearTimeout(timer);
  //   timer = setTimeout(() => {
  //     $.post(
  //       strHref,
  //       {action: "get_user", user: $("#save_user").val()},
  //       (response, status) => {
  //         var data = JSON.parse(response)
  //         if (data["status"]) {
  //           $(".suggest").html(data["list"])
  //         }
  //       }
  //     )
  //   }, 500);
  // }) 

  // $("#edit_save_user").keyup(e => {
  //   clearTimeout(timer);
  //   timer = setTimeout(() => {
  //     $.post(
  //       strHref,
  //       {action: "get_user", user: $("#edit_save_user").val()},
  //       (response, status) => {
  //         var data = JSON.parse(response)
  //         if (data["status"]) {
  //           $(".suggest").html(data["list"])
  //         }
  //       }
  //     )
  //   }, 500);
  // }) 

  // function set_user(username, id) {
  //   userid = id
  //   $("#save_user, #edit_save_user").val(username)
  // }
</script>
<!-- END: main -->
