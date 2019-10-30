<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/exp/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">

<div id="msgshow"></div>

<div class="row">
  <div class="col-sm-12">
    <input type="text" class="form-control" id="filter-key">
  </div>
  <div class="col-sm-12">
    <select class="form-control" id="filter-time">
      <option value="7"> Một tuần </option>
      <option value="30"> Một tháng </option>
      <option value="90"> Một quý </option>
      <option value="180"> Nửa năm </option>
      <option value="365"> Một năm </option>
      <option value="720"> Hai năm </option>
    </select>
  </div>
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
  function filter() {
    $.post(
      '',
      {action: 'filter', keyword: $("#filter-keyword").val(), time: $("#filter-time").val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          $('#content').html(data['html'])
        }, () => {}) 
      }
    )
  }
</script>
<!-- END: main -->