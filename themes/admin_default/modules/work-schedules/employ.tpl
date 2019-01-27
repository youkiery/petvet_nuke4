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
          <div class="form-group">
            <label> {lang.employ_name} </label>
            <input class="form-control" type="text" id="name-edit">
          </div>
          <div class="form-group suggest">
            <label> {lang.employ_depart}: <span id="depart-list"></span> </label>
            <input class="form-control suggest-input" type="text" id="depart-edit">
            <div class="suggest-list"></div>
          </div>
          <button class="btn btn-info" data-dismiss="modal">
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
  function select(id) {
    g_id = id;
  }

  function remove() {
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
</script>
<!-- END: main -->
