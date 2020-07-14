<!-- BEGIN: main -->
<div id="list-modal" class="modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <div class="form-group" id="list-content">

                </div>
                <div class="text-center">
                    <button class="btn btn-info" onclick="convertTable()">
                        Xuất file
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="insert" class="modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <div class="relative form-group">
                    <div id="insert-suggest" class="suggest">

                    </div>
                </div>
                <div class="form-group" id="insert-content"></div>
                <div class="text-center">
                    <button>
                        Gửi danh sách
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- <div class="modal" id="excel-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <div class="text-center">
                    <p class="excel-text" id="text-insert"> Chọn file excel Kiot để thêm hàng hóa </p>
                    <p class="excel-text" id="text-update"> Chọn file excel Kiot để cập nhật số lượng </p>
                </div>

                <div style="text-align: center; position: relative;">
                    <div style="margin: auto;">
                        <div style="position: absolute;"></div>
                        <label class="filebutton">
                            <div
                                style="background: #eee; height: 200px; width: 200px; font-size: 100px; border-radius: 10%; line-height: 200px; color: green;">
                                +
                            </div>

                            <span>
                                <input type="file" id="file" style="display: none;"
                                    accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                            </span>
                        </label>
                    </div>
                </div>

                <div class="text-center" id="excel-error" style="color: red; font-weight: bold;"> </div>
            </div>
        </div>
    </div>
</div> -->

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