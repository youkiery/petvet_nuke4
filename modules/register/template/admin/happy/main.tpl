<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/core/css/style.css">

<div id="msgshow"></div>

{modal}

<form>
  <input type="hidden" name="nv" value="register">
  <input type="hidden" name="op" value="happy">
  <div class="form-group row-x">
    <div class="col-4">
      <input type="text" class="form-control" id="filter-keyword" value="{keyword}" placeholder="Nhập tên người, SĐT">
    </div>
    <div class="col-4">
      <select class="form-control" name="status">
        <option value="0" {active_0}> Tất cả </option>
        <option value="1" {active_1}> Chưa xác nhận </option>
        <option value="2" {active_2}> Đã xác nhận </option>
      </select>
    </div>
    <div class="col-4">
      <button class="btn btn-info">
        Lọc danh sách
      </button>
    </div>
  </div>
</form>

<div id="content">
  {content}
</div>

<script src="/modules/core/js/vhttp.js"></script>
<script>

  function done(id) {
    vhttp.checkelse('', { action: 'done', id: id }).then(data => {
      $("#content").html(data['html'])
    })
  }

  function preview(id) {
    vhttp.checkelse('', { action: 'preview', id: id }).then(data => {
      $("#preview-content").html(data['html'])
      $("#preview-modal").modal('show')
    })
  }
</script>
<!-- END: main -->