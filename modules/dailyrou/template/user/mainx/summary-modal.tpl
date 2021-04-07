<!-- BEGIN: main -->
<div id="summary-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Bản thống kê ngày nghỉ tháng </h2>
        <br>
        <div class="form-inline">
          <div class="form-group">
            <label>
              Từ ngày
            </label>
            <input type="text" class="form-control" id="summary-date-from" value="{startDate}" autocomplete="off">
          </div>
          <div class="form-group">
            <label>
              Đến ngày
            </label>
            <input type="text" class="form-control" id="summary-date-end" value="{endDate}" autocomplete="off">
          </div>
          <button class="btn btn-info" onclick="summarySubmit()">
            Xem tổng kết
          </button>
        </div>
        <div id="summary-content">
          {summary}
        </div>
        <div class="text-center">
          <button class="btn btn-danger" data-dismiss="modal">
            Trở về
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->
