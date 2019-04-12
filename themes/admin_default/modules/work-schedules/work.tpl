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
            <div class="relative">
              <input type="text" class="form-control user-suggest" id="user" autocomplete="off">
              <div class="user-suggest-list">

              </div>
            </div>
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
            <div class="relative">
                <input type="text" class="form-control user-suggest" id="edit_user" autocomplete="off">
                <div class="user-suggest-list">
  
                </div>
              </div>
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
<button class="btn btn-info" data-toggle="modal" data-target="#insert">
  {lang.g_insert}
</button><br>
<p>
  Có tổng cộng <span id="count"> {count} </span> công việc
</p>

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
<div id="nav">
  {nav}
</div>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  var today = {today};
  var userid = -1
  var g_id = -1
  var typing
  var limit = 10
  var content = $("#content")
  var count = $("#count")
  var nav = $("#nav")

  $('#starttime, #endtime, #edit_starttime, #edit_endtime, #starttime-filter, #endtime-filter').datepicker({
    format: 'dd/mm/yyyy'
  });

  $("#user, #edit_user").focus(() => {
    $(".user-suggest-list").show()
  });
  $("#user, #edit_user").blur(() => {
    setTimeout(() => {
      $(".user-suggest-list").hide()
    }, 200)
  });

  $("#user, #edit_user").keydown(e => {
    clearTimeout(typing)
    typing = setTimeout(() => {
      $.post(
        strHref,
        {action: "search", keyword: e.target.value},
        (response, status) => {
          checkResult(response, status).then(data => {
            $(".user-suggest-list").html(data["list"])
          }, () => {})
        }
      )      
    }, 200)
  })

  function set_user(id, name) {
    userid = id
    $("#user, #edit_user").val(name)
  }

  function search(e) {
    e.preventDefault();
  }

  function edit(id) {
    g_id = id
    freeze()
    $.post(
      strHref,
      {action: "get_work", id: g_id},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#edit_name").val(data["content"])
          $("#edit_starttime").val(data["starttime"])
          $("#edit_endtime").val(data["endtime"])
          // $("#edit_customer").html(data["customer"])
          $("#edit_depart").html(data["depart"])
          $("#edit_user").val(data["user"])
          $("#edit_note").html(data["note"])
          $("#edit_save_user").val(data["username"])
          $("#edit_process").val(data["process"])
          userid = data["userid"]
          $("#edit").modal("show")
          defreeze()
        }, () => {
          defreeze()
        })
      }
    )
  }

  function remove(id) {
    g_id = id
    $("#remove").modal("show")
  }

  function remove_submit() {
    freeze()
    $.post(
      strHref,
      {action: "remove", id: g_id},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['list']["html"])
          nav.html(data['list']["nav"])
          count.text(data['list']["count"])
          $("#remove").modal("hide")
          defreeze()
        }, () => {
          defreeze()
        })
      }
    )
  }

  function save(e) {
    e.preventDefault()
    freeze()
    $.post(
      strHref,
      {action: "save", content: $("#name").val(), starttime: $("#starttime").val(), endtime: $("#endtime").val(), /*customer: $("#customer").val(),*/ userid: userid, depart: $("#depart").val(), process: $("#process").val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data['list']["html"])
          nav.html(data['list']["nav"])
          count.text(data['list']["count"])
          $("#insert").modal("hide")
          defreeze()
        }, () => {
          defreeze()
        })
      }
    )
  }

  function edit_submit(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "edit", id: g_id, content: $("#edit_name").val(), starttime: $("#edit_starttime").val(), endtime: $("#edit_endtime").val(), /*customer: $("#edit_customer").val(),*/ userid: userid, depart: $("#edit_depart").val(), note: $("#edit_note").val(), process: $("#edit_process").val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data['list']["html"])
          nav.html(data['list']["nav"])
          count.text(data['list']["count"])
          $("#edit").modal("hide")
          defreeze()
        }, () => {
          defreeze()
        })
      }
    )
  }

  function goPage(page) {
    freeze()
    $.post(
      strHref,
      {action: "filter", page: page, limit: limit, starttime: $("#edit_starttime").val(), endtime: $("#edit_endtime").val()},
      (response, status) => {
        checkResult(response, status).then((data) => {
          content.html(data['list']["html"])
          nav.html(data['list']["nav"])
          count.text(data['list']["count"])
          defreeze()
        }, () => {
          defreeze()
        })
      }
    )
  }
</script>
<!-- END: main -->
