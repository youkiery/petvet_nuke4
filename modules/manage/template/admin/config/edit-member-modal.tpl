<!-- BEGIN: main -->
<div class="modal" id="edit-member-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <p> <b> Quản lý thiết bị </b> </p>
        <div class="form-group">
          <div class="col-4">
            Phòng ban
          </div>
          <div class="col-8">
            <!-- BEGIN: depart -->
            <div class="checkbox">
              <label> <input type="checkbox" name="member-depart" index="{id}" id="member-depart-{id}"> {name} </label>
            </div>
            <!-- END: depart -->
          </div>
        </div>
        <div style="clear: left;"></div>
        <div class="form-group">
          <div class="col-4">
            Quyền sử dụng
          </div>
          <div class="col-8">
            <div class="radio">
              <label> <input type="radio" name="allowance" id="member-allowance-0" value="0" checked> Không </label>
            </div>
            <div class="radio">
              <label> <input type="radio" name="allowance" id="member-allowance-1" value="1"> Chỉ xem </label>
            </div>
            <div class="radio">
              <label> <input type="radio" name="allowance" id="member-allowance-2" value="2"> Chỉnh sửa </label>
            </div>
          </div>
        </div>

        <div class="text-center" style="clear: left;">
          <button class="btn btn-danger" onclick="editMemberSubmit()">
            Cập nhật
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->