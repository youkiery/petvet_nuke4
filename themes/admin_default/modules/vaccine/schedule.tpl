<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>

<div id="remove" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> {lang.schedule_remove} </h4>
      </div>
      <div class="modal-body">
        <button class="btn btn-danger" onclick="remove_submit()">
          {lang.remove}
        </button>    
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>    
      </div>
    </div>

  </div>
</div>

<table class="table"> 
  <thead>
    <tr>
      <td>
        {lang.user}
      </td>
      <td>
        {lang.restday}
      </td>
      <td></td>
    </tr>
  </thead>
  <tbody id="content">
    {content}
  </tbody>
</table>
<form onsubmit="return save(event)">
  <div class="form-group">
    <label> {lang.restday} </label>
    <input type="text" class="form-control" id="save_restday" readonly>
  </div>
  <div class="form-group">
    <label> {lang.user} </label>
    <div class="relative">
      <input class="form-control" id="save_user" type="text" autocomplete="off">
      <div class="suggest"></div>
    </div>
  </div>
  <button class="btn btn-info">
    {lang.schedule_save}
  </button>
</form>

<script>
  var userid = -1;

  $('#save_restday').datepicker({
    format: 'dd/mm/yyyy'
  });

  function save(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "save", userid: userid, restday: $("#save_restday").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#save_user").val("")
          $("#save_restday").val("")
        }
        alert_msg(data["notify"])
      }
    )
  }

  $("#save_user").blur(() => {
    setTimeout(() => {
      $(".suggest").hide()
    }, 200)
  })

  $("#save_user").focus(() => {
    $(".suggest").show()
  })

  $("#save_user").keyup(e => {
    clearTimeout(timer);
    timer = setTimeout(() => {
      $.post(
        strHref,
        {action: "get_user", user: $("#save_user").val()},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            $(".suggest").html(data["list"])
          }
        }
      )
    }, 500);
  }) 

  function set_user(username, id) {
    userid = id
    $("#save_user").val(username)
  }

  function remove(id) {
    userid = id
    $("#remove").modal("show")
  }

  function remove_submit() {
    if (userid > 0) {
      $.post(
        strHref,
        {action: "remove", id: userid},
        (response, status) => {
          data = JSON.parse(response)
          if (data["status"]) {
            $("#content").html(data["list"])
            $("#remove").modal("hide")
          }
          alert_msg(data["notify"])
        }
      )
    }
  }
</script>
<!-- END: main -->

