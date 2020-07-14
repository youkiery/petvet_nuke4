<!-- BEGIN: main -->
<div class="modal" id="remove-modal" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b> Xác nhận xóa thiết bị </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>

                <div class="text-center">
                    <p> Thiết bị sau khi xác nhận sẽ bị xóa vĩnh viễn, bạn có chắc chắn chứ? </p>
                    <button class="btn btn-danger" onclick="removeDeviceSubmit()">
                        Xác nhận
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="depart-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b style="font-size: 1.5em;"> Danh sách phòng </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>

                <div class="form-group input-group">
                    <input type="text" class="form-control" id="depart-name" placeholder="Nhập tên phòng">
                    <div class="input-group-btn">
                        <button class="btn btn-success" onclick="insertDepartSubmit()">
                            Thêm
                        </button>
                    </div>
                </div>

                <div id="depart-content">
                    {depart_content}
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="detail-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b style="font-size: 1.5em;"> Danh sách nhân viên </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>

                <div class="form-group relative">
                    <input type="text" class="form-control" id="detail-name" placeholder="Nhập tên nhân viên">
                    <div class="suggest" id="detail-name-suggest"></div>
                </div>

                <div id="detail-content"> </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="manager-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b style="font-size: 1.5em;"> Danh sách nhân viên </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>

                <div class="form-group relative">
                    <input type="text" class="form-control" id="manager-name" placeholder="Nhập tên nhân viên">
                    <div class="suggest" id="manager-name-suggest"></div>
                </div>

                <div id="manager-content">
                    {manager_content}
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="employ-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b style="font-size: 1.5em;"> Tìm kiếm nhân viên </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>

                <div class="form-group input-group">
                    <input type="text" class="form-control" id="employ-name" placeholder="Nhập tên nhân viên">
                    <div class="input-group-btn">
                        <button class="btn btn-success" onclick="employFilter()">
                            Tìm kiếm
                        </button>
                    </div>
                </div>

                <div id="employ-content"></div>
            </div>
        </div>
    </div>
</div>


<div class="modal" id="device-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
                <button class="btn btn-info" onclick="loadDefault()">
                    <span class="glyphicon glyphicon-refresh"></span>
                </button>

                <div class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-sm-4"> Tên thiết bị </label>
                        <div class="col-sm-20 relative">
                            <input type="text" class="form-control" id="device-name">
                            <div class="suggest" id="device-name-suggest"> </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4"> Quy cách </label>
                        <div class="col-sm-20 relative">
                            <input type="text" class="form-control" id="device-intro">
                            <div class="suggest" id="device-intro-suggest"></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4"> Đơn vị </label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="device-unit">
                        </div>
                        <label class="control-label col-sm-4"> Số lượng </label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="device-number">
                        </div>
                        <label class="control-label col-sm-6"> Năm sử dụng </label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="device-year">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4"> Nguồn cung cấp </label>
                        <div class="col-sm-20 relative">
                            <input type="text" class="form-control" id="device-source">
                            <div class="suggest" id="device-source-suggest"></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4"> Tình trạng sử dụng </label>
                        <div class="col-sm-20">
                            <input type="text" class="form-control" id="device-status">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4"> Đơn vị sử dụng </label>
                        <div class="col-sm-20 relative">
                            <div class="input-group">
                                <input type="text" class="form-control" id="device-depart-input">
                                <div class="input-group-btn">
                                    <button class="btn btn-info" onclick="insertDepart()">
                                        <span class="glyphicon glyphicon-plus"></span>
                                    </button>
                                </div>
                            </div>
                            <div class="suggest" id="device-depart-suggest"> </div>
                        </div>
                        <div> Đã chọn: <span id="device-depart"> </span> </div>
                    </div>
                    <div class="error" id="depart-error">  </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4"> Ngày nhập </label>
                        <div class="col-sm-20">
                            <input type="text" class="form-control" id="device-import-time"
                                placeholder="Ngày/tháng/năm nhập">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4"> Ghi chú </label>
                        <div class="col-sm-20">
                            <textarea class="form-control" id="device-description" rows="5"></textarea>
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-success" id="device-insert" onclick="deviceInsertSubmit()">
                            Thêm thiết bị </button>
                        <button type="submit" class="btn btn-info" id="device-edit" onclick="deviceEditSubmit()"> cập
                            nhật </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->