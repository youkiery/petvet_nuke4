<!-- BEGIN: main -->
<div class="modal" id="filter-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br>

        <div class="text-center form-group">
          <input type="text" class="form-control form-group" id="filter-keyword" placeholder="Nhập tên vật tư tìm kiếm...">
          <div class="row-x form-group">
            <div class="col-6">
              <input type="text" class="form-control date" id="filter-start" value="{start}">
            </div>
            <div class="col-6">
              <input type="text" class="form-control date" id="filter-end" value="{end}">
            </div>
          </div>
          <button class="btn btn-info" onclick="goReportPage(1)"> Lọc báo cáo </button>
        </div>

        <div id="filter-content">

        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->
