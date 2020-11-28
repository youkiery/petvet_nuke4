<!-- BEGIN: main -->
<div class="modal" id="overtime-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Cài đặt thời gian làm việc
          <div type="button" class="close" data-dismiss="modal"> &times; </div>
        </div>

        <div class="form-group">
          <div class="rows">
            <label class="col-4"> Thời gian bắt đầu </label>
            <label class="col-4"> <input type="text" class="form-control" id="starthour"> </label>
            <label class="col-4"> <input type="text" class="form-control" id="startminute"> </label>
          </div>
          <div class="rows">
            <label class="col-4"> Thời gian kết thúc </label>
            <label class="col-4"> <input type="text" class="form-control" id="endhour"> </label>
            <label class="col-4"> <input type="text" class="form-control" id="endminute"> </label>
          </div>
        </div>

        <div class="form-group">
          <button class="btn btn-info btn-block" onclick="saveOvertime()">
            Chỉnh sửa cấu hình
          </button>
        </div>

      </div>
    </div>
  </div>
</div>

<div class="modal" id="config-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Cài đặt quyền sử dụng
          <div type="button" class="close" data-dismiss="modal"> &times; </div>
        </div>

        <table class="table table-bordered" style="font-size: 0.8em;">
          <tr>
            <th> Chức năng </th>
            <th> Thời gian bắt đầu </th>
            <th> Thời gian kết thúc </th>
          </tr>
          <!-- BEGIN: module -->
          <tr class="overtime" id="{id}"> 
            <td> {module} </td>
            <!-- <td> <input type="checkbox" id="check-{id}"> </td> -->
            <td> 
              <div class="rows">
                <div class="col-6"> <input type="text" class="form-control" id="starthour-{id}" value="{start0}"> </div>
                <div class="col-6"> <input type="text" class="form-control" id="startminute-{id}" value="{start1}"> </div>
              </div>
            </td>
            <td> 
              <div class="rows">
                <div class="col-6"> <input type="text" class="form-control" id="endhour-{id}" value="{end0}"> </div>
                <div class="col-6"> <input type="text" class="form-control" id="endminute-{id}" value="{end1}"> </div>
              </div>
            </td>
          </tr>
          <!-- END: module -->
        </table>
        <!-- <div class="form-group">
          <div class="rows">
            <label class="col-4"> Thời gian bắt đầu </label>
            <label class="col-4"> <input type="text" class="form-control" id="starthour"> </label>
            <label class="col-4"> <input type="text" class="form-control" id="startminute"> </label>
          </div>
          <div class="rows">
            <label class="col-4"> Thời gian kết thúc </label>
            <label class="col-4"> <input type="text" class="form-control" id="endhour"> </label>
            <label class="col-4"> <input type="text" class="form-control" id="endminute"> </label>
          </div>
        </div> -->

        <div class="form-group">
          <button class="btn btn-info btn-block" onclick="saveOvertime()">
            Chỉnh sửa cấu hình
          </button>
        </div>

      </div>
    </div>
  </div>
</div>
<!-- END: main -->
