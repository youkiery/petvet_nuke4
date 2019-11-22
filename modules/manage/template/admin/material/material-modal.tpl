<!-- BEGIN: main -->
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
<!-- END: main -->
