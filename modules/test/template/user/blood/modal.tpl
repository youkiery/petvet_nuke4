<!-- BEGIN: main -->
<div class="modal" id="sample-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b> Nạp hóa chất </b>
          <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>
        </div>

        <form onsubmit="return pushSampleSubmit(event)">
          <div class="form-group">
            <b> Lyse </b> (Giới hạn: <span class="text-red" id="push-limit1"> {number1} </span>)
            <input class="form-control" id="sample-value-1" value="1">
          </div>
  
          <div class="form-group">
            <b> Diluent </b> (Giới hạn: <span class="text-red" id="push-limit2"> {number2} </span>)
            <input class="form-control" id="sample-value-2" value="1">
          </div>
  
          <div class="form-group">
            <b> Rinse </b> (Giới hạn: <span class="text-red" id="push-limit3"> {number3} </span>)
            <input class="form-control" id="sample-value-3" value="1">
          </div>

          <div class="form-group">
            <b> Số đầu </b> (Hiện tại: <span class="text-red" id="push-limit"> {number} </span>)
            <input class="form-control" id="sample-value" value="1">
          </div>
  
          <div class="text-center">
            <button class="btn btn-success"> Nạp hóa chất </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="pull-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b> Chạy hóa chất </b>
          <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>
        </div>

        <form onsubmit="return pullSampleSubmit(event)">
          <div class="form-group">
            Chạy bao nhiêu hóa chất?
            <input class="form-control" id="pull-value" value="1">
          </div>
  
          <div class="text-center">
            <button class="btn btn-warning"> Chạy hóa chất </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="statistic-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b> Thống kê </b>
          <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>
        </div>

        <div class="row">
            <div class="col-sm-8">
              Ngày bắt đầu
            </div>
            <div class="col-sm-16">
              <input type="text" class="form-control date" id="from" value="{from}">
            </div>
            <div class="col-sm-8">
              Ngày kết thúc
            </div>
            <div class="col-sm-16">
              <input type="text" class="form-control date" id="end" value="{end}">
            </div>
        </div>
        <div class="text-center form-group">
          <button class="btn btn-info" onclick="statisticFilter()">
            Xem thống kế
          </button>
        </div>

        <div id="statistic-content">
          {statistic_content}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="import-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b> Thêm phiếu nhập hóa chất </b>
          <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>
        </div>

        <div class="maxi-form">
          <div class="form-group">
            Thời gian
            <input type="text" class="form-control" id="import-time" value="{today}">
          </div>
          <div class="form-group">
            Giá
            <input type="text" class="form-control" id="import-price" value="0">
          </div>
          <div class="form-group rows">
            <div class="col-4">
              Lyse
              <input type="text" class="form-control" id="import-number-1" value="0">
            </div>
            <div class="col-4">
              Diluent
              <input type="text" class="form-control" id="import-number-2" value="0">
            </div>
            <div class="col-4">
              Rinse
              <input type="text" class="form-control" id="import-number-3" value="0">
            </div>
          </div>
          <div class="form-group">
            Ghi chú
            <textarea class="form-control" id="import-note" rows="3"></textarea>
          </div>
          <div class="text-center">
            <button class="btn btn-success" id="import-insert-button" onclick="insertImport()">
              Nhập hóa chất
            </button>
            <button class="btn btn-info" id="import-edit-button" onclick="editImport()">
              Chỉnh sửa thông tin
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="insert-modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <b> Thêm phiếu xét nghiệm </b>
          <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>
        </div>

        <div class="maxi-form">
          <div class="form-group">
            Thời gian
            <input type="text" class="form-control date" id="insert-time" value="{today}">
          </div>
          <div class="form-group">
            Số lượng mẫu
            <input type="text" class="form-control" id="insert-number" value="1">
          </div>

          <div class="rows form-group">
            <div class="col-6">
              <div>
                Số đầu
                <div class="input-group">
                  <input type="text" class="form-control" id="insert-start" value="{last}" readonly>
                  <div class="input-group-btn">
                    <button class="btn btn-success" onclick="pushSample()">
                      nạp hóa chất
                    </button>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-6">
              <div>
                Số cuối
                <div class="input-group">
                  <input type="text" class="form-control" id="insert-end" value="{nextlast}" readonly>
                  <div class="input-group-btn">
                    <button class="btn btn-warning" onclick="pullSample()">
                      chạy hóa chất
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="form-group">
            Mục đích sử dụng
            <div class="relative">
              <input type="text" class="form-control" id="insert-name">
              <div class="suggest" id="insert-name-suggest"> </div>
            </div>
          </div>

          <div class="form-group">
            Người thực hiện
            <select class="form-control" id="insert-doctor">
              <option value="0"> Chưa chọn </option>
              <!-- BEGIN: doctor -->
              <option value="{id}" {selected}> {name} </option>
              <!-- END: doctor -->
            </select>
          </div>
          <div class="text-center">
            <button class="btn btn-success" id="blood-insert-button" onclick="insertBlood()">
              Thêm mẫu xét nghiệm
            </button>
            <button class="btn btn-info" id="blood-edit-button" onclick="editBlood()">
              Chỉnh sửa thông tin
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="remove-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          <div class="close" type="button" data-dismiss="modal"> &times; </div> <br> <br>
        </div>

        <div class="text-center">
          <p> Sau khi xác nhận, phiếu sẽ bị xóa vĩnh viễn </p>
          <button class="btn btn-danger" onclick="removeSubmit()">
            Xóa
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->