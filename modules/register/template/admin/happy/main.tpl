<!-- BEGIN: main -->
<link rel="stylesheet" href="/modules/core/css/style.css">

<div id="msgshow"></div>

<div class="form-group row-x">
  <div class="col-4">
    <label> Từ khóa </label>
    <input type="text" class="form-control" id="filter-keyword" value="{keyword}" placeholder="Nhập tên người, SĐT">
  </div>
  <div class="col-4">
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

<script src="/modules/core/js/vhttp.js"></script>
<script>


</script>
<!-- END: main -->