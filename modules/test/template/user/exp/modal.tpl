<!-- BEGIN: main -->
<div class="modal" id="statistic-modal" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <div class="form-group">
          Thống kê mặt hàng hết hạn
          <div type="button" class="close" data-dismiss="modal"> &times; </div> <br><br>
        </div>

        <div id="statistic-content"></div>
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