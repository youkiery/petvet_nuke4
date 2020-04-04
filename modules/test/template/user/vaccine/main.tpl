<!-- BEGIN: main -->
<div id="msgshow" class="msgshow"></div>
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript"
  src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script src="/modules/core/js/vhttp.js"></script>
<script src="/modules/core/js/vremind-5.js"></script>

<style>
  .item_suggest2 {
    width: 90%;
    float: left;
  }

  .item_suggest3 {
    width: 10%;
    float: left;
  }

  .hr {
    border-bottom: 1px solid #eee;
  }

  .error {
    color: red;
    font-size: 1.2em;
    font-weight: bold;
  }

  .text-red {
    color: red;
  }
  .text-yellow {
    color: orange;
  }
  .text-green {
    color: green;
  }

  .vaccine-left {
    position: absolute;
    left: 5px;
  }

  .vaccine-right {
    position: absolute;
    right: 5px;
  }

  td {
    font-size: 0.8em;
  }

  th {
    position: sticky;
    top: 0px;
    background: white;
    z-index: 10;
    border-bottom: 1px solid black;
    text-align: center;
    vertical-align: inherit !important;
  }
</style>

{modal}

<form class="col-sm-10 input-group form-group" onsubmit="search(event)">
  <div class="relative">
    <input type="text" class="form-control" id="vaccine-search-all" style="float:none;"
      placeholder="Số điện thoại hoặc tên khách hàng" autocomplete="off">
    <div class="suggest" id="search-all-suggest"></div>
  </div>
  <div class="input-group-btn">
    <button class="btn"> <span class="glyphicon glyphicon-search"></span> </button>
  </div>
</form>

<div class="form-group">
  <a class="btn btn-sm {btn0}" href="/index.php?nv={nv}&op={op}&page=0&status={status}"> {lang.list} </a>
  <a class="btn btn-sm {btn1}" href="/index.php?nv={nv}&op={op}&page=1&status={status}"> {lang.list2} </a>
  <a class="btn btn-sm {btn2}" href="/index.php?nv={nv}&op={op}&page=2&status={status}"> {lang.list3} </a>
</div>

<div class="form-group">
  <!-- BEGIN: filter -->
  <a class="btn btn-sm {check}" href="/index.php?nv={nv}&op={op}&page={page}&status={ipd}"> {vsname} </a>
  <!-- END: filter -->
  <!-- BEGIN: manager -->
  <div class="right">
    <button class="btn btn-success" onclick="$('#vaccine-modal').modal('show')">
      Thêm
    </button>
  </div>
  <!-- END: manager -->
</div>

<div id="content">
  {content}
</div>

