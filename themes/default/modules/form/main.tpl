<!-- BEGIN: main -->
<!-- <link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script> -->
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<div class="msgshow" id="msgshow"></div>

<!-- <div id="regist_confirm" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <h2> Bạn có muốn đăng ký những ngày này không? </h2>
        <div id="regist_list">

        </div>
        <div class="text-center">
          <button class="btn btn-success" onclick="registSubmit()">
            Đăng ký
          </button>
          <button class="btn btn-danger" data-dismiss="modal">
            Hủy
          </button>
        </div>
      </div>
    </div>
  </div>
</div> -->
<style id="style">
  * {font-family: "Times New Roman", Times, serif;font-size: 20px;}
  table {width: 100%;border-collapse: collapse;}
  td {padding: 4px; }
  p {margin: 10px;}
  br {display: block; content: ""; margin: 5px 0px;}
  .container {padding: 40px 10px 40px 60px;}
  .cell-center {text-align: center;vertical-align: inherit !important;}
  .relative {position: relative;}
  .bottom-left {position: absolute;bottom: 8px;left: 8px;}
  .para td {line-height: 35px;}
  .left {float: left;}
  .w30 {width: 30%;}
  .w40 {width: 40%;}
  .small {font-size: 0.9em;}
  .smaller {font-size: 0.8em;}
  .tide {width: 100px;}
  .tider {width: 50px;}
</style>

<div id="tab" style="float: left;">
  {tab}
</div>
<button class="btn btn-info right" onclick="printer()">
  <span class="glyphicon glyphicon-print"></span>
</button>
<div style="clear: both;"></div>
<div id="content">
  {content}
</div>

