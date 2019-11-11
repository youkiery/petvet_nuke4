<!-- BEGIN: main -->
<div class="modal" id="depart-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="form-group">
          <label class="control-label col-sm-4"> Tên đơn vị </label>
          <div class="col-sm-20">
            <input type="text" class="form-control" id="depart-name">
          </div>
        </div>

        <div class="form-group text-center" onclick="departsubmit()">
          <button type="submit" class="btn btn-info"> Thêm đơn vị </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->