<script>
  var g_miscustom = -1;
  var g_id = 0;
  var g_index = -1;
  var g_vacid = -1;
  var g_disease = -1;
  var g_petid = -1;
  var g_customer = 0;
  var page = '{page}';
  var refresh = 0

  var note = ["Hiện ghi chú", "Ẩn ghi chú"]
  var note_s = 0;
  var searchInterval
  var searchAllTimeout
  var global = {
    id: 0
  }

  $(document).ready(() => {
    vremind.install('#customer_name', '#customer_name_suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', { action: 'customer-remind', name: input, type: 0 }).then(data => {
          resolve(data['html'])
        })
      })
    }, 500, 300)
    vremind.install('#customer_phone', '#customer_phone_suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', { action: 'customer-remind', name: input, type: 1 }).then(data => {
          resolve(data['html'])
        })
      })
    }, 500, 300)
    vremind.install('#vaccine-search-all', '#search-all-suggest', (input) => {
      return new Promise(resolve => {
        vhttp.checkelse('', { action: 'customer-suggest', keyword: $("#vaccine-search-all").val() }).then(data => {
          resolve(data['html'])
        })
      })
    }, 500, 300)
  })

  $('.date, #confirm_recall').datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function editCustomer(id) {
    freeze()
    vhttp.check('', { action: 'get-customer', id: id }).then(data => {
      global['id'] = id
      $("#customer-name").val(data['data']['name'])
      $("#customer-phone").val(data['data']['phone'])
      $("#customer-address").val(data['data']['address'])
      $("#customer-modal").modal('show')
      defreeze()
    }, () => { defreeze() })
  }

  function checkCustomerData() {
    data = {
      name: $("#customer-name").val(),
      address: $("#customer-address").val(),
      phone: $("#customer-phone").val()
    }
    if (!data['name'].length) {
      errorText('customer-error', 'Nhập tên trước khi lưu')
    }
    else if ((!data['phone'].length)) {
      errorText('customer-error', 'Nhập số điện thoại trước khi lưu')
    }
    else {
      return data
    }
    return false
  }

  function editCustomerSubmit() {
    sdata = checkCustomerData()
    if (sdata) {
      freeze()
      vhttp.check('', { action: 'edit-customer', id: global['id'], data: sdata }).then(data => {
        $("#customer-modal").modal('hide')
        defreeze()
      }, () => {
        defreeze() 
        errorText('customer-error', 'Số điện thoại này của người khác')
      })
    }
  }

  function errorText(id, text) {
    $("#" + id).text(text)
    $("#" + id).show()
    $("#" + id).fadeOut(3000)
  }

  function parseKeyword(phone) {
    $("#vaccine-search-all").val(phone)
  }

  function search(e) {
    e.preventDefault()
    $.post(
      strHref,
      { action: 'search-all', keyword: $("#vaccine-search-all").val() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#search-all-content").html(data['html'])
          $("#search-all").modal('show')
          // content.html(data['html'])
        }, () => { })
      }
    )
  }

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
        { action: "change_custom", name: name, phone: phone, address: address, cid: g_miscustom, id: g_id, page: page, cnote: note_s },
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

  function editNote(id) {
    var answer = prompt("Ghi chú: ", trim($("#note_" + id).text()));
    if (answer) {
      freeze()
      vhttp.check('', {action: 'edit-note', id: id, text: answer}).then(data => {
        $("#note_" + id).text(answer)
      }, () => {
        defreeze() 
      })
    }
  }

  function viewNote(index, diseaseid) {
    $("#note_" + diseaseid + "_" + index).toggle(500);
  }

  function selectCustomer(id, customer, phone, pet_option) {
    g_customer = id
    $("#customer_name").val(customer)
    $("#customer_phone").val(phone)
    $("#pet_info").html(pet_option)
  }

  function insertPetModal() {
    $("#insert-pet-name").val('')
    $("#insert-pet-modal").modal('show')
  }

  function insertPetSubmit() {
    if (g_customer) {
      freeze()
      vhttp.check('', { action: 'insert-pet', name: $("#insert-pet-name").val() }).then(data => {
        $("#pet_info").html(data['html'])
        $("#pet_info").val(data['id'])

        $("#insert-pet-modal").modal('hide')
      }, () => {
        defreeze() 
      })
    }
  }

  function checkVaccineData() {
    data = {
      name: $("#customer_name").val(),
      phone: $("#customer_phone").val(),
      address: $("#customer_address").val(),
      customer: g_customer,
      pet: $("#pet_info").val(),
      disease: $("#pet_disease").val(),
      cometime: $("#pet_cometime").val(),
      calltime: $("#pet_calltime").val(),
      doctor: $("#doctor").val(),
      note: $("#pet_note").val()
    }
    if (!data['name'].length) return 'Nhập tên khách hàng trước'
    else if (!data['phone'].length) return 'Nhập tên số điện thoại trước'
    else if (g_customer && !data['pet']) return 'Thêm thú cưng trước'
    else if (!data['disease']) return 'Chưa có loại tiêm phòng, xin cấu hình trong admin'
    else if (!data['cometime'].length) return 'Chọn ngày tiêm phòng trước'
    else if (!data['calltime'].length) return 'Chọn ngày tái chủng trước'
    else if (!data['doctor']) return 'Chưa có bác sĩ, xin cấu hình trong admin'
    return data
  }

  function insertVaccineSubmit() {
    vaccine = checkVaccineData()
    if (!vaccine['phone']) alert_msg(vaccine)
    else {
      freeze()
      vhttp.check('', { action: 'insert-vaccine', data: vaccine }).then(data => {
        g_customer = 0
        $("#customer_name").val('')
        $("#customer_phone").val('')
        $("#customer_address").val('')
        $("#pet_info").html('')
        $("#pet_note").val('')
        $("#content").html(data['html'])
        alert_msg('Đã thêm phiếu tiêm phòng')
      }, () => {
        defreeze() 
      })
    }
  }

  function changeStatus(id, type) {
    freeze()
    vhttp.check('', { action: 'change-status', id: id, type: type }).then((data) => {
      $("#content").html(data['html'])
    }, () => {
      defreeze() 
    })
  }
</script>
<!-- END: main -->