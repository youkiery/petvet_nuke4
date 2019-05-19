<!-- BEGIN: main -->
<!-- <link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script> -->
<style>
  .right {
    overflow: auto;
  }
  .right-click {
    float: left;
    width: 85%;
    overflow: hidden;
  }
</style>

<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<div class="msgshow" id="msgshow"></div>

<div id="method-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>

        <form onsubmit="insertMethodSubmit(event)">
          <div class="row">
            <label class="col-sm-6">Tên phương pháp</label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="insert-method-name">
            </div>
          </div>
          <div class="row">
            <label class="col-sm-6">Ký hiệu phương pháp</label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="insert-method-symbol">
            </div>
          </div>
          <div class="text-center">
            <button class="btn btn-success">
              Thêm
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="form-remove" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        Xác nhận xóa văn bản 
        <div class="text-center">
          <button class="btn btn-danger" onclick="removeSubmit()">
            Xóa
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<ul class="nav nav-tabs">
  <li class="active"><a data-toggle="tab" href="#home"> Danh sách </a></li>
  <li><a data-toggle="tab" href="#menu1"> Thêm văn bản </a></li>
</ul>

<div class="tab-content">
  <div id="home" class="tab-pane active">
    <form onsubmit="filter(event)">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control" id="filter-keyword" placeholder="Mẫu phiếu">
        </div>
        <div class="col-sm-6">
          <select class="form-control" id="filter-printer">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5" selected>5</option>
          </select>
          <!-- <div class="input-group dropdown">
            <input class="form-control dropdown-toggle" id="filter-printer" type="button" data-toggle="dropdown" placeholder="Mẫu đơn số">
            <div class="input-group-btn">
              <button class="btn" onclick="clearFilterPrinter()"> <span class="glyphicon glyphicon-remove"></span> </button>
            </div>
            <ul class="dropdown-menu" id="drug-search-system-suggest">
              <label class="printer-x"> <input type="checkbox" class="checkbox"> 1 </label><br>
              <label class="printer-x"> <input type="checkbox" class="checkbox"> 2 </label><br>
              <label class="printer-x"> <input type="checkbox" class="checkbox"> 3 </label><br>
              <label class="printer-x"> <input type="checkbox" class="checkbox"> 4 </label><br>
              <label class="printer-x"> <input type="checkbox" class="checkbox"> 5 </label>
            </ul>
          </div> -->
        </div>
        <div class="col-sm-6">
          <select class="form-control" id="filter-limit">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option value="75">75</option>
            <option value="100">100</option>
          </select>
        </div>
        <div class="col-sm-6"><button class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button></div>
      </div>      
    </form>
    <div id="content">
      {content}
    </div>
  </div>

  <div id="menu1" class="tab-pane">
    <div class="row form-group boxed box-1">
      <label class="col-sm-4">Số phiếu</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="form-insert-code">
      </div>
    </div>

    <div class="row form-group boxed box-1">
      <label class="col-sm-4">Ngày nhận mẫu</label>
      <div class="col-sm-8">
        <input type="text" class="form-control" id="form-insert-receive" autocomplete="off">
      </div>
      <label class="col-sm-4">Ngày hẹn trả</label>
      <div class="col-sm-8">
        <input type="text" class="form-control" id="form-insert-resend" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-1">
      <label class="col-sm-4">
        Tên đơn vị
      </label>
      <div class="relative col-sm-10">
        <input type="text" class="form-control" id="form-insert-sender-employ" autocomplete="off">
        <div class="suggest" id="form-insert-sender-employ-suggest"></div>
      </div>
    </div>

    <div class="boxed box-1">
      <label>Hình thức nhận</label>
      <div>
        <label><input type="radio" name="state" class="check-box state" id="state-0" checked>Trực tiếp</label>
      </div>
      <div>
        <label><input type="radio" name="state" class="check-box state" id="state-1">Bưu điện</label>
      </div>
      <div class="row form-group">
        <label class="col-sm-4"><input type="radio" name="state" class="check-box state" id="state-2">Khác</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="form-insert-receive-state-other">
        </div>
      </div>
    </div>

    <div class="row form-group boxed box-1">
      <label class="col-sm-4">
        Người nhận hồ sơ
      </label>
      <div class="relative col-sm-10">
        <input type="text" class="form-control" id="form-insert-receiver-employ" autocomplete="off">
        <div class="suggest" id="form-insert-receiver-employ-suggest"></div>
      </div>
    </div>

    <div class="row boxed box-1">
      <label class="col-sm-4">Ngày nhận mẫu</label>
      <div class="col-sm-8">
        <input type="text" class="form-control" id="form-insert-ireceive" autocomplete="off">
      </div>
      <label class="col-sm-4">Ngày hẹn trả</label>
      <div class="col-sm-8">
        <input type="text" class="form-control" id="form-insert-iresend" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-1">
      <div class="panel" id="form-insert-form">

      </div>
      <button class="btn btn-success" onclick="addInfo(1)">
        <span class="glyphicon glyphicon-plus"></span>
      </button>
    </div>

    <div class="row form-group boxed box-2 box-3">
      <label class="col-sm-4">Số ĐKXN</label>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box xcode" id="form-insert-xcode-1">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box xcode" id="form-insert-xcode-2">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box xcode" id="form-insert-xcode-3">
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">Số trang</label>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box page" id="form-insert-page-1">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box page" id="form-insert-page-2">
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">Liên</label>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box no" id="form-insert-no-1">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box no" id="form-insert-no-2">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-3">
      <label class="col-sm-4"> Thời gian nhận mẫu </label>
      <div class="col-sm-6">
        <input type="text" class="form-control" id="form-insert-sample-receive-time">
      </div>
      <label class="col-sm-3"> Giờ </label>
      <div class="col-sm-4">
        <select class="form-control" id="form-insert-sample-receive-hour">
          <!-- BEGIN: hour -->
          <option value="{value}">{value}</option>
          <!-- END: hour -->
        </select>
      </div>
      <label class="col-sm-3"> Phút </label>
      <div class="col-sm-4">
        <select class="form-control" id="form-insert-sample-receive-minute">
          <!-- BEGIN: minute -->
          <option value="{value}">{value}</option>
          <!-- END: minute -->
        </select>
      </div>
    </div>

    <div class="row form-group boxed box-2">
      <label class="col-sm-4">
        Người giao mẫu
      </label>
      <div class="relative col-sm-8">
        <input type="text" class="form-control" id="form-insert-isender-employ" autocomplete="off">
        <div class="suggest" id="form-insert-isender-employ-suggest"></div>
      </div>
      <label class="col-sm-4">
        Bộ phận giao mẫu
      </label>
      <div class="relative col-sm-8">
        <input type="text" class="form-control" id="form-insert-isender-unit" autocomplete="off">
        <div class="suggest" id="form-insert-isender-unit-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Khách hàng
      </label>
      <div class="relative col-sm-10">
        <input type="text" class="form-control" id="form-insert-customer" autocomplete="off">
        <div class="suggest" id="form-insert-customer-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Địa chỉ
      </label>
      <div class="relative col-sm-10">
        <input type="text" class="form-control" id="form-insert-address">
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Số điện thoại
      </label>
      <div class="relative col-sm-10">
        <input type="text" class="form-control" id="form-insert-phone">
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Ngày lấy mẫu
      </label>
      <div class="relative col-sm-10">
        <input type="text" class="form-control" id="form-insert-sample-receive">
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Người lấy mẫu
      </label>
      <div class="relative col-sm-10">
        <input type="text" class="form-control" id="form-insert-sample-receiver" autocomplete="off">
        <div class="suggest" id="form-insert-sample-receiver-suggest"></div>
      </div>
    </div>
      
    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Ngày giờ nhận mẫu
      </label>
      <div class="relative col-sm-10">
        <input type="text" class="form-control" id="form-insert-sample-time">
      </div>
    </div>
      
    <div class="row form-group boxed box-2">
      <label class="col-sm-4">
        Người nhận mẫu
      </label>
      <div class="relative col-sm-8">
        <input type="text" class="form-control" id="form-insert-ireceiver-employ" autocomplete="off">
        <div class="suggest" id="form-insert-ireceiver-employ-suggest"></div>
      </div>
      <label class="col-sm-4">
        Bộ phận nhận mẫu
      </label>
      <div class="relative col-sm-8">
        <input type="text" class="form-control" id="form-insert-ireceiver-unit" autocomplete="off">
        <div class="suggest" id="form-insert-ireceiver-unit-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Ngày giờ xét nghiệm
      </label>
      <div class="relative col-sm-10">
        <input type="text" class="form-control" id="form-insert-exam-date">
      </div>
    </div>

    <div class="boxed box-1 box-2 box-3">
      <label> Loại mẫu </label>
      <div id="type-0">
        <input type="radio" name="type" class="check-box type" id="typed-0" checked>
        Nguyên con
      </div>
      <div id="type-1">
        <input type="radio" name="type" class="check-box type" id="typed-1">
        Huyết thanh
      </div>
      <div id="type-2">
        <input type="radio" name="type" class="check-box type" id="typed-2">
        Máu
      </div>
      <div id="type-3">
        <input type="radio" name="type" class="check-box type" id="typed-3">
        Phủ tạng
      </div>
      <div id="type-4">
        <input type="radio" name="type" class="check-box type" id="typed-4">
        Swab
      </div>
      <div class="form-group row">
        <label class="col-sm-4">
          <input type="radio" name="type" class="check-box type" id="typed-5">
          Khác
        </label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="form-insert-type-other">
        </div>
      </div>
      <div class="form-group row">
        <label class="col-sm-4"> Số lượng mẫu </label>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="form-insert-number">
        </div>
        <label class="col-sm-4"> Loài vật được lấy mẫu </label>
        <div class="col-sm-8">
          <input type="text" class="form-control sample" id="form-insert-sample">
        </div>
      </div>
      <div class="form-group row">
        <label class="col-sm-6"> Tình trạng </label>
        <div class="col-sm-18">
          <input type="text" class="form-control" id="form-insert-status">
        </div>
      </div>
      <div class="form-group row">
        <label class="col-sm-6"> Ký hiệu mẫu </label>
        <div class="col-sm-18" id="form-insert-sample-parent">
          <input type="text" class="form-control" id="form-insert-sample-code">
        </div>
      </div>
    </div>

    <div class="boxed box-2">
      <label> Hình thức bảo quản </label>
      <div>
        <input type="radio" name="status" class="check-box status" checked>
        Thùng đá
      </div>
      <div>
        <input type="radio" name="status" class="check-box status">
        Xe lạnh
      </div>
      <div>
        <input type="radio" name="status" class="check-box status">
        Phương tiện khác
      </div>
    </div>

    <div class="boxed box-2">
      <label class="6"> Chất lượng chung của mẫu </label>
      <div class="18">
        <input type="text" class="form-control" id="form-insert-quality">
      </div>
    </div>

    <div class="boxed box-1 box-2 box-3">
      <label>
        Yêu cầu xét nghiệm
        <button class="btn btn-success" onclick="insertMethod()"> <span class="glyphicon glyphicon-plus"></span> </button>
      </label>
      <div id="form-insert-request"></div>
      <button class="btn btn-success" onclick="addInfo(2)">
        <span class="glyphicon glyphicon-plus"></span>
      </button>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Yêu cầu khác
      </label>
      <div class="col-sm-20">
        <input type="text" class="form-control" id="form-insert-other">
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Kết quả
      </label>
      <div class="col-sm-20">
        <input type="text" class="form-control" id="form-insert-result">
      </div>
    </div>

    <div class="row form-group boxed box-3">
      <label class="col-sm-4">
        Mục đích xét nghiệm
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-target"></textarea>
      </div>
    </div>

    <div class="text-center">
      <button class="btn btn-success" onclick="insertSubmit()"> Lưu biểu mẫu </button>
    </div>

    <button class="btn btn-info saved" id="saved-2-1" style="position: fixed; top: 10px; right: 10px;" onclick="printer(1)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved" id="saved-2-2" style="position: fixed; top: 45px; right: 10px;" onclick="printer(2)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved" id="saved-2-3" style="position: fixed; top: 80px; right: 10px;" onclick="printer(3)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved" id="saved-2-4" style="position: fixed; top: 115px; right: 10px;" onclick="printer(4)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <!-- <button class="btn btn-info saved saved-3" style="position: fixed; top: 115px; right: 10px;" onclick="printer(4)">
      <span class="glyphicon glyphicon-print"></span>
    </button> -->

    <button class="btn btn-warning saved" id="saved-1-1" style="position: fixed; top: 10px; right: 50px;" onclick="parseBox(1)">
      <span class="glyphicon glyphicon-user"></span>
    </button>

    <button class="btn btn-warning saved" id="saved-1-2" style="position: fixed; top: 45px; right: 50px;" onclick="parseBox(2)">
      <span class="glyphicon glyphicon-user"></span>
    </button>

    <button class="btn btn-warning saved" id="saved-1-3" style="position: fixed; top: 80px; right: 50px;" onclick="parseBox(3)">
      <span class="glyphicon glyphicon-user"></span>
    </button>

    <button class="btn btn-warning saved" id="saved-1-4" style="position: fixed; top: 115px; right: 50px;" onclick="parseBox(4)">
      <span class="glyphicon glyphicon-user"></span>
    </button>

    <button class="btn btn-success saved-0" style="position: fixed; top: 150px; right: 10px;" onclick="newForm()">
      <span class="glyphicon glyphicon-user"></span>
    </button>

  </div>
