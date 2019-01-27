<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div id="msgshow" class="msgshow"></div>
<style>
		#ui-datepicker-div {
			z-index: 10000 !important;
		}
	</style>

<div id="vac_notify"></div>
<div id="reman"></div>
<div id="treatinsult" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
          <div id="vac2_header"></div>
          <div id="vac2_body"></div>
      </div>
    </div>
  </div>
</div>
<div id="treatdetail" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
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
            {lang.treatcome}: 
            <span id="luubenh"></span>
          </p>
          <p>
            {lang.doctor2}: 
            <span id="doctor"></span>
          </p>
        </div>
        <div class="treating">
          <span id="treating" style="float: right;"></span>
          <form onsubmit="return themtreating(event)">
       			<div class="input-group date" data-provide="datepicker">
              <input type="text" class="form-control" id="timetreating" value="{now}" readonly>
              <div class="input-group-addon">
                  <span class="glyphicon glyphicon-th"></span>
              </div>
            </div>
            <button class="submitbutton btn btn-info">
              {lang.add}
            </button>
          </form>
          <div id="dstreating"> </div>
          <div id="treating">
            <form onsubmit="return luutreating(event)" id="qltreating">
              <div style="font-size:0px;">
                <input class="form-control" type="text" id="temperate" placeholder="{lang.temperate}">
                <input class="form-control" type="text" id="eye" placeholder="{lang.eye}">
                <input class="form-control" type="text" id="other" placeholder="{lang.other}">
                <input class="form-control" type="text" id="treating2" placeholder="{lang.treating}">
              </div>
              <div>
                <label for="doctorx">{lang.doctor}</label>
                <select class="form-control" name="doctorx" id="doctorx"> 
                  <!-- BEGIN: doctor -->
                  <option value="{doctorid}"> {doctorname} </option>
                  <!-- END: doctor -->
                </select>
              </div>
              <div>
                <label for="status">{lang.status}</label>
                <select class="form-control" name="status" id="status2"> 
                  <!-- BEGIN: status_option -->
                  <option value="{status_value}"> {status_name} </option>
                  <!-- END: status_option -->
                </select>
              </div>
              <div>
                <label for="xetnhiem">{lang.examine}</label>
                <select class="form-control" name="examine" id="examine"> 
                  <option value="0"> {lang.non} </option>
                  <option value="1"> {lang.have} </option>
                </select>
              </div>
              <button class="submitbutton btn btn-info">
                {lang.submit}
              </button>
              <input type="button" class="btn btn-info" onclick="ketthuc(1)" value="{lang.treated}">
              <input type="button" class="btn btn-info" onclick="ketthuc(2)" value="{lang.dead}">
              <input type="button" class="btn btn-info" onclick="tongket(1)" value="{lang.summary}" data-toggle="modal" data-target="#treatinsult">
            </form>
          </div>
      </div>
    </div>
  </div>
</div>
</div>
<!-- <form class="vac_form" method="GET">
  <input type="hidden" name="nv" value="vac">
  <input type="hidden" name="op" value="danhsachsieuam">
  <input type="text" name="key" value="{keyword}" class="vac_input">
  <input type="submit" class="vac_button" value="{lang.search}">
</form> -->

<!-- <form class="vac_form" onsubmit="return filter2(event)">
  <input class="form-control" placeholder="Nhập từ khóa" type="text" name="key" id="keyword" value="{keyword}">
  <input class="btn btn-info" type="submit" class="vac_button" value="{lang.search}">
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
        {lang.petname}
      </th>
      <th>
        {lang.customer}
      </th>
      <th>
        {lang.doctor2}
      </th>  
      <th>
        {lang.treatcome}
      </th>
      <th>
        {lang.pet_status}
      </th>
      <th>
        {lang.insult}
      </th>
    </tr>
  </thead>
  <tbody id="disease_display">
    {content}
  </tbody>
