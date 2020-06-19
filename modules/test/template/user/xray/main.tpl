<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<div id="msgshow" class="msgshow"></div>

{modal}

<div class="form-group" style="float: right;">
  <button class="btn btn-success" onclick="$('#insert-modal').modal('show')">
    Thêm X-Quang
  </button>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>
  var link = "/index.php?" + nv_name_variable + "=" + nv_module_name + "&act=post&" + nv_fc_variable + "=";
  var blur = true;
  var g_customer = -1;
  var customer_data = [];
  var customer_list = [];
  var g_index = -1
  var customer_name = document.getElementById("customer_name");
  var customer_phone = document.getElementById("customer_phone");
  var customer_address = document.getElementById("customer_address");
  var pet_info = document.getElementById("pet_info");
  var pet_note = document.getElementById("pet_note");
  var suggest_name = document.getElementById("customer_name_suggest");
  var suggest_phone = document.getElementById("customer_phone_suggest");

  $('.date').datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function checkXray() {
    data = {
      pet: $('#pet_info').val(),
      cometime: $('#cometime').val(),
      temperate: $('#temperate').val(),
      eye: $('#eye').val(),
      other: $('#other').val(),
      treating: $('#treating2').val(),
      doctor: $('#doctor').val(),
      condition: $('#condition').val()
    }
    if (!data['pet']) {
      return "Khách hàng chưa có thú cưng!"
    }
    return data
  }

  function insertXraySubmit() {
    sdata = checkXray()
    if (!sdata['pet']) {
      alert_msg(msg)
    } else {
      vhttp.checkelse('', {action: 'insert-xray', data: sdata}).then(data => {
        g_customer = 0
        $('#customer_name').val('')
        $('#customer_phone').val('')
        $('#customer_address').val('')
        $('#pet_info').html('')
        $('#temperate').val('')
        $('#eye').val('')
        $('#other').val('')
        $('#treating2').val('')
        $('#content').html(data['html'])
        $('#insert-modal').modal('hide')
      })
    }
    return false;
  }

  customer_name.addEventListener("keyup", (e) => {
    showSuggest(e.target.getAttribute("id"), true);
  })

  customer_phone.addEventListener("keyup", (e) => {
    showSuggest(e.target.getAttribute("id"), false);
  })

  suggest_name.addEventListener("mouseenter", (e) => {
    blur = false;
  })
  suggest_name.addEventListener("mouseleave", (e) => {
    blur = true;
  })
  customer_name.addEventListener("focus", (e) => {
    suggest_name.style.display = "block";
  })
  customer_name.addEventListener("blur", (e) => {
    if (blur) {
      suggest_name.style.display = "none";
    }
  })
  suggest_phone.addEventListener("mouseenter", (e) => {
    blur = false;
  })
  suggest_phone.addEventListener("mouseleave", (e) => {
    blur = true;
  })
  customer_phone.addEventListener("focus", (e) => {
    suggest_phone.style.display = "block";
  })
  customer_phone.addEventListener("blur", (e) => {
    if (blur) {
      suggest_phone.style.display = "none";
    }
  })

</script>
<!-- END: main -->