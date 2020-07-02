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
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="rows">
          <div class="col-4">
            <input type="text" class="form-control date" id="report-date" value="{last_month}"> 
          </div>
          <div class="col-4">
            <div class="relative">
              <input type="text" class="form-control" id="report-type" placeholder="loại hóa chất"> 
              <input type="hidden" id="report-type-val"> 
              <div class="suggest" id="report-type-suggest"> </div>
            </div>
          </div>
          <div class="col-4">
            <div class="relative">
              <input type="text" class="form-control" id="report-source" placeholder="nguồn gốc"> 
              <input type="hidden" id="report-source-val"> 
              <div class="suggest" id="report-source-suggest"> </div>
            </div>
          </div>
        </div>
        <div class="form-group text-center">
          <div class="form-group">
            <label> <input type="radio" name="tick" value="0" checked> Xuất nhập </label>
            <label> <input type="radio" name="tick" value="1"> Hóa chất gần hết </label>
            <label> <input type="radio" name="tick" value="2"> Hóa chất sắp hết hạn </label>
          </div>
          <button class="btn btn-info" onclick="reportSubmit()">
            Thống kê
          </button>
        </div>
        <div id="report-content"></div>
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
                <th></th>
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
                <th></th>
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
<!-- END: main -->
