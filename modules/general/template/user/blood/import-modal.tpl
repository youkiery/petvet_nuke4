<!-- BEGIN: main -->
<div class="modal" id="import-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="close" type="button" data-dismiss="modal"> &times; </div> <br>

                <div class="maxi-form">
                    <label class="form-group">
                        Thời gian
                        <input type="text" class="form-control" id="import-time" value="{today}">
                    </label>
                    <label class="form-group">
                        Giá
                        <input type="text" class="form-control" id="import-price" value="0">
                    </label>
                    <label class="form-group">
                        Số lượng
                        <input type="text" class="form-control" id="import-number" value="0">
                    </label>
                    <label class="form-group">
                        Ghi chú
                        <textarea class="form-control" id="import-note" rows="3"></textarea>
                    </label>
                    <div class="text-center">
                        <button class="btn btn-success" id="import-insert-button" onclick="insertImport()">
                            Nhập hóa chất
                        </button>
                        <button class="btn btn-info" id="import-edit-button" onclick="editImport()">
                            Chỉnh sửa thông tin
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->