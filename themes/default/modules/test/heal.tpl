<!-- BEGIN: main -->
<!-- <link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script> -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<div id="heal-insert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="row"><div class="col-sm-6">Khách hàng</div>
        <div class="col-sm-18 relative"><input type="text" class="form-control" id="heal-insert-customer"> <div class="suggest" id="customer-suggest"></div> </div> </div>
        <div class="row"><div class="col-sm-6">Thú nuôi</div>
        <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-pet"> </div> </div>
        <div class="row"><div class="col-sm-6">Lứa tuổi</div>
        <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-age"> </div> </div>
        <div class="row"><div class="col-sm-6"> Cân nặng </div>
        <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-weight"> </div> </div>
        <div class="row"><div class="col-sm-6"> Triệu chứng </div>
        <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-appear"> </div> </div>
        <div class="row"><div class="col-sm-6"> Xét nghiệm </div>
        <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-exam"> </div> </div>
        <div class="row"><div class="col-sm-6"> Siêu âm </div>
        <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-usg"> </div> </div>
        <div class="row"><div class="col-sm-6"> X-quang </div>
        <div class="col-sm-18"><input type="text" class="form-control" id="heal-insert-xray"> </div> </div>
        <div class="row"> Thuốc điều trị 

        </div>
        <div class="text-center">
          <button class="btn btn-success" id="heal-insert-button"> Thêm</button>
          <button class="btn btn-success" id="heal-edit-button"> Sửa</button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="heal-summary" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-inline">
          <label> Từ ngày </label>
          <input type="text" class="form-control" id="summary-cometime" value="{cometime}" autocomplete="off">
          <label> Đến ngày </label>
          <input type="text" class="form-control" id="summary-calltime" value="{calltime}" autocomplete="off">
        </div>
        <div id="heal-summary-content">
          {summary}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="form-inline">
  <label> Từ ngày </label>
  <input type="text" class="form-control" id="cometime" value="{cometime}" autocomplete="off">
  <label> Đến ngày </label>
  <input type="text" class="form-control" id="calltime" value="{calltime}" autocomplete="off">
  <select class="form-control" id="limit">
    <option value="10">10</option>
    <option value="20">20</option>
    <option value="50">50</option>
    <option value="100">100</option>
  </select>
  <button class="btn btn-info" onclick="filter()">
    Lọc
  </button>
</div>

<!-- <div class="form-inline">
  <button class="type btn btn-warning active" type="0">
    Gần đây
  </button>
  <button class="type btn btn-warning" type="1">
    Hôm nay
  </button>
</div> -->

<!-- <div class="form-inline">
  <button class="insult btn btn-info active" insult="0">
    Đang điều trị
  </button>
  <button class="insult btn btn-info" insult="1">
    Xuất viện
  </button>
  <button class="insult btn btn-info" insult="2">
    Đã chết
  </button>
</div> -->

<div id="content">
  {content}
</div>
<script>
  var healInsert = $("#heal-insert")
  var healSummaryContent = $("#heal-summary-content")
  var summaryCometime = $("#summary-cometime")
  var summaryCalltime = $("#summary-calltime")
  var healInsertCustomer = $("#heal-insert-customer")
  var healInsertPet = $("#heal-insert-pet")
  var healInsertAge = $("#heal-insert-age")
  var healInsertWeight = $("#heal-insert-weight")
  var healInsertAppear = $("#heal-insert-appear")
  var healInsertExam = $("#heal-insert-exam")
  var healInsertUsg = $("#heal-insert-usg")
  var healInsertXray = $("#heal-insert-xray")
  var healInsertButton = $("#heal-insert-button")
  var healEditButton = $("#heal-edit-button")
  var summaryCalltime = $("#summary-calltime")
  var cometime = $("#cometime")
  var calltime = $("#calltime")
  var limit = $("#limit")
  var content = $('#content')

  var customerSuggest = $("#customer-suggest")

  var type = $(".type")
  var insult = $(".insult")

  var editData = {}
  var dbdata = {}
  var addData = JSON.parse(localStorage.getItem('add-list'))
  var mode = 0
  var g_type = 0
  var page = 1
  var customerTimeout

  $('#summary-cometime, #summary-calltime, #cometime, #calltime').datepicker({
		format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
	});
  
  type.click((e) => {
    var target = e.currentTarget
    type.removeClass('active')
    type.removeClass('btn-warning')
    target.classList.add('active')
    target.classList.add('btn-warning')
    g_type = target.getAttribute('type')
    filter()
  })

  healInsertCustomer.keyup(() => {
    clearTimeout(customerTimeout)
    customerTimeout = setTimeout(() => {
      $.post(
        strHref,
        {action: 'customer-suggest', keyword: healInsertCustomer.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            dbdata = JSON.parse(data['customer'])
            parseSuggest()
          }, () => {})
        }
      )
    }, 200);
  })

  healInsertCustomer.focus(() => {
    customerSuggest.show()
  })
  healInsertCustomer.blur(() => {
    customerSuggest.hide()
  })

  function parseSuggest() {
    var html = ''
    dbdata.forEach((customer, index) => {
      html += '<div class="item-suggest" onclick="parsePet('+index+')">' + customer['name'] + '<div class="right"> '+ customer["name"] +' </div> </div>';     
    });
    customerSuggest.html(html)

  }

  function parsePetset(index) {
    var html = '<option>'
    dbdata[index]['pet'].forEach((pet, index) => {
      html += '<option value="'+pet['id']+'">' + customer['name'] +' </option>';     
    });
    healInsertPet.html(html)
  }

  function filter() {
    freeze()
    $.post(
      strHref,
      {action: 'filter', page: page, limit: limit.val(), cometime: cometime.val(), calltime: calltime.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {})
      }
    )
  }

  function insert(id) {
    healInsertButton.show()
    healEditButton.hide()
    healInsert.model('show')
  }

  function edit(id) {
    freeze()
    $.post(
      strHref,
      {action: 'get_edit', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          editData = data
          healInsertButton.hide()
          healEditButton.show()
          healInsert.modal('show')
        }, () => {})
      }
    )
  }

  function editSubmit() {
    freeze()
    $.post(
      strHref,
      {action: 'edit'},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          healInsert.modal('hide')
        }, () => {})
      }
    )
  }
  
</script>
<!-- END: main -->
