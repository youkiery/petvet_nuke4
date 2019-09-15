<!-- BEGIN: main -->
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">
<script type="text/javascript" src="/themes/default/src/jquery-ui.min.js"></script> 
<script type="text/javascript" src="/themes/default/src/jquery.ui.datepicker-vi.js"></script>

<div class="msgshow"></div>
<div id="modal-parent" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div style="clear: both;"></div>
        <div class="row">
          <div class="col-sm-12">
            <div class="input-group">
              <input type="text" class="form-control" id="parent-key" placeholder="Người dùng theo số điện thoại">
              <div class="input-group-btn">
                <button class="btn btn-info" onclick="parentFilter()">
                  Tìm kiếm
                </button>
              </div>
            </div>
            <div id="parent-list" style="max-height: 400px; overflow-y: scroll;">  </div>
          </div>
          <div class="col-sm-12">
            <div class="input-group">
              <input type="text" class="form-control" id="pet-key" placeholder="Tên, giống loài thú cưng">
              <div class="input-group-btn">
                <button class="btn btn-info" onclick="petFilter()">
                  Tìm kiếm
                </button>
              </div>
            </div>
            <div id="pet-list" style="max-height: 400px; overflow-y: scroll;">  </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="modal-ceti" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body text-center">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p class="text-center">
          Nhập số tiền thu?
        </p>
        <input type="text" class="form-control" id="ceti-price" placeholder="Số tiền">
        <button class="btn btn-info" onclick="cetiSubmit()">
          Lưu
        </button>
        <button class="btn btn-danger" onclick="removeCetiSubmit()">
          Xóa
        </button>
      </div>
    </div>
  </div>
</div>

<div id="modal-remove-pay" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body text-center">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p>
          Xác nhận xóa?
        </p>
        <button class="btn btn-danger" onclick="removePaySubmit()">
          Xóa
        </button>
      </div>
    </div>
  </div>
</div>

<div id="modal-pay" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body text-center">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p>
          Nhập phiếc chi?
        </p>
        <select class="form-control" id="pay-user">
          <!-- BEGIN: user -->
          <option value="{userid}">{username}</option>
          <!-- END: user -->
        </select>
        <input type="text" class="form-control" id="pay-price" placeholder="Số tiền">
        <textarea class="form-control" id="pay-content" rows="3"></textarea>
        <button class="btn btn-info" onclick="paySubmit()">
          Lưu
        </button>
      </div>
    </div>
  </div>
</div>

<label>
  <input type="radio" name="type" id="filter-type-1" checked> Danh sách thu
</label>
<label>
  <input type="radio" name="type" id="filter-type-2"> Danh sách chi
</label>
<button class="btn btn-info" onclick="filter()">
  Lọc
</button>
<button class="btn btn-success" style="float: right;" onclick="pay()">
  <span class="glyphicon glyphicon-plus"></span>
</button>
<div style="clear: both;"></div>
<div id="content">
  {content}
</div>

<script>
  var content = $("#content")
  var global = {
    id: 0,
    petid: 0,
    page: 1,
    page2: 1,
    parentid: 0
  }

  function filter() {
    if ($("#filter-type-1").prop('checked')) {
      goPage(1)
    }
    else {
      goPage2(1)
    }
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      strHref,
      { action: 'filter', filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          $("#modal-ceti").modal('hide')
        }, () => { })
      }
    )
  }

  function goPage2(page) {
    global['page2'] = page
    $.post(
      strHref,
      { action: 'filter', filter: checkFilter2() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          $("#modal-ceti").modal('hide')
        }, () => { })
      }
    )
  }

  function checkFilter() {
    return {
      page: global['page'],
      limit: 10,
      type: ($("#filter-type-1").prop('checked') ? 1 : 2)
    }
  }

  function checkFilter2() {
    return {
      page: global['page2'],
      limit: 10,
      type: ($("#filter-type-1").prop('checked') ? 1 : 2)
    }
  }

  function removePay(id) {
    global['id'] = id
    $("#modal-remove-pay").modal('show')
  }

  function removePaySubmit() {
    $.post(
      strHref,
      { action: 'remove-pay', id: global['id'], filter: checkFilter2() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          $("#modal-pay").modal('hide')
        }, () => { })
      }
    )
  }

  function pay() {
    $("#modal-pay").modal('show')
  }

  function checkPay() {
    return {
      userid: $("#pay-user").val(),
      price: $("#pay-price").val(),
      content: $("#pay-content").val()
    }
  }

  function paySubmit() {
    if ($("#filter-type-1").prop('checked')) {
      $("#filter-type-2").prop('checked', true);
      global['page2'] = 1
    }
    $.post(
      strHref,
      { action: 'pay', data: checkPay(), filter: checkFilter2() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          $("#modal-pay").modal('hide')
        }, () => { })
      }
    )
  }

  function ceti(petid, price) {
    global['petid'] = petid
    $("#ceti-price").val(price)
    $("#modal-ceti").modal('show')
  }

  function cetiSubmit() {
    $.post(
      strHref,
      { action: 'ceti', price: $("#ceti-price").val(), petid: global['petid'], filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          $("#modal-ceti").modal('hide')
        }, () => { })
      }
    )
  }

  function removeCetiSubmit() {
    $.post(
      strHref,
      { action: 'remove-ceti', petid: global['petid'], filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          $("#modal-ceti").modal('hide')
        }, () => { })
      }
    )
  }

  function parentFilter() {
    $.post(
      global['url'],
      // {action: 'filter-parent', key: $("#parent-key").val(), type: ($("#parent-type-1").prop('checked') ? 1 : 2)},
      {action: 'filter-parent', key: $("#parent-key").val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#parent-list").html(data['html'])
        }, () => {})
      }
    )
  }

  function thisOwner(id) {
    global['parentid'] = id
    petFilter()
  }

  function petFilter() {
    if (global['parentid']) {
      $.post(
        global['url'],
        {action: 'filter-pet', key: $("#pet-key").val(), parentid: global['parentid']},
        (response, status) => {
          checkResult(response, status).then(data => {
            $("#pet-list").html(data['html'])
          }, () => {})
        }
      )
    }
  }

  function thisPet(id, name) {
    $("#modal-parent").modal('hide')
    ceti(id, 0)
  }

</script>
<!-- END: main -->
