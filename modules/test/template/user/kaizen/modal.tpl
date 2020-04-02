<!-- BEGIN: main -->
<div id="insert_modal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    Nhập thông tin vào phiếu để hoàn tất
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="form-group">
                    <label> Vấn đề </label>
                    <input class="form-control" id="problem" type="text">
                </div>
                <div class="form-group">
                    <label> Giải quyết </label>
                    <textarea class="form-control" id="solution"></textarea>
                </div>
                <div class="form-group">
                    <label> Hiệu quả </label>
                    <textarea class="form-control" id="result"></textarea>
                </div>
                <div class="text-center">
                    <button class="btn btn-success" id="insert" onclick="insertSubmit()">
                        Gửi giải pháp
                    </button>
                    <button class="btn btn-info" id="edit" onclick="editSubmit()">
                        Sửa giải pháp
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="remove_modal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    Xác nhận trước khi xóa
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="text-center">
                    <button class="btn btn-danger" onclick="removeSubmit()">
                        Xóa
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->