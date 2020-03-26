<!-- BEGIN: main -->
<div class="modal" id="export-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div class="form-group">
          <button class="btn btn-success" onclick="insertExportModal()">
            <span class="glyphicon glyphicon-plus"></span>
          </button>
        </div>
        <div id="export-content">
          {content}
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->
