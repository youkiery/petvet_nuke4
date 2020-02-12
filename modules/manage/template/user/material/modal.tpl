<!-- BEGIN: main -->
<div class="modal" id="report-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div id="report-content"></div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="modal-expire" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br><br>
        <select id="expire-limit">
          <!-- BEGIN: expire -->
          <option value="{value}"> {name} </option>
          <!-- END: expire -->
        </select>
        <div id="text-center">
          <button class="btn btn-info" onclick="expireFilter()">
            <span class="glyphicon glyphicon-search"></span>
          </button>
        </div>

        <div id="expire-content">
          {expire_content}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="material-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div class="form-horizontal">

          <div class="form-group">
            <label class="control-label col-sm-6"> Tên mục hàng </label>
            <div class="col-sm-18">
              <input type="text" class="form-control" id="material-name">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-6"> Số lượng </label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="material-number">
            </div>
            <label class="control-label col-sm-6"> Đơn vị </label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="material-unit">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-6"> Loại </label>
            <div class="col-sm-18">
              <label> <input name="type" type="radio" checked> Vật tư </label>
              <label> <input name="type" type="radio"> Hóa chất </label>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-6"> Mô tả </label>
            <div class="col-sm-18">
              <textarea class="form-control" id="material-description" rows="5"></textarea>
            </div>
          </div>
          <div class="text-center">
            <button class="btn btn-success" onclick="insertMaterial()">
              Thêm mục hàng
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="overlow-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div id="overlow-content">
          {overlow_content}
        </div>

        <div class="text-center">
          <button class="btn btn-info" onclick="overlowFilter()">
            Tải lại
          </button>
        </div>
      </div>
    </div>
  </div>
</div>


<div class="modal" id="import-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div class="form-group">
          <button class="btn btn-success" onclick="insertImportModal()">
            <span class="glyphicon glyphicon-plus"></span>
          </button>
        </div>
        <div id="material-content">
          {import_content}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="import-modal-remove" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="text-center">
          <p> Sau khi xóa, phiếu nhập sẽ biến mất hoàn toàn </p>
          <button class="btn btn-danger" id="import-button" onclick="importRemoveSubmit()"> Xóa phiếu nhập </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="import-modal-insert" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="relative">
          <div class="input-group">
            <input type="text" class="form-control" id="import-item-finder">
            <div class="input-group-btn">
              <button class="btn btn-success" onclick="materialModal()">
                <span class="glyphicon glyphicon-plus"></span>
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
                <th class="cell-center"> Ghi chú </th>
              </tr>
            </thead>
          </table>
        </div>
        <div class="text-center">
          <button class="btn btn-info" id="import-button" onclick="importSubmit()"> Thêm phiếu nhập </button>
          <!-- <button class="btn btn-info" id="edit-import-button" onclick="editImportSubmit()"> Sửa phiếu nhập </button> -->
        </div>
      </div>
    </div>
  </div>
</div>

<!-- <div class="modal" id="import-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div id="material-insert-content">
        </div>
      </div>
    </div>
  </div>
</div> -->

<div class="modal" id="filter-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="text-center form-group">
          <input type="text" class="form-control form-group" id="filter-keyword" placeholder="Nhập tên vật tư tìm kiếm...">
          <div class="row-x form-group">
            <div class="col-6">
              <input type="text" class="form-control date" id="filter-start" value="{start}">
            </div>
            <div class="col-6">
              <input type="text" class="form-control date" id="filter-end" value="{end}">
            </div>
          </div>
          <button class="btn btn-info" onclick="goReportPage(1)"> Lọc báo cáo </button>
        </div>

        <div id="filter-content">

        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="export-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div class="form-group">
          <button class="btn btn-success" onclick="insertExportModal()">
            <span class="glyphicon glyphicon-plus"></span>
          </button>
        </div>
        <div id="export-content">
          {export_content}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="export-modal-remove" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="text-center">
          <p> Sau khi xóa, phiếu xuất sẽ biến mất hoàn toàn </p>
          <button class="btn btn-danger" id="export-button" onclick="exportRemoveSubmit()"> Xóa phiếu xuất </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="export-modal-insert" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="relative">
          <div class="input-group">
            <input type="text" class="form-control" id="export-item-finder">
            <div class="input-group-btn">
              <button class="btn btn-success" onclick="materialModal()">
                <span class="glyphicon glyphicon-plus"></span>
              </button>
            </div>
          </div>
          <div id="export-item-finder-suggest" class="suggest"></div>
        </div>
        <div id="export-insert-modal-content" style="margin-top: 10px;">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th class="cell-center"> STT </th>
                <th class="cell-center"> Tên thiết bị </th>
                <th class="cell-center"> Ngày hết hạn </th>
                <th class="cell-center"> Số lượng </th>
                <th class="cell-center"> Ghi chú </th>
              </tr>
            </thead>
          </table>
        </div>
        <div class="text-center">
          <button class="btn btn-info" id="export-button" onclick="exportSubmit()"> Thêm phiếu xuất </button>
          <!-- <button class="btn btn-info" id="edit-export-button" onclick="editexportSubmit()"> Sửa phiếu xuất </button> -->
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->
