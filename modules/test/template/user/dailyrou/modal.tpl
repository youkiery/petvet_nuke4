<!-- BEGIN: main -->
<div id="summary" class="modal fade" role="dialog">
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

<div id="modal-overflow" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body" id="overflow-content">
      </div>
    </div>
  </div>
</div>

<div id="regist_confirm" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Bạn có muốn đăng ký những ngày này không? </h2>
        <div id="regist_list">

        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="registSubmit()">
            Đăng ký
          </button>
          <button class="btn btn-danger" data-dismiss="modal">
            Hủy
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="wconfirm_alert" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Bạn có muốn Thay đổi những mục này không? </h2>
        <div id="wconfirm_alert_content">

        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="wconfirmSubmit()">
            Xác nhận
          </button>
          <button class="btn btn-danger" data-dismiss="modal">
            Hủy
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->