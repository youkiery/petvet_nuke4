<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
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
        <h4 class="modal-title">{lang.drug_insert}</h4>
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
            <label>{lang.drugtype}</label>
            <select class="form-control" id="drug">
              <!-- BEGIN: drug -->
              <option value="{drug_value}">{drug_name}</option>
              <!-- END: drug -->
            </select>
          </div>
          <div class="form-group">
            <label> {lang.drugcome} </label>
            <input type="text" class="form-control" id="drugcome" value="{today}" readonly>
          </div>
          <div class="form-group">
            <label> {lang.drugcall} </label>
            <input type="text" class="form-control" id="drugcall" value="{recall}" readonly>
          </div>
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

<div id="vaccinedetail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
          <form>
            <div class="form-group">
              <label> {lang.drug} </label>
              <select class="form-control" id="detail-drug"></select>
            </div>
            <div class="form-group">
              <label>{lang.recall}</label>
              <div class="input-group date" data-provide="datepicker">
                <input type="text" class="form-control" id="confirm_recall" readonly>
                <div class="input-group-addon">
                    <span class="glyphicon glyphicon-th"></span>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label> {lang.note} </label>
              <input type="text" class="form-control" id="detail-note">
            </div>
            <div class="form-group text-center">
              <input class="btn btn-info" id="btn_save_vaccine" type="button" onclick="save_form()" value="{lang.save}" data-dismiss="modal">
            </div>
          </form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>

<ul style="list-style-type: circle; padding: 10px;">
  <li>
    <a href="/index.php?nv={nv}&op={op}"> {lang.drug_list} </a>
  </li>
  <li>
    <a href="/index.php?nv={nv}&op={op}&page=list"> {lang.drug_new_list} </a>
    <img src="/themes/default/images/dispatch/new.gif">
  </li>
</ul>

<!-- BEGIN: filter -->
<button class="filter btn {check}" id="chatter_{ipd}" onclick="change_data({ipd})">
  {vsname}
</button>
<!-- END: filter -->

<div class="right">
  <button class="btn btn-info" id="exall">
    {lang.show_note}
  </button>
</div>


