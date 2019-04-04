<!-- BEGIN: main -->
<div class="alert_msg"></div>

<div id="insert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body" id="detail_content">
        <form onsubmit="return insert(event)">
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
            <input class="form-control" type="text" id="process">
          </div>
          <div class="form-group">
            <label> {lang.note} </label>
            <input class="form-control" type="text" id="note">
          </div>
          <button class="btn btn-info">
            {lang.work_insert}
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
            <input class="form-control" type="text" id="edit_process">
          </div>
          <div class="form-group">
            <label> {lang.note} </label>
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

<div id="change_confirm" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form onsubmit="return change_confirm_submit(event)">
          <div class="form-group">
            <label> {lang.confirm} </label>
            <select class="form-control" id="confirm_value">

            </select>
          </div>
          <div class="form-group">
            <label> {lang.review} </label>
            <select class="form-control" id="confirm_review">

            </select>
          </div>
          <div class="form-group">
            <label> {lang.note} </label>
            <input type="text" class="form-control" id="confirm_note">
          </div>
          <button class="btn btn-info">
            {lang.update}
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="process_change" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form onsubmit="return change_process_submit(event)">
          <div class="form-group">
            <label> {lang.process} </label>
            <input class="form-control" type="text" id="edit_process2">
          </div>
          <div class="form-group">
            <label> {lang.note} </label>
            <input class="form-control" type="text" id="edit_note">
          </div>
          <button class="btn btn-info">
            {lang.update}
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

<form class="row form-inline" onsubmit="return change_data_2(event)">
  <div class="form-group col-md-10">
    <label>
      {lang.cometime}
    </label>
    <input type="text" value="{cometime}" class="form-control" id="cometime" readonly>
  </div>
  <div class="form-group col-md-10">
    <label>
      {lang.calltime}
    </label>
    <input type="text" value="{calltime}" class="form-control" id="calltime" readonly>
  </div>
  <div class="form-group col-md-2">
    <button class="btn btn-info">
      Lọc
    </button>
  </div>
</form>

<div id="depart_list">
  {depart_list}
</div>

<br>

<div>
  <button class="complete btn btn-warning active">
    Chưa hoàn thành
  </button>
  <button class="complete btn">
    Hoàn thành
  </button>
</div>

<div>
  {lang.count}
  <span id="count">{count}</span> 
  {lang.count_2}
</div>

<table class="table" id="content">
  {content}
</table>

<!-- BEGIN: manager -->
<button class="btn btn-info" data-toggle="modal" data-target="#insert">
  {lang.work_insert}
</button>
<!-- END: manager -->

