<!-- BEGIN: main -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<div class="msgshow" id="msgshow"></div>

<div class="form-inline">
  <input type="text" class="form-control" id="filter-from" placeholder="Ngày bắt đầu">
  <input type="text" class="form-control" id="filter-end" placeholder="Ngày kết thúc">
  <!-- <button class="btn btn-info" onclick="changeDate()">
      <span class="glyphicon glyphicon-arrow-left"></span>
    </button>
    <button class="btn btn-info" onclick="changeDate(1)">
      <span class="glyphicon glyphicon-arrow-right"></span>
    </button> -->
  <button class="btn btn-info" onclick="goPage(1)">
    Lọc danh sách
  </button>
</div>

<h2> Danh sách quá ngày </h2>
<div id="content">
  {content}
</div>
<script>
  var content = $("#content")
  var global = {
    page: 1
  }

  $(this).ready(() => {
    $("#filter-from, #filter-end").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
  })

  function checkFilter() {
    return {
      from: $("#filter-from").val(),
      end: $("#filter-end").val(),
      page: global['page'],
      limit: 20
    }
  }

  function goPage(page) {
    global['page'] = page
    $.post(
      strHref,
      { action: "filter", filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data["html"])
        }, () => { })
      })
  }

  function change(id) {
    $.post(
      strHref,
      { action: "change", id: id, filter: checkFilter() },
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data["html"])
        }, () => { })
      })
  }

    // function changeDate(type = 0) {
    //   var date = $("#filter-date").val().split('/')

    //   if (type) {
    //     var datetime = new Date(date['2'], Number(date['1']) - 1, Number(date['0']) + 7)
    //   }
    //   else {
    //     var datetime = new Date(date['2'], Number(date['1']) - 1, Number(date['0']) - 7)
    //   }

    //   $("#filter-date").val((datetime.getDate() < 10 ? "0" : "" ) + datetime.getDate() + '/' + (datetime.getMonth() < 10 ? "0" : "" ) + (datetime.getMonth() + 1) + '/' + datetime.getFullYear())
    //   goPage(1)
    // }
</script>
<!-- END: main -->