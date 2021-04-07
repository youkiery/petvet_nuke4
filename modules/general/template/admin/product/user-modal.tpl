<!-- BEGIN: main -->
<div class="modal" id="tag-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b style="font-size: 1.5em;"> Quyền truy cập các tag </b>
          <div class="close" type="button" data-dismiss="modal"> &times; </div>
        </div>

        <div class="form-group relative">
          <input type="text" class="form-control" id="tag-name">
          <div class="suggest" id="tag-name-suggest"> </div>
        </div>
        <div id="tag-list"></div>
        <div class="text-center">
          <button class="btn btn-info" onclick="saveTagPermit()">
            Lưu tag
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->