<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  var today = '{today}'
  var userid = -1
  var g_id = -1
  var g_departid = 0
  var current = 0
  var typing
  var complete = $(".complete")
  var completeStatus = 0

  $("#depart").change(() => {
    $(".user-suggest-list").html("")
  })

  complete.click((e) => {
    var currentTarget = e.currentTarget
    complete.removeClass("active")
    complete.removeClass("btn-warning")
    
    currentTarget.classList.add("active")
    currentTarget.classList.add("btn-warning")

    if (trim(currentTarget.innerHTML).length > 12) {
      completeStatus = 0
    }
    else {
      completeStatus = 1
    }
    
    $.post(
      strHref,
      {action: "change_data", completeStatus: completeStatus, departid: g_departid, cometime: $("#cometime").val(), calltime: $("#calltime").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          change_tab(g_departid)
          reload_date(data)
        }
        alert_msg(data["notify"])
      }
    )
  })

  $('#starttime, #endtime, #edit_starttime, #edit_endtime, #starttime-filter, #endtime-filter, #cometime, #calltime').datepicker({
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
          if (status === "success" && response) {
            try {
              var data = JSON.parse(response)
              if (data["status"]) {
                $(".user-suggest-list").html(data["list"])
              }
              alert_msg(data["notify"])
            } catch (e) {
              alert_msg("{lang.g_error}")
            }
          }
        }
      )      
    }, 200)
  })

  function set_user(id, name) {
    userid = id
    $("#user, #edit_user").val(name)
  }

  function change_process_submit(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "change_process", id: g_id, cometime: $("#cometime").val(), calltime: $("#calltime").val(), process: $("#edit_process2").val().replace("%", ""), note: $("#edit_note").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#process_change").modal("hide")
          reload_date(data)
        }
        alert_msg(data["notify"])
      }
    )    
  }

  function change_process(id) {
    g_id = id
    $.post(
      strHref,
      {action: "get_process", id: g_id},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          current = data["process"]
          $("#edit_process2").val(data["process"] + "%")
          $("#edit_note").val(data["note"])
          $("#process_change").modal("show")
        }
        else {
          alert_msg(data["notify"])
        }
      }
    )
  }

  function change_data_2(e) {
    e.preventDefault()
    change_data(g_departid)
  }

  function change_data(id) {
    g_departid = id
    $.post(
      strHref,
      {action: "change_data", completeStatus: completeStatus, departid: g_departid, cometime: $("#cometime").val(), calltime: $("#calltime").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          change_tab(id)
          reload_date(data)
        }
        alert_msg(data["notify"])
      }
    )
  }

  function change_confirm(id) {
    g_id = id
    $.post(
      strHref,
      {action: "change_confirm", id: g_id},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#change_confirm").modal("show")
          $("#confirm_value").html(data["confirm"])
          $("#confirm_review").html(data["review"])
          $("#confirm_note").val(data["note"])
        }
        else {
          alert_msg(data["notify"])
        }
      }
    )
  }

  function change_confirm_submit(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "confirm", completeStatus: completeStatus, departid: g_departid, id: g_id, cometime: $("#cometime").val(), calltime: $("#calltime").val(), confirm: $("#confirm_value").val(), review: $("#confirm_review").val(), note: $("#confirm_note").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#change_confirm").modal("hide")
          $("#content").html(data["list"])
          reload_date(data)
        }
        alert_msg(data["notify"])
      }
    )
  }

  function my_work() {
    $.post(
      strHref,
      {action: "my_work", completeStatus: completeStatus, cometime: $("#cometime").val(), calltime: $("#calltime").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          g_departid = 0
          $("#content").html(data["list"])
          change_tab(g_departid)
          reload_date(data)
        }
        else {
          alert_msg(data["notify"])
        }
      }
    )
  }

  function manager_work() {
    $.post(
      strHref,
      {action: "manager_work", completeStatus: completeStatus, cometime: $("#cometime").val(), calltime: $("#calltime").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          g_departid = "end"
          $("#content").html(data["list"])
          change_tab("end")
          reload_date(data)
        }
        else {
          alert_msg(data["notify"])
        }
      }
    )
  }

  $("#edit_process, #edit_process2, #process").keyup((e) => {
    var key = e.currentTarget.value.replace("%", "")
    var check = isFinite(key)
    if (check && key >= 0 && key <= 100) {
      current = key
    }
    e.currentTarget.value = current + "%"
  })


  function edit(id) {
    g_id = id
    $.post(
      strHref,
      {action: "get_work", id: g_id},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          console.log(data["user"]);
          
          $("#edit_name").val(data["content"])
          $("#edit_starttime").val(data["starttime"])
          $("#edit_endtime").val(data["endtime"])
          // $("#edit_customer").html(data["customer"])
          $("#edit_depart").html(data["depart"])
          $("#edit_user").val(data["user"])
          userid = data["userid"]
          $("#edit_note").html(data["note"])
          $("#edit_save_user").val(data["username"])
          $("#edit_process").val(data["process"] + "%")
          userid = data["userid"]
          $("#edit").modal("show")
        }
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
      {action: "remove", completeStatus: completeStatus, id: g_id, cometime: $("#cometime").val(), calltime: $("#calltime").val()},
      (response) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#remove").modal("hide")
          reload_date(data)
        }
        alert_msg(data["notify"])
      }
    )
  }

  function insert(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "insert", completeStatus: completeStatus, departid: g_departid, cometime: $("#cometime").val(), calltime: $("#calltime").val(), content: $("#name").val(), starttime: $("#starttime").val(), endtime: $("#endtime").val(), /*customer: $("#customer").val(),*/ userid: userid, depart: $("#depart").val(), process: $("#process").val().replace("%", "")},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#insert").modal("hide")
          reload_date(data)
        }
        alert_msg(data["notify"])
      }
    )
  }

  function edit_submit(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "edit", completeStatus: completeStatus, departid: g_departid, id: g_id, cometime: $("#cometime").val(), calltime: $("#calltime").val(), content: $("#edit_name").val(), starttime: $("#edit_starttime").val(), endtime: $("#edit_endtime").val(), /*customer: $("#edit_customer").val(),*/ userid: userid, depart: $("#edit_depart").val(), note: $("#edit_note").val(), process: $("#edit_process").val().replace("%", "")},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#edit").modal("hide")
          reload_date(data)
        }
        alert_msg(data["notify"])
      }
    )
  }

  function reload_date(data) {
    if (data["cometime"]) {
      $("#cometime").val(data["cometime"])
    }
    if (data["calltime"]) {
      $("#calltime").val(data["calltime"])
    }
    $("#count").text(data["count"])
  }

  function change_tab(id) {
    $(".depart").removeClass("active")
    $(".depart").removeClass("btn-info")
    $("#depart_" + id).addClass("active")
    $("#depart_" + id).addClass("btn-info")
  }
</script>
<!-- END: main -->
