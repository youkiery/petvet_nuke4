<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">

<div id="msgshow"></div>

<div class="row">
  <div class="col-sm-12">
    <input type="text" class="form-control" id="filter-key" placeholder="Từ khóa">
  </div>
  <div class="col-sm-12">
    <select class="form-control" id="filter-time">
      <option value="7"> Một tuần </option>
      <option value="30"> Một tháng </option>
      <option value="90" selected> Một quý </option>
      <option value="180"> Nửa năm </option>
      <option value="365"> Một năm </option>
      <option value="720"> Hai năm </option>
    </select>
  </div>
</div>
<div class="row">
  <div class="col-sm-12">
    <input type="text" class="form-control date" id="filter-from" placeholder="Bắt đầu từ...">
  </div>
  <div class="col-sm-12">
    <input type="text" class="form-control date" id="filter-to" placeholder="...Đến khoảng">
  </div>
</div>
<div>
  <label style="padding: 0px 20px 0px 0px;">
    <input type="checkbox" id="item-check-all" checked> Tất cả
  </label>
  <!-- BEGIN: category -->
  <label style="padding: 0px 20px 0px 0px;"> <input type="checkbox" class="event-checkbox" id="item-check-{id}" checked> {name} </label>
  <!-- END: category -->
</div>
<div class="text-center">
  <button class="btn btn-info" onclick="filter()">
    <span class="glyphicon glyphicon-filter"></span>
  </button>
</div>

<div id="content">
  {content}
</div>

<script src="/modules/exp/src/script.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
  $(document).ready(() => {
    var today = new Date().getTime()
    $(".date").datepicker({
      format: 'dd/mm/yyyy',
      changeMonth: true,
      changeYear: true
    });
    $("#item-check-all").change((e) => {
      checked = e.currentTarget.checked
      $(".event-checkbox").each((index, item) => {
        item.checked = checked
      })
    })
    // $("#filter-time").change((e) => {
    //   time = e.currentTarget.value * 60 * 60 * 24 * 1000
    //   from = today - time
    //   end = today + time
      
    //   $("#filter-from").val(parseTime(from))
    //   $("#filter-to").val(parseTime(end))
    // })
  })
  function parseTime(time) {
    time = new Date(time)
    day = time.getDate()
    month = (time.getMonth() + 1)
    return (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month + '/' + time.getFullYear()
  }
  function filter() {
    list = []
    $(".event-checkbox:checked").each((index, item) => {
      if (item.checked) {
        list.push(item.getAttribute('id').replace('item-check-', ''))
      }
    })
    $.post(
      '',
      {action: 'filter', keyword: $("#filter-keyword").val(), list: list, time: $("#filter-time").val(), from: $("#filter-from").val(), to: $("#filter-to").val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          $('#content').html(data['html'])
        }, () => {}) 
      }
    )
  }
</script>
<!-- END: main -->