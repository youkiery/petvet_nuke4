<!-- BEGIN: main -->
<div class="msgshow" id="msgshow"></div>
<div id="customer_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.spa_custom_title}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return customer_submit(event)">
          <div class="row">
            <div class="form-group col-md-12">
              <label>{lang.customer}</label>
              <input type="text" class="form-control" id="customer_name">
            </div>
            <div class="form-group col-md-12">
              <label>{lang.phone}</label>
              <input type="text" class="form-control" id="customer_phone">
            </div>
          </div>
          <div class="form-group">
            <label>{lang.address}</label>
            <input type="text" class="form-control" id="customer_address">
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
            <label>{lang.customer} <span class="small_icon" data-toggle="modal" data-target="#customer_modal"> + </span></label>
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
            <label>{lang.spa_weight}</label>
            <select class="form-control" id="weight">
              <!-- BEGIN: weight -->
              <option value="{weight_value}">{weight_name}</option>
              <!-- END: weight -->
            </select>
          </div>
          <div class="form-group">
            <label>{lang.spa_doctor}</label>
            <select class="form-control" id="doctor">
              <!-- BEGIN: doctor -->
              <option value="{doctor_value}">{doctor_name}</option>
              <!-- END: doctor -->
            </select>
          </div>
          <div class="form-group">
            <label>{lang.spa_doctor2}</label>
            <select class="form-control" id="doctor2">
              <!-- BEGIN: doctor2 -->
              <option value="{doctor_value}">{doctor_name}</option>
              <!-- END: doctor2 -->
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
        <div class="form-group">
          <label> {lang.spa_weight} </label>
          <select class="form-control" id="detail_weight"> </select>
        </div>
        <div class="form-group">
          <label> {lang.spa_doctor2} </label>
          <select class="form-control" id="detail_doctor2"> </select>
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
        <button class="btn btn-info" onclick="detail()" id="btn-detail2">
          {lang.complete}
        </button>
        <button class="btn btn-info" onclick="payment()" id="btn-detail3">
          {lang.payment}
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
  var refresh = 0
  $("#detail_content").click((e) => {
    var row = e.target;
    if (row.tagName !== "INPUT") {
      row = e.target.parentElement.children[2].children[0];
      if (row.checked) {
        row.checked = false
      }
      else {
        row.checked = true
      }
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

  function customer_submit(e) {
    e.preventDefault()
    var name = $("#customer_name").val()
    var phone = $("#customer_phone").val()
    var address = $("#customer_address").val()
    
    if (!name) {
      alert_msg("{lang.no_custom_name}");
    }
    else if (!phone) {
      alert_msg("{lang.no_custom_phone}");
    }
    else {
      $.post(
        strHref,
        {action: "custom", name: name, phone: phone, address: address},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            customer = data["id"]
            $("#customer_modal").modal("toggle")
            $("#customer_name_info").text(name)
            $("#customer_phone_info").text(phone)
            alert_msg(data["notify"])
          }
          else {alert_msg(data["notify"])}
        }
      )
    }
  }

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
        {action: "insert", note: $("#c_note").val(), customer: customer, doctor: $("#doctor").val(), doctor2: $("#doctor2").val(), weight: $("#weight").val(), check: check},
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
        {action: "update", note: $("#c_note2").val(), doctor: $("#detail_doctor2").val(), weight: $("#detail_weight").val(), customer: g_id, check: check},
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

  function payment() {
    $.post(
      strHref,
      {action: "payment", id: g_id},
      (response, status) => {
        var data = JSON.parse(response);
        if (data["status"]) {
          $("#content").html(data["list"])
          $("#detail").modal("toggle")
        }
        alert_msg(data["notify"])
      }
    )
  }

  function view_detail(id) {
    $("#btn-detail").attr("disabled", "disabled")
    $("#btn-detail2").attr("disabled", "disabled")
    $("#btn-detail3").attr("disabled", "disabled")
    $.post(
      strHref,
      {action: "get_detail", id: id},
      (response, status) => {
        g_id = id
        var data = JSON.parse(response);
        if (data["done"] == 0) {
          $("#btn-detail").removeAttr("disabled")
        }
        if (data["payment"] == 0) {
          $("#btn-detail2").removeAttr("disabled")
          $("#btn-detail3").removeAttr("disabled")
        }
        $("#detail").modal("toggle")
        $("#detail_content").html(data["list"])
        $("#detail_doctor2").html(data["html"])
        $("#detail_weight").html(data["weight"])
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
        {action: "confirm", note: $("#c_note2").val(), doctor: $("#detail_doctor2").val(), customer: g_id, check: check},
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

  setInterval(() => {
    if (!refresh) {
      refresh = 1
      $.post(
        strHref,
        {action: "refresh"},
        (response, status) => {
          var data = JSON.parse(response);
          $("#content").html(data["list"])
          refresh = 0
        }
      )
    }
  }, 10000);
</script>
<!-- END: main -->