</div>

<script>
  var style = '<style> body { margin: 0px; } .document { width: 730px; height: 1200px; border: 1px solid black; padding: 60px 60px 0px 100px; } .document * { font-family: "Times New Roman", Times, serif; font-size: 20px; } .text-center { text-align: center; } .text, .multiline-input, .border, .group, .inline { position: absolute; box-sizing: border-box; font-size: 18px; } .text, .group { width: max-content; } .text { overflow: hidden; } .border { border: 1px solid black; } table.form td { padding: 10px; } .form { border-collapse: collapse; width: 100%; } </style>'
  var former = {1: '<div class="document"> <div class="border" style="width: 150px; height: 100"></div> <div class="border" style="width: 580px; height: 100; left: 249px;"></div> <div class="text" style="width: 88px; text-align: center; left: 128px; top: 82px;"> CHI CỤC THÚ Y VÙNG V </div> <div class="text" style="left: 430px; top: 82px;"> <b>PHIẾU GIẢI QUYẾT HỒ SƠ</b> </div> <div class="text" style="left: 256px; top: 135px;">  <b>Số</b> <span class="input" id="code">(code)</span>/TYV5-TH </div> <div class="text" style="left: 105px; top: 180; width: 720px;"> Tên đơn vị: <span class="input" id="sender"> (sender) </span> </div> <div class="group" style="left: 105px; top: 210;"> <div class="text" style="width: 300px;">  Ngày nhận: <span class="input" id="receive"> (receive) </span> </div> <div class="text" style="left: 400px; width: 300px;">  Ngày hẹn trả kết quả: <span class="input" id="resend"> (resend) </span> </div> </div> <div class="group" style="left: 105px; top: 240;"> <div class="text">  Hình thức nhận: </div> <div class="group" style="left: 144px; width: 300px;"> <input type="checkbox" class="input" (state-0)> Trực tiếp </div> <div class="group" style="left: 300px; width: 300px;"> <input type="checkbox" class="input" (state-1)> Bưu điện </div> <div class="group" style="left: 450px; width: 300px;"> Khác: <span class="input"> (other) </span> </div> </div> <div class="text" style="left: 105px; top: 270; width: 730px;"> Người nhận hồ sơ: <span class="input" id="receiver"> (receiver) </span> </div> <div class="group" style="left: 105px; top: 300;"> <div class="text"> Phòng chuyên môn: </div> <div class="text" style="left: 200px; width: 300px;"> Ngày nhận:  <span class="input" id="ireceive"> (ireceive) </span> </div> <div class="text" style="left:450px; width: 300px;"> Ngày trả:  <span class="input" id="iresend"> (iresend) </span> </div> </div> <div class="border" style="left: 100px; top: 340; width: 730px; height: 330px;"> </div> <div class="text" style="left: 450; top: 350px;"> <u>Hồ sơ gồm:</u> </div> <div class="multiline-input" row="7" style="left: 110px; top: 380px; width: 700px; height: 280;">(form)</div> <div class="border" style="left: 100; top: 689px; width: 500; height: 30;">  </div> <div class="border" style="left: 599px; top: 689px; width: 230px; height: 30;"></div> <div class="border" style="left: 100; top: 718px; width: 500; height: 300px;"></div> <div class="border" style="left: 599px; top: 718px; width: 230; height: 300px;"></div> <div class="text" style="top: 695px; left: 115px;"> <b>Ý kiến của phòng, bộ phận chịu trách nhiệm giải quyết</b> </div> <div class="text" style="top: 695px; left: 610px;"> <b>Ý kiến của ban lãnh đạo</b> </div> <div class="text" style="top: 1030px; left: 100px; width: 730px;"> <i> <b> <u>Ghi chú:</u></b></i> Hồ sơ có ý kiếm của thủ trưởng (hoặc người được ủy quyền) phải được giao lại cho bộ phận một cửa trước 01 ngày so với ngày hẹn trả kết quả </div> <div class="text" style=" top: 1175px; left: 100px;"> Mã số: BM-02/TYV5-06 </div> <div class="text" style="top: 1175px; left: 400px;"> Ngày ban hành: 02/11/2017, </div> <div class="text" style="top: 1175px; left: 650px;"> Lần sửa đổi: 02 </div> </div>', 2: '<div class="document"> <div class="border" style="top: 115px; left: 50px; width: 300px; height: 45px;"></div> <div class="border" style="top: 110px; left: 140px; width: 93px;"></div> <div class="border" style="top: 110px; left: 496px; width: 242px;"></div> <div class="text" style="left: 140px; top: 60px;"> CỤC THÚ Y </div> <div class="text" style="left: 85px; top: 85px;"> <b>CHI CỤC THÚ Y VÙNG V</b></div> <div class="text" style="left: 410px; top: 60px;"> <b>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</b> </div> <div class="text" style="left: 495px; top: 85px;"> <b>Độc lập - Tự do - Hạnh phúc</b> </div> <div class="text" style="left: 60; top: 130px;"> Số ĐKXN: <span class="input"> (xcode-0) </span>/<span class="input">(xcode-1)</span>/<span class="input">(xcode-2)</span> </div> <div class="text" style="left: 430px; top: 130px;"> <i>Đắk Lắk, <span class="input">(receiveHour)</span> giờ, <span class="input">(receiveMinute)</span> p, ngày <span class="input">(receiveTime-0)</span> tháng <span class="input">(receiveTime-1)</span> năm <span class="input">(receiveTime-2)</span></i> </div> <div class="text" style="left: 230px; top: 190;"><b>BIÊN BẢN GIAO NHẬN MẤU XÉT NGHIỆM</b></div> <div class="text" style="left: 100; top: 225;"> <b>1/ Đại diện bên giao mẫu</b> </div>  <div class="text" style="left: 100; top: 255;"> - Họ và tên: <span class="input"> (isenderEmploy) </span> </div> <div class="text" style="left: 100; top: 285;"> (isenderUnit) </div> <div class="text" style="left: 100; top: 315;"><b>2/ Đại diện bên nhận mẫu:</b></div> <div class="text" style="left: 100; top: 345;"> - Họ và tên: <span class="input"> (ireceiverEmploy) </span> </div> <div class="text" style="left: 100; top: 375;"> (ireceiverUnit) </div> <div class="text" style="left: 200; top: 405;">* Điện thoại: 0262 3.877.795</div> <div class="text" style="left: 100; top: 435;"><b>3/ Thông tin về mẫu</b></div> <div class="group" style="left: 100; top: 475px;"> <div class="text"> - Loại mẫu: <span class="input"> (type) </span> </div> <div class="text" style="left: 330px;"> Loài vật được lấy mẫu: <span class="input"> (sample) </span> </div> </div> <div class="group" style="left: 100; top: 505px;"> <div class="text"> - Số lượng mẫu: <span class="input"> (number) </span> </div> <div class="text" style="left: 350px;"> Tình trạng mẫu: <span class="input"> (status) </span> </div> </div> <div class="text" style="left: 100; top: 535px; width: 730; height: 50px;"> - Ký hiệu mẫu: <span class="input"> (sampleCode) </span> </div> <div class="group" style="left: 100; top: 595px; width: 730px;"> * Ghi chú: (đính kèm danh sách nhận diện mẫu)  <span class="text" style="width: 100px; margin-left: 10px;"> có <input type="checkbox" class="input"> </span> <span class="text" style="width: 100px; left: 550px;"> không <input type="checkbox" class="input"> </span> </div> <div class="text" style="left: 60; top: 625px; width: 730px;">&ensp;&ensp;&ensp;&ensp;- Hình thức bảo quản, vận chuyển mẫu khi bàn giao (đề nghị gạch chéo vào một trong các ô sau đây)</div> <div class="group" style="left: 100; top: 685px;"> <div class="text" style="left: 50px;"> <input type="checkbox" (xstatus-0)> Thùng đá </div> <div class="text" style="left: 250px;"> <input type="checkbox" (xstatus-1)> Xe lạnh </div> <div class="text" style="left: 450px;"> <input type="checkbox" (xstatus-2)> Phương tiện khác </div> </div> <div class="group" style="left: 100; top: 745px;"> <div class="text" style="width: 730; height: 45px;"> - Chất lượng chung của mẫu khi bàn giao (dựa vào cảm quan để nhận xét) <span> <!-- input --> </span> </div> </div> <div class="text" style="left: 100; top: 770px;"> <b>4/ Yêu cầu xét nghiệm</b> </div> <div class="group" style="left: 100; top: 800px; width: 730px; height: 250px;"> (exam) </div> <div class="text" style="left: 60; top: 1055; width: 730;"> &ensp;&ensp;&ensp;&ensp;Biên bản kết thúc vào lúc <span class="input"></span>h <span class="input"></span>p cùng ngày; biên bản được lập thành  <span class="input"></span> bản; bên giao và nhận thống nhất ký vào biên bản (bên nhận mẫu giữ bản copy). </div> <div class="text" style="left: 115px; top: 1110px;"><b>XÁC NHẬN CỦA BÊN NHẬN MẪU</b></div> <div class="text" style="left: 151px; top: 1140px;"><i>(Ký xác nhận, ghi rõ họ tên)</i></div> <div class="text" style="left: 500px; top: 1110px;"><b>XÁC NHẬN CỦA BÊN GIAO MẪU</b></div> <div class="text" style="left: 535px; top: 1140px;"><i>(Ký xác nhận, ghi rõ họ tên)</i></div>  </div>', 3: '<div class="document">  <div class="border" style="top: 60px; left: 100px; width: 470; height: 60px;"></div> <div class="border" style="top: 60px; left: 569px; width: 260px; height: 60px;"></div> <div class="text" style="top: 63px; left: 220px;"><b>CHI CỤC THÚ Y VÙNG V</b></div> <div class="text" style="top: 90; left: 105px;"><b>TRẠM CHUẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT</b></div> <div class="text" style="top: 65; left: 572px;"><b>BIỂU MẪU SỐ: BM.STTT.02.02</b></div> <div class="text" style="top: 95; left: 615px;"><b>Số Soát xét: 03.02718</b></div> <div class="text" style="top: 130; left: 580;"> <i> Ngày <span class="input" id="1"></span> tháng <span class="input" id="2"></span> năm <span class="input" id="3"></span> </i> </div> <div class="text" style="top: 160; left: 400;"><b>PHIẾU YÊU CẦU XÉT NGHIỆM</b></div> <div class="border" style="top: 190px; left: 485px; width: 340px; height: 100;"></div> <div class="text" style="top: 200; left: 500;"> <b>Số ĐKXN:</b> <span class="input" id="4">(xcode-0)</span> / <span class="input" id="5">(xcode-1)</span> / <span class="input" id="6">(xcode-2)</span> </div> <div class="text" style="top: 230; left: 500;"> <b>Số trang:</b> <span class="input" id="7">(page-0)</span> / <span class="input" id="8">(page-1)</span> </div> <div class="text" style="top: 260; left: 500;"> <b>Liên: </b> <span class="input" id="9">(no-0)</span> / <span class="input" id="10">(no-1)</span> </div>  <div class="text" style="top: 310; left: 100;"> <b>Khách hàng:</b> <span class="input" id="11">(customer)</span> </div> <div class="group" style="top: 340; left: 100;"> <b>Loại mẫu:</b> <div class="text" style="left: 150; top: 0px;"> Nguyên con <input type="checkbox" class="input" id="12" (type-0)> </div> <div class="text" style="left: 280; top: 0px;"> Huyết thanh <input type="checkbox" class="input" id="13" (type-1)> </div> <div class="text" style="left: 420; top: 0px;"> Máu <input type="checkbox" class="input" id="14" (type-2)> </div> <div class="text" style="left: 520; top: 0px;"> Phù tạng <input type="checkbox" class="input" id="15" (type-3)> </div> <div class="text" style="left: 620; top: 0px;"> Swab <input type="checkbox" class="input" id="16" (type-4)> </div> </div> <div class="text" style="top: 370; left: 100;"> Khác: <span class="input" id="17"> (type-5) </span> </div> <div class="group" style="top: 400; left: 100;"> <div class="text"> <b>Số lượng mẫu: </b> <span class="input" id="18">(number)</span> </div> <div class="text" style="left: 400"> <b>- Loài vật được lấy mẫu:</b> <span class="input" id="19">(sample)</span> </div> </div> <div class="text" style="top: 430; left: 100; width: 730;"> <b>Số nhận diện: </b> <span class="inline input" id="20">(sampleCode)</span> </div>  <div class="group" style="top: 480px; left: 150px;"> * Ghi chú: (Đính kèm danh sách nhận diện mẫu): <div class="text" style="left: 370px; top: 0;"> - Có <input type="checkbox" class="input" id="21"> </div> <div class="text" style="left: 500; top: 0;"> - Không <input type="checkbox" class="input" id="22"> </div> </div>  <div class="text" style="top: 510; left: 100;"><b>Chỉ tiêu xét nghiệm</b></div> (exam)  <div class="text" style="top: (position); left: 100;">(index). <span class="input" id="23"></span> (exam-content) </div> <div class="text" style="top: (position-2); left: 100;"> Phương pháp xét nghiệm: <span class="input" id="24"> (method) </span> </div> <div class="text" style="top: (position-3); left: 100;"> Ký hiệu phương pháp: <span class="input" id="25"> (symbol) </span> </div> (/exam) <div class="text" style="top: 1000px; left: 100;"> <b>Các yêu cầu khác:</b> <span class="input" id="38"></span> </div> <div class="text" style="top: 1030; left: 100;"> Ngày nhận mẫu <span class="input" id="39"></span>/ <span class="input" id="40"></span>/ <span class="input" id="41"></span> </div> <div class="text" style="top: 1030; left: 550;"> Ngày hẹn trả kết quả: <span class="input" id="42"></span>/ <span class="input" id="43"></span>/ <span class="input" id="44"></span> </div> <div class="text" style="top: 1060; left: 250;"><b>Khách hàng</b></div> <div class="text" style="top: 1060; left: 650;"><b>Bộ phận nhận mẫu</b></div>', 4: '<div class="document"> <table border="1" class="form"> <tr> <td class="text-center"> <b>Biểu mẫu số: BM.STTT.22.01</b> </td> <td class="text-center"> <b>Số soát xét: 03.02718</b> </td> </tr> <tr> <td colspan="2"> <div class="text-center"> <b>CHI CỤC THÚ Y VÙNG V</b> </div> <div class="text-center"> <b>TRẠM CHUẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT</b> </div> <div> Địa chỉ: Số 36 Phạm Hùng, Phường Tân An, Thành phố Buôn Ma Thuột, Tỉnh Đăklăk </div> <div> Điện thoại: 0262 3877793 </div> </td> </tr> </table> <div class="text-center" style="margin: 10px;"> <b>PHIẾU KẾT QUẢ XÉT NGHIỆM</b> </div> <div style="margin: 4px;"> <div style="float: left"> Số phiếu kết quả xét nghiệm: xcode-0/xcode-1/xcode-2.CĐXN </div> <div style="float: right">Trang: 1/4</div> </div> <table border="1" class="form"> <tr> <td colspan="2"> Tên khách hàng: (customer) </td> <td style="width: 30%"> Số ĐKXN: xcode-0/xcode-1/xcode-2</td> </tr> <tr> <td colspan="3"> <div> Địa chỉ khách hàng: (address) </div> <div> Số điện thoại: (phone) </div> </td> </tr> <tr> <td colspan="3"> Loại mẫu: (type) </td> </tr> <tr> <td colspan="3"> Số lượng mẫu: (number) </td> </tr> <tr> <td colspan="3"> Ký hiệu mẫu: (sampleCode) </td> </tr> <tr> <td colspan="3"> Tình trạng khi nhận mẫu: (status) </td> </tr> <tr> <td style="width: 50%"> Ngày lấy mẫu: (sampleReceive) </td> <td colspan="2"> người lấy mẫu: (sampleReceiver) </td> </tr> <tr> <td style="width: 50%"> Ngày, giờ nhận mẫu: (ireceive)</td> <td colspan="2"> Người nhận mẫu: (ireceiver) </td> </tr> <tr> <td colspan="3">  <b>Chỉ tiêu xét nghiệm</b> <br> (exam)  <div>(index). (exam-content) </div> <div> Phương pháp xét nghiệm: (method); Ký hiệu phương pháp: (symbol). </div> (/exam) </td> </tr> <tr> <td colspan="3"> Ngày phân tích: (examDate) </td> </tr> <tr> <td colspan="3"> <b> Kết quả: </b> <br> (result) </td> </tr> </table> <table style="width: 100%"> <tr> <td class="text-center"> Ngày tháng năm </td> <td class="text-center"> Ngày tháng năm </td> </tr> <tr> <td class="text-center"> <b>BỘ PHẬN XÉT NGHIỆM</b> </td> <td class="text-center"> <b>TRƯỞNG TRẠM</b> </td> </tr> <tr> <td class="text-center"> (Ký, ghi rõ họ tên) </td> </tr> </table> </div>'};
  var methodModal = $("#method-modal")
  var formInsert = $('#form-insert')
  var method = JSON.parse('{method}')
  var remind = JSON.parse('{remind}')
  var relation = JSON.parse('{relation}')
  var menu1 = $("#menu1")
  var content = $("#content")
  var formRemove = $("#form-remove")
  var formInsertCode = $("#form-insert-code")
  var formInsertReceiverState = $("#form-insert-receive-state")
  var formInsertReceiverState2 = $("#form-insert-receive-state2")
  var formInsertReceiverState3 = $("#form-insert-receive-state3")
  var formInsertReceiverStateOther = $("#form-insert-receive-state-other")
  var formInsertRequest = $("#form-insert-request")
  var formInsertReceive = $("#form-insert-receive")
  var formInsertResend = $("#form-insert-resend")
  var formInsertIreceive = $("#form-insert-ireceive")
  var formInsertIresend = $("#form-insert-iresend")
  var formInsertNumber = $("#form-insert-number")
  var formInsertSample = $("#form-insert-sample")
  var formInsertStatus = $("#form-insert-status")
  var formInsertSampleCode = $("#form-insert-sample-code")
  var formInsertSampleParent = $("#form-insert-sample-parent")
  var formInsertOther = $("#form-insert-other")
  var formInsertResult = $("#form-insert-result") 
  var formInsertTypeOther = $("#form-insert-type-other") 

  var formInsertSenderUnit = $("#form-insert-sender-unit")
  var formInsertSenderUnitSuggest = $("#form-insert-sender-unit-suggest")
  var formInsertSenderEmploy = $("#form-insert-sender-employ")
  var formInsertSenderEmploySuggest = $("#form-insert-sender-employ-suggest")
  var formInsertReceiverUnit = $("#form-insert-receiver-unit")
  var formInsertReceiverUnitSuggest = $("#form-insert-receiver-unit-suggest")
  var formInsertReceiverEmploy = $("#form-insert-receiver-employ")
  var formInsertReceiverEmploySuggest = $("#form-insert-receiver-employ-suggest")
  var formInsertSamplerUnit = $("#form-insert-sampler-unit")
  var formInsertSamplerUnitSuggest = $("#form-insert-sampler-unit-suggest")
  var formInsertSamplerEmploy = $("#form-insert-sampler-employ")
  var formInsertSamplerEmploySuggest = $("#form-insert-sampler-employ-suggest")

  var formInsertIsenderEmploy = $("#form-insert-isender-employ")
  var formInsertIsenderEmploySuggest = $("#form-insert-isender-employ-suggest")
  var formInsertIreceiverEmploy = $("#form-insert-ireceiver-employ")
  var formInsertIreceiverEmploySuggest = $("#form-insert-ireceiver-employ-suggest")

  var formInsertIsenderUnit = $("#form-insert-isender-unit")
  var formInsertIsenderUnitSuggest = $("#form-insert-isender-unit-suggest")
  var formInsertIreceiverUnit = $("#form-insert-ireceiver-unit")
  var formInsertIreceiverUnitSuggest = $("#form-insert-ireceiver-unit-suggest")
  var formInsertSampleReceiver = $("#form-insert-sample-receiver")
  var formInsertSampleReceiverSuggest = $("#form-insert-sample-receiver-suggest")
  var formInsertSampleReceive = $("#form-insert-sample-receive")
  var formInsertSampleTime = $("#form-insert-sample-time")

  var formInsertCustomer = $("#form-insert-customer")
  var formInsertCustomerSuggest = $("#form-insert-customer-suggest")
  var formInsertPhone = $("#form-insert-phone")
  var formInsertAddress = $("#form-insert-address")

  var formInsertSampleReceiveTime = $("#form-insert-sample-receive-time")
  var formInsertSampleReceiveHour = $("#form-insert-sample-receive-hour")
  var formInsertSampleReceiveMinute = $("#form-insert-sample-receive-minute")
  var formInsertExamDate = $("#form-insert-exam-date")
  var formInsertTarget = $("#form-insert-target")

  var formInsertXcode1 = $("#form-insert-xcode-1")
  var formInsertXcode2 = $("#form-insert-xcode-2")
  var formInsertXcode3 = $("#form-insert-xcode-3")
  var formInsertNo1 = $("#form-insert-page-1")
  var formInsertNo2 = $("#form-insert-page-2")
  var formInsertPage1 = $("#form-insert-no-1")
  var formInsertPage2 = $("#form-insert-no-2")
  var formInsertQuality = $("#form-insert-quality")

  var formInsertInfo = $("#form-insert-info")
  var formInsertForm = $("#form-insert-form")
  var formInsertRequest = $("#form-insert-request")

  var filterLimit = $("#filter-limit")
  var filterPrinter = $("#filter-printer")
  var filterKeyword = $("#filter-keyword")

  var insertMethodSymbol = $("#insert-method-symbol")
  var insertMethodName = $("#insert-method-name")

  var global_form = 1
  var global_saved = 0
  var global_id = 0
  var global_page = 1

  var visible = {
    0: {1: '1', 2: ''},
    1: {1: '1, 2', 2: '1'},
    2: {1: '1, 2, 3', 2: '1, 2'},
    4: {1: '1, 2, 3, 4', 2: '1, 2, 3, 4, 5'}
  }
  var dataPicker = {'form': 1, 'exam': 2}
  var rdataPicker = {'1': 'form', '2': 'exam'}
  var infoData = {1: [], 2: []}
  var remindData = {}
  var globalTarget = {
    'sender-unit': {
      input: formInsertSenderUnit,
      suggest: formInsertSenderUnitSuggest,
      data: 1,
      name: 'value'
    },
    'sender-employ': {
      input: formInsertSenderEmploy,
      suggest: formInsertSenderEmploySuggest,
      data: 2,
      name: 'value'
    },
    'receiver-unit': {
      input: formInsertReceiverUnit,
      suggest: formInsertReceiverUnitSuggest,
      data: 2,
      name: 'value'
    },
    'receiver-employ': {
      input: formInsertReceiverEmploy,
      suggest: formInsertReceiverEmploySuggest,
      data: 1,
      name: 'value'
    },
    'sampler-unit': {
      input: formInsertSamplerUnit,
      suggest: formInsertSamplerUnitSuggest,
      data: 2,
      name: 'value'
    },
    'sampler-employ': {
      input: formInsertSamplerEmploy,
      suggest: formInsertSamplerEmploySuggest,
      data: 1,
      name: 'value'
    },
    'ireceiver-unit': {
      input: formInsertIreceiverUnit,
      suggest: formInsertIreceiverUnitSuggest,
      data: 2,
      name: 'value'
    },
    'ireceiver-employ': {
      input: formInsertIreceiverEmploy,
      suggest: formInsertIreceiverEmploySuggest,
      data: 1,
      name: 'value'
    },
    'isender-unit': {
      input: formInsertIsenderUnit,
      suggest: formInsertIsenderUnitSuggest,
      data: 2,
      name: 'value'
    },
    'isender-employ': {
      input: formInsertIsenderEmploy,
      suggest: formInsertIsenderEmploySuggest,  
      data: 1,
      name: 'value'
    },
    'customer': {
      input: formInsertCustomer,
      suggest: formInsertCustomerSuggest,
      data: 3,
      name: 'value'
    },
    'sample-receiver': {
      input: formInsertSampleReceiver,
      suggest: formInsertSampleReceiverSuggest,
      data: 1,
      name: 'value'
    }
  }

  $(document).ready(() => {
    htmlInfo = formInsertInfo.html()
    addInfo(1)
    addInfo(2)
    installRemind('sender-unit');
    installRemind('sender-employ');
    installRemind('receiver-unit');
    installRemind('receiver-employ');
    installRemind('sampler-unit');
    installRemind('sampler-employ');

    installRemind('ireceiver-employ');
    installRemind('ireceiver-unit');
    installRemind('isender-employ');
    installRemind('isender-unit');
    installRemind('sample-receiver');
    parseBox(1)
    parseSaved()
  })

  $("#form-insert-receive, #form-insert-resend, #form-insert-ireceive, #form-insert-iresend, #form-insert-sample-receive, #form-insert-sample-time, #form-insert-exam-date").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  $('.printer-x').change(() => {
    var list = []
    $('.printer-x').each((index, item) => {
      if (item.children[0].checked) {
        list.push(item.innerText)
      }
    })
    filterPrinter.val(list.join(', '))
  })

  function clearFilterPrinter() {
    $('.printer-x').each((index, item) => {
      item.children[0].checked = false
    })
    filterPrinter.val('')
  }

  function parseSample() {
    formInsertCode.val('TY-5')
    formInsertSenderEmploy.val('Phùng chí kiên')
    formInsertReceiverEmploy.val('Mai thị lựu')
    formInsertReceive.val('25/11/2018')
    formInsertResend.val('28/11/2018')
    formInsertIreceive.val('25/11/2018')
    formInsertIresend.val('29/11/2018')
    addInfo(1)
    $(".form")[0].value = 'Mẫu'
    $(".form")[1].value = 'Phiếu'
    formInsertNumber.val(1)
    formInsertSample.val("Chó")
    formInsertStatus.val("Tốt")
    formInsertSampleCode.val("GD-05")
    addInfo(2)
    $(".exam")[0].value = 'Phát hiện virus H5N1'
    $(".exam")[1].value = 'Phát hiện virus H1N1'
  }

  function parseSample2() {
    parseSample()
    $(".xcode")[0].value = '25'
    $(".xcode")[1].value = '19'
    $(".xcode")[2].value = '013'
    formInsertSampleReceiveTime.val('25/11/1996')
    formInsertIsenderEmploy.val('Mai Thị Lựu')
    formInsertIsenderUnit.val('Phòng tổng hợp')
    formInsertIreceiverEmploy.val('Lưu Trọng Khoan')
    formInsertIreceiverUnit.val('Phòng xét nghiệm')
    formInsertQuality.val('Đạt')
  }

  function parseSample3() {
    parseSample()
    parseSample2()
    $(".page")[0].value = '01'
    $(".page")[1].value = '01'
    $(".no")[0].value = '01'
    $(".no")[1].value = '02'
    formInsertExamDate.val('11/05/2019')
    formInsertCustomer.val('Bộ thông tin và truyền thông')
    formInsertOther.val('Không')
    formInsertResult.val('Toàn bộ đều nhiễm bệnh sắp chết cmnr')
  }

  function parseBox(index) {
    if (index - 1 <= global_saved) {
      global_form = index
      $(".boxed").hide()
      $(".box-" + index).show()
    }
  }

  function parseSaved() {
    $(".saved").addClass('disabled')
    
    $(".saved").each((index, item) => {
      var id = item.getAttribute('id').replace('saved-', '')
      var pos = id.split('-')
      
      if (visible[global_saved][pos[0]].search(pos[1]) >= 0) {
        $("#saved-" + id).removeClass('disabled')
      }
    })
  }

  function selectRemind(name, selectValue) {
    globalTarget[name]['input'].val(selectValue)
  }

  function insertMethod() {
    methodModal.modal('show')
  }

  function insertMethodSubmit(e) {
    e.preventDefault()
    if (insertMethodName.val().length > 0 && insertMethodSymbol.val().length > 0) {
      $.post(
        strHref,
        {action: 'insertMethod', name: insertMethodName.val(), symbol: insertMethodSymbol.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            $('.method').each((index, item) => {
              item.innerHTML = data['html']
              
              addInfo = (id) => {
                var length = infoData[id].length
                switch (id) {
                  case 1:
                    var html = `
                      <div class="formed" id="form-` + length + `">
                        <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(1, ` + length + `)">&times;</button>
                        <br>
                        <div class="row">
                          <label class="col-sm-4"> Tên hồ sơ </label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control input-box form" id="formed-` + length + `">
                          </div>
                        </div>
                      </div>`
                          
                      formInsertForm.append(html)
                    break;
                  case 2:
                  var html = `
                      <div class="examed" id="exam-` + length + `">
                        <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(2, ` + length + `)">&times;</button>
                        <br>
                        <div class="row">
                          <label class="col-sm-4"> Yêu cầu </label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control input-box exam" id="examed-` + length + `">
                          </div>
                          <div class="input-group">
                            <select class="form-control input-box method" id="method-` + length + `">
                              `+data['html']+`
                            </select>
                          </div>
                        </div>
                      </div>`
                    formInsertRequest.append(html)
                    break;
                }
                infoData[id].push(html)
              }
            })
          })
        }
      )
    }
    else {
      alert_msg('Chưa điền đủ thông tin')
    }
  }

  function installRemind(name) {
    var timeout
    globalTarget[name]['input'].keyup(() => {
      clearTimeout(timeout)
      setTimeout(() => {
        var key = paintext(globalTarget[name]['input'].val())
        var html = ''
        for (const index in remind[globalTarget[name]['data']]) {
          if (remind[globalTarget[name]['data']].hasOwnProperty(index)) {
            const element = paintext(remind[globalTarget[name]['data']][index]['value']);
            
            if (element.search(key) >= 0) {
              html += '<div class="item_suggest" onclick="selectRemind(\'' + name + '\', \'' + remind[globalTarget[name]['data']][index]['value'] + '\')"><span class="right-click">' + remind[globalTarget[name]['data']][index]['value'] + '</span><button class="close right" data-dismiss="modal" onclick="removeRemind('+remind[globalTarget[name]['data']][index]['id']+', \''+name+'\')">&times;</button></div>'
            }
          }
        }
        globalTarget[name]['suggest'].html(html)
      }, 200);
    })
    globalTarget[name]['input'].focus(() => {
      globalTarget[name]['suggest'].show()
    })
    globalTarget[name]['input'].blur(() => {
      setTimeout(() => {
        globalTarget[name]['suggest'].hide()
      }, 200);
    })
  }

  function removeRemind(id, name) {
    if (id) {
      $.post(
        strHref,
        {action: 'removeRemind', id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            remind = JSON.parse(data['remind'])
            globalTarget[name][input].val('')
          }, () => {})
        }
      )
    }
  }

  function newForm() {
    global_id = 0
    global_form = 1
    global_saved = 0
    formInsertCode.val('')
    formInsertSenderEmploy.val('')
    formInsertReceiverEmploy.val('')
    formInsertReceive.val('')
    formInsertResend.val('')
    formInsertIreceive.val('')
    formInsertIresend.val('')
    formInsertNumber.val('')
    formInsertSample.val('')
    formInsertStatus.val('')
    formInsertSampleCode.val('')
    formInsertTarget.val('')
    // parseInputs(data, 'exam')
    // parseInputs(data, 'form')
    $(".formed").each((index, item) => {
      removeInfo(1, index)
    })
    $(".examed").each((index, item) => {
      removeInfo(2, index)
    })
    infoData = {1: [], 2: []}
    addInfo(1)
    addInfo(2)
    $(".type").prop('checked', false)
    $(".state").prop('checked', false)

    $("#typed-0").prop('checked', true)
    $("#state-0").prop('checked', true)
    formInsertReceiverStateOther.val('')
    formInsertTypeOther.val('')

    // var xcode = data['form']['xcode'].split(',')
    // formInsertXcode1.val(xcode[0])
    // formInsertXcode2.val(xcode[1])
    // formInsertXcode3.val(xcode[2])
    // formInsertSample.val(data['form']['sample'])
    // formInsertStatus.val(data['form']['status'])
    // formInsertSampleCode.val(data['form']['sampleCode'])
    // formInsertSampleReceiveTime.val(data['form']['receiveTime'])
    // formInsertSampleReceiveHour.val(data['form']['receiveTime'])
    // formInsertSampleReceiveMinute.val(data['form']['receiveTime'])
    // formInsertIsenderEmploy.val(data['form']['IsenderEmploy'])
    // formInsertIsenderUnit.val(data['form']['IsenderUnit'])
    // formInsertIreceiverEmploy.val(data['form']['IreceiverEmploy'])
    // formInsertIreceiverUnit.val(data['form']['IreceiverUnit'])
    // formInsertQuality.val(data['form']['Quality'])

    // var page = data['form']['page'].split(',')
    // var no = data['form']['no'].split(',')
    // formInsertPage1.val(page[0])
    // formInsertPage2.val(page[1])
    // formInsertNo1.val(no[0])
    // formInsertNo2.val(no[1])
    // formInsertReceiverEmploy.val(data['form']['ReceiverEmploy'])
    // formInsertIreceive.val(data['form']['Ireceive'])
    // formInsertIresend.val(data['form']['Iresend'])
    // formInsertExamDate.val(data['form']['ExamDate'])
    // formInsertCustomer.val(data['form']['Customer'])
    // formInsertOther.val(data['form']['Other'])
    // formInsertResult.val(data['form']['Result'])
  }

  function edit(id) {
    $.post(
      strHref,
      {action: 'getForm', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          newForm()
          global_id = id
          global_form = 1
          global_saved = data['form']['printer']
          parseSaved()
          console.log(data['form']['printer']);
          
          parseBox(data['form']['printer'])
          infoData = {1: [], 2: []}

          if (data['form']['printer'] >= 1) {
            formInsertCode.val(data['form']['code'])
            formInsertSenderEmploy.val(data['form']['sender'])
            formInsertReceiverEmploy.val(data['form']['receiver'])
            formInsertReceive.val(data['form']['receive'])
            formInsertResend.val(data['form']['resend'])
            formInsertIreceive.val(data['form']['ireceive'])
            formInsertIresend.val(data['form']['iresend'])
            formInsertNumber.val(data['form']['number'])
            formInsertSample.val(data['form']['sample'])
            formInsertStatus.val(data['form']['status'])
            formInsertSampleCode.val(data['form']['samplecode'])
            parseInputs(data, 'exam')
            parseInputs(data, 'form')
            $("#typed-" + data['form']['typeindex']).attr('checked', true)
            $("#state-" + data['form']['stateindex']).attr('checked', true)
            formInsertReceiverStateOther.val(data['form']['statevalue'])
            formInsertTypeOther.val(data['form']['typevalue'])
          }

          if (data['form']['printer'] >= 2) {
            var xcode = data['form']['xcode'].split(',')
            formInsertXcode1.val(xcode[0])
            formInsertXcode2.val(xcode[1])
            formInsertXcode3.val(xcode[2])
            formInsertSampleReceiveTime.val(data['form']['receivetime'])
            for (const key in formInsertSampleReceiveHour[0].children) {
              if (formInsertSampleReceiveHour[0].children.hasOwnProperty(key)) {
                if (key == data['form']['receivehour']) { 
                  formInsertSampleReceiveHour[0].children[key].setAttribute('selected', true)
                }
                else {
                  formInsertSampleReceiveHour[0].children[key].removeAttribute('selected')
                }
              }
            }
            for (const key in formInsertSampleReceiveMinute[0].children) {
              if (formInsertSampleReceiveMinute[0].children.hasOwnProperty(key)) {
                if (key == data['form']['receiveminute']) {
                  formInsertSampleReceiveMinute[0].children[key].setAttribute('selected', true)
                }
                else {
                  formInsertSampleReceiveMinute[0].children[key].removeAttribute('selected')
                }
              }
            }
            formInsertIsenderEmploy.val(data['form']['isenderemploy'])
            formInsertIsenderUnit.val(data['form']['isenderunit'])
            formInsertIreceiverEmploy.val(data['form']['ireceiveremploy'])
            formInsertIreceiverUnit.val(data['form']['ireceiverunit'])
            formInsertQuality.val(data['form']['quality'])
          }

          if (data['form']['printer'] >= 3) {
            var page = data['form']['page'].split(',')
            var no = data['form']['no'].split(',')

            formInsertPage1.val(page[0])
            formInsertPage2.val(page[1])
            formInsertNo1.val(no[0])
            formInsertNo2.val(no[1])

            formInsertExamDate.val(data['form']['examDate'])
            formInsertCustomer.val(data['form']['customer'])
            formInsertOther.val(data['form']['other'])
            formInsertResult.val(data['form']['result'])

            formInsertAddress.val(data['form']['address'])
            formInsertPhone.val(data['form']['phone'])
            formInsertSampleReceive.val(data['form']['samplereceive'])
            formInsertSampleReceiver.val(data['form']['samplereceiver'])
            formInsertSampleTime.val(data['form']['sampletime'])
            formInsertExamDate.val(data['form']['examdate'])
            formInsertTarget.html(data['form']['target'].replace(/<br\s*[\/]?>/gi, "\n"))
          }
          
          $('a[href="#menu1"]').tab('show')
        }, () => {})
      }
    )
  }

  function parseInputs(data, name) {
    $("." + name + "ed").remove()
    
    var array = data['form'][name].split(', ')
    if (data['form']['method']) {
      method = data['form']['method'].split(', ')
    }
    array.forEach((element, index) => {
      addInfo(dataPicker[name])
      if (dataPicker[name] == 1) {
        $("#formed-" + index).val(element)
      }
      else {
        $("#examed-" + index).val(element)
        var method = data['form']['method'].split(', ')
        var child = $("#method-" + index)[0].children
        for (const key in child) {
          if (child.hasOwnProperty(key)) {
            const item = child[key];
            var id = item.value

            if (id == method[index]) {
              item.setAttribute('selected', true)
            }
          }
        }
      }
    });
  }

  function insert() {
    formInsert.modal('show')
  }

  function addInfo(id) {
    var length = infoData[id].length
    switch (id) {
      case 1:
        var html = `
          <div class="formed" id="form-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(1, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-4"> Tên hồ sơ </label>
              <div class="col-sm-10">
                <input type="text" class="form-control input-box form" id="formed-` + length + `">
              </div>
            </div>
          </div>`
              
          formInsertForm.append(html)
        break;
      case 2:
      var html = `
          <div class="examed" id="exam-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(2, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-4"> Yêu cầu </label>
              <div class="col-sm-10">
                <input type="text" class="form-control input-box exam" id="examed-` + length + `">
              </div>
              <div class="input-group">
                <select class="form-control input-box method" id="method-` + length + `">
                  {methodOption}
                </select>
              </div>
            </div>
          </div>`
        formInsertRequest.append(html)
        break;
    }
    infoData[id].push(html)
  }

  function removeInfo(id, index) {
    switch (id) {
      case 1:
        $("#form-" + index).remove()
        break;
      case 2:
        $("#exam-" + index).remove()
        break;
    }
  }

  function gatherInput(className) {
    var data = []
    $("." + className).each((index, item) => {
      data.push(item.value)
    })
    return data
  }

  function getCheckbox(name, target = null) {
    var check = 0
    var count = 0
    $(".check-box." + name).each((index, item) => {
      count = index
      if (item.checked) {
        check = index
      }
    })    
    if (check == count && target) {
      return {index: check, value: target.val()}
    } 
    return {index: check, value: ''}
  }

  function getInputs(name, tag = '') {
    var list = []
    $(".input-box." + name).each((index, item) => {
      var row = item.value
      if (tag) {
        row = (index + 1) + tag + row
      }
      list.push(row)
    })    
    return list
  }

  function checkSampleCode(target, parent, number = 1) {
    var value = trim(target.val())
    while (value.search('  ') >= 0) {
      value = value.replace(/  /g, ' ')
    }
    value = value.split(/,/g)
    target.val(value.join(', '))
    
    if (value.length != number) {
      parent.addClass('has-error')
      return 0
    }
    parent.removeClass('has-error')
    return 1
  }

  function remove(id) {
    formRemove.modal('show')
    global_id = id
  }

  function removeSubmit() {
    freeze()
    $.post(
      strHref, 
      {action: 'remove', id: global_id, page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          formRemove.modal('hide')
        }, () => {})
      }
    )
  }

  function checkForm(id) {
    var data = {}
    switch (id) {
      case 1:
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            code: formInsertCode.val(),
            sender: formInsertSenderEmploy.val(),
            receive: formInsertReceive.val(),
            resend: formInsertResend.val(),
            state: getCheckbox('state', formInsertReceiverStateOther),
            receiver: formInsertReceiverEmploy.val(),
            ireceive: formInsertIreceive.val(),
            iresend: formInsertIresend.val(),
            type: getCheckbox('type', formInsertTypeOther),
            sample: formInsertSample.val(),
            status: formInsertStatus.val(),
            number: formInsertNumber.val(),
            form: getInputs('form', ') '),
            exam: getInputs('exam', ') '),
            forms: getInputs('form'),
            exams: getInputs('exam'),
            methods: getInputs('method'),
            sampleCode: formInsertSampleCode.val()
          }
        }
      break;
      case 2: 
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            xcode: getInputs('xcode'),
            receiveTime: formInsertSampleReceiveTime.val(),
            receiveHour: formInsertSampleReceiveHour.val(),
            receiveMinute: formInsertSampleReceiveMinute.val(),
            isenderEmploy: formInsertIsenderEmploy.val(),
            isenderUnit: formInsertIsenderUnit.val(),
            ireceiverEmploy: formInsertIreceiverEmploy.val(),
            ireceiverUnit: formInsertIreceiverUnit.val(),
            type: getCheckbox('type', formInsertTypeOther),
            sample: formInsertSample.val(),
            number: formInsertNumber.val(),
            status: formInsertStatus.val(),
            sampleCode: formInsertSampleCode.val(),
            xstatus: getCheckbox('status'),
            quality: formInsertQuality.val(),
            exam: getInputs('exam', ') '),
            method: getInputs('method'),
            exams: getInputs('exam'),
            methods: getInputs('method'),
          }
        }
      break;
      case 3:
      case 4:
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            xcode: getInputs('xcode'),
            page: getInputs('page'),
            no: getInputs('no'),
            sampleTime: formInsertSampleTime.val(),
            examDate: formInsertExamDate.val(),
            sample: formInsertSample.val(),
            other: formInsertOther.val(),
            receiveTime: formInsertSampleReceiveTime.val(),
            receiveHour: formInsertSampleReceiveHour.val(),
            receiveMinute: formInsertSampleReceiveMinute.val(),
            customer: formInsertCustomer.val(),
            address: formInsertAddress.val(),
            phone: formInsertPhone.val(),
            type: getCheckbox('type'),
            number: formInsertNumber.val(),
            sampleCode: formInsertSampleCode.val(),
            status: formInsertStatus.val(),
            sampleReceive: formInsertSampleReceive.val(),
            sampleReceiver: formInsertSampleReceiver.val(),
            ireceive: formInsertIreceive.val(),
            ireceiver: formInsertIreceiverEmploy.val(),
            exam: getInputs('exam'),
            method: getInputs('method'),
            exams: getInputs('exam'),
            methods: getInputs('method'),
            examDate: formInsertExamDate.val(),
            result: formInsertResult.val(),
            target: formInsertTarget.val()
          }
        }
      break;
    }
    return data
  }

  function insertSubmit() {
    freeze()
    var data = checkForm(global_form)
    if (Object.keys(data).length) {
      $.post(
        strHref,
        {action: 'insert', form: global_form, id: global_id, data: data, page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            global_saved = global_form
            parseSaved()
            global_id = data['id']
          }, () => {})
        }
      )
    }
  }

  function filter(e) {
    e.preventDefault()
    freeze()
    $.post(
      strHref,
      {action: 'filter', page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
        }, () => {})
      }
    )
  }

  function goPage(page) {
    freeze()
    $.post(
      strHref,
      {action: 'filter', page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global_page = page
          content.html(data['html'])
        }, () => {})
      }
    )
  }

  function printer(id) {
    // if (visible[global_saved][2].search(id) >= 0) {
      var data = checkForm(id)
      if (Object.keys(data).length) {
        var html = former[id]
        switch (id) {
          case 1:
            html = html.replace('(code)', data['code'])
            html = html.replace('(sender)', data['sender'])
            html = html.replace('(receiver)', data['receiver'])
            html = html.replace('(receive)', data['receive'])
            html = html.replace('(resend)', data['resend'])
            html = html.replace('(ireceive)', data['ireceive'])
            html = html.replace('(iresend)', data['iresend'])
            html = html.replace('(state-0)', data['state']['index'] == 0 ? 'checked' : '')
            html = html.replace('(state-1)', data['state']['index'] == 1 ? 'checked' : '')
            html = html.replace('(other)', data['state']['value'])
            html = html.replace('(form)', (data['form'].join('<br>') + '<br>Số lượng mẫu: ' + data['number'] + '<br>' + data['exam'].join('<br>')))
          break;
          case 2:
            var receiveTime = data['receiveTime'].split('/')
            html = html.replace('(xcode-0)', data['xcode'][0])
            html = html.replace('(xcode-1)', data['xcode'][1])
            html = html.replace('(xcode-2)', data['xcode'][2])
            html = html.replace('(receiveTime-0)', receiveTime[0])
            html = html.replace('(receiveTime-1)', receiveTime[1])
            html = html.replace('(receiveTime-2)', receiveTime[2])
            html = html.replace('(receiveHour)', data['receiveHour'])
            html = html.replace('(receiveMinute)', data['receiveMinute'])
            html = html.replace('(isenderEmploy)', data['isenderEmploy'])
            html = html.replace('(isenderUnit)', data['isenderUnit'])
            html = html.replace('(ireceiverEmploy)', data['ireceiverEmploy'])
            html = html.replace('(ireceiverUnit)', data['ireceiverUnit'])
            html = html.replace('(type)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('(sample)', data['sample'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['sampleCode'])
            html = html.replace('(status)', data['status'])
            html = html.replace('(quality)', data['quality'])
            html = html.replace('(xstatus-0)', data['xstatus']['index'] == 0 ? 'checked' : '')
            html = html.replace('(xstatus-1)', data['xstatus']['index'] == 1 ? 'checked' : '')
            html = html.replace('(xstatus-2)', data['xstatus']['index'] == 2 ? 'checked' : '')
            html = html.replace('(exam)', (data['exam'].join('<br>')))          
          break;
          case 3:
            html = html.replace('(xcode-0)', data['xcode'][0])
            html = html.replace('(xcode-1)', data['xcode'][1])
            html = html.replace('(xcode-2)', data['xcode'][2])
            html = html.replace('(page-0)', data['page'][0])
            html = html.replace('(page-1)', data['page'][1])
            html = html.replace('(no-0)', data['no'][0])
            html = html.replace('(no-1)', data['no'][1])
            html = html.replace('(customer)', data['customer'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['sampleCode'])
            html = html.replace('(type-0)', data['type']['index'] == 0 ? 'checked' : '')
            html = html.replace('(type-1)', data['type']['index'] == 1 ? 'checked' : '')
            html = html.replace('(type-2)', data['type']['index'] == 2 ? 'checked' : '')
            html = html.replace('(type-3)', data['type']['index'] == 3 ? 'checked' : '')
            html = html.replace('(type-4)', data['type']['index'] == 4 ? 'checked' : '')
            html = html.replace('(type-5)', data['type']['value'])
            html = html.replace('(other)', data['other'])
            var length = data['exam'].length
            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var position = 540
            var parse = ''
            for (let i = 0; i < length; i++) {
              var temp = part 
              temp = temp.replace('(index)', i + 1)
              temp = temp.replace('(position)', position + "px")
              temp = temp.replace('(position-2)', position + 30 + "px")
              temp = temp.replace('(position-3)', position + 60 + "px")
              temp = temp.replace('(exam-content)', data['exam'][i])
              temp = temp.replace('(method)', trim($("#method-" + i).text()))
              temp = temp.replace('(symbol)', data['method'][i])
              parse += temp
              position += 90
            }
            html = html.replace('(parse)', parse)
            html = html.replace('(type-5)', data['type']['value'])
          break; 
          case 4:
            var receiveTime = data['receiveTime'].split('/')
            html = html.replace(/xcode-0/g, data['xcode'][0])
            html = html.replace(/xcode-1/g, data['xcode'][1])
            html = html.replace(/xcode-2/g, data['xcode'][2])
            html = html.replace('(customer)', data['customer'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['sampleCode'])

            html = html.replace('(receiveTime)', data['receiveTime'])
            html = html.replace('(receiveHour)', data['receiveHour'])
            html = html.replace('(receiveMinute)', data['receiveMinute'])
            html = html.replace('(address)', data['address'])
            html = html.replace('(phone)', data['phone'])
            html = html.replace('(type)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('(status)', data['status'])
            html = html.replace('(sampleReceive)', data['sampleReceive'])
            html = html.replace('(sampleReceiver)', data['sampleReceiver'])
            html = html.replace('(ireceive)', data['ireceive'])
            html = html.replace('(ireceiver)', data['ireceiver'])
            html = html.replace('(examDate)', data['examDate'])
            html = html.replace('(result)', data['result'])

            var length = data['exam'].length
            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var parse = ''
            for (let i = 0; i < length; i++) {
              var temp = part 
              temp = temp.replace('(index)', i + 1)
              temp = temp.replace('(exam-content)', data['exam'][i])
              temp = temp.replace('(method)', trim($("#method-" + i).text()))
              temp = temp.replace('(symbol)', data['method'][i])
              parse += temp
            }
            html = html.replace('(parse)', parse)
          break;
        }
        var html = style + html
        var winPrint = window.open('', '', 'left=0,top=0,width=800,height=600,toolbar=0,scrollbars=0,status=0');
        winPrint.focus()
        winPrint.document.write(html);
        winPrint.print()
        winPrint.close()
      }
    // }
  }
</script>
<!-- END: main -->