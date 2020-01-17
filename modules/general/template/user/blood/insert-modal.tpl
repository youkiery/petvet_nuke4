<!-- BEGIN: main -->
<div class="modal" id="insert-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="close" type="button" data-dismiss="modal"> &times; </div> <br>

                <div class="maxi-form">
                    <label class="form-group">
                        Thời gian
                        <input type="text" class="form-control date" id="insert-time" value="{today}">
                    </label>
                    <label class="form-group">
                        Số lượng mẫu
                        <input type="text" class="form-control" id="insert-number" value="1">
                    </label>
                    <label class="form-group">
                        Số đầu
                        <input type="text" class="form-control" id="insert-start" value="{last}" readonly>
                    </label>
                    <label class="form-group">
                        Số cuối
                        <input type="text" class="form-control" id="insert-end" value="{nextlast}" readonly>
                    </label>

                    <label class="form-group">
                        Mục đích sử dụng
                        <div class="relative">
                            <input type="text" class="form-control" id="insert-name">
                            <div class="suggest" id="insert-name-suggest"> </div>
                        </div>
                    </label>

                    <label class="form-group">
                        Người thực hiện
                        <select class="form-control" id="insert-doctor">
                            <option value="0"> Chưa chọn </option>
                            <!-- BEGIN: doctor -->
                            <option value="{id}" {selected}> {name} </option>
                            <!-- END: doctor -->
                        </select>
                    </label>
                    <div class="text-center">
                        <button class="btn btn-success" id="blood-insert-button" onclick="insertBlood()">
                            Thêm mẫu xét nghiệm
                        </button>
                        <button class="btn btn-info" id="blood-edit-button" onclick="editBlood()">
                            Chỉnh sửa thông tin
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->