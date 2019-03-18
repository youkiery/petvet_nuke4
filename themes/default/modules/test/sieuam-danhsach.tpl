<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<div id="msgshow" class="msgshow"></div>
<div id="vac_notify"></div>
<div id="reman"></div>

<div id="miscustom" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div>
          {lang.miscustom_prequest}
        </div>
      </div>
      <div class="modal-body">
        <form onsubmit="return change_custom(event)">
          <div class="row">
            <div class="form-group col-md-12">
              <label> {lang.customer} </label>
              <input type="text" class="form-control" id="vaccustom">
            </div>
            <div class="form-group col-md-12">
              <label> {lang.phone} </label>
              <input type="text" class="form-control" id="vacphone">
            </div>
          </div>
          <div class="form-group">
            <label> {lang.address} </label>
            <input type="text" class="form-control" id="vacaddress">
          </div>
          <button class="btn btn-info">
            {lang.g_edit}
          </button>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal" onclick="miscustom_submit()">
          {lang.submit}
        </button>
        <button class="btn btn-info" data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="deadend" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div>
          {lang.deadend_prequest}
        </div>
      </div>
      <div class="modal-footer">
        <button data-dismiss="modal" onclick="deadend_submit()">
          {lang.submit}
        </button>
        <button data-dismiss="modal">
          {lang.cancel}
        </button>
      </div>
    </div>
  </div>
</div>

<div id="usgrecall" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.usgrecallmodal}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return onbirth(event)">
       		<div class="form-group">
            <div>
              <label>{lang.usgnumber}</label>
              <input class="form-control" type="number" id="birthnumber">
            </div>
          </div>
       		<div class="form-group">
            <div>
              <label>{lang.usgbirthday}</label>
              <div class="input-group date" data-provide="datepicker">
                <input type="text" class="form-control" id="birthday" value="{now}" readonly>
                <div class="input-group-addon">
                    <span class="glyphicon glyphicon-th"></span>
                </div>
              </div>
            </div>
          </div>
       		<div class="form-group">
            <div>
              <label>{lang.usgdoctor}</label>
              <select class="form-control" id="doctor_select">
                <!-- BEGIN: doctor -->
                <option value="{doctorid}">
                  {doctorname}
                </option>
                <!-- END: doctor -->
              </select>      
            </div>
          </div>
       		<div class="form-group text-center">
            <button class="btn btn-info" id="btn_save_birth">
              {lang.save}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="usgdetail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
          <div id="thumb-box">
            <img id="thumb" src="{image}">
          </div>
          <div id="info">
            <p>
              {lang.petname}: 
              <span id="petname"></span>
            </p>
            <p>
              {lang.customer}: 
              <span id="customer"></span>
            </p>
            <p>
              {lang.phone}: 
              <span id="phone"></span>
            </p>
            <p>
              {lang.usgcome}: 
              <span id="sieuam"></span>
            </p>
            <p>
              {lang.usgcall}: 
              <span id="dusinh"></span>
            </p>
          </div>
        </div>
    </div>
  </div>
</div>

<!-- <form class="vac_form" onsubmit="return filter2(event)">
  <input class="form-control" placeholder="Nhập từ khóa" type="text" name="key" id="keyword" value="{keyword}">
  <input class="btn btn-info" type="submit" class="vac_button" value="{lang.search}">
</form> -->

<ul style="list-style-type: circle; padding: 10px;">
  <li>
    <a href="/index.php?nv={nv}&op={op}"> {lang.usg_list} </a>
  </li>
  <li>
    <a href="/index.php?nv={nv}&op={op}&page=list"> {lang.usg_new_list} </a>
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
    Hiện ghi chú
  </button>
</div>

<table class="table table-striped">
  <thead>
    <tr>
      <th>
        {lang.index}
      </th>  
      <th>
        {lang.customer}
      </th>  
      <th>
        {lang.phone}
      </th>  
      <th>
        {lang.usgcome}
      </th>  
      <th>
        {lang.usgcall}
      </th>  
      <th>
        {lang.usgconfirm}
      </th>
    </tr>
  </thead>
  <tbody id="disease_display">
    {content}
  </tbody>
  <tfoot>
    <tr>
      <td colspan="9">
        <p style="float: right;" id="nav">
          {nav}
        </p>
      </td>
    </tr>
  </tfoot>
</table>

