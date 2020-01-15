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
              <input type="text" class="form-control" id="material-number" value="0">
            </div>
            <label class="control-label col-sm-6"> Đơn vị </label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="material-unit">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-6"> Loại </label>
            <div class="col-sm-18">
              <label> <input name="type" type="radio" id="material-type-0" checked> Vật tư </label>
              <label> <input name="type" type="radio" id="material-type-1"> Hóa chất </label>
            </div>
          </div>

          <div class="form-group">
            <label class="control-label col-sm-6"> Giới hạn nhận hàng </label>
            <div class="col-sm-18">
              <input type="text" class="form-control" id="material-bound" value="0"
                placeholder="Số lượng dưới giới hạn, cần phải nhập hàng">
            </div>
          </div>

          <div class="form-group">
            <label class="control-label col-sm-6"> Mô tả </label>
            <div class="col-sm-18">
              <textarea class="form-control" id="material-description" rows="5"></textarea>
            </div>
          </div>
          <div class="text-center">
            <button class="btn btn-success" id="insert-material" onclick="insertMaterialSubmit()">
              Thêm mục hàng
            </button>
            <button class="btn btn-info" id="edit-material" onclick="editMaterialSubmit()">
              Sửa mục hàng
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
          {content}
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

<div class="modal" id="link-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          <label> Vật tư </label>
          <div class="relative">
            <input type="text" class="form-control" id="link-item">
            <div class="suggest" id="link-item-suggest">  </div>
          </div>
        </div>

        <div class="form-group">
          <label> Vật tư liên kết </label>
          <div class="relative">
            <input type="text" class="form-control" id="link2-item">
            <div class="suggest" id="link2-item-suggest">  </div>
          </div>
        </div>

        <div id="link-content">
          {link_content}
        </div>

        <div class="text-center">
          <button class="btn btn-info" onclick="linkSubmit()">
            Liên kết
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->