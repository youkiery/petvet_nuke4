<!-- BEGIN: main -->
<style>
  .modal {
    overflow-y: auto;
  }
  label {
    font-weight: normal;
  }
</style>

<div class="container">
  <div id="msgshow"></div>
  <div id="loading">
    <div class="black-wag"> </div>
    <img class="loading" src="/themes/default/images/loading.gif">
  </div>

  <div class="modal" id="user-buy" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">

        </div>
      </div>
    </div>
  </div>

  <a href="/">
    <img src="/themes/default/images/banner.png" style="width: 200px;">
  </a>

  <div style="float: right;">
    <a href="/{module_file}/logout"> Đăng xuất </a>
  </div>

  <form onsubmit="filterE(event)">
    <div class="row" style="margin: 10px 0px;">
      <div class="col-sm-6">
        <input type="text" class="form-control" id="filter-breed" placeholder="Loài">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control" id="filter-species" placeholder="Giống">
      </div>
    </div>

    <div class="row" style="margin: 10px 0px;">
      <div class="col-sm-12 form-inline">
        <b style="margin-right: 50px;"> Trạng thái </b>
        <label style="width: auto;"> <input type="checkbox" value="0" id="filter-status-0" checked> Đang chờ duyệt </label>
        <label style="width: auto;"> <input type="checkbox" value="1" id="filter-status-1" checked> Đã duyệt </label>
        <label style="width: auto;"> <input type="checkbox" value="2" id="filter-status-2" checked> Đã hủy </label>
      </div>
    </div>

    <div class="row" style="margin: 10px 0px;">
      <div class="col-sm-12 form-inline">
        <b style="margin-right: 50px;">Chủ đề</b>
        <label style="width: auto;"> <input type="checkbox" value="0" id="filter-type-0" checked> Cần mua </label>
        <label style="width: auto;"> <input type="checkbox" value="1" id="filter-type-1" checked> Cần bán </label>
        <label style="width: auto;"> <input type="checkbox" value="2" id="filter-type-2" checked> Cần phối </label>
      </div>
    </div>
    <div class="text-center">
      <button class="btn btn-info">
        Lọc danh sách
      </button>
    </div>
  </form>

  <div id="content">
    {content}
  </div>
</div>

<script>
  var global = {
    url: '{url}',
    page: 1
  }

  function filterE(e) {
    e.preventDefault()
    goPage(1)
  }

  function checkFilter() {
    return {
      page: global['page'],
      limit: 10,
      breed: $("#filter-breed").val(),
      species: $("#filter-species").val(),
      status: [
        Number($("#filter-status-0").prop('checked')),
        Number($("#filter-status-1").prop('checked')),
        Number($("#filter-status-2").prop('checked'))
      ],
      type: [
        Number($("#filter-type-0").prop('checked')),
        Number($("#filter-type-1").prop('checked')),
        Number($("#filter-type-2").prop('checked'))
      ]
    }
  }

  function goPage(page) {
    global['page'] = page
    freeze()
    $.post(
      global['url'],
      { action: 'filter', filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
        }, () => {})
      }
    )    
  }

  function cancel(type, id) {
    freeze()
    $.post(
      global['url'],
      { action: 'cancel', type: type, id: id, filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
        }, () => {})
      }
    )    
  }

  function request(type, id) {
    freeze()
    $.post(
      global['url'],
      { action: 'request', type: type, id: id, filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          $("#content").html(data['html'])
        }, () => {})
      }
    )    
  }
</script>
<!-- END: main -->