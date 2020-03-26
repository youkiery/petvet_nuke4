<!-- BEGIN: main -->
<div class="modal" id="depart-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="form-group">
                    <b style="font-size: 1.5em;"> Thông tin phòng ban </b>
                    <div class="close" type="button" data-dismiss="modal"> &times; </div>
                </div>

                <div class="form-group input-group">
                    <input type="text" class="form-control" id="depart-name" placeholder="Nhập tên phòng ban">
                    <div class="input-group-btn">
                        <button class="btn btn-success" onclick="updateDepartSubmit()">
                            Cập nhật
                        </button>
                    </div>
                </div>

                <div class="form-group" style="float: right;">
                    <button class="btn btn-success" onclick="$('#employ-modal').modal('show')">
                        Thêm nhân viên
                    </button>
                </div>

                <div id="depart-content"></div>
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

<!-- END: main -->
