<!-- BEGIN: main -->
<div class="modal" id="member-edit-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          <select class="form-control" id="member-level"> </select>
        </div>

        <!-- BEGIN: depart -->
        <label style="margin-right: 10px;"> <input type="checkbox" class="member-depart-{id}" name="member-depart" value="{id}"> {name} </label>
        <!-- END: depart -->

        <div class="text-center">
          <button class="btn btn-info" onclick="editMemberSubmit()">
            Chỉnh sửa phân quyền
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->