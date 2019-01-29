  <!-- BEGIN: main -->
<div id="edit" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.employ_edit}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return edit()">
          <div class="form-group" id="edit-depart">
            
          </div>
          <button class="btn btn-info" onclick="edit_submit(event)">
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
        <h4 class="modal-title">{lang.employ_remove}</h4>
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
        {lang.employ_name}
      </th>
      <th>
        {lang.employ_roles}
      </th>
      <th>
      </th>
    </tr>
  </thead>
  <tbody id="content">
    {content}
  </tbody>
</table>
<form onsubmit="return search()">
  <div class="form-group">
    <label> {lang.employ_searchkey} </label>
    <input class="form-control" type="text" id="key">
  </div>
  <button class="btn btn-info">
    {lang.employ_search}
  </button>
</form>
<div id="s_content" style="display: none;">
  <table class="table">
    <thead>
      <tr>
        <th>
          {lang.index}
        </th>
        <th>
          {lang.employ_name}
        </th>
        <th>
          {lang.employ_phone}
        </th>
        <th>
          {lang.employ_address}
        </th>
        <th>
        </th>
      </tr>
    </thead>
    <tbody id="s_content_list">
      {s_content_list}
    </tbody>
  </table>
</div>
<script>
  var g_id = -1;
  var g_depart = {}


  function select(id) {
    g_id = id;
  }

  function edit_submit(e) {
    e.preventDefault()
    var depart = {};
    $(".edit_depart").each((index, element) => {
      var id = element.getAttribute("id");
      var check = element.checked
      if (check) {
        depart[id] = 1;
      }
    })
    
    $.post(
      strHref,
      {action: "edit", userid: g_id, depart: depart},
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

  function remove() {
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

  function get_employ(id) {
    g_id = id;
    $.post(
      strHref,
      {action: "get_employ", userid: id},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#edit-depart").html(data["list"])
          $("#edit").modal("show")
        }
      }
    )
  } 
</script>
<!-- END: main -->
