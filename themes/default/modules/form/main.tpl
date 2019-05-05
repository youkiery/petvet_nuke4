<!-- BEGIN: main -->
<!-- <link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script> -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<!-- <div class="modal fade" id="form-insert" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content"> 
      <div class="modal-body"> -->
        <div class="form-group">
          <label>Số phiếu</label>
          <input type="text" class="form-control" id="form-insert-code">
        </div>
        <div class="form-group">
          <label>Đơn vị</label>
          <input type="text" class="form-control" id="form-insert-unit">
        </div>
        <div class="form-group">
          <label>Ngày nhận</label>
          <input type="text" class="form-control" id="form-insert-receive" autocomplete="off">
        </div>
        <div class="form-group">
          <label>Ngày hẹn trả</label>
          <input type="text" class="form-control" id="form-insert-sendback" autocomplete="off">
        </div>
        <div class="form-group">
          Hình thức nhận
          <div class="checkbox">
            <label><input type="checkbox" id="form-insert-receive-state">Trực tiếp</label>
          </div>
          <div class="checkbox">
            <label><input type="checkbox" id="form-insert-receive-state-2">Bưu điện</label>
          </div>
          <input type="text" id="form-insert-receive-state-3">
        </div>
        <div class="form-group">
          <label> Người nhận hồ sơ </label>
          <input type="text" id="form-insert-receiver">
        </div>
        <p><b>Chuyên môn</b></p>
        <div class="form-group">
          <label> Ngày nhận </label>
          <input type="text" id="form-insert-elite-receive">
        </div>
        <div class="form-group">
          <label> Người nhận hồ sơ </label>
          <input type="text" id="form-insert-elite-sendback">
        </div>
        <div>
          Hồ sơ gồm
          <!-- js notice: add multi input -->
        </div>
        <div class="form-group">
          <label> Người giao mẫu </label>
          <input type="text" id="form-insert-elite-sendback">
        </div>
        <div class="form-group">
          <label> Bộ phận giao mẫu </label>
          <input type="text" id="form-insert-elite-sendback">
        </div>
        <div class="form-group">
          <label> Người nhận mẫu </label>
          <input type="text" id="form-insert-elite-sendback">
        </div>
        <div class="form-group">
          <label> Bộ phận nhận mẫu </label>
          <input type="text" id="form-insert-elite-sendback">
          <!-- note: receive unit attach with phone number -->
        </div>
        <div class="form-group">
          <!-- note: multi input receive sample status -->
          <!-- field: loại mẫu, loài lấy mẫu, số lượng, tình trạng, ký hiệu mẫu, hình thức bảo quản, nhận xét chung, yêu cầu xét nghiệm, phương pháp, ký hiệu phương pháp (đi cùng với phương pháp) -->
        </div>
        <div class="form-group">
          <label> Yêu cầu khác </label>
          <input type="text" id="form-insert-elite-sendback">
        </div>
      <!-- </div>
    </div>
  </div>
</div> -->

<div class="right">
  <button class="btn btn-success" onclick="insert()"><span class="glyphicon glyphicon-plus"></span></button>
</div>

<div id="content">

</div>

<script>
  var formInsert = $('#form-insert')
  function insert() {
    formInsert.modal('show')
  }

  function printer() {
  var WinPrint = window.open('', '', 'left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
  var html = style + content.html().toString()
  
  WinPrint.document.write(html);
  WinPrint.document.close();
  WinPrint.focus();
  WinPrint.print();
  WinPrint.close();
}
 
var datax = {}
function parseData() {
  for (const key in datax) {
    if (datax.hasOwnProperty(key)) {
      var element = document.getElementById(key)
      if (element) {
        const value = datax[key]; 
        var type = typeof(value)
        if (type == 'boolean') {
          element.checked = value
        }
        else {
          element.innerHTML = value
        }
      }
    }
  }
}

</script>
<!-- END: main -->