<script>
  var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
  var g_filter = 0;
  var g_miscustom = -1;
  var g_vacid = -1;
  var g_index = -1
  var g_id = -1
  var g_petid = -1
  var page = "{page}";
  var refresh = 0

  var note = ["Hiện ghi chú", "Ẩn ghi chú"]
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
  
  // function filter2(e) {
  //   e.preventDefault();
  //   $("#disease_display").html("")
  //   var element = $("[name='filter']");
  //   var filter = "";
  //   element.each((i, e) => {
  //     if (e.checked == true) {
  //       filter += e.value;
  //     }
  //   })
  //   if (!filter.length) {
  //     filter = "0";
  //   }
    
  //   $.post(link + "sieuam", 
  //   {action: "filter", keyword: $("#keyword").val(), filter: filter},
  //   (response, status) => {
  //     var data = JSON.parse(response);
  //     $("#disease_display").html(data["data"]["html"])
  //   })
  // }

  function change_custom(e) {
    e.preventDefault()
    var name = $("#vaccustom").val()
    var phone = $("#vacphone").val()
    var address = $("#vacaddress").val()
    var msg = "";

    if (!name.length) {
      msg = "{lang.no_custom_name}"
    }
    else if (phone.length < 4 || phone.length > 15) {
      msg = "{lang.no_custom_phone}"
    }
    else {
      $.post(
        strHref,
        {action: "change_custom", name: name, phone: phone, address: address, cid: g_miscustom, id: g_id, page: page, cnote: note_s},
        (response, status) => {
          var data = JSON.parse(response)
          if (data["status"]) {
            $("#miscustom").modal("toggle")
            $("#disease_display").html(data["list"])
          }
          alert_msg(data["notify"])
        }
      )
    }
    if (msg) {
      alert_msg(msg)
    }
  }

  function miscustom(id) {
    g_vacid = id
    $.post(
      strHref,
      {action: "get_miscustom", id: id},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          g_miscustom = data["id"]
          $("#miscustom").modal("toggle")
          $("#vaccustom").val(data["name"])
          $("#vacphone").val(data["phone"])
          $("#vacaddress").val(data["address"])
        }
      }
    )
  }

  function miscustom_submit() {
    $.post(
      "index.php?" + query_string,
      {action: "miscustom", vacid: g_vacid, id: g_id, page: page, cnote: note_s},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#disease_display").html(data["list"])
          // note_s = 0
          // $("#exall").text(note[note_s])
          alert_msg("{lang.complete}")
        }
        else {
          alert_msg("{lang.error}")
        }
      }
    )
  }
  function deadend(id) {
    g_vacid = id
    $("#deadend").modal("toggle")
  }
  function deadend_submit(id) {
    $.post(
      "index.php?" + query_string,
      {action: "deadend", vacid: g_vacid, id: g_id, page: page},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#disease_display").html(data["list"])
          alert_msg("{lang.complete}")
          // note_s = 0
          // $("#exall").text(note[note_s])
        }
        else {
          alert_msg("{lang.error}")
        }
      }
    )
  }

  function change_data(id) {
    g_filter = id;
    $.post(link + "sieuam", 
    {action: "change_data", keyword: $("#customer_key").val(), filter: g_filter, page: page, cnote: 0},
    (response, status) => {
      var data = JSON.parse(response);

      $(".filter").removeClass("btn-info")
      $("#chatter_" + id).addClass("btn-info")
      $("#disease_display").html(data["data"]["html"])
      note_s = 0
      $("#exall").text(note[note_s])
    })
  }

  $('#birthday').datepicker({
   	format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
	});

  function confirm_lower(index, vacid, petid) {
    var e = document.getElementById("vac_confirm_" + index);
    e = trim(e.innerHTML)
    if (e == "Đã Sinh") {
      
    }
    else {
      $.post(
        link + "xacnhansieuam",
        {act: "down", value: e, id: vacid, filter: g_filter, page: page, cnote: note_s},
        (data, status) => {
          data = JSON.parse(data);
          change_color(e, data, index, vacid, petid);
        }
      )
    }
  }

  function confirm_upper(index, vacid, petid) {
    var e = document.getElementById("vac_confirm_" + index);
    e = trim(e.innerHTML)
    if (e == "Đã Gọi") {
      birth(index, vacid, petid);
      $("#usgrecall").modal("toggle")
    }
    else {
      $.post(
        link + "xacnhansieuam",
        {act: "up", value: e, id: vacid, filter: g_filter, page: page, cnote: note_s},
        (data, status) => {
          data = JSON.parse(data);
          change_color(e, data, index, vacid, petid);
        }
      )
    }
  }

  function change_color(e, response, index, vacid, petid) {
    if (response["status"]) {
      // e.innerText = response["data"]["value"];
      // e.style.color = response["data"]["color"];
      
      $("#disease_display").html(response["data"]["html"]);
      alert_msg('{lang.changed}');
      // note_s = 0
      // $("#exall").text(note[note_s])
      

      // var check = response["data"].hasOwnProperty("birth");
      // if (check) {
      //   if (response["data"]["color"] == "green") {
      //     $("#birth_" + index).html("~> <button class='btn btn-info' type='button' data-toggle='modal' data-target='#usgrecall' onclick='birth(" + index + ", " + vacid + ", " + petid + ")'> " + response["data"]["birth"] + "</button>");
      //   }
      // } else {
      //   $("#birth_" + index).html("");
      // }
    }
  }

  function editNote(index) {
    var answer = prompt("Ghi chú: ", trim($("#note_v" + index).text()));
    if (answer) {
      $.post(
        link + "sieuam&act=post",
        {action: "editNote", note: answer, id: index},
        (data, status) => {
          data = JSON.parse(data);
          if(data["status"]) {
            $("#note_v" + index).text(answer);
          }
        }
      )
    }
  }

  function viewNote(index) {
    $("#note_" + index).toggle(500);
  }

  function birth(index, vacid, petid) {
    $("#birthnumber").val("")
    $("#birthday").val("")
    $("#btn_save_birth").attr("disable", true);

    $.post(
        link + "sieuam",
        {action: "getbirth", id: vacid},
        (response, status) => {
          data = JSON.parse(response);
          if (data["status"]) {
            $("#birthnumber").val(data["data"]["birth"])
            if (data["data"]["birthday"]) {
              $("#birthday").val(data["data"]["birthday"])
            }
            $("#doctor_select").html(data["data"]["doctor"])
            $("#btn_save_birth").attr("disable", false);
          }
        }
      )

    g_index = index
    g_id = vacid
    g_petid = petid
  }

  function onbirth(event) {
    event.preventDefault()
      $.post(
        link + "sieuam",
        {action: "birth", id: g_id, petid: g_petid, birth: $("#birthnumber").val(), birthday: $("#birthday").val(), doctor: $("#doctor_select").val(), filter: g_filter, page: page, cnote: note_s},
        (response, status) => {
          data = JSON.parse(response);
          if (data["status"]) {
            $("#usgrecall").modal("toggle");
            $("#disease_display").html(data["data"]["html"])
            alert_msg("{lang.saved}")
            // note_s = 0
            // $("#exall").text(note[note_s])
            // $("#birth_" + g_index).attr("disabled", "true")
            g_index = -1
            g_id = -1
            g_petid = -1
          }
        }
      )
  }

  $("tbody td[class]").click((e) => {
    var id = e.currentTarget.parentElement.getAttribute("id");
    $.post(link + "sieuam",
    {action: "getusgdetail", id: id},
    (response, status) => {
      console.log(response);
      data = JSON.parse(response);

      if (data["status"]) {
        var c = document.createElement("canvas")
        var ctx = c.getContext("2d");
        var img = new Image()
        img.src = data["data"]["image"];
        img.onload = () => {
          c.width = img.width
          c.height = img.height
          ctx.fillStyle = "#fff"
          ctx.fillRect(0, 0, c.width, c.height)
          ctx.drawImage(img, 0, 0)
          var image_data = c.toDataURL("image/jpg")
          $("#thumb").attr("src", image_data);
        }

        $("#thumb").attr("src", "");
        $("#petname").text(data["data"]["petname"]);
        $("#customer").text(data["data"]["customer"]);
        $("#phone").text(data["data"]["phone"]);
        $("#sieuam").text(data["data"]["cometime"]);
        $("#dusinh").text(data["data"]["calltime"]);
      }
      else {
        console.log(data["error"]);
      }
      
    })
  })

  setInterval(() => {
    if (!refresh) {
      refresh = 1
      $.post(link + "sieuam", 
      {action: "change_data", keyword: $("#customer_key").val(), filter: g_filter, page: page, cnote: note_s},
      (response, status) => {
        var data = JSON.parse(response);
        $("#disease_display").html(data["data"]["html"])
        refresh = 0
      })

    }
  }, 10000);

</script>
<!-- END: main -->