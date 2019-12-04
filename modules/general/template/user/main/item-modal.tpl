<!-- BEGIN: main -->
<div class="modal" id="item-modal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>
                <div class="input-group">
                    <button class="btn btn-info" style="position: sticky; top: 10px; left: 10px;" onclick="submitAll()">
                        Xác nhận mục chọn
                    </button>
                    <button class="btn btn-danger" style="position: sticky; top: 10px; left: 10px;" onclick="removeAll()">
                        Xóa mục chọn
                    </button>
                </div>
                <div></div>
                <div id="item-content">

                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->