<script>
  var data = ['<div id="content"><div class="container"><table border="1"><tr height="110px"><td width="25%" class="cell-center">CHI CỤC <br> THÚ Y <br> VÙNG V</td><td class="relative"><div class="cell-center" style="margin-bottom: 25px;">PHIẾU GIẢI QUYẾT HỒ SƠ</div><div class="bottom-left">SỐ <div class="cinput"></div>/TYV5-TH</div></td></tr></table><br><table class="para"><tr><td colspan="4">Tên đơn vị: <div class="cinput"></div></td></tr><tr><td>Ngày nhận: <div class="cinput"></div></td><td colspan="3">Ngày hẹn trả kết quả: <div class="cinput"></div></td></tr><tr><td width="350px">Hình thức nhận: </td><td width="300px"><input type="checkbox" class="5">Trực tiếp</td><td width="300px"><input type="checkbox" class="5">Bưu điện</td><td width="300px">Khác <input type="text" class="tide" id="6"></td></tr><tr><td>Người nhận hồ sơ: <input type="text" class="tide" id="7"></td></tr><tr><td>Phòng chuyên môn:</td><td>Ngày nhận <input type="text" class="tide" id="8"></td><td>Ngày trả <input type="text" class="tide" id="9"></td></tr></table><br><table border="1"><tr><td class="cell-center">Hồ sơ gồm</td></tr><tr><td><textarea rows="7" cols="65"></textarea></td></tr></table><br><table border="1"><tr><td class="small cell-center">Ý kiến của phòng, Bộ phận chịu trách nhiệm giải quyết</td><td class="small cell-center">Ý khiến của Ban Lãnh đạo</td></tr><tr><td><textarea rows="7" cols="40"></textarea></td><td><textarea rows="7" cols="20"></textarea></td></tr></table><div class="small">&nbsp;&nbsp;&nbsp;&nbsp; <b> <i> <u>Ghi chú:</u> </i> </b> Hồ sơ có ý kiến của thủ trưởng (hoặc người được ủy quyền) phải giao lại cho Bộ phận một cửa trước 01 ngày so với ngày hẹn trả kết quả</div><div></div><div></div><div style="height: 120px;"></div><div><div class="smaller left w40">Mã số: </div><div class="smaller left w30">Ngày ban hành</div><div class="smaller left w30">Lần sửa đổi</div></div></div></div>', '<div id="content"><div class="container"><table><tr><td class="cell-center">CỤC THÚ Y <br> CHI CỤC THÚ Y VÙNG V</td><td class="cell-center">CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM <br><u>Độc lập - Tự do - Hạnh phúc</u></td></tr><tr><td></td><td style="text-align: right;"><i> Đăk Lăk, &nbsp;&nbsp;&nbsp;&nbsp; giờ &nbsp;&nbsp;&nbsp;&nbsp;p, ngày &nbsp;&nbsp;&nbsp;&nbsp; tháng  &nbsp;&nbsp;&nbsp;&nbsp;  năm &nbsp;&nbsp;&nbsp;&nbsp;</i></td></tr></table><br><h1 style="text-align: center">BIÊN BẢN GIAO NHẬN MẪU XÉT NGHIỆM</h1><P><b>&nbsp;&nbsp;&nbsp;&nbsp; 1/ Đại diện bên giao mẫu</b></P><p>&nbsp;&nbsp;&nbsp;&nbsp;  - Họ và tên: </p><p>&nbsp;&nbsp;&nbsp;&nbsp;Bộ phận một cửa - Phòng Tổng hợp - Chi cục Thú y Vùng V</p><p>&nbsp;&nbsp;&nbsp;&nbsp; <b>2/ Đại diện bên nhận mẫu:</b></p><p>&nbsp;&nbsp;&nbsp;&nbsp; - Họ và tên: </p><p>&nbsp;&nbsp;&nbsp;&nbsp; Bộ phận nhập mẫu - Trạm CĐXN bệnh động vật - Chi cục Thú y vùng V</p><p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <i> *Điện thoại: </i> 02623.877.795</p><p> &nbsp;&nbsp;&nbsp;&nbsp;<b> 3/ Thông tin về mẫu</b></p><table><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Loại mẫu: </td><td>Loại vật được lấy mẫu</td></tr></table><table><tr><td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Số lượng mẫu: </td><td> Tình trạng mẫu</td></tr><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Ký hiệu mẫu <br><br></td></tr></table><table><tr><td width="420px"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Ghi chú: (đính kèm danh sách nhận diện mẫu) </td><td> có</td><td> không</td></tr></table>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hình thức bảo quản, vận chuyển mẫu khi bàn giao (Đề nghị gạch chéo vào một trong các ô sau đây)<table><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thùng đá</td><td>Xe lạnh</td><td>Phương tiện khác</td></tr></table>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Chất lượng chung của mẫu khi bàn giao (dựa vào cảm quan để nhận xét): <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>4/ Yêu cầu xét nghiệm</b> <br><br><br><br><br><br><br><p>&nbsp;&nbsp;&nbsp;&nbsp; Biên bản kết thúc vào lúc h p, cùng ngày; biên bản này đã được lập thành bản; bên giao và bên nhận thống nhất ký vào biên bản (bên nhân giữ mẫu copy).</p><table><tr><td class="cell-center"><b>XÁC NHẬN CỦA BÊN NHẬN MẪU</b> <br>(Ký xác nhận, ghi rõ họ và tên)<br><br><br></td><td width="50px"></td><td class="cell-center"><b>XÁC NHẬN CỦA BÊN GIAO MẪU</b> <br>(Ký xác nhận, ghi rõ họ và tên)<br><br><br></td></tr></table></div></div>', '<div id="content"><div class="container"><table border="1"><tr><td class="cell-center" width="600px">CHI CỤC THÚ Y VÙNG V <br>TRẠM CHUẨN ĐOÁN XÉT NGHIỆM ĐỘNG VẬT</td><td class="cell-center">Biểu mẫu Số <br>Số soát xét</td></tr></table><div style="text-align: right;"><i> Ngày &nbsp;&nbsp;&nbsp;&nbsp; tháng  &nbsp;&nbsp;&nbsp;&nbsp;  năm &nbsp;&nbsp;&nbsp;&nbsp;</i></div><br><h1 style="text-align: center">PHIẾU YÊU CẦU XÉT NGHIỆM</h1><div style="float: right; border: 1px solid black; width: 300px; padding: 8px;">Số DKXN: <br>Số trang: <br>Liên: <br></div><div style="clear: both;"></div>Khách hàng: <br>Loại mẫu: &nbsp;&nbsp;  Nguyên con &#9744; &nbsp;&nbsp;  Huyết thanh &#9744; &nbsp;&nbsp;  Máu &#9744; &nbsp;&nbsp;  Phủ tạng &#9744; &nbsp;&nbsp;  Swab &#9744; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Khác: <br>Số lượng mẫu &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Loài vật được lấy mẫu <br>Số nhận diện <br> <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Ghi chú: (Đính kèm danh sách nhận diện mẫu) - Có &#9744; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Không &#9744; <br>Chỉ tiêu xét nghiệm:  <br>1. <br>Phương pháp xét nghiệm  <br>Ký hiệu xét nghiệm <br>2.  <br>Phương pháp xét nghiệm  <br>Ký hiệu xét nghiệm  <br>3.  <br>Phương pháp xét nghiệm  <br>Ký hiệu xét nghiệm  <br>4.  <br>Phương pháp xét nghiệm  <br>Ký hiệu xét nghiệm  <br>5.  <br>Phương pháp xét nghiệm  <br>Ký hiệu xét nghiệm  <br>Các yêu cầu khác: <br>Ngày hẹn trả kết quả &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ngày nhận mẫu<table><tr><td class="cell-center"><b>Khách hàng</b></td><td class="cell-center"><b>Bộ phận nhận mẫu</b></td></tr></table></div></div>']
  var tab = $("#tab")
  var content = $("#content")
  var style = '<style>* {font-family: "Times New Roman", Times, serif;font-size: 20px;} table {width: 100%;border-collapse: collapse;} td {padding: 4px; } p {margin: 10px;} br {display: block; content: ""; margin: 5px 0px;} .container {padding: 40px 10px 40px 60px;} .cell-center {text-align: center;vertical-align: inherit !important;} .relative {position: relative;} .bottom-left {position: absolute;bottom: 8px;left: 8px;} .para td {line-height: 35px;} .left {float: left;} .w30 {width: 30%;} .w40 {width: 40%;} .small {font-size: 0.9em;} .smaller {font-size: 0.8em;} .tide {width: 100px;} .tider {width: 50px;}</style>'
  var tabButton

  $("document").ready(() => {
    var html = ''
    var i = 0
    data.forEach((item, index) => {
      if (i == index) {
        var cls = 'btn btn-info active'
      }
      else {
        cls = 'btn'
      }
      html += '<button class="' + cls + ' tab-button" onclick="totab('+ index +')"> Mẫu '+ (index + 1) +' </button>';
    })    
    tab.html(html)
    tabButton = $(".tab-button")
    tabButton.click((e) => {
      var current = e.currentTarget

      tabButton.removeClass('active')
      tabButton.removeClass('btn-info')
      current.classList.add('active')
      current.classList.add('btn-info')
    })
    totab(i)
  })

  function totab(index) {
    content.html(data[index])
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

</script>
<!-- END: main -->