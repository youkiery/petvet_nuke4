<!-- BEGIN: main -->
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
          <button class="btn btn-info" onclick="importSubmit()"> Thêm phiếu nhập </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->
