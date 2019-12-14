<!-- BEGIN: main -->
<div class="modal" id="filter-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <div class="form-group">
                    Từ khóa
                    <input type="text" class="form-control" id="filter-keyword" placeholder="Từ khóa tìm kiếm">
                </div>

                <div class="form-group">
                    Giới hạn mặc định
                    <input type="text" class="form-control" id="filter-limit" value="10"
                        placeholder="Giới hạn mặc định">
                </div>
                <div class="form-group">
                    <label style="margin-right: 10px;"> <input type="checkbox" id="filter-check-all" checked> Tất cả
                    </label>
                    <!-- BEGIN: category -->
                    <label style="margin-right: 10px;"> <input type="checkbox" class="filter-checkbox" index="{id}"
                            checked> {name}
                    </label>
                    <!-- END: category -->
                </div>

                <div class="text-center">
                    <button class="btn btn-info" onclick="goPage(1)">
                        Lọc
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->