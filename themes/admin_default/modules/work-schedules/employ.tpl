<!-- BEGIN: main -->
<div class="alert_msg" id="alert_msg"></div>
<div id="add" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.employ_add}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return add()">
          <div class="form-group" id="add-depart">
            <table class="table">
              <thead>
                <tr>
                  <th>
                    {lang.user}
                  </th>
                  <th>
                    {lang.user_main}
                  </th>
                  <th>
                    {lang.delete}
                  </th>
                  <th>
                    {lang.depart_name}
                  </th>
                </tr>
              </thead>
              <tbody>
                <tbody>
                  <!-- BEGIN: row -->
                  <tr>
                    <td>
                      <label class="radio-inline">
                        <input type="radio" name="{id}" class="add_depart" id="si_{id}" {check1}>
                      </label>
                    </td>        
                    <td>
                      <label class="radio-inline">
                        <input type="radio" name="{id}" class="add_depart2" id="ai_{id}" {check2}>
                      </label>
                    </td>
                    <td>
                      <span class="btn" onclick="diselect({id})">
                        x
                      </span>
                    </td>
                    <td>
                      {depart}
                    </td>
                  </tr>
                  <!-- END: row -->
                </tbody>
              </tbody>  
            </table>
          </div>
          <div class="form-group text-center">
            <button class="btn btn-info btn-block text-center" onclick="add_submit(event)">
              {lang.employ_add}
            </button>
          </div>
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
        <h4 class="modal-title">{lang.employ_edit}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return edit()">
          <div class="form-group" id="edit-depart">
            
          </div>
          <div class="form-group text-center">
            <button class="btn btn-info btn-block text-center" onclick="edit_submit(event)">
              {lang.g_edit}
            </button>
          </div>
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
        <h4 class="modal-title">{lang.employ_remove}</h4>
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
        {lang.employ_username}
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
<form onsubmit="return search(event)">
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
          {lang.employ_username}
        </th>
        <th>
          {lang.employ_name}
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
  var g_userid = -1;
  var g_depart = {}

  function select(id) {
    g_id = id;
  }

  function add(id) {
    g_userid = id
    $("#add").modal("show")
  }

  function add_submit(e) {
    e.preventDefault()
    var depart = {};
    $(".add_depart").each((index, element) => {
      var id = element.getAttribute("id").slice(3);
      var check = element.checked
      if (check) {
        depart[id] = {action: 1, value: 1};
      }
    })
    $(".add_depart2").each((index, element) => {
      var id = element.getAttribute("id").slice(3);
      var check = element.checked
      if (check) {
        depart[id] = {action: 1, value: 2};
      }
    })
    
    $.post(
      strHref,
      {action: "add", userid: g_userid, depart: depart},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#add").modal("hide")
          $("#s_content").hide()
        }
        alert_msg(data["notify"])
      }
    )
  }

  function search(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: "search"},
      (response) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#s_content").show()
          $("#s_content_list").html(data["list"])
        }
        else {
          alert_msg(data["notify"])
        }
      }
    )
  }

  function edit_submit(e) {
    e.preventDefault()
    var depart = {};
    $(".edit_depart").each((index, element) => {
      var id = element.getAttribute("id").slice(2);
      var check = element.checked
      if (check) {
        depart[id] = {action: 1, value: 1};
      }
    })
    $(".edit_depart2").each((index, element) => {
      var id = element.getAttribute("id").slice(2);
      var check = element.checked
      if (check) {
        depart[id] = {action: 1, value: 2};
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

  function diselect(id) {
    $("#a_" + id)[0].checked = false
    $("#s_" + id)[0].checked = false
    $("#si_" + id)[0].checked = false
    $("#ai_" + id)[0].checked = false
  }
</script>
<!-- END: main -->
