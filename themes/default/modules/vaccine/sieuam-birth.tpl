<!-- BEGIN: main -->
<style>
  #ui-datepicker-div {
    z-index: 10000 !important;
  }
</style>

<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>
<div id="vac_notify" style="display: none; position: fixed; top: 0; right: 0; background: white; padding: 8px; border: 1px solid black; z-index: 1000;"></div>

<div id="vaccineusg" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.confirm_mess}</h4>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label>{lang.recall}</label>
            <div class="input-group date" data-provide="datepicker">
              <input type="text" class="form-control" id="confirm_recall" value="{now}" readonly>
              <div class="input-group-addon">
                  <span class="glyphicon glyphicon-th"></span>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label>{lang.doctor}</label>
            <select class="form-control" id="doctor_select">
              <!-- BEGIN: doctor -->
              <option value="{doctorid}">
                {doctorname}
              </option>
              <!-- END: doctor -->
            </select>      
          </div>
          <div class="form-group">
            <label>{lang.disease}</label>
            <select class="form-control" id="disease_select">
              <!-- BEGIN: disease -->
              <option value="{disease_value}">
                {disease_name}
              </option>
              <!-- END: disease -->
            </select>      
          </div>
          <div class="form-group text-center">
            <input class="btn btn-info" id="btn_save_birth" type="button" onclick="save_form()" value="{lang.save}">
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="usgbirthdetail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <p>
          {lang.customer}:
          <span id="detail_customer"> </span>
        </p>
        <p>
          {lang.petname}:
          <span id="detail_petname"> </span>
        </p>
        <p>
          {lang.phone}:
          <span id="detail_phone"> </span>
        </p>
      </div>
    </div>
  </div>
</div>

<ul style="list-style-type: circle; padding: 10px;">
  <li>
    <a href="/index.php?nv={nv}&op={op}"> {lang.birth_list} </a>
  </li>
  <li>
    <a href="/index.php?nv={nv}&op={op}&page=list"> {lang.birth_new_list} </a>
    <img src="/themes/default/images/dispatch/new.gif">
  </li>
</ul>



<!-- <form class="vac_form" onsubmit="return filter2(event)">
  <input class="form-control" type="text" name="key" value="{keyword}" placeholder="Nhập từ khóa" class="vac_input">
  <input type="submit" class="btn btn-info" value="{lang.search}">
</form> -->

<!-- BEGIN: filter -->
<button class="filter btn {check}" id="chatter_{ipd}" onclick="change_data({ipd})">
  {vsname}
</button>
<!-- END: filter -->

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
        {lang.usgexbirth}
      </th>  
      <th>
        {lang.usgbirth}
      </th>  
      <th>
        {lang.usgbirthday}
      </th>  
      <th>
        {lang.vacday}
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
      <td colspan="9">
        <p style="float: right;" id="nav">
          {nav}
        </p>
      </td>
    </tr>
  </tfoot>
</table>
<script>
  var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=";
  var g_filter = 0;
  var g_index = -1;
  var g_vacid = -1;
  var g_petid = -1;
  var refresh = 0;
  var page = '{page}';

  // var note = ["Hiện", "Ẩn"]
  // var note_s = 0;
  // $("#exall").click(() => {
  //   $(".note").toggle()
  //   if (note_s) {
  //     note_s = 0
  //   }
  //   else {
  //     note_s = 1
  //   }
  //   $("#exall").text(note[note_s])
  // })
  
  $('#confirm_recall').datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });
  
    
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
  //   {action: "birthfilter", keyword: $("#keyword").val(), limit: $("#limit").val(), filter: filter},
  //   (response, status) => {
  //     var data = JSON.parse(response);
  //     $("#content").html(data["data"]["html"])
  //     $("#nav").html(data["data"]["nav"])
  //   })
  // }

  function change_data(id) {
    g_filter = id;
    $.post(link + "sieuam", 
    {action: "birthfilter", keyword: $("#customer_key").val(), filter: g_filter, page: page},
    (response, status) => {
      var data = JSON.parse(response);

      $(".filter").removeClass("btn-info")
      $("#chatter_" + id).addClass("btn-info")
      $("#content").html(data["data"]["html"])
    })
  }


    function confirm_upper(index, vacid, petid) {
      var value = document.getElementById("vac_confirm_" + index);
      value = trim(value.innerText)
      if (value == "Đã Gọi") {
        recall(index, vacid, petid)
        $("#vaccineusg").modal("toggle")
      }
      else {
        fetch(link + "sieuam&action=cvsieuam&act=up&value=" + value + "&vacid=" + vacid + "&filter=" + g_filter, []).then(response => {
          response = JSON.parse(response);
          change_color(value, response, index, vacid, petid);
        })
      }
    }
  
    function confirm_lower(index, vacid, petid) {
      value = trim(value.innerText)
      if (value == "Đã Tiêm") {
      
      }
      else {
        var value = document.getElementById("vac_confirm_" + index);
        fetch(link + "sieuam&action=cvsieuam&act=low&value=" + trim(value.innerText) + "&vacid=" + vacid + "&filter=" + g_filter, []).then(response => {
          response = JSON.parse(response);
          change_color(value, response, index, vacid, petid);
        })
      }
    }
  
    function change_color(e, response, index, vacid, petid) {
        console.log(response);
      if (response["status"]) {
        
        $("#nav").html(response["data"]["nav"])
        $("#content").html(response["data"]["html"])
        alert_msg('{lang.changed}');
      }
    }
  
    function recall(index, vacid, petid) {
      $("#btn_save_birth").attr("disabled", true);
      $.post(
        link + "sieuam&act=post",
        {action: "getbirthrecall", vacid: vacid},
        (data, status) => {
          data = JSON.parse(data);
          g_vacid = vacid
          g_petid = petid
          g_index = index
          
          if (data["status"]) {
            $("#confirm_recall").val(data["data"]["calltime"])
            $("#doctor_select").html(data["data"]["doctor"])
            if (data["data"]["vaccine"] < 2) {
              $("#btn_save_birth").attr("disabled", false);
            }
          }
        }
      )
    }
  
    function save_form() {
      $.post(
        link + "sieuam&act=post",
        {action: "save", petid: g_petid, recall: $("#confirm_recall").val(), doctor: $("#doctor_select").val(), disease: $("#doctor_select").val(), vacid: g_vacid, filter: g_filter, page: page},
        (data, status) => {
          data = JSON.parse(data);
          if (data["status"]) {
            $("#content").html(data["data"]["html"]) 
            $("#vaccineusg").modal("toggle")
            alert_msg("{lang.saved}")
            g_vacid = -1;
            g_petid = -1;
            g_index = -1;
          } else {
  
          }
        }
      )
    }
  
  $(".detail").click((e) => {
    var id = e.target.parentElement.getAttribute("id")
    $("#usgbirthdetail").modal("toggle")
    $.post(
      link + "sieuam-birth&act=post",
      {action: "detail", id: id},
      (response, status) => {
        var data = JSON.parse(response)
        if (data["status"]) {
          $("#detail_customer").text(data["customer"])
          $("#detail_phone").text(data["phone"])
          $("#detail_petname").text(data["petname"])
        }
      }
    )
  })

  setInterval(() => {
    if (!refresh) {
      refresh = 1
      $.post(
        link + "sieuam", 
        {action: "birthfilter", keyword: $("#customer_key").val(), filter: g_filter, page: page},
        (response, status) => {
          var data = JSON.parse(response);
          $("#content").html(data["data"]["html"])
          refresh = 0
        }
      )
    }
  }, 10000);

  </script>
<!-- END: main -->