<!-- BEGIN: main -->
<div class="modal" id="type-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="input-group">
          <input type="text" class="form-control" id="type-name">
          <div class="input-group-btn">
            <button class="btn btn-success" onclick="insertType()"> Thêm </button>
          </div>
        </div>

        <div class="type-content">
          {type_content}
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->