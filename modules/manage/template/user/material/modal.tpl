<!-- BEGIN: main -->
<div class="modal" id="type-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          Loại hóa chất
          <input type="text" class="form-control" id="type-name">
        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="insertTypeSubmit()">
            Thêm loại hóa chất
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="source-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          Nguồn gốc
          <input type="text" class="form-control" id="source-name">
        </div>
        <div class="form-group">
          Ghi chú
          <textarea class="form-control" id="source-note" rows="3"></textarea>
        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="insertSourceSubmit()">
            Thêm nguồn gốc
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

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
        <select class="form-control form-group" id="expire-limit">
          <!-- BEGIN: expire -->
          <option value="{value}" {check}> {name} </option>
          <!-- END: expire -->
        </select>
        <div class="form-group text-center">
          <button class="btn btn-info" onclick="expireFilter()">
            Lọc danh sách
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
            <label class="control-label col-sm-6"> Đơn vị </label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="material-unit">
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

        <div class="form-group">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th class="cell-center"> Hóa chất </th>
                <th class="cell-center"> Ngày nhập </th>
                <th class="cell-center" style="width: 20%;"> Nguồn </th>
                <th class="cell-center"> SL </th>
                <th class="cell-center"> HSD </th>
                <th class="cell-center"> Ghi chú </th>
              </tr>
            </thead>
            <tbody id="import-insert-modal-content"></tbody>
          </table>
        </div>
        <div class="form-group">
          <button class="btn btn-success" onclick="insertLine['import']()">
            <span class="glyphicon glyphicon-plus"></span>
          </button>
        </div>
        <div class="text-center">
          <button class="btn btn-info" id="import-button" onclick="importSubmit()"> Thêm phiếu nhập </button>
          <!-- <button class="btn btn-info" id="edit-import-button" onclick="editImportSubmit()"> Sửa phiếu nhập </button> -->
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
          <input type="text" class="form-control" id="export-item-finder">
          <div id="export-item-finder-suggest" class="suggest"></div>
        </div>
        <div style="margin-top: 10px;">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th class="cell-center"> Hóa chất </th>
                <th class="cell-center"> Ngày xuất </th>
                <th class="cell-center" style="width: 20%;"> Nguồn </th>
                <th class="cell-center"> SL </th>
                <th class="cell-center"> HSD </th>
                <th class="cell-center"> Ghi chú </th>
              </tr>
            </thead>
            <tbody id="export-insert-modal-content"></tbody>
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

<div class="modal" id="export-detail-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div id="export-detail-content"> </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="filter-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="text-center form-group">
          <input type="text" class="form-control form-group" id="filter-keyword"
            placeholder="Nhập tên vật tư tìm kiếm...">
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
<!-- END: main -->