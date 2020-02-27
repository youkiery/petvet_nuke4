<!-- BEGIN: main -->
<div class="modal" id="list-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br> <br>

                <div class="form-group">
                    <label> Số dòng </label>
                    <input type="checkbox" class="list" name="number" id="checkbox-number">
                    <input type="text" class="form-control list-input" id="list-number">
                </div>

                <div class="form-group">
                    <label> Tiền tố </label>
                    <input type="checkbox" class="list" name="prefix" id="checkbox-prefix">
                    <input type="text" class="form-control list-input" id="list-prefix">
                </div>

                <div class="form-group">
                    <label> Hậu tố </label>
                    <input type="checkbox" class="list" name="subfix" id="checkbox-subfix">
                    <input type="text" class="form-control list-input" id="list-subfix">
                </div>
                <div class="form-group text-center">
                    <button class="btn btn-info" onclick="saveListConfig()">
                        Lưu cấu hình
                    </button>
                </div>
                <!-- <div id="list-content">

                </div> -->
            </div>
        </div>
    </div>
</div>

<div class="modal" id="table-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br> <br>
                <div id="table-content">

                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
