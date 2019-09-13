<!-- BEGIN: main -->
<link rel="stylesheet" href="/themes/default/src/glyphicons.css">
<script type="text/javascript" src="/themes/default/src/jquery-ui.min.js"></script> 
<script type="text/javascript" src="/themes/default/src/jquery.ui.datepicker-vi.js"></script>

<div class="container">
  <div id="loading">
    <div class="black-wag"> </div>
    <img class="loading" src="/themes/default/images/loading.gif">
  </div>
  <div id="msgshow"></div>

  <a href="/">
    <img src="/themes/default/images/banner.png" style="width: 200px;">
  </a>

  <div style="float: right;">
    <a href="/{module_file}/logout"> Đăng xuất </a>
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
</div>
<script>
  var content = $("#content")
  var global = {
    url: '{url}',
    id: 0,
    petid: 0,
    page: 1,
    page2: 1
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
      global['url'],
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
      global['url'],
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
      global['url'],
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
      global['url'],
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
      global['url'],
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
      global['url'],
      { action: 'remove-ceti', petid: global['petid'], filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          $("#modal-ceti").modal('hide')
        }, () => { })
      }
    )
  }
</script>
<!-- <div id="modal-insert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <p class="text-center"> <b> Cấp giấy, chip thú cưng </b> </p>

        <div class="relative">
          <input class="form-control" id="insert-owner" type="text" autocomplete="off"
            placeholder="tìm kiếm khách hàng">
          <div class="suggest" id="insert-owner-suggest"></div>
        </div>

        <div class="relative">
          <input class="form-control" id="insert-pet" type="text" autocomplete="off"
            placeholder="tìm kiếm khách hàng">
          <div class="suggest" id="insert-pet-suggest"></div>
        </div>

        <label> 
          Ngày cấp
          <input type="text" class="form-control" id="insert-time">
        </label>

        <label> 
          Số tiền
          <input type="number" value="0" class="form-control" id="insert-price">
        </label>

        <div class="text-center">
          <button class="btn btn-success" onclick="insertSubmit()">
            Thêm
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<button class="btn btn-success" style="float: right;" onclick="insert()">
  <span class="glyphicon glyphicon-plus"></span>
</button>
<div style="clear: both;"></div> 

<div id="content">
  {content}
</div>-->
<script>
  // var content = $("#content")
  // var global = {
  //   owner: 0,
  //   type: 0
  // }

  // $().ready(() => {
  //   installRemindOwner('insert-owner')
  //   installRemindPet('insert-pet')

  //   $("#insert-time").datepicker({
  //     format: 'dd/mm/yyyy',
  //     changeMonth: true,
  //     changeYear: true
  //   });

  // })

  // function insert() {
  //   $("#modal-insert").modal('show')
  // }

  // function pickOwner(name, id) {
  //   $("#insert-owner").val(name)
  //   global['owner'] = id
  // }

  // function pickPet(name, id) {
  //   $("#insert-pet").val(name)
  //   global['pet'] = id
  // }

  // function installRemindOwner(section) {
  //   var timeout
  //   var input = $("#" + section)
  //   var suggest = $("#" + section + "-suggest")

  //   input.keyup(() => {
  //     clearTimeout(timeout)
  //     timeout = setTimeout(() => {
  //       var key = paintext(input.val())
  //       var html = ''

  //       $.post(
  //         global['url'],
  //         { action: 'parent', keyword: key },
  //         (response, status) => {
  //           checkResult(response, status).then(data => {
  //             suggest.html(data['html'])
  //           }, () => { })
  //         }
  //       )

  //       suggest.html(html)
  //     }, 200);
  //   })
  //   input.focus(() => {
  //     suggest.show()
  //   })
  //   input.blur(() => {
  //     setTimeout(() => {
  //       suggest.hide()
  //     }, 200);
  //   })
  // }

  // function installRemindPet(section) {
  //   var timeout
  //   var input = $("#" + section)
  //   var suggest = $("#" + section + "-suggest")

  //   input.keyup(() => {
  //     clearTimeout(timeout)
  //     timeout = setTimeout(() => {
  //       var key = paintext(input.val())
  //       var html = ''

  //       $.post(
  //         global['url'],
  //         { action: 'pet', keyword: key, userid: global['owner'] },
  //         (response, status) => {
  //           checkResult(response, status).then(data => {
  //             suggest.html(data['html'])
  //           }, () => { })
  //         }
  //       )

  //       suggest.html(html)
  //     }, 200);
  //   })
  //   input.focus(() => {
  //     suggest.show()
  //   })
  //   input.blur(() => {
  //     setTimeout(() => {
  //       suggest.hide()
  //     }, 200);
  //   })
  // }

</script>
<!-- END: main -->
