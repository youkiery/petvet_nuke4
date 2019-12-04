<!-- BEGIN: main -->
<div class="modal" id="excel-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <p class="excel-text" id="text-insert"> Chọn file excel Kiot để thêm hàng hóa </p>
                <p class="excel-text" id="text-update"> Chọn file excel Kiot để cập nhật số lượng </p>

                <div style="text-align: center; position: relative;">
                    <div style="margin: auto;">
                        <div style="position: absolute;"></div>
                        <label class="filebutton">
                            <div style="background: #eee; height: 200px; width: 200px; font-size: 100px; border-radius: 10%; line-height: 200px; color: green;">
                                +
                            </div>

                            <span>
                                <input type="file" id="file" style="display: none;" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                            </span>
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
