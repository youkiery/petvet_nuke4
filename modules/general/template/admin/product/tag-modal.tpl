<!-- BEGIN: main -->
<div class="modal" id="insert-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b style="font-size: 1.5em;"> Thêm tag </b>
          <div class="close" type="button" data-dismiss="modal"> &times; </div>
        </div>

        <div class="form-group">
          <div class="input-group">
            <input class="form-control" type="text" id="category-name" placeholder="Nhập tên danh mục">
            <div class="input-group-btn">
              <button class="btn btn-success" onclick="categoryInsertSubmit()">
                Thêm
              </button>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>

<!-- END: main -->