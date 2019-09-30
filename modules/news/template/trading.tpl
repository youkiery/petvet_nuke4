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

  <div class="modal" id="user-insert" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <ul class="nav nav-pills">
            <li class="active"><a data-toggle="pill" href="#buy"> Mua </a></li>
            <li><a data-toggle="pill" href="#trade"> Bán, phối </a></li>
          </ul>

          <div class="tab-content">
            <div id="home" class="tab-pane fade in active">
              <label class="row">
                <div class="col-sm-3">
                  Loài
                </div>
                <div class="col-sm-9" style="text-align: right;">
                  <input type="text" class="form-control" id="species-buy">
                  <div class="suggest" id="species-suggest-buy" style="text-align: left;"></div>
                </div>
              </label>

              <label class="row">
                <div class="col-sm-3">
                  Giống
                </div>
                <div class="col-sm-9" style="text-align: right;">
                  <input type="text" class="form-control" id="breed-buy">
                  <div class="suggest" id="breed-suggest-buy" style="text-align: left;"></div>
                </div>
              </label>

              <label class="row">
                <div class="col-sm-3">
                  Giới tính
                </div>
                <div class="col-sm-9">
                  <label>
                    <input type="radio" name="sex4" id="buy-sex-0" checked> Sao cũng được
                  </label>
                  <label>
                    <input type="radio" name="sex4" id="buy-sex-1"> Đực
                  </label>
                  <label>
                    <input type="radio" name="sex4" id="buy-sex-2"> Cái
                  </label>
                </div>
              </label>

              <label>
                <input type="checkbox" name="age" id="buy-age-check" checked> Sao cũng được
              </label>
              <label class="row">
                <div class="col-sm-3">
                  Tuổi
                </div>
                <div class="col-sm-9">
                  <input type="number" class="form-control" id="buy-age" placeholder="tháng" disabled>
                </div>
              </label>

              <label>
                <input type="checkbox" name="age" id="buy-price-check" checked> Liên hệ
              </label>
              <label for="customRange2">Khoảng giá <span id="buy-price"></span></label>
              <input type="range" class="buy-form" min="0" max="100" id="buy-price-from" disabled>
              <input type="range" class="buy-form" min="0" max="100" id="buy-price-end" disabled>

              <label>
                Yêu cầu thêm
                <textarea class="form-control" id="buy-note" rows="5"></textarea>
              </label>

              <div id="buy-error" style="color: red; font-weight: bold;"></div>

              <div class="text-center">
                <button class="btn btn-info" onclick="buySubmit()">
                  Thêm cần mua
                </button>
              </div>
            </div>
            <div id="trade" class="tab-pane fade">
                            
            </div>
          </div>
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
  <div class="separate"></div>
  <a style="margin: 8px 0px; display: block;" href="javascript:history.go(-1)">
    <span class="glyphicon glyphicon-chevron-left">  </span> Trở về </a>
  </a>

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