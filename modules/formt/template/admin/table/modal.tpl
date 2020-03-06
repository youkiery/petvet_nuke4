<!-- BEGIN: main -->
<div class="modal" id="insert-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br> <br>

                <div class="form-group row">
                    <div class="col-sm-6">
                        <label> Tên mẫu </label>
                    </div>
                    <div class="col-sm-18">
                        <input type="text" class="form-control" id="insert-name">
                    </div>
                </div>

                <div class="form-group text-center">
                    <button class="btn btn-success insert-btn" id="insert-btn" onclick="insertSubmit()">
                        Thêm mẫu
                    </button>
                    <button class="btn btn-success insert-btn" id="edit-btn" onclick="editSubmit()">
                        Sửa mẫu
                    </button>
                    <div class="error" id="insert-error"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
