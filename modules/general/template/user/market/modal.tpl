<!-- BEGIN: main -->
<div id="insert-modal" class="modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <div class="form-group row">
                    <div class="col-row-4"> <label> Tên hàng </label> </div>
                    <div class="col-row-8"> 
                        <input type="text" class="form-control" id="insert-name">
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-row-4"> <label> Giá </label> </div>
                    <div class="col-row-8"> 
                        <input type="text" class="form-control" id="insert-price">
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-row-4"> <label> Địa chỉ </label> </div>
                    <div class="col-row-8"> 
                        <textarea class="form-control" id="insert-address" rows="4"></textarea>
                    </div>
                </div>

                <div class="text-center">
                    <button class="btn btn-success" id="insert-btn" onclick="insertSubmit()">
                        Thêm phiếu
                    </button>
                    <button class="btn btn-info" id="edit-btn" onclick="editSubmit()">
                        Lưu thông tin
                    </button>
                    <div class="error" id="insert-error"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="remove-modal" class="modal" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <div class="text-center">
                    <p> Sau khi xác nhận, phiếu sẽ mất vĩnh viễn </p>
                    <button class="btn btn-danger" onclick="removeSubmit()">
                        Xóa phiếu
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- END: main -->
