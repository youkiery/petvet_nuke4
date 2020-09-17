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
              <input type="text" class="form-control date" id="insert-starttime" value="{starttime}" autocomplete="off">
            </div>
            <div class="form-group col-6">
              <label> Hạn chót </label>
              <input type="text" class="form-control date" id="insert-endtime" value="{endtime}" autocomplete="off">
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
            <input class="form-control" id="user-name" type="text" placeholder="Nhập họ tên hoặc tài khoản nhân viên">
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

<div id="filter-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <br>

        <div class="form-group rows">
          <div class="col-6">
            <label> Từ </label>
            <input type="text" class="form-control date" id="filter-starttime" value="{starttime}" autocomplete="off">
          </div>
          <div class="col-6">
            <label> Đến </label>
            <input type="text" class="form-control date" id="filter-endtime" value="{endtime}" autocomplete="off">
          </div>
        </div>

        <div class="form-group">
          <div class="relative">
            <div class="input-group">
              <input type="text" class="form-control" id="filter-user" placeholder="Chọn danh sách nhân viên">
              <div class="input-group-btn">
                <button class="btn btn-danger" onclick="clearFilterUser()">
                  <span class="glyphicon glyphicon-remove"></span>
                </button>
              </div>
            </div>
            <input type="hidden" id="filter-user-val">
            <div class="suggest" id="filter-user-suggest"> </div>
          </div>

          <div id="filter-user-text"> {selected} </div>
        </div>

        <button class="btn btn-info btn-block" onclick="filterSubmit()">
          Lọc danh sách
        </button>
      </div>
    </div>
  </div>
</div>



<div id="edit" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{lang.work_edit}</h4>
      </div>
      <div class="modal-body">
        <form onsubmit="return edit_submit(event)">
          <div class="form-group">
            <label> {lang.work_name} </label>
            <input class="form-control" type="text" id="edit_name">
          </div>
          <div class="form-group">
            <label> {lang.work_depart} </label>
            <select class="form-control" id="edit_depart">

            </select>
          </div>
          <div class="form-group">
            <label> {lang.user} </label>
            <div class="relative">
              <input type="text" class="form-control user-suggest" id="edit_user" autocomplete="off">
              <div class="user-suggest-list" style="display: none;">
                {suggest}
              </div>
            </div>
          </div>
          <div class="form-group">
            <label> {lang.work_starttime} </label>
            <input type="text" class="form-control" id="edit_starttime" value="{startDate}" autocomplete="off">
          </div>
          <div class="form-group">
            <label> {lang.work_endtime} </label>
            <input type="text" class="form-control" id="edit_endtime" value="{endDate}" autocomplete="off">
          </div>
          <div class="form-group">
            <label> {lang.work_process} </label>
            <input class="form-control" type="text" id="edit_process" value="0%">
          </div>
          <div class="form-group">
            <label> {lang.note} </label>
            <input class="form-control" type="text" id="edit_note">
          </div>
          <button class="btn btn-info">
            {lang.work_update}
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="change_confirm" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form onsubmit="return change_confirm_submit(event)">
          <div class="form-group">
            <label> {lang.confirm} </label>
            <select class="form-control" id="confirm_value">

            </select>
          </div>
          <div class="form-group">
            <label> {lang.review} </label>
            <select class="form-control" id="confirm_review">

            </select>
          </div>
          <div class="form-group">
            <label> {lang.note} </label>
            <input type="text" class="form-control" id="confirm_note">
          </div>
          <button class="btn btn-info">
            {lang.update}
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="process_change" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form onsubmit="return change_process_submit(event)">
          <div class="form-group">
            <label> {lang.process} </label>
            <input class="form-control" type="text" id="edit_process2">
          </div>
          <div class="form-group">
            <label> {lang.note} </label>
            <input class="form-control" type="text" id="edit_note2">
          </div>
          <button class="btn btn-info">
            {lang.update}
          </button>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->