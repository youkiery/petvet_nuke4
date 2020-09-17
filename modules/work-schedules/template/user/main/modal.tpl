<!-- BEGIN: main -->
<div id="insert-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <div class="form-group">
          <div class="form-group">
            <label> {lang.work_name} </label>
            <input class="form-control insert-form" type="text" id="insert-name">
          </div>

          <!-- <div class="form-group">
            <label> {lang.work_depart} </label>
            <div class="relative">
              <div class="input-group">
                <input type="text" class="form-control" id="depart" autocomplete="off">
                <div class="input-group-btn">
                  <button class="btn btn-success" onclick="insertDepart()">
                    <span class="glyphicon glyphicon-plus"></span>
                  </button>
                </div>
              </div>
              <div class="suggest" id="depart-suggest"> </div>
            </div>
          </div> -->
          <div class="form-group">
            <label> {lang.user} </label>
            <div class="relative">
              <div class="input-group">
                <input type="text" class="form-control user-suggest insert-form" id="insert-user" autocomplete="off">
                <div class="input-group-btn">
                  <button class="btn btn-success" onclick="insertUser()">
                    <span class="glyphicon glyphicon-plus"></span>
                  </button>
                </div>
              </div>
              <div class="suggest" id="insert-user-suggest"> </div>
            </div>
            <p> Đã chọn: <span id="insert-user-name"></span> </p>
          </div>
          <div class="rows">
            <div class="form-group col-6">
              <label> Ngày bắt đầu </label>
              <div class="input-group">
                <input type="text" class="form-control date" id="insert-starttime" value="{starttime}"
                  autocomplete="off">
                <div class="input-group-addon">
                  <span class="glyphicon glyphicon-calendar"></span>
                </div>
              </div>
            </div>
            <div class="form-group col-6">
              <label> Hạn chót </label>
              <div class="input-group">
                <input type="text" class="form-control date" id="insert-endtime" value="{endtime}" autocomplete="off">
                <div class="input-group-addon">
                  <span class="glyphicon glyphicon-calendar"></span>
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label> Tiến độ </label>
            <div class="input-group">
              <input class="form-control" type="number" min="0" max="100" id="insert-process" value="0">
              <div class="input-group-addon">
                <span class="input-group-text"> % </span>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label> {lang.note} </label>
            <input class="form-control insert-form" type="text" id="insert-note">
          </div>
          <button class="btn btn-info btn-block" onclick="insertSubmit()">
            {lang.work_insert}
          </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="user-modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <div class="form-group">
          <div class="relative">
            <input class="form-control" id="user-name" type="text" placeholder="Nhập họ tên hoặc tài khoản nhân viên" autocomplete="off">
            <div class="suggest" id="user-name-suggest"> </div>
          </div>
        </div>
        <p style="color: black; opacity: 0.6; font-weight: bold;">
          * Chọn tài khoản nhân viên để thêm người dùng vào danh sách
        </p>
      </div>
    </div>
  </div>
</div>

<div id="report-modal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <div class="form-group">
          <label> Tiến độ </label>
          <div class="input-group">
            <input type="number" class="form-control" id="report-process">
            <div class="input-group-addon">
              %
            </div>
          </div>
        </div>

        <div class="form-group">
          <label> Ghi chú </label>
          <input type="text" class="form-control" id="report-note" value="0">
        </div>

        <!-- BEGIN: manager -->
        <div class="form-group">
          <label> Hạn chót </label>
          <div class="input-group">
            <input type="text" class="form-control date" id="report-calltime">
            <div class="input-group-addon">
              <span class="glyphicon glyphicon-calendar"></span>
            </div>
          </div>
        </div>
        <!-- END: manager -->

        <button class="btn btn-info btn-block" onclick="updateProcessSubmit()">
          Cập nhật
        </button>
      </div>
    </div>
  </div>
</div>

<div id="manager-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <div class="form-group">
          <div class="relative">
            <input class="form-control" id="manager-name" type="text" placeholder="Nhập họ tên hoặc tài khoản nhân viên" autocomplete="off">
            <div class="suggest" id="manager-name-suggest"> </div>
          </div>
        </div>

        <div id="manager-content">
          {manager_content}
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->