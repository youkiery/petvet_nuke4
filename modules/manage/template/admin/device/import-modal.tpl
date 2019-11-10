<!-- BEGIN: main -->
<div class="modal" id="import-modal" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>
        <div style="float: right;">
          <button class="btn btn-success" onclick="$('#import-insert-modal').modal('show')">
            Nhập hàng
          </button>
        </div>

        <div id="import-modal-content">
          {content}
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->