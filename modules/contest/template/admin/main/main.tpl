<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/contest/src/style.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script src="/modules/core/js/vhttp.js">

</script>
<div id="msgshow"></div>
<style>
  .form-group { clear: both; }
</style>

<div class="form-group row">
  <div class="col-sm-8">
    <label> Từ khóa </label>
    <input type="text" class="form-control" id="filter-keyword" value="{keyword}" placeholder="Nhập tên người, SĐT">
  </div>
  <div class="col-sm-8">
    <label> Khóa học </label>
    <select class="form-control" id="filter-court">
      <option value="0"> Tất cả </option>
      <!-- BEGIN: court -->
      <option value="{id}" {selected}> {name} </option>
      <!-- END: court -->
    </select>
  </div>
  <div class="col-sm-8">
    <label> Trạng thái </label>
    <select class="form-control" id="filter-active">
      <option value="0" {active_0}> Tất cả </option>
      <option value="1" {active_1}> Chưa xác nhận </option>
      <option value="2" {active_2}> Đã xác nhận </option>
    </select>
  </div>
</div>
<div class="form-group text-center">
  <button class="btn btn-info" onclick="filter()">
    Lọc danh sách
  </button>
</div>

<div id="content">
  {content}
</div>

<script>
  var global = {
    type: {0: 'btn btn-info', 1: 'btn btn-warning'}
  }

  function filter() {
    window.location.replace(window.location.origin + window.location.pathname + '?nv=' + nv_module_name + '&keyword=' + $("#filter-keyword").val() + '&court=' + $("#filter-court").val() + '&active=' + $("#filter-active").val())
  }

  function activeSubmit(id, type) {
    $("[rel=" + id + "]").prop('disabled', true)
    vhttp.check('', { action: 'active', id: id, type: type}).then((data) => {
      $("[rel=" + id + "]").prop('disabled', false)
      $("[rel=" + id + "]").attr('class', global['type'][type])
    }, () => {
      $("[rel=" + id + "]").prop('disabled', false)
    })
  }
</script>
<!-- END: main -->
