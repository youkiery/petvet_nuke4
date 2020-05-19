<!-- BEGIN: main -->
<div class="modal" id="detail-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Cập nhật thiết bị
          <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        </div>

        <div class="form-group rows">
          <label class="col-4"> Tình trạng </label>
          <div class="col-8">
            <input type="text" class="form-control" id="detail-status">
          </div>
        </div>

        <div class="form-group rows">
          <label class="col-4"> Ghi chú </label>
          <div class="col-8">
            <textarea class="form-control" id="detail-note" rows="5"></textarea>
          </div>
        </div>

        <div class="form-group text-center">
          <button type="submit" class="btn btn-info" onclick="detailSubmit()"> Cập nhật </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="depart-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          <label class="col-4"> Tên đơn vị </label>
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

        <div class="form-horizontal">
          <div class="form-group">
            <b>
              Tên thiết bị:
            </b>
            <span id="device-name"> </span>
          </div>

          <div class="form-group rows">
            <div class="col-6">
              <b>
                Quy cách:
              </b>
              <span id="device-intro"></span>
            </div>
            <div class="col-6">
              <b>
                Đơn vị:
              </b>
              <span id="device-unit"></span>
            </div>
          </div>

          <div class="form-group rows">
            <div class="col-6">
              <b>
                Số lượng:
              </b>
              <span id="device-number"></span>
            </div>
            <div class="col-6">
              <b>
                Năm sử dụng:
              </b>
              <span id="device-year"></span>
            </div>
          </div>

          <div class="form-group">
            <b>
              Nguồn cung cấp:
            </b>
            <span id="device-source"></span>
          </div>

          <div class="form-group">
            <b>
              Tình trạng sử dụng:
            </b>
            <span id="device-status"></span>
          </div>

          <div class="form-group">
            <b>
              Đơn vị sử dụng:
            </b>
            <span id="device-depart"></span>
          </div>

          <div class="form-group">
            <b>
              Ngày nhập:
            </b>
            <span id="device-import-time"></span>
          </div>

          <div class="form-group">
            <b>
              Ghi chú:
            </b>
            <span id="device-description"></span>
          </div>
          <div class="form-group text-center">
            <button type="submit" class="btn btn-info" id="device-edit" onclick="deviceEditSubmit()"> cập nhật
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->