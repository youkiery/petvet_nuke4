<!-- BEGIN: main -->
<div class="modal" id="done-modal" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div class="text-center">
          <p> Sau khi xác nhận, bản ghi sẽ biến mất, bạn có chắc chắn </p>
          <button class="btn btn-warning" onclick="doneSubmit()">
            Xác nhận
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="statistic-modal" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Thống kê mặt hàng hết hạn
          <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>
        </div>
        <div class="form-group">
          <div class="input-group">
            <select class="form-control" id="statistic-time">
              <option value="30"> 1 tháng </option>
              <option value="90" selected> 3 tháng </option>
              <option value="180"> 6 tháng </option>
              <option value="365"> 1 năm </option>
              <option value="730"> 2 năm </option>
            </select>
            <div class="input-group-btn">
              <button class="btn btn-info" onclick="statistic()">
                thống kê
              </button>
            </div>
          </div>
        </div>

        <div id="statistic-content">
          {statistic}
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="modal-number" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div id="number-content">

        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="modal-excel" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <div style="text-align: center; position: relative;">
          <p> Chọn file .XSLS từ thiết bị </p>
          <div style="margin: auto;">
            <div style="position: absolute;"></div>
              <label class="filebutton">
                <div style="background: #eee; height: 200px; width: 200px; font-size: 100px; border-radius: 10%; line-height: 200px; color: green;">
                  +
                </div>
                
                <span>
                  <input type="file" class="fileinput" id="file" onchange="tick(event)">
                </span>
              </label>
          </div>
        </div>
        
        <div id="error" style="color: red; font-weight: bold; font-size: 1.2em;">
        
        </div>
        <div id="notice" style="color: green; font-weight: bold; font-size: 1.2em;">
        
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->