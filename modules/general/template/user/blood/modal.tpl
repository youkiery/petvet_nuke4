<!-- BEGIN: main -->
<div class="modal" id="statistic-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>

                <div class="row">
                    <label>
                        <div class="col-sm-8">
                            Ngày bắt đầu
                        </div>
                        <div class="col-sm-16">
                            <input type="text" class="form-control date" id="from" value="{from}">
                        </div>
                    </label>
                    <label>
                        <div class="col-sm-8">
                            Ngày kết thúc
                        </div>
                        <div class="col-sm-16">
                            <input type="text" class="form-control date" id="end" value="{end}">
                        </div>
                    </label>
                </div>
                <div class="text-center form-group">
                    <button class="btn btn-info" onclick="statisticFilter()">
                        Xem thống kế
                    </button>
                </div>

                <div id="statistic-content">
                    {statistic_content}
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->