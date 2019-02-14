<!-- BEGIN: main -->
<div id="edit" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.depart_edit}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return edit()">
          <div class="form-group">
            <label> {lang.depart_name} </label>
            <input class="form-control" type="text" id="name">
          </div>
          <div class="form-group">
            <label> {lang.depart_rele} </label>
            <select id="role">
              <!-- BEGIN: role_option -->
              <option value="{depart_role_value}">{depart_role_name}</option>
              <!-- END: role_option -->
            </select>
          </div>
          <button class="btn btn-info" data-dismiss="modal">
            {lang.depart_employ_submit}
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
        <h4 class="modal-title">{lang.depart_remove}</h4>
      </div>
      <div class="modal-body text-center">
        <button class="btn btn-danger" onclick="remove()" data-dismiss="modal">
          {lang.g_remove}
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
        {lang.depart_employ_username}
      </th>
      <th>
        {lang.depart_employ_name}
      </th>
      <th>
        {lang.depart_employ_role}
      </th>
      <th>
      </th>
    </tr>
  </thead>
  <tbody id="content">
    {content}
  </tbody>
</table>
<form onsubmit="return search(event)">
  <div class="form-group">
    <label> {lang.depart_searchkey} </label>
    <input class="form-control" type="text" id="keyword">
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
          {lang.employ_username}
        </th>
        <th>
          {lang.employ_name}
        </th>
        <th>
          {lang.employ_role}
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
  var g_id = -1

  function select(id) {
    g_id = id
  }

  function chose(id) {
    if (id > 0) {
      $.post(
        strHref,
        {action: "chose", userid: id, name: trim($("#search_" + id).text())},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            $("#content").html(data["list"])
            $("#s_content").hide();
          }
          alert_msg(data["notify"])
        }
      )
    }
  }

  function remove() {
    if (g_id > 0) {
      $.post(
        strHref,
        {action: "remove", userid: g_id},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            $("#content").html(data["list"])
            $("#s_content_list").html("");
          }
          alert_msg(data["notify"])
        }
      )
    }
  }

  function search(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "search", keyword: $("#keyword").val()},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          alert_msg(data["notify"])
          $("#s_content_list").html(data["list"]);
          $("#s_content").show();
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
</script>
<!-- END: main -->
