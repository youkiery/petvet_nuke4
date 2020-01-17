<!-- BEGIN: main -->
<div class="modal" id="insert-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>

                <label>
                    Nhóm
                    <select class="form-control" id="insert-name">
                        <!-- BEGIN: name -->
                        <option value="{id}"> {name} </option>
                        <!-- END: name -->
                    </select>
                </label>

                <label>
                    Giá trị
                    <input class="form-control" type="text" id="insert-value">
                </label>

                <div class="text-center">
                    <button class="btn btn-success" onclick="insertRemind()">
                        Thêm gợi ý
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="remove-modal" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>

                <div class="text-center">
                    <p> Sau khi xác nhận, gợi ý sẽ mất vĩnh viễn, bạn có chắc chắn không? </p>
                    <button class="btn btn-danger" onclick="removeRemindSubmit()">
                        Xác nhận xóa
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->