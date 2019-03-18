<!-- BEGIN: main -->
<div class="msgshow" id="msgshow"></div>
<div id="remove" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.spa_remove}</h4>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" onclick="remove()">
          {lang.submit}
        </button>
          <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
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
        <h4 class="modal-title">{lang.spa_insert}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return insert(event)">
          <div class="form-group">
            <label>{lang.customer}</label>
            <div class="relative">
              <input class="form-control" id="customer" type="text" name="customer" autocomplete="off">
              <div class="suggest"></div>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-md-12">
              <b>
                {lang.customer_name}:
              </b>
              <span id="customer_name_info"> </span>
            </div>
            <div class="col-md-12">
              <b>
                {lang.customer_number}:
              </b>
              <span id="customer_phone_info"> </span>
            </div>
          </div>
          <div class="form-group">
            <label>{lang.spa_doctor}</label>
            <select class="form-control" id="doctor">
              <!-- BEGIN: doctor -->
              <option value="{doctor_value}">{doctor_name}</option>
              <!-- END: doctor -->
            </select>
          </div>
          <table class="table">
            <thead>
              <tr>
                <th>
                  {lang.index}
                </th>
                <th>
                  {lang.content}
                </th>
                <th>

                </th>
              </tr>
            </thead>
            <tbody id="insert_content">
              {insert_content}
            </tbody>
          </table>
          <div class="form-group">
            <label>
              {lang.note}
            </label>
            <input type="text" class="form-control" id="c_note">
          </div>
          <button class="btn btn-info">
            {lang.submit}
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="detail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.spa_detail}</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <span> {lang.doctor}: </span>
          <span id="detail_doctor"></span>
        </div>
        <div class="form-group">
          <span> {lang.spa_from}: </span>
          <span id="detail_from"></span>
        </div>
        <table class="table small">
          <thead>
            <tr>
              <th>
                {lang.index}
              </th>
              <th>
                {lang.content}
              </th>
              <th>

              </th>
            </tr>
          </thead>
          <tbody id="detail_content">
            
          </tbody>
          <tfoot>
            <tr>
              <td>
                {lang.note}
              </td>
              <td colspan="2">
                  <input type="text" class="form-control" id="c_note2">
              </td>
            </tr>
          </tfoot>
        </table>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" onclick="update()" id="btn-detail">
          {lang.update}
        </button>
        <button class="btn btn-info" onclick="detail()" id="btn-detail">
          {lang.complete}
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
      <th>
        {lang.index}
      </th>
      <!-- <th>
        {lang.spa_doctor}
      </th> -->
      <th>
        {lang.customer_name}
      </th>
      <th>
        {lang.customer_number}
      </th>
      <!-- <th>
        {lang.spa_from}
      </th> -->
      <th>
        {lang.spa_end}
      </th>
      <th>
      </th>
    </tr>
  </thead>
  <tbody id="content">
    {content}
  </tbody>
  <tfoot>
    <tr>
      <td colspan="6">
        <button class="btn btn-info" data-toggle="modal" data-target="#insert">
          {lang.add}
        </button>
      </td>
    </tr>
  </tfoot>
</table>
<script>
  var list = [];
  var customer = 0;
  var g_id = 0;
  var timer;
  $("#detail_content").click((e) => {
    var row = e.target.parentElement.children[2].children[0];
    if (row.checked) {
      row.checked = false
    }
    else {
      row.checked = true
    }
  })
  $("#customer").blur(() => {
    setTimeout(() => {
      $(".suggest").hide()
    }, 200)
  })
  $("#customer").focus(() => {
    $(".suggest").show()
  })
  $("#customer").keyup(e => {
    clearTimeout(timer);
    timer = setTimeout(() => {
      $.post(
        strHref,
        {action: "getcustomer", key: $("#customer").val()},
        (response, status) => {
          var data = JSON.parse(response)
          $(".suggest").html(data["list"])
        }
      )
    }, 500);
  }) 
  function setcustom(id, name, phone) {
    customer = id
    $("#customer_name_info").text(name)
    $("#customer_phone_info").text(phone)
  }
  function insert(e) {
    e.preventDefault()
    if (customer > 0) {
      var check = [];
      $("#insert_content").each((index, element) => {
        var length = element.children.length
        for (var i = 0; i < length; i++) {
          tr = element.children[i];
          var input = tr.children[2].children[0]
          var id = input.getAttribute("class")
          var checking = input.checked

          check.push({id: id, checking: checking})
        } 
      })
      $.post(
        strHref,
        {action: "insert", note: $("#c_note").val(), customer: customer, doctor: $("doctor").val(), check: check},
        (response, status) => {
          var data = JSON.parse(response);
          if (data["status"]) {
            $("#content").html(data["list"])
            $("#insert").modal("toggle")
            alert_msg(data["notify"])
          }
          else {
            alert_msg(data["notify"])
          }
        }
      )
    }
    else {      
      alert_msg("{lang.no_customer}")
    }
  }
  function update() {
    if (g_id > 0) {
      var check = [];
      $("#detail_content").each((index, element) => {
        var length = element.children.length
        for (var i = 0; i < length; i++) {
          tr = element.children[i];
          var input = tr.children[2].children[0]
          var id = input.getAttribute("class")
          var checking = input.checked

          check.push({id: id, checking: checking})
        } 
      })
      
      $.post(
        strHref,
        {action: "update", note: $("#c_note2").val(), customer: g_id, check: check},
        (response, status) => {
          var data = JSON.parse(response);
          if (data["status"]) {
            $("#content").html(data["list"])
            $("#detail").modal("toggle")
            alert_msg(data["notify"])
          }
          else {
            alert_msg(data["notify"])
          }
        }
      )
    }
    else {      
      alert_msg("{lang.no_customer}")
    }
  }
  function remove() {
    if (g_id > 0) {
      $.post(
        strHref,
        {action: "remove", id: g_id},
        (response, status) => {
          var data = JSON.parse(response);
          if (data["status"]) {
            $("#content").html(data["list"])
            $("#remove").modal("toggle")
            alert_msg(data["notify"])
          }
          else {
            alert_msg(data["notify"])
          }
        }
      )
    }
    else {      
      alert_msg("{lang.no_customer}")
    }
  }
  function remove_confirm(id) {
    g_id = id;
    $("#remove").modal("toggle")
  }
  function view_detail(id) {
    $("#btn-detail").attr("disabled", "disabled")
    $.post(
      strHref,
      {action: "get_detail", id: id},
      (response, status) => {
        g_id = id
        var data = JSON.parse(response);
        if (data["done"] == 0) {
          $("#btn-detail").removeAttr("disabled")
        }
        $("#detail").modal("toggle")
        $("#detail_content").html(data["list"])
        $("#detail_doctor").text(data["doctor"])
        $("#detail_from").text(data["from"])
        $("#c_note2").val(data["note"])
      }
    )
  }
  function detail() {
    if (g_id > 0) {
      var check = [];
      $("#detail_content").each((index, element) => {
        var length = element.children.length
        for (var i = 0; i < length; i++) {
          tr = element.children[i];
          var input = tr.children[2].children[0]
          var id = input.getAttribute("class")
          var checking = input.checked

          check.push({id: id, checking: checking})
        } 
      })

      $.post(
        strHref,
        {action: "confirm", note: $("#c_note2").val(), customer: g_id, check: check},
        (response, status) => {
          var data = JSON.parse(response);
          $("#detail").modal("toggle")
          $("#content").html(data["list"])
          alert_msg(data["notify"])
        }
      )    
    }
    else {
      alert_msg("{lang.no_customer}")
    }
  }
</script>
<!-- END: main -->

