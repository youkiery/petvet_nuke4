<!-- BEGIN: main -->
<div class="modal" id="lowitem-modal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <div class="form-group">
                    Từ khóa
                    <input type="text" class="form-control" id="lowitem-keyword" placeholder="Từ khóa tìm kiếm">
                </div>
                <div class="form-group">
                    Giới hạn mặc định
                    <input type="text" class="form-control" id="lowitem-limit" placeholder="Giới hạn mặc định" value="10">
                </div>
                <div class="form-group">
                    <label style="margin-right: 10px;"> <input type="checkbox" id="lowitem-check-all" checked> Tất cả
                    </label>
                    <!-- BEGIN: category -->
                    <label style="margin-right: 10px;"> <input type="checkbox" class="lowitem-checkbox" index="{id}"
                            checked> {name} </label>
                    <!-- END: category -->
                </div>

                <div class="text-center">
                    <button class="btn btn-info" onclick="filterLowitem()">
                        Lọc
                    </button>
                </div>

                <div id="lowitem-content">

                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->