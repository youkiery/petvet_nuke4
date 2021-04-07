<!-- BEGIN: main -->
<div class="modal" id="member-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group input-group">
          <input type="text" class="form-control" id="member-keyword" placeholder="Tìm kiếm theo tên người dùng">
          <div class="input-group-btn">
            <button class="btn btn-info" onclick="goMemPage(1)">
              Tìm kiếm
            </button>
          </div>
        </div>

        <div id="member-content"> </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->