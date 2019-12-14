<!-- BEGIN: main -->
<div class="modal" id="item-modal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>
                <div class="form-group">
                    <button class="btn btn-info submit" style="position: sticky; top: 10px; left: 10px;"
                        onclick="submitAll()">
                        Xác nhận mục chọn
                    </button>
                    <button class="btn btn-danger submit" style="position: sticky; top: 10px; left: 10px;"
                        onclick="removeAllItem()">
                        Xóa mục chọn
                    </button>
                </div>

                Lưu vào chi nhánh
                <select class="form-control form-group" id="item-brand">
                    <option value="0"> Bệnh viện </option>
                    <option value="1"> Kho </option>
                </select>

                <div class="form-group input-group">
                    <input type="text" class="form-control" id="item-filter" value="10"
                        placeholder="Hàng hóa mỗi trang">
                    <div class="input-group-btn">
                        <button class="btn btn-info" onclick="goPageItem(1)">
                            Lọc
                        </button>
                    </div>
                </div>

                <div></div>
                <div id="item-content">

                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->