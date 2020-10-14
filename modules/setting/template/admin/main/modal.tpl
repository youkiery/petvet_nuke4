<!-- BEGIN: main -->
<div class="modal" id="branch-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Thêm chi nhánh
          <div type="button" class="close" data-dismiss="modal"> &times; </div>
        </div>

        <div class="form-group">
          <input type="text" class="form-control" id="branch-name" placeholder="Nhập tên chi nhánh">
        </div>

        <button class="btn btn-success btn-block" onclick="insertBranchSubmit()">
          Thêm chi nhánh
        </button>

      </div>
    </div>
  </div>
</div>

<div class="modal" id="user-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Thên nhân viên
          <div type="button" class="close" data-dismiss="modal"> &times; </div>
        </div>

        <div class="input-group">
          <input type="text" class="form-control" id="user-name" placeholder="Nhập họ và tên hoặc tên tài khoản">
          <div class="input-group-btn">
            <button class="btn btn-success" onclick="insertBranchSubmit()">
              Thêm nhân viên
            </button>
          </div>
        </div>

        <div id="user-modal-list"> </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->