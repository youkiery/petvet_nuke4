<!-- BEGIN: main -->
<div id="alert_msg"></div>

<div id="edit" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.depart_edit}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return edit(event)">
          <div class="form-group">
            <label> {lang.depart_name} </label>
            <input class="form-control" type="text" id="name2">
          </div>
          <button class="btn btn-info">
            {lang.g_edit}
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
        <h4 class="modal-title">{lang.depart_remove}</h4>
      </div>
      <div class="modal-body">
        <button class="btn btn-info" onclick="remove(event)" data-dismiss="modal">
          {lang.g_remove}
        </button>
        <button class="btn btn-info" data-dismiss="modal">
          {lang.g_cencal}
        </button>
      </div>
    </div>
  </div>
</div>

<form onsubmit="return save(event)">
  <div class="form-group">
    <label> {lang.depart_name} </label>
    <input class="form-control" type="text" id="name">
  </div>
  <button class="btn btn-info">
    {lang.depart_submit}
  </button>
</form>

<table class="table">
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>
      <th>
        {lang.depart_name}
      </th>
      <th>

      </th>
    </tr>
  </thead>
  <tbody id="content">
    {content}
  </tbody>
</table>
<script>
  var base_url = script_name + "?nv=" + nv_module_name + "&op=";
  var g_id = 0;

  function select_id(id) {
    g_id = id
  }

  function predit(id) {
    g_id = id

    if (g_id > 0) {
      $.post(
        strHref,
        {action: 'predit', id: g_id},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            $("#edit").modal("toggle");
            $("#name2").val(data["name"]);
          }
          else {
            // notify error
          }
        }
      )
    }
  }

  function remove(e) {
    e.preventDefault()

    if (g_id > 0) {
      $.post(
        strHref,
        {action: 'remove', id: g_id},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            alert_msg(data["notify"])
            $("#content").html(data["list"]);
          }
          else {
            // notify error
          }
        }
      )
    }
    else {
      // error
    }
  }

  function edit(e) {
    e.preventDefault()
    var name = $("#name2").val()
    if (name.length) {
      $("#name2").removeClass("alert");
      $("#name2").removeClass("alert-danger");
      $.post(
        base_url + "depart",
        {action: "update",  name: name, id: g_id},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            alert_msg(data["notify"])
            $("#edit").modal("toggle");
            $("#content").html(data["list"]);
            $("#name").val("");
          }
          else if (data["notify"]) {
            alert_msg(data["notify"])
          }
          else {
            alert_msg("{lang.g_error}")
          }
        }
      )
    }
    else {
      $("#name").addClass("alert");
      $("#name").addClass("alert-danger");
      alert_msg("{lang.depart_blank}")
    }
  }

  function save(e) {
    e.preventDefault()
    var name = $("#name").val()
    if (name.length) {
      $("#name").removeClass("alert");
      $("#name").removeClass("alert-danger");
      $.post(
        base_url + "depart",
        {action: "save", name: name},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            alert_msg(data["notify"])
            $("#content").html(data["list"]);
            $("#name").val("");
          }
          else if (data["notify"]) {
            alert_msg(data["notify"])
          }
          else {
            alert_msg("{lang.g_error}")
          }
        }
      )
    }
    else {
      $("#name").addClass("alert");
      $("#name").addClass("alert-danger");
      alert_msg("{lang.depart_blank}")
    }
  }
</script>
<!-- END: main -->
