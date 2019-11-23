<!-- BEGIN: main -->
<div class="modal" id="edit-member-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          <div class="col-4">
            Phòng ban
          </div>
          <div class="col-8">
            <div class="input-group form-group">
              <input type="text" class="form-control" id="depart-name">
              <div class="input-group-btn">
                <button class="btn btn-success" onclick="insertDepart()">
                  Thêm
                </button>
              </div>
            </div>
            <div id="depart-content">
              {content}
              <div id="depart-content-tail"></div>
            </div>
          </div>
        </div>
        <p> <b> Quản lý thiết bị </b> </p>
        <div style="clear: left;"></div>
        <div class="form-group">
          <div class="col-4">
            Quyền sử dụng
          </div>
          <div class="col-8">
            <div class="radio">
              <label> <input type="radio" name="device" id="member-device-0" value="0" checked> Không </label>
            </div>
            <div class="radio">
              <label> <input type="radio" name="device" id="member-device-1" value="1"> Chỉ xem </label>
            </div>
            <div class="radio">
              <label> <input type="radio" name="device" id="member-device-2" value="2"> Chỉnh sửa </label>
            </div>
          </div>
        </div>
        <p> <b> Quản lý vật tư, hóa chất </b> </p>
        <div class="form-group">
          <div class="col-4">
            Quyền sử dụng
          </div>
          <div class="col-8">
            <div class="radio">
              <label> <input type="radio" name="material" id="member-material-0" value="0" checked> Không </label>
            </div>
            <div class="radio">
              <label> <input type="radio" name="material" id="member-material-1" value="1"> Chỉ xem </label>
            </div>
            <div class="radio">
              <label> <input type="radio" name="material" id="member-material-2" value="2"> Chỉnh sửa </label>
            </div>
          </div>
        </div>


        <div class="text-center" style="clear: left;">
          <button class="btn btn-info" onclick="editMemberSubmit()">
            Cập nhật
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->