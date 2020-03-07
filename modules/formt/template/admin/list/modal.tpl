<!-- BEGIN: main -->
<div class="modal" id="list-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br> <br>

                <div id="list-content">

                </div>

                <div class="form-group">
                    <label>
                        <input type="checkbox" class="list" name="number" id="checkbox-number">
                        Số dòng
                    </label>
                    <input type="text" class="form-control list-input" id="list-number">
                </div>

                <div class="form-group">
                    <label>
                        <input type="checkbox" class="list" name="prefix" id="checkbox-prefix">
                        Tiền tố
                    </label>
                    <input type="text" class="form-control list-input" id="list-prefix">
                </div>

                <div class="form-group">
                    <label>
                        <input type="checkbox" class="list" name="subfix" id="checkbox-subfix">
                        Hậu tố
                    </label>
                    <input type="text" class="form-control list-input" id="list-subfix">
                </div>
                <div class="form-group text-center">
                    <button class="btn btn-info" onclick="saveListConfig()">
                        Lưu cấu hình
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="style-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br> <br>

                <div class="form-group">
                    <label> Chiều in </label>
                    <input type="radio" name="scene" value="0" checked> Chiều dọc
                    <input type="radio" name="scene" value="1"> Chiều Ngang
                </div>
                <div class="form-group">
                    <label> Căn lề </label>
                    <div class="row form-group">
                        <label class="col-sm-6">
                            Lề trái
                        </label>
                        <div class="col-sm-18">
                            <input class="form-control" type="text" id="margin-left" value="1">
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-sm-6">
                            Lề phải
                        </label>
                        <div class="col-sm-18">
                            <input class="form-control" type="text" id="margin-right" value="1">
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-sm-6">
                            Lề trên
                        </label>
                        <div class="col-sm-18">
                            <input class="form-control" type="text" id="margin-top" value="1">
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-sm-6">
                            Lề dưới
                        </label>
                        <div class="col-sm-18">
                            <input class="form-control" type="text" id="margin-bottom" value="1">
                        </div>
                    </div>
                </div>

                <div class="form-group text-center">
                    <button class="btn btn-success" onclick="saveStyle()">
                        Lưu khổ giấy
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="variable-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br> <br>

                <div class="form-group" id="variable-content"></div>

                <div class="form-group text-center">
                    <button class="btn btn-success" onclick="insertVariable()">
                        Thêm biến mới
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