<table class="table">
  <thead>
    <tr>
      <th>
        {lang.customer_name}
      </th>
      <th>
        {lang.customer_number}
      </th>
      <th>
        {lang.drugtype}
      </th>
      <!-- <th>
        {lang.drugcome}
      </th> -->
      <th>
        {lang.drugcall}
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
  var page = "{page}"
  var g_filter = 0
  var note = ["{lang.show_note}", "{lang.hide_note}"]
  var note_s = 0;
  $("#exall").click(() => {
    if (note_s) {
      $(".note").hide()
      note_s = 0
    }
    else {
      $(".note").show()
      note_s = 1
    }
    $("#exall").text(note[note_s])
  })

  $("#drugcome, #drugcall").datepicker({
   	format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true  
	});

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
        script_name,
        {action: "getcustomer", key: $("#customer").val()},
        (response, status) => {
          var data = JSON.parse(response)
          $(".suggest").html(data["list"])
        }
      )
    }, 500);
  }) 

  function change_data(filter) {
    g_filter = filter
    
    $.post(
      strHref,
      {action: "change", filter: g_filter, page: page},
      (response, status) => {
        var data = JSON.parse(response)
        $(".filter").removeClass("btn-info")
        $("#chatter_" + filter).addClass("btn-info")
        $("#content").html(data["html"])
        note_s = 0
        $("#exall").text(note[note_s])
      }
    )
  }

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
        script_name,
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

  function confirm(id, target) {
    var value = document.getElementById("confirm_" + id);
    value = trim(value.innerText)
    if (value == "Đã Gọi" && target == "up") {
      recall(id)      
      $("#btn_save_vaccine").attr("disabled", "disabled");
      $("#vaccinedetail").modal("toggle")
    }
    else {
      $.post(
        strHref,
        {action: 'confirm', target: target, id: id, filter: g_filter, page: page},
        (response, status) => {
          data = JSON.parse(response);
          if (data["status"]) {
            alert_msg(data["notify"]);
            $("#content").html(data["list"])
            note_s = 0
            $("#exall").text(note[note_s])
          }
        }
      )
    }
  }

  function save_form() {
    $("#btn_save_vaccine").attr("disabled", true);
    $.post(
			strHref,
      {action: "recall", recall: $("#confirm_recall").val(), drug: $("#detail-drug").val(), note: $("#detail-note").val(), id: g_id, filter: g_filter, page: page},
      (data, status) => {
				data = JSON.parse(data);
				if (data["status"]) {
          alert_msg(data["notify"])
          $("#content").html(data["list"])
          $("#vaccinedetail").modal("toggle")
				}
        else {
          alert_msg(data["notify"])
        }
			}
    )
  }


  function recall(id) {
    g_id = id
    $("#btn_save_vaccine").attr("disabled", true);
    $.post(
			strHref,
      {action: "getrecall", id: id, filter: g_filter, page: page},
      (data, status) => {
				data = JSON.parse(data);
				if (data["status"]) {
          $("#confirm_recall").val(data["recall"])
          $("#detail-drug").html(data["drug"])
          $("#btn_save_vaccine").attr("disabled", false);
				}
        else {
          alert_msg(data["notify"])
        }
			}
    )
  }

  function setcustom(id, name, phone) {
    customer = id
    $("#customer_name_info").text(name)
    $("#customer_phone_info").text(phone)
  }

  function insert(e) {
    e.preventDefault()
    if (customer > 0) {
      $.post(
        strHref,
        {action: "insert", note: $("#c_note").val(), customer: customer, drug: $("#drug").val(), drugcome: $("#drugcome").val(), drugcall: $("#drugcall").val(), page: page},
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
  // function update() {
  //   if (g_id > 0) {
  //     var check = [];
  //     $("#detail_content").each((index, element) => {
  //       var length = element.children.length
  //       for (var i = 0; i < length; i++) {
  //         tr = element.children[i];
  //         var input = tr.children[2].children[0]
  //         var id = input.getAttribute("class")
  //         var checking = input.checked

  //         check.push({id: id, checking: checking})
  //       } 
  //     })
      
  //     $.post(
  //       script_name,
  //       {action: "update", note: $("#c_note2").val(), doctor: $("#detail_doctor2").val(), customer: g_id, check: check},
  //       (response, status) => {
  //         var data = JSON.parse(response);
  //         if (data["status"]) {
  //           $("#content").html(data["list"])
  //           $("#detail").modal("toggle")
  //           alert_msg(data["notify"])
  //         }
  //         else {
  //           alert_msg(data["notify"])
  //         }
  //       }
  //     )
  //   }
  //   else {      
  //     alert_msg("{lang.no_customer}")
  //   }
  // }
  function view_detail(id) {
    $("#btn-detail").attr("disabled", "disabled")
    $("#btn-detail2").attr("disabled", "disabled")
    $.post(
      script_name,
      {action: "get_detail", id: id},
      (response, status) => {
        g_id = id
        var data = JSON.parse(response);
        if (data["done"] == 0) {
          $("#btn-detail").removeAttr("disabled")
          $("#btn-detail2").removeAttr("disabled")
        }
        $("#detail").modal("toggle")
        $("#detail_content").html(data["list"])
        $("#detail_doctor2").html(data["html"])
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
        script_name,
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

  function editNote(id) {
    var answer = prompt("Ghi chú: ", trim($("#note_" + id).text()));
    if (answer) {
      $.post(
        strHref,
        {action: "editNote", note: answer, id: id},
        (data, status) => {
          data = JSON.parse(data);
          if(data["status"]) {
            $("#note_" + id).text(answer);
          }
          alert_msg(data)
        }
      )
    }
  }

</script>
<!-- END: main -->
