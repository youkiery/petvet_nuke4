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
  .document {
    position: relative;   width: 730px;   height: 1200px; padding: 60px 60px 0px 100px;
  }
  .text-center {
    text-align: center;
  }
  .text, .multiline-input, .border, .group, .inline {
    position: absolute;   box-sizing: border-box;   font-size: 18px; font-family: 'Times New Roman', Times, serif;
  }
  .text, .group {
    width: max-content;
  }
  .text {
    overflow: hidden;
  }
  .border {
    border: 1px solid black;
  }
</style>

<div id="tab" style="float: left;">
  {tab}
</div>
<button class="btn btn-info right" onclick="printer()">
  <span class="glyphicon glyphicon-print"></span>
</button>
<div style="clear: both;"></div>
<div id="content" class="document">
  {content}
</div>

<script>
  var data = ['<div class="border" style="top: 60px; left: 100px; width: 150px; height: 100px"></div> <div class="border" style="top: 60px; width: 580px; height: 100px; left: 249px;"></div> <div class="text" style="width: 88px; text-align: center; left: 128px; top: 82px;"> CHI CỤC THÚ Y VÙNG V </div> <div class="text" style="left: 430px; top: 82px;"> <b>PHIẾU GIẢI QUYẾT HỒ SƠ</b> </div> <div class="text" style="left: 256px; top: 135px;">   <b>Số</b> <span class="input" id="1"></span>/TYV5-TH </div> <div class="text" style="left: 105px; top: 180px; width: 720px;">  Tên đơn vị:  <span class="input" id="2"> </span> </div> <div class="group" style="left: 105px; top: 210px;">  <div class="text" style="width: 300px;">  Ngày nhận: <span class="input" id="3"> </span>  </div>  <div class="text" style="left: 400px; width: 300px;">  Ngày hẹn trả kết quả: <span class="input" id="4"> </span>  </div> </div> <div class="group" style="left: 105px; top: 240px;">  <div class="text">  Hình thức nhận:  </div>  <div class="group" style="left: 144px; width: 300px;"> <input type="checkbox" class="input" id="5"> Trực tiếp  </div>  <div class="group" style="left: 300px; width: 300px;"> <input type="checkbox" class="input" id="6"> Bưu điện  </div>  <div class="group" style="left: 400px; width: 300px;"> Khác  <span class="input" id="7"></span>  </div> </div> <div class="text" style="left: 105px; top: 270px; width: 730px;">  Người nhận hồ sơ:  <span class="input" id="8"></span> </div> <div class="group" style="left: 105px; top: 300px;">  <div class="text"> Phòng chuyên môn:  </div>  <div class="text" style="left: 200px; width: 300px;"> Ngày nhận:  <span class="input" id="9"></span>  </div>  <div class="text" style="left:450px; width: 300px;"> Ngày trả:  <span class="input" id="10"></span>  </div> </div> <div class="border" style="left: 100px; top: 340px; width: 730px; height: 330px;"> </div> <div class="text" style="left: 450px; top: 350px;">  <u>Hồ sơ gồm:</u> </div> <div class="multiline-input" row="7" style="left: 110px; top: 380px; width: 700px; height: 280px;" id="11"></div> <div class="border" style="left: 100px; top: 689px; width: 500px; height: 30px;"></div> <div class="border" style="left: 599px; top: 689px; width: 230px; height: 30px;"></div> <div class="border" style="left: 100px; top: 718px; width: 500px; height: 300px;"></div> <div class="border" style="left: 599px; top: 718px; width: 230px; height: 300px;"></div> <div class="text" style="top: 695px; left: 115px;">  <b>Ý kiến của phòng, bộ phận chịu trách nhiệm giải quyết</b> </div> <div class="text" style="top: 695px; left: 610px;">  <b>Ý kiến của ban lãnh đạo</b> </div> <div class="text" style="top: 1030px; left: 100px; width: 730px;">  <i> <b> <u>Ghi chú:</u></b></i> Hồ sơ có ý kiếm của thủ trưởng (hoặc người được ủy quyền) phải được giao lại cho bộ phận một cửa trước 01 ngày so với ngày hẹn trả kết quả </div> <div class="text" style=" top: 1175px; left: 100px;">  Mã số: BM-02/TYV5-06 </div> <div class="text" style="top: 1175px; left: 400px;">  Ngày ban hành: 02/11/2017,  </div> <div class="text" style="top: 1175px; left: 650px;">  Lần sửa đổi: 02 </div> ', '<div class="border" style="top: 115px; left: 50px; width: 300px; height: 45px;"></div><div class="border" style="top: 110px; left: 140px; width: 93px;"></div><div class="border" style="top: 110px; left: 496px; width: 242px;"></div><div class="text" style="left: 140px; top: 60px;"> CỤC THÚ Y </div><div class="text" style="left: 85px; top: 85px;"> <b>CHI CỤC THÚ Y VÙNG V</b></div><div class="text" style="left: 410px; top: 60px;"> <b>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</b> </div><div class="text" style="left: 495px; top: 85px;"> <b>Độc lập - Tự do - Hạnh phúc</b> </div><div class="text" style="left: 60px; top: 130px;"> Số ĐKXN: <span class="input"></span>/<span class="input"></span>/<span class="input"></span> </div><div class="text" style="left: 430px; top: 130px;"> <i>Đắk Lắk, <span class="input"></span> giờ, <span class="input"></span>p, ngày <span class="input"></span> tháng <span class="input"></span> năm <span class="input"></span></i> </div><div class="text" style="left: 230px; top: 190px;"><b>BIÊN BẢN GIAO NHẬN MẤU XÉT NGHIỆM</b></div><div class="text" style="left: 100px; top: 225px;"> <b>1/ Đại diện bên giao mẫu</b> </div><div class="text" style="left: 100px; top: 255px;">- Họ và tên:<span class="input"></span></div><div class="text" style="left: 100px; top: 285px;"> Bộ phận một cửa - Phòng tổng hợp - Chi cục Thú y vùng V</div><div class="text" style="left: 100px; top: 315px;"><b>2/ Đại diện bên nhận mẫu:</b></div><div class="text" style="left: 100px; top: 345px;">- Họ và tên:<span class="input"></span></div><div class="text" style="left: 100px; top: 375px;"> Bộ phận nhập mẫu - Trạm CĐXN bệnh động vật - Chi cục Thú y vùng V</div><div class="text" style="left: 200px; top: 405px;">* Điện thoại: 0262 3.877.795</div><div class="text" style="left: 100px; top: 435px;"><b>3/ Thông tin về mẫu</b></div><div class="group" style="left: 100px; top: 475px;"><div class="text">- Loại mẫu<span class="input"></span></div><div class="text" style="left: 330px;">Loài vật được lấy mẫu<span class="input"></span></div></div><div class="group" style="left: 100px; top: 505px;"><div class="text">- Số lượng mẫu<span class="input"></span></div><div class="text" style="left: 350px;">Tình trạng mẫu<span class="input"></span></div></div><div class="text" style="left: 100px; top: 535px; width: 730px; height: 50px;">- Ký hiệu mẫu<span class="input"></span></div><div class="group" style="left: 100px; top: 595px; width: 730px;">* Ghi chú: (đính kèm danh sách nhận diện mẫu) <span class="text" style="width: 100px; margin-left: 10px;">có<input type="checkbox" class="input"></span><span class="text" style="width: 100px; left: 550px;">không<input type="checkbox" class="input"></span></div><div class="text" style="left: 60px; top: 655px; width: 730px;">&ensp;&ensp;&ensp;&ensp;- Hình thức bảo quản, vận chuyển mẫu khi bàn giao (đề nghị gạch chéo vào một trong các ô sau đây)</div><div class="group" style="left: 100px; top: 715px;"><div class="text" style="left: 50px;"><input type="checkbox">Thùng đá</div><div class="text" style="left: 250px;"><input type="checkbox">Xe lạnh</div><div class="text" style="left: 450px;"><input type="checkbox">Phương tiện khác</div></div><div class="group" style="left: 100px; top: 745px;"><div class="text" style="width: 730px; height: 52px;">- Chất lượng chung của mẫu khi bàn giao (dựa vào cảm quan để nhận xét)<span></span></div></div><div class="text" style="left: 100px; top: 805px;"><b>4/ Yêu cầu xét nghiệm</b></div><div class="input" style="left: 100px; top: 835px; width: 730px; height: 220px;"></div><div class="text" style="left: 60px; top: 1055px; width: 730px;">&ensp;&ensp;&ensp;&ensp;Biên bản kết thúc vào lúc<span class="input"></span>h<span class="input"></span>p cùng ngày; biên bản được lập thành <span class="input"></span> bản; bên giao và nhận thống nhất ký vào biên bản (bên nhận mẫu giữ bản copy).</div><div class="text" style="left: 115px; top: 1110px;"><b>XÁC NHẬN CỦA BÊN NHẬN MẪU</b></div><div class="text" style="left: 151px; top: 1140px;"><i>(Ký xác nhận, ghi rõ họ tên)</i></div><div class="text" style="left: 500px; top: 1110px;"><b>XÁC NHẬN CỦA BÊN GIAO MẪU</b></div><div class="text" style="left: 535px; top: 1140px;"><i>(Ký xác nhận, ghi rõ họ tên)</i></div>', '<div class="border" style="top: 60px; left: 100px; width: 470px; height: 60px;"></div><div class="border" style="top: 60px; left: 569px; width: 260px; height: 60px;"></div><div class="text" style="top: 63px; left: 220px;"><b>CHI CỤC THÚ Y VÙNG V</b></div><div class="text" style="top: 90px; left: 105px;"><b>TRẠM CHUẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT</b></div><div class="text" style="top: 65px; left: 572px;"><b>BIỂU MẪU SỐ: BM.STTT.02.02</b></div><div class="text" style="top: 95px; left: 615px;"><b>Số Soát xét: 03.02718</b></div><div class="text" style="top: 130px; left: 580px;"><i>Ngày<span class="input" id="1"></span> tháng<span class="input" id="2"></span> năm<span class="input" id="3"></span></i></div><div class="text" style="top: 160px; left: 400px;"><b>PHIẾU YÊU CẦU XÉT NGHIỆM</b></div><div class="border" style="top: 190px; left: 485px; width: 340px; height: 100px;"></div><div class="text" style="top: 200px; left: 500px;"><b>Số ĐKXN:</b><span class="input" id="4"></span>/<span class="input" id="5"></span>/<span class="input" id="6"></span></div><div class="text" style="top: 230px; left: 500px;"><b>Số trang:</b><span class="input" id="7"></span>/<span class="input" id="8"></span></div><div class="text" style="top: 260px; left: 500px;"><b>Liên</b><span class="input" id="9"></span>/<span class="input" id="10"></span></div><div class="text" style="top: 310px; left: 100px;"><b>Khách hàng:</b><span class="input" id="11"></span></div><div class="group" style="top: 340px; left: 100px;"><b>Loại mẫu:</b><div class="text" style="left: 150px; top: 0px;">Nguyên con<input type="checkbox" class="input" id="12"></div><div class="text" style="left: 280px; top: 0px;">Huyết thanh<input type="checkbox" class="input" id="13"></div><div class="text" style="left: 420px; top: 0px;">Máu<input type="checkbox" class="input" id="14"></div><div class="text" style="left: 520px; top: 0px;">Phù tạng<input type="checkbox" class="input" id="15"></div><div class="text" style="left: 620px; top: 0px;">Swab<input type="checkbox" class="input" id="16"></div></div><div class="text" style="top: 370px; left: 100px;">Khác:<span class="input" id="17"></span></div><div class="group" style="top: 400px; left: 100px;"><div class="text"><b>Số lượng mẫu</b><span class="input" id="18"></span></div><div class="text" style="left: 400px"><b>- Loài vật được lấy mẫu:</b><span class="input" id="19"></span></div></div><div class="text" style="top: 430px; left: 100px; width: 730px;"><b>Số nhận diện: </b><span class="inline input" id="20"></span></div><div class="group" style="top: 480px; left: 150px;">* Ghi chú: (Đính kèm danh sách nhận diện mẫu):<div class="text" style="left: 370px; top: 0px;">- Có<input type="checkbox" class="input" id="21"></div><div class="text" style="left: 500px; top: 0px;">- Không<input type="checkbox" class="input" id="22"></div></div><div class="text" style="top: 510px; left: 100px;"><b>Chỉ tiêu xét nghiệm</b></div><div class="text" style="top: 540px; left: 100px;">1.<span class="input" id="23"></span></div><div class="text" style="top: 570px; left: 100px;">Phương pháp xét nghiệm:<span class="input" id="24"></span></div><div class="text" style="top: 600px; left: 100px;">Ký hiệu phương pháp:<span class="input" id="25"></span></div><div class="text" style="top: 630px; left: 100px;">2.<span class="input" id="26"></span></div><div class="text" style="top: 670px; left: 100px;">Phương pháp xét nghiệm:<span class="input" id="27"></span></div><div class="text" style="top: 700px; left: 100px;">Ký hiệu phương pháp:<span class="input" id="28"></span></div><div class="text" style="top: 730px; left: 100px;">3.<span class="input" id="29"></span></div><div class="text" style="top: 760px; left: 100px;">Phương pháp xét nghiệm:<span class="input" id="30"></span></div><div class="text" style="top: 790px; left: 100px;">Ký hiệu phương pháp:<span class="input" id="31"></span></div><div class="text" style="top: 820px; left: 100px;">4.<span class="input" id="32"></span></div><div class="text" style="top: 850px; left: 100px;">Phương pháp xét nghiệm:<span class="input" id="33"></span></div><div class="text" style="top: 880px; left: 100px;">Ký hiệu phương pháp:<span class="input" id="34"></span></div><div class="text" style="top: 910px; left: 100px;">5.<span class="input" id="35"></span></div><div class="text" style="top: 940px; left: 100px;">Phương pháp xét nghiệm:<span class="input" id="36"></span></div><div class="text" style="top: 970px; left: 100px;">Ký hiệu phương pháp:<span class="input" id="37"></span></div><div class="text" style="top: 1000px; left: 100px;"><b>Các yêu cầu khác:</b><span class="input" id="38"></span></div><div class="text" style="top: 1030px; left: 100px;">Ngày nhận mẫu<span class="input" id="39"></span>/<span class="input" id="40"></span>/<span class="input" id="41"></span></div><div class="text" style="top: 1030px; left: 550px;">Ngày hẹn trả kết quả:<span class="input" id="42"></span>/<span class="input" id="43"></span>/<span class="input" id="44"></span></div><div class="text" style="top: 1060px; left: 250px;"><b>Khách hàng</b></div><div class="text" style="top: 1060px; left: 650px;"><b>Bộ phận nhận mẫu</b></div><div class="border" style="top: 1150px; left: 400px; width: 200px; height: 75px;"></div><div class="text" style="top: 1155px; left: 455px;"><b>BIỂU MẪU</b></div><div class="text" style="top: 1180px; left: 430px;"><b>ĐÃ KIỂM SOÁT</b></div><div class="text" style="top: 1205px; left: 405px; font-family: consolas; font-size: 0.75em;">Ngày<span class="input" id="45"></span> tháng<span class="input" id="46"></span> năm<span class="input" id="47"></span></div>']
  var tab = $("#tab")
  var content = $("#content")
  var style = '<style>.document { position: relative;   width: 730px;   height: 1200px; padding: 60px 60px 0px 100px; } .text-center { text-align: center; } .text, .multiline-input, .border, .group, .inline { position: absolute;   box-sizing: border-box;   font-size: 18px; } .text, .group { width: max-content; } .text { overflow: hidden; } .border { border: 1px solid black; }</style>'
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