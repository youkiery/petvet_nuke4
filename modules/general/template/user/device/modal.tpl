<!-- BEGIN: main -->
<div class="modal" id="depart-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          <label class="control-label col-4"> Tên đơn vị </label>
          <div class="col-20">
            <input type="text" class="form-control" id="depart-name">
          </div>
        </div>

        <div class="form-group text-center" onclick="departsubmit()">
          <button type="submit" class="btn btn-info"> Thêm đơn vị </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="remove-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        
        <div class="form-group text-center">
          <p> <b> Chọn xác nhận để xóa dữ liệu </b> </p>
          <button type="submit" class="btn btn-danger" onclick="deviceRemoveSubmit()"> Xác nhận </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="remove-all-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        
        <div class="form-group text-center">
          <p> <b> Chọn xác nhận để xóa các mục đã chọn </b> </p>
          <button type="submit" class="btn btn-danger" onclick="deviceRemoveAllSubmit()"> Xác nhận </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="import-modal" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div style="float: right;">
          <button class="btn btn-success" onclick="importInsert()">
            Nhập hàng
          </button>
        </div>

        <div id="import-modal-content">
          {content}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="import-insert-modal" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="relative">
          <div class="input-group">
            <input type="text" class="form-control" id="import-item-finder">
            <div class="input-group-btn">
              <button class="btn btn-info" onclick="itemFilter()">
                Tìm kiếm  
              </button>
            </div>
          </div>
          <div id="import-item-finder-suggest" class="suggest"></div>
        </div>
        <div id="import-insert-modal-content" style="margin-top: 10px;">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th class="cell-center"> STT </th>
                <th class="cell-center"> Tên thiết bị </th>
                <th class="cell-center"> Ngày hết hạn </th>
                <th class="cell-center"> Số lượng </th>
                <th class="cell-center"> Chất lượng </th>
              </tr>
            </thead>
          </table>
        </div>
        <div class="text-center">
          <button class="btn btn-info" id="import-button" onclick="importSubmit()"> Thêm phiếu nhập </button>
          <button class="btn btn-info" id="edit-import-button" onclick="editImportSubmit()"> Sửa phiếu nhập </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="device-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Thêm thiết bị
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="form-group">
          <button class="btn btn-info" onclick="loadDefault()">
            Điều mẫu nhanh
          </button>
        </div>

        <div class="form-horizontal">
          <div class="form-group">
            <label class="control-label col-3"> Tên thiết bị </label>
            <div class="col-9 relative">
              <input type="text" class="form-control" id="device-name">
              <div class="suggest" id="device-name-suggest"> </div>
            </div>
          </div>

          <div class="form-group">
            <label class="control-label col-3"> Quy cách </label>
            <div class="col-3 relative">
              <input type="text" class="form-control" id="device-intro">
              <div class="suggest" id="device-intro-suggest"></div>
            </div>
            <label class="control-label col-3"> Đơn vị </label>
            <div class="col-3">
              <input type="text" class="form-control" id="device-unit">
            </div>
          </div>

          <div class="form-group">
            <label class="control-label col-3"> Số lượng </label>
            <div class="col-3">
              <input type="text" class="form-control" id="device-number">
            </div>
            <label class="control-label col-3"> Năm sử dụng </label>
            <div class="col-3">
              <input type="text" class="form-control" id="device-year">
            </div>
          </div>

          <div class="form-group">
            <label class="control-label col-3"> Nguồn cung cấp </label>
            <div class="col-9 relative">
              <input type="text" class="form-control" id="device-source">
              <div class="suggest" id="device-source-suggest"></div>
            </div>
          </div>

          <div class="form-group">
            <label class="control-label col-3"> Tình trạng sử dụng </label>
            <div class="col-9">
              <input type="text" class="form-control" id="device-status">
            </div>
          </div>

          <div class="form-group">
            <label class="control-label col-3"> Đơn vị sử dụng </label>
            <div class="col-9 relative">
              <div class="input-group">
                <input type="text" class="form-control" id="device-depart-input">
                <div class="input-group-btn">
                  <button class="btn btn-info" onclick="insertDepart()">
                    <span class="glyphicon glyphicon-plus"></span>
                  </button>
                </div>
              </div>
              <div class="suggest" id="device-depart-suggest"> </div>
            </div>
            <div> Đã chọn: <span id="device-depart"> </span> </div>
          </div>

          <div class="form-group">
            <label class="control-label col-3"> Ngày nhập </label>
            <div class="col-9">
              <input type="text" class="form-control" id="device-import-time" placeholder="Ngày/tháng/năm nhập">
            </div>
          </div>

          <div class="form-group">
            <label class="control-label col-3"> Ghi chú </label>
            <div class="col-9">
              <textarea class="form-control" id="device-description" rows="5"></textarea>
            </div>
          </div>
          <div class="form-group text-center">
            <button type="submit" class="btn btn-success" id="device-insert" onclick="deviceInsertSubmit()"> Thêm thiết bị </button>
            <button type="submit" class="btn btn-info" id="device-edit" onclick="deviceEditSubmit()"> cập nhật </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->