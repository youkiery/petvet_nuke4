<!-- BEGIN: main -->
<div class="modal" id="item-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div class="form-horizontal">
          <div class="form-group">
            <label class="control-label col-sm-4"> Tên thiết bị </label>
            <div class="col-sm-20">
              <input type="text" class="form-control" id="item-name">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-4"> Số lượng </label>
            <div class="col-sm-3">
              <input type="text" class="form-control" id="item-number">
            </div>
            <label class="control-label col-sm-4"> Đơn vị </label>
            <div class="col-sm-3">
              <input type="text" class="form-control" id="item-unit">
            </div>
            <label class="control-label col-sm-4"> Chất lượng </label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="item-status">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-4"> Tên công ty </label>
            <div class="col-sm-20">
              <input type="text" class="form-control" id="item-company">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-4"> Mô tả </label>
            <div class="col-sm-20">
              <textarea class="form-control" id="item-description" rows="5"></textarea>
            </div>
          </div>
          <div class="form-group text-center" onclick="itemInsertsubmit()">
            <button type="submit" class="btn btn-info"> Xác nhận </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->