<!-- BEGIN: main -->
<div id="insert-modal" class="modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <div id="insert-box-content">
                    <div class="text-center">
                        <button class="btn btn-info" onclick="insertSubmit()">
                            Thêm mục đã chọn
                        </button>
                    </div>
                    <div id="insert-content"> </div>
                </div>

                <div class="text-center" id="insert-box" style="margin: auto;">
                    <label class="filebutton">
                        <div
                            style="background: #eee; height: 200px; width: 200px; font-size: 100px; border-radius: 10%; line-height: 200px; color: green;">
                            +
                        </div>
        
                        <span>
                            <input type="file" id="insert-file" style="display: none;"
                                accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                        </span>
                    </label>
                    <br>
                    File excel bệnh viện
                    <br>
                    <button class="btn btn-info" onclick="process('insert')">
                        Xử lý
                    </button>
                    <div id="insert-notify" class="error"></div>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- END: main -->