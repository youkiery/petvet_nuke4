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

  <div class="separate"></div>
  <a style="margin: 8px 0px; display: block;" href="javascript:history.go(-1)">
    <span class="glyphicon glyphicon-chevron-left">  </span> Trở về </a>
  </a>

  <div id="modal-statistic" class="modal fade" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body text-center">
          <form class="row">
            <div class="col-sm-6">
              <input type="text" class="form-control" id="filter-from">
            </div>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="filter-end">
            </div>
            <button class="btn btn-info" onclick="viewStatistic(event)">
              Lọc theo thời gian
            </button>
          </form>

          <div id="content">
            {statistic}
          </div>
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
  <button class="btn btn-info" style="float: right;" onclick="showStatistic()">
    Thống kê
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

  $(this).ready(() => {
    $("#filter-from, #filter-end").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

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

  function showStatistic() {
    $("#modal-statistic").modal('show')
  }

  function viewStatistic(e) {
    e.preventDefault()
    $.post(
      global['url'],
      {action: 'statistic', filter: {from: $("#filter-from").val(), end: $("#filter-end").val()}},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        })
      }
    )
  }

</script>
<!-- END: main -->
