<!-- BEGIN: main -->
<div class="modal" id="statistic-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>

        <div class="row">
          <label>
            <div class="col-sm-8">
              Ngày bắt đầu
            </div>
            <div class="col-sm-16">
              <input type="text" class="form-control date" id="from" value="{from}">
            </div>
          </label>
          <label>
            <div class="col-sm-8">
              Ngày kết thúc
            </div>
            <div class="col-sm-16">
              <input type="text" class="form-control date" id="end" value="{end}">
            </div>
          </label>
        </div>
        <div class="text-center form-group">
          <button class="btn btn-info" onclick="statisticFilter()">
            Xem thống kế
          </button>
        </div>

        <div id="statistic-content">
          {statistic_content}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="import-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>

        <div class="maxi-form">
          <label class="form-group">
            Thời gian
            <input type="text" class="form-control" id="import-time" value="{today}">
          </label>
          <label class="form-group">
            Giá
            <input type="text" class="form-control" id="import-price" value="0">
          </label>
          <label class="form-group">
            Số lượng
            <input type="text" class="form-control" id="import-number" value="0">
          </label>
          <label class="form-group">
            Ghi chú
            <textarea class="form-control" id="import-note" rows="3"></textarea>
          </label>
          <div class="text-center">
            <button class="btn btn-success" id="import-insert-button" onclick="insertImport()">
              Nhập hóa chất
            </button>
            <button class="btn btn-info" id="import-edit-button" onclick="editImport()">
              Chỉnh sửa thông tin
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="insert-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>

        <div class="maxi-form">
          <label class="form-group">
            Thời gian
            <input type="text" class="form-control date" id="insert-time" value="{today}">
          </label>
          <label class="form-group">
            Số lượng mẫu
            <input type="text" class="form-control" id="insert-number" value="1">
          </label>
          <label class="form-group">
            Số đầu
            <input type="text" class="form-control" id="insert-start" value="{last}" readonly>
          </label>
          <label class="form-group">
            Số cuối
            <input type="text" class="form-control" id="insert-end" value="{nextlast}" readonly>
          </label>

          <label class="form-group">
            Mục đích sử dụng
            <div class="relative">
              <input type="text" class="form-control" id="insert-name">
              <div class="suggest" id="insert-name-suggest"> </div>
            </div>
          </label>

          <label class="form-group">
            Người thực hiện
            <select class="form-control" id="insert-doctor">
              <option value="0"> Chưa chọn </option>
              <!-- BEGIN: doctor -->
              <option value="{id}" {selected}> {name} </option>
              <!-- END: doctor -->
            </select>
          </label>
          <div class="text-center">
            <button class="btn btn-success" id="blood-insert-button" onclick="insertBlood()">
              Thêm mẫu xét nghiệm
            </button>
            <button class="btn btn-info" id="blood-edit-button" onclick="editBlood()">
              Chỉnh sửa thông tin
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="remove-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>

        <div class="text-center">
          <p> Sau khi xác nhận, phiếu sẽ bị xóa vĩnh viễn </p>
          <button class="btn btn-danger" onclick="removeSubmit()">
            Xóa
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->