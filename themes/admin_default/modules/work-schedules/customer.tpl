<!-- BEGIN: main -->
<div id="insert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form onsubmit="return insert(event)">
          <div class="form-group">
            <label> {lang.customer_name} </label>
            <input class="form-control" type="text" id="name">
          </div>
          <div class="form-group">
            <label> {lang.customer_address} </label>
            <input class="form-control" type="text" id="address">
          </div>
          <button class="btn btn-info">
            {lang.customer_submit}
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

<div id="edit" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.customer_edit}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return edit_submit(event)">
          <div class="form-group">
            <label> {lang.customer_name} </label>
            <input class="form-control" type="text" id="name2">
          </div>
          <div class="form-group">
            <label> {lang.customer_address} </label>
            <input class="form-control" type="text" id="address2">
          </div>
          <button class="btn btn-info">
            {lang.customer_submit}
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
        <h4 class="modal-title">{lang.customer_remove}</h4>
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


<table class="table">
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>
      <th>
        {lang.customer_name}
      </th>
      <th>
        {lang.customer_address}
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
  {lang.add}
</button>
<script>
  var g_id = -1
  function insert(event) {
    event.preventDefault()

    $.post(
      strHref,
      {action: "insert", name: $("#name").val(), address: $("#address").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"]);
          $("#insert").modal("hide");
        }
        alert_msg(data["notify"])
      }
    )
  }
  function edit(id) {
    event.preventDefault()
    g_id = id
    if (g_id > 0) {
      $.post(
        strHref,
        {action: "get_edit", id: g_id},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            $("#name2").val(data["name"]);
            $("#address2").val(data["address"]);
          }
          alert_msg(data["notify"])
        }
      )
    }
  }
  function edit_submit(event) {
    event.preventDefault()
    $.post(
      strHref,
      {action: "update", id: g_id, name: $("#name2").val(), address: $("#address2").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"]);
          $("#edit").modal("hide");
        }
        alert_msg(data["notify"])
      }
    )
  }
  function remove() {
    event.preventDefault()
    $.post(
      strHref,
      {action: "remove", id: g_id},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"]);
        }
        alert_msg(data["notify"])
      }
    )
  }
  function select(id) {
    g_id = id
  }
</script>
<!-- END: main -->
