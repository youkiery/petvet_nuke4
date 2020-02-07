<!-- BEGIN: main -->
<div class="modal" id="statistic-modal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">

                <div class="row">
                    <label style="width: 100%;">
                        <div class="col-sm-6">
                            Ngày bắt đầu
                        </div>
                        <div class="col-sm-18">
                            <input type="text" class="form-control" id="from" value="{from}">
                        </div>
                    </label>
                    <label style="width: 100%;">
                        <div class="col-sm-6">
                            Ngày kết thúc
                        </div>
                        <div class="col-sm-18">
                            <input type="text" class="form-control" id="end" value="{end}">
                        </div>
                    </label>
                </div>
                <div class="text-center">
                    <button class="btn btn-info" onclick="statisticSubmit()">
                        Xem thống kê
                    </button>
                </div>
                <div id="statistic-content">
                    {statistic_content}
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="remove-modal" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <div class="text-center">
                    <p>
                        Xác nhận xóa bản ghi này
                    </p>
                    <button class="btn btn-danger" onclick="removeSubmit()">
                        Xóa
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="rider-detail" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <p> Thời gian nhập: <span id="rider-date"></span> </p>
                <p> Điểm đến: <span id="rider-destination"></span> </p>
                <p> Cây số đi: <span id="rider-from"></span> </p>
                <p> Cây số về: <span id="rider-end"></span> </p>
            </div>
        </div>
    </div>
</div>

<div id="insert-collect" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <p class="text-center">
                    Phiếu ghi lộ trình
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </p>
                <div class="form-group">
                    <label> Bác sĩ đi cùng </label>
                    <select class="form-control" id="collect-doctor">
                        <!-- BEGIN: collect_doctor -->
                        <option value="{driver_id}" {collect_doctor_check}>{driver_name}</option>
                        <!-- END: collect_doctor -->
                    </select>
                </div>

                <div class="form-group">
                    <label> Cây số đầu </label>
                    <input class="form-control" id="collect-start" type="text" value="{clock}">
                </div>
                <div class="form-group">
                    <label> Cây số cuối </label>
                    <input class="form-control" id="collect-end" type="text" value="{clock}">
                </div>
                <div class="form-group">
                    <label> Giá tiền </label>
                    <input class="form-control" id="collect-price" type="text">
                </div>
                <div class="form-group">
                    <label> Khách hàng <span id="collect-customer-info"></span> </label>
                    <div class="relative">
                        <input class="form-control" id="collect-customer" type="text">
                        <div class="suggest" id="collect-customer-suggest"> </div>
                    </div>
                </div>
                <div class="form-group">
                    <label> Địa điểm đến </label>
                    <div class="relative">
                        <input class="form-control" id="collect-destination" type="text">
                        <div class="suggest" id="collect-destination-suggest"> </div>
                    </div>
                </div>
                <div class="form-group">
                    <label> Ghi chú </label>
                    <input class="form-control" id="collect-note" type="text">
                </div>
                <div class="form-group text-center">
                    <button class="btn btn-success" id="collect-insert">
                        Lưu lộ trình
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="insert-pay" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <p class="text-center">
                    Phiếu chi lộ trình
                </p>
                <div class="form-group">
                    <label> Số tiền chi </label>
                    <input class="form-control" id="pay-money" type="text" value="0">
                </div>
                <div class="form-group">
                    <label> Ghi chú </label>
                    <input class="form-control" id="pay-note" type="text">
                </div>
                <div class="form-group">
                    <button class="btn btn-success" id="pay-insert">
                        Lưu phiếu chi
                    </button>
                    <button class="btn close" data-dismiss="modal">
                        Trở về
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