</table>
<script>
  var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
  var g_filter = 0;
  var lid = -1;
  var g_ltid = -1;
  var g_id = -1;
  var d_treating = []
  var g_insult = -1;
  var vac_index = 0;
  var refresh = 0

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
    
  //   $.post(link + "luubenh", 
  //   {action: "filter", keyword: $("#keyword").val(), filter: filter},
  //   (response, status) => {
  //     var data = JSON.parse(response);
  //     $("#disease_display").html(data["data"]["html"])
  //   })
  // }

  function change_data(id) {
    g_filter = id;
    $.post(link + "luubenh", 
    {action: "filter", keyword: $("#customer_key").val(), filter: g_filter},
    (response, status) => {
      var data = JSON.parse(response);

      $(".filter").removeClass("btn-info")
      $("#chatter_" + id).addClass("btn-info")
      $("#disease_display").html(data["data"]["html"])
    })
  }


  $('#timetreating').datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  $("tbody tr").click((e) => {
    lid = e.currentTarget.getAttribute("id");
    vac_index = 1;
    $.post(
      link + "luubenh",
      {action: "thongtinluubenh", id: lid},
      (response, status) => {
        response = JSON.parse(response)
        if (response["status"]) {
          data = response["data"]
          $("#petname").text(data["petname"])
          $("#customer").text(data["customer"])
          $("#phone").text(data["phone"])
          $("#luubenh").text(data["cometime"])
          $("#doctor").text(data["doctor"])
          var h_treating = ""
          g_insult = data["insult"];
          
          if (data["treating"]) {
            if (data["insult"] > 0) {
              $("#qltreating input").attr("disabled", "disabled");
              $("#qltreating select").attr("disabled", "disabled");
              $(".submitbutton").attr("disabled", "disabled");
            }
            else {
              $("#qltreating input").removeAttr("disabled", "");
              $("#qltreating select").removeAttr("disabled", "");
              $(".submitbutton").removeAttr("disabled", "");
            }
            select = -1;
            d_treating = data["treating"]
            $("#dstreating").html("")
            data["treating"].forEach(e => {
              select ++
              var time = e["time"] * 1000;
              g_ltid = e["id"]
              g_id = select
              html = "<span onclick='xemtreating(" + g_ltid + ", " + select +")'>" + e["time"] + "</span> ";
              $("#dstreating").html($("#dstreating").html() + html)
            })
            $("#temperate").val(data["treating"][select]["temperate"])

            $("#eye").val(data["treating"][select]["eye"])
            $("#other").val(data["treating"][select]["other"])
            $("#treating2").val(data["treating"][select]["treating"])
            $("#examine").val(data["treating"][select]["examine"])
            $("#treating").text(data["treating"][select]["time"])
            $("#status2").val(data["treating"][select]["status"])
            $("#doctorx").val(data["treating"][select]["doctorx"])
          }
          else {
            d_treating = []
            $("#qltreating input").attr("disabled", "disabled");
            $("#qltreating select").attr("disabled", "disabled");
            $("#dstreating").html("")
            
            $("#temperate").val("")
            $("#rate").val("")
            $("#other").val("")
            $("#treating2").val("")
            $("#examine").val(0)
            $("#treating").text("")
            $("#status2").val(0)
            $("#doctorx").val(0)
          }
        }
      }
    )
  })

  function tongket() {
    var body = ""
    var addition = "<p><b>{lang.totaltreat} " + d_treating.length + " </b></p>"
    d_treating.forEach((treating, index) => {
      body += "<tr><td style='width: 20%'>" + treating["time"] + "</td><td style='width: 50%'><b>{lang.temperate}</b>: " + treating["temperate"] + "<br><b>{lang.eye}</b>: " + treating["eye"] + "<br><b>{lang.other}</b>: " + treating["other"] + "</td><td style='width: 30%'>" + treating["treating"] + "</td></tr>"
    }) 
    var html = 
    "<table class='table table-border'><thead><tr style='height: 32px;'><th><span id='tk_otherhhang'>" + $("#customer").text() + "</span> / <span id='tk_thucung'>" + $("#petname").text() + "</span></th><th>{lang.eviden}</th><th>{lang.treating}</th></tr></thead><tbody>" + body + "</tbody><tfoot><tr><td colspan='3'>" + addition + "</td></tr></tfoot></table>"
    $("#vac2_body").html(html)
  }

  function themtreating(e) {
    e.preventDefault();
    $.post(
      link + "luubenh",
      {action: "themtreating", time: $("#timetreating").val(), id: lid},
      (response, status) => {
        response = JSON.parse(response)
        switch (response["status"]) {
          case 1:
            // thành công
            var data = response["data"]
            d_treating.push(data)
            id = d_treating.length - 1
            g_ltid = data["id"]
            g_id = id
            $("#temperate").val(d_treating[id]["temperate"])
            $("#eye").val(d_treating[id]["eye"])
            $("#other").val(d_treating[id]["other"])
            $("#treating2").val(d_treating[id]["treating"])
            $("#examine").val(d_treating[id]["examine"])
            $("#treating").text(d_treating[id]["time"])
            $("#status2").val(d_treating[id]["status"])
            $("#doctorx").val(d_treating[id]["doctorx"])

            html = "<span onclick='xemtreating(" + d_treating[id]["id"] + ", " + g_id + ")'>" + data["time"] + "</span>";
            $("#dstreating").html($("#dstreating").html() + html)
            $("#qltreating input").removeAttr("disabled", "");
            $("#qltreating select").removeAttr("disabled", "");
          break;
          case 2:
            // đã tồn tại ngày hôm nay
            
          break;
          default:
        }
        // if () {
        // }
      }
    )
  }

  function xemtreating(ltid, id) {
    g_ltid = ltid;
    g_id = id;
    
    $("#temperate").val(d_treating[id]["temperate"])
    $("#eye").val(d_treating[id]["eye"])
    $("#other").val(d_treating[id]["other"])
    $("#treating2").val(d_treating[id]["treating"])
    $("#examine").val(d_treating[id]["examine"])
    $("#treating").text(d_treating[id]["time"])
    $("#status2").val(d_treating[id]["status"])
    $("#doctorx").val(d_treating[id]["doctorx"])
  }

  function ketthuc(val) {
    $.post(
      link + "luubenh",
      {action: "trihet", id: lid, val: val},
      (response, status) => {
        response = JSON.parse(response);
        if (response["status"]) {
          $("#disease_display").html(response["data"]["html"])
          alert_msg("{lang.changed}");
          $("#treatdetail").modal("toggle")
        }
      }
    )    
  }

  function luutreating(e) {
    e.preventDefault();
    var temperate = $("#temperate").val();
    var eye = $("#eye").val();
    var other = $("#other").val();
    var examine = $("#examine").val();
    var treating = $("#treating2").val();
    var status = $("#status2").val();
    var doctorx = $("#doctorx").val();
    
    $.post(
      link + "luubenh",
      {action: "luutreating", id: g_ltid, temperate: temperate, eye: eye, other: other, examine: examine, treating: treating, status: status, doctorx: doctorx},
      (response, status) => {
        response = JSON.parse(response);
        if (response["status"]) {
          alert_msg("{lang.saved}");
          $("#" + lid).css("background", response["data"]["color"])
          $("#" + lid + " .suckhoe").text(response["data"]["status"])
          d_treating[g_id]["temperate"] = temperate
          d_treating[g_id]["eye"] = eye
          d_treating[g_id]["other"] = other
          d_treating[g_id]["examine"] = examine
          d_treating[g_id]["treating2"] = treating
          d_treating[g_id]["status"] = status
          d_treating[g_id]["doctorx"] = doctorx
        }
      }
    )    
  }
  
  setInterval(() => {
    if (!refresh) {
      refresh = 1
      $.post(
        link + "luubenh", 
        {action: "filter", keyword: $("#customer_key").val(), filter: g_filter},
        (response, status) => {
          var data = JSON.parse(response);
          $("#disease_display").html(data["data"]["html"])
          refresh = 0
        }
      )
    }
  }, 10000);

</script>
<!-- END: main -->