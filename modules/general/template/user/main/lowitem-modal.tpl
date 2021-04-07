<!-- BEGIN: main -->
<div class="modal" id="lowitem-modal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>

                <div class="form-group input-group">
                    <input type="text" class="form-control" id="lowitem-filter" value="10"
                        placeholder="Giới hạn mặc định">
                    <div class="input-group-btn">
                        <button class="btn btn-info" onclick="filterLowitem()">
                            Lọc
                        </button>
                    </div>
                </div>
                <div class="form-group">
                    <label style="margin-right: 10px;"> <input type="checkbox" class="lowitem-check-all" checked> Tất cả </label>
                    <!-- BEGIN: category -->
                    <label style="margin-right: 10px;"> <input type="checkbox" class="lowitem-checkbox" index="{id}" checked> {name} </label>
                    <!-- END: category -->
                </div>

                <div id="lowitem-content">
                    {content}
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->