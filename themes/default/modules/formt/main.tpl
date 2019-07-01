<!-- BEGIN: main -->
<style>
  .right {
    overflow: auto;
  }
  .right-click {
    float: left;
    overflow: hidden;
    height: 32px;
    width: 80%;
  }
  .right2-click {
    float: left;
    overflow: hidden;
    height: 38px;
    width: 80%;
  }
  .bordered {
    border: 1px solid gray;
    border-radius: 10px;
    padding: 5px;
    margin: 5px;
  }
  .float-button {
    z-index: 10;
    position: fixed;
  }
  .marker {
    font-size: 1.5em;
    font-weight: bold;
    text-align: center;
    color: red;
  }
</style>

<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

<div class="msgshow" id="msgshow"></div>

<div id="form-summary" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <div class="row">
          <label class="col-sm-4">Ngày bắt đầu</label>
          <div class="col-sm-5">
            <input type="text" class="form-control" id="form-summary-from" value="{summaryfrom}" autocomplete="off">
          </div>
          <label class="col-sm-4">Ngày kết thúc</label>
          <div class="col-sm-5">
            <input type="text" class="form-control" id="form-summary-end" value="{summaryend}" autocomplete="off">
          </div>
        </div>
        <label class="row" style="width: 100%;">
          <span class="col-sm-6"> Đơn vị </span>
          <div class="col-sm-12"> <input type="text" class="form-control" id="form-summary-unit"> </div>
        </label>
        <label class="row" style="width: 100%;">
          <span class="col-sm-6"> Yêu cầu xét nghiệm </span>
          <div class="col-sm-12"> <input type="text" class="form-control" id="form-summary-exam"> </div>
        </label>
        <label class="row" style="width: 100%;">
          <span class="col-sm-6"> Loại động vật </span>
          <div class="col-sm-12"> <input type="text" class="form-control" id="form-summary-sample"> </div>
        </label>
        <button class="btn btn-info" onclick="summaryFilter()">
          Xem tổng kết
        </button>
        <div id="form-summary-content"> {summarycontent} </div>
      </div>
    </div>
  </div>
</div>

<div id="method-modal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>

        <form onsubmit="insertMethodSubmit(event)">
          <div class="row">
            <label class="col-sm-6">Tên phương pháp</label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="insert-method-name" autocomplete="off">
            </div>
          </div>
          <div class="row">
            <label class="col-sm-6">Ký hiệu phương pháp</label>
            <div class="col-sm-6">
              <input type="text" class="form-control" id="insert-method-symbol" autocomplete="off">
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
  <!-- BEGIN: mod -->
  <li><a data-toggle="tab" href="#menu1"> Thêm văn bản </a></li>
  <!-- END: mod -->
</ul>

<div class="tab-content">
  <div id="home" class="tab-pane active">
    <form onsubmit="filter(event)">
      <div class="row form-group">
        <div class="col-sm-6">
          <input type="text" class="form-control" id="filter-keyword" placeholder="Mẫu phiếu" autocomplete="off">
        </div>
        <div class="col-sm-6">
          <input type="text" class="form-control" id="filter-xcode" placeholder="Số ĐKXN" autocomplete="off">
        </div>
        <div class="col-sm-6">
          <select class="form-control" id="filter-printer">
            <option value="1" selected>Mẫu 1</option>
            <option value="2">Mẫu 2</option>
            <option value="3">Mẫu 3</option>
            <option value="4">Mẫu 4</option>
            <option value="5">Mẫu 5</option>
          </select>
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
      </div>
      <div class="form-group row">
        <div class="col-sm-6">
          <input type="text" class="form-control" id="filter-unit" placeholder="Đơn vị">
        </div>
        <div class="col-sm-6">
          <input type="text" class="form-control" id="filter-exam" placeholder="Kết quả xét nghiệm">
        </div>
        <div class="col-sm-6">
          <input type="text" class="form-control" id="filter-sample" placeholder="Loại động vật">
        </div>
      </div>      
      <div class="text-center">
        <button class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button>
      </div>
    </form>
    <button class="btn btn-info" onclick="summary()"> Tổng kết </button>
    <div id="content">
      {content}
    </div>
  </div>

  <!-- BEGIN: mod2 -->
  <div id="menu1" class="tab-pane">
    <div id="credit"></div>
    <div class="row form-group boxed box-1 box-1-1">
      <label class="col-sm-6">Số phiếu</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-code" autocomplete="off">
      </div>
    </div>
    
    <div class="row form-group boxed box-2 box-2-1 box-3 box-3-1 box-21 box-21-1 box-31 box-31-2 box-4 box-4-1 box-5 box-5-19">
      <label class="col-sm-6">Số ĐKXN</label>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box xcode" id="form-insert-xcode-1" autocomplete="off">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box xcode" id="form-insert-xcode-2" autocomplete="off">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box xcode" id="form-insert-xcode-3" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-31 box-31-3">
      <label class="col-sm-6">Số trang</label>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box page" id="form-insert-page-1" autocomplete="off">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box page" id="form-insert-page-2" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-31 box-31-4">
      <label class="col-sm-6">Liên</label>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box no" id="form-insert-no-1" autocomplete="off">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control input-box no" id="form-insert-no-2" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-2 box-5 box-5-2">
      <label class="col-sm-6">
        Tên đơn vị - khách hàng
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sender-employ" autocomplete="off">
        <div class="suggest" id="form-insert-sender-employ-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-21 box-21-2 box-4 box-4-14">
      <label class="col-sm-6"> Thời gian nhận mẫu </label>
      <label class="col-sm-9">
        Giờ 
        <select class="form-control" id="form-insert-sample-receive-hour">
          <!-- BEGIN: hour -->
          <option value="{value}">{value}</option>
          <!-- END: hour -->
        </select>
      </label>
      <label class="col-sm-9">
        Phút 
        <select class="form-control" id="form-insert-sample-receive-minute">
          <!-- BEGIN: minute -->
          <option value="{value}">{value}</option>
          <!-- END: minute -->
        </select>
      </label>
    </div>

    <div class="row form-group boxed box-1 box-1-3 box-21 box-21-3 box-31 box-31-1 box-4 box-4-15 box-5 box-5-14">
      <label class="col-sm-6">Ngày nhận mẫu</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-receive" autocomplete="off">
      </div>
    </div>
    
    <div class="row form-group boxed box-1 box-1-4 box-31 box-31-14">
      <label class="col-sm-6">Ngày hẹn trả kết quả</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-resend" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-1">
      <label class="col-sm-6"> Ngày thông báo kết quả </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-notice-time" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-12">
      <label class="col-sm-6">
        Ngày lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sample-receive" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-13">
      <label class="col-sm-6">
        Người lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sample-receiver" autocomplete="off">
        <div class="suggest" id="form-insert-sample-receiver-suggest"></div>
      </div>
    </div>

    <div class="boxed box-1 box-1-5">
      <label>Hình thức nhận</label>
      <div>
        <label><input type="radio" name="state" class="check-box state" id="state-0" checked>Trực tiếp</label>
      </div>
      <div>
        <label><input type="radio" name="state" class="check-box state" id="state-1">Bưu điện</label>
      </div>
      <div class="row form-group">
        <label class="col-sm-6"><input type="radio" name="state" class="check-box state" id="state-2">Khác</label>
        <div class="col-sm-12">
          <input type="text" class="form-control" id="form-insert-receive-state-other" autocomplete="off">
        </div>
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-6">
      <b> <p> Phòng chuyên môn </p> </b>
      <label class="col-sm-6">
        Người nhận hồ sơ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-receiver-employ" autocomplete="off">
        <div class="suggest" id="form-insert-receiver-employ-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-7">
      <label class="col-sm-6">Ngày nhận</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-ireceive" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-1 box-1-8 box-2 box-2-6">
      <label class="col-sm-6">Ngày trả</label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-iresend" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-1 box-1-9">
      <div id="form-insert-form">

      </div>
      <button class="btn btn-success" onclick="addInfo(1)">
        <span class="glyphicon glyphicon-plus"></span>
      </button>
    </div>

    <div class="row form-group boxed box-21 box-21-4">
      <label class="col-sm-6">
        Người giao mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-isender-employ" autocomplete="off">
        <div class="suggest" id="form-insert-isender-employ-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-2 box-21 box-21-5 box-31 box-31-5 box-4 box-4-2">
      <label class="col-sm-6">
        Bộ phận giao mẫu - Khách hàng yêu cầu xét nghiệm
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-isender-unit" autocomplete="off">
        <div class="suggest" id="form-insert-isender-unit-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-4 box-4-3">
      <label class="col-sm-6">
        Địa chỉ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-address" autocomplete="off">
        <div class="suggest" id="form-insert-address-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-3">
      <label class="col-sm-6">
        Địa chỉ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-xaddress" autocomplete="off">
        <div class="suggest" id="form-insert-xaddress-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-6">
      <label class="col-sm-6">
        Chủ hộ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-owner" autocomplete="off">
        <div class="suggest" id="form-insert-owner-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-7">
      <label class="col-sm-6">
        Nơi lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sample-place" autocomplete="off">
        <div class="suggest" id="form-insert-sample-place-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-5">
      <label class="col-sm-6">
        Điện thoại
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="ownerphone-0" autocomplete="off">
        <div class="suggest" id="ownerphone-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-4">
      <label class="col-sm-6">
        Email
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="ownermail-0" autocomplete="off">
        <div class="suggest" id="ownermail-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-21 box-21-6 box-4 box-4-16">
      <label class="col-sm-6">
        Người nhận mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-ireceiver-employ" autocomplete="off">
        <div class="suggest" id="form-insert-ireceiver-employ-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-3 box-21 box-21-7">
      <label class="col-sm-6">
        Bộ phận nhận mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-ireceiver-unit" autocomplete="off">
        <div class="suggest" id="form-insert-ireceiver-unit-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-21 box-21-8 box-4 box-4-4">
      <label class="col-sm-6">
        Số điện thoại
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="xphone-0" autocomplete="off">
        <div class="suggest" id="xphone-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-21 box-21-8 box-4 box-4-5">
      <label class="col-sm-6">
        fax
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="fax-0" autocomplete="off">
        <div class="suggest" id="fax-suggest-0"></div>
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-10 box-21 box-21-13 box-31 box-31-7 box-4 box-4-8 box-5 box-5-10">
      <label class="col-sm-6"> Số lượng mẫu nhận </label>
      <div class="col-sm-12">
        <input type="number" class="form-control" id="form-insert-number" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-11 box-21 box-21-14 box-31 box-31-8 box-4 box-4-9 box-5 box-5-11">
      <label class="col-sm-6"> Số lượng mẫu nhận (Chữ) </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-number-word" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-5 box-5-12">
      <label class="col-sm-6"> Số lượng mẫu đạt yêu cầu </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-examsample" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-1 box-1-12 box-21 box-21-9 box-31 box-31-6 box-4 box-4-7 box-5 box-5-9">
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
        <label class="col-sm-6">
          <input type="radio" name="type" class="check-box type" id="typed-5">
          Khác
        </label>
        <div class="col-sm-12">
          <input type="text" class="form-control" id="form-insert-type-other" autocomplete="off">
        </div>
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-13 box-21 box-21-10 box-31 box-31-9 box-4 box-4-6 box-5 box-5-8">
      <label class="col-sm-6"> Loài vật được lấy mẫu </label>
      <div class="col-sm-12">
        <input type="text" class="form-control sample" id="form-insert-sample" autocomplete="off">
      </div>
    </div>

    <!-- <div class="form-group row boxed box-21 box-21-11">
      <label class="col-sm-6"> Số lượng mẫu </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-number2" autocomplete="off">
      </div>
    </div> -->

    <div class="form-group row boxed box-1 box-1-14 box-21 box-21-16 box-31 box-31-10">
      <label class="col-sm-6"> Ký hiệu mẫu </label>
      <div class="col-sm-12" id="form-insert-sample-parent">
        <input type="text" class="form-control" id="form-insert-sample-code" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-4 box-4-10 box-5 box-5-13">
      <label class="col-sm-6"> Ký hiệu mẫu </label>
      <div class="col-sm-12" id="form-insert-sample-parent">
        <input type="text" class="form-control" id="form-insert-sample-code-5" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-21 box-21-15 box-4 box-4-11">
      <label class="col-sm-6"> Tình trạng mẫu </label>
      <div>
        <input type="radio" name="status" class="check-box status status-0" checked>
        Đạt
      </div>
      <div>
        <input type="radio" name="status" class="check-box status status-1">
        Không đạt
      </div>
    </div>

    <div class="row form-group boxed box-21 box-21-17 box-31 box-31-11">
      <label> Đính kèm danh sách nhận diện mẫu </label>
      <div>
        <input type="radio" name="attach" class="check-box attach attach-0" checked>
        Có
      </div>
      <div>
        <input type="radio" name="attach" class="check-box attach attach-1">
        Không
      </div>
    </div>

    <div class="boxed box-21 box-21-18">
      <label> Hình thức bảo quản </label>
      <div>
        <input type="radio" name="xstatus" class="check-box xstatus status-0" checked>
        Thùng đá
      </div>
      <div>
        <input type="radio" name="xstatus" class="check-box xstatus status-1">
        Xe lạnh
      </div>
      <div>
        <input type="radio" name="xstatus" class="check-box xstatus status-2">
        Phương tiện khác
      </div>
    </div>

    <div class="boxed box-21 box-21-19">
      <label class="6"> Chất lượng chung của mẫu </label>
      <div>
        <input type="radio" name="quality" class="check-box quality quality-0" checked>
        Đạt
      </div>
      <div>
        <input type="radio" name="quality" class="check-box quality quality-1">
        Không đạt
      </div>
    </div>

    <div class="boxed box-1 box-1-15 box-21 box-21-20 box-31 box-31-12 box-4 box-4-17 box-5 box-5-16 bordered">
      <label>
        Yêu cầu xét nghiệm
        <button class="btn btn-success" onclick="insertMethod()"> <span class="glyphicon glyphicon-plus"></span> </button>
      </label>
      <div id="form-insert-request"></div>
    </div>

    <div class="row form-group boxed box-1 box-1-16 box-21 box-21-21">
      <label class="col-sm-6">
        Ghi chú
      </label>
      <div class="col-sm-20">
        <textarea class="form-control" id="form-insert-xnote" autocomplete="off"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-21 box-21-22">
      <label class="col-sm-6"> Thời gian kết thúc</label>
      <label class="col-sm-6">
        Giờ 
        <select class="form-control" id="form-insert-ended-hour">
          <!-- BEGIN: hour2 -->
          <option value="{value}">{value}</option>
          <!-- END: hour2 -->
        </select>
      </label>
      <label class="col-sm-6">
        Phút 
        <select class="form-control" id="form-insert-ended-minute">
          <!-- BEGIN: minute2 -->
          <option value="{value}">{value}</option>
          <!-- END: minute2 -->
        </select>
      </label>
      <label class="col-sm-6">
        Số bản in
        <input type="text" class="form-control" id="form-insert-ended-copy" autocomplete="off">
      </label>
    </div>

    <div class="row form-group boxed box-31 box-31-13">
      <label class="col-sm-6">
        Yêu cầu khác
      </label>
      <div class="col-sm-20">
        <input type="text" class="form-control" id="form-insert-other" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-7 box-5 box-5-18 box-4 box-4-21">
      <label class="col-sm-6">
        Kết quả
      </label>
      <div class="col-sm-12">
        <textarea class="form-control" id="form-insert-result"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-17 box-4 box-4-19">
      <label class="col-sm-6">
        Ghi chú
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-note"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-14">
      <label class="col-sm-6">
        Ghi chú
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-cnote"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-5 box-4 box-4-20">
      <label class="col-sm-6">
        Ngày phân tích
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-exam-date" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-20">
      <label class="col-sm-6">
        Nơi nhận
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-receive-dis"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-19">
      <label class="col-sm-6">
        Người phụ trách
      </label>
      <div class="col-sm-20">
        <input type="text" class="form-control" id="form-insert-receive-leader">
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-14">
      <label class="col-sm-6">
        Mục đích xét nghiệm
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-target" autocomplete="off"></textarea>
      </div>
    </div>

    <div class="boxed box-2 box-2-4 box-3 box-3-4 html-sample" id="sample">
      
    </div>

    <div class="row form-group boxed box-3 box-3-6">
      <label class="col-sm-6"> Ghi chú </label>
      <div class="col-sm-10">
        <textarea type="text" id="form-insert-vnote" class="form-control"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-3 box-3-7">
      <label class="col-sm-6"> Bộ phận xét nghiệm </label>
      <div class="col-sm-10 relative">
        <input type="text" id="xexam-0" class="form-control">
        <div class="suggest" id="xexam-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-8">
      <label class="col-sm-6"> Ngày giao mẫu </label>
      <div class="col-sm-10">
        <input type="text" id="form-insert-xsend" class="form-control">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-9">
      <label class="col-sm-6"> Người giao mẫu </label>
      <div class="col-sm-10 relative">
        <input type="text" id="xsender-0" class="form-control">
        <div class="suggest" id="xsender-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-10">
      <label class="col-sm-6"> Ngày nhận mẫu </label>
      <div class="col-sm-10">
        <input type="text" id="form-insert-xreceive" class="form-control">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-11">
      <label class="col-sm-6"> Người nhận mẫu </label>
      <div class="col-sm-10 relative">
        <input type="text" id="xreceiver-0" class="form-control">
        <div class="suggest" id="xreceiver-suggest-0"></div>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-12">
      <label class="col-sm-6"> Ngày giao kết quả </label>
      <div class="col-sm-10">
        <input type="text" id="form-insert-xresend" class="form-control">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-13 box-3 box-3-8">
      <label class="col-sm-6"> Người phụ trách bộ phận xét nghiệm </label>
      <div class="col-sm-10 relative">
        <input type="text" class="form-control" id="xresender-0">
        <div class="suggest" id="xresender-suggest-0"></div>
      </div>
    </div>

    <button class="btn btn-info saved float-button" id="saved-2-1" style="top: 10px; right: 10px;" onclick="printer(1)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved float-button" id="saved-2-2" style="top: 45px; right: 10px;" onclick="printer(2)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved float-button" id="saved-2-3" style="top: 80px; right: 10px;" onclick="printer(3)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved float-button" id="saved-2-4" style="top: 115px; right: 10px;" onclick="printer(4)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-info saved float-button" id="saved-2-5" style="top: 150px; right: 10px;" onclick="printer(5)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-warning saved float-button" id="saved-1-1" style="top: 10px; right: 50px;" onclick="parseBox(1)">
      Mẫu 1
    </button>

    <button class="btn btn-warning saved float-button" id="saved-1-2" style="top: 45px; right: 50px;" onclick="parseBox(2)">
      Mẫu 2
    </button>

    <button class="btn btn-warning saved float-button" id="saved-1-3" style="top: 80px; right: 50px;" onclick="parseBox(3)">
      Mẫu 3
    </button>

    <button class="btn btn-warning saved float-button" id="saved-1-4" style="top: 115px; right: 50px;" onclick="parseBox(4)">
      Mẫu 4
    </button>

    <button class="btn btn-warning saved float-button" id="saved-1-5" style="top: 150px; right: 50px;" onclick="parseBox(5)">
      Mẫu 5
    </button>

    <button class="btn btn-success float-button" style="top: 185px; right: 50px;" onclick="insertSubmit()"> Lưu </button>

    <button class="btn btn-info saved-0 float-button" style="top: 185px; right: 10px;" onclick="newForm()">
      <span class="glyphicon glyphicon-file"></span>
    </button>
  </div>
  <!-- END: mod2 -->
</div>

<script>
  var style = '.table-bordered {border-collapse: collapse;}.table-wider td, .table-wider th {padding: 10px;}table {width: 100%;}table td {padding: 5px;}.no-bordertop {border-top: 1px solid white; }.no-borderleft {border-left: 1px solid white; }.c20, .c25, .c30, .c35, .c40, .c45, .c50, .c80 {display: inline-block;}.c20 {width: 19%;}.c25 {width: 24%;}.c30 {width: 29%;}.c35 {width: 34%;}.c40 {width: 39%;}.c45 {width: 44%;}.c50 {width: 49%;}.c80 {width: 79%;}.p11 {font-size: 11pt}.p12 {font-size: 12pt}.p13 {font-size: 13pt}.p14 {font-size: 14pt}.p15 {font-size: 15pt}.p16 {font-size: 16pt}.text-center, .cell-center {text-align: center;}.cell-center {vertical-align: inherit;} p {margin: 5px 0px;}'
  var profile = ['@page { size: A4 portrait; margin: 20mm 10mm 10mm 25mm; }', '@page { size: A4 landscape; margin: 20mm 10mm 10mm 25mm;}']
  var former = {
    1: '<table class="table-bordered" border="1"><tr><td rowspan="2" class="cell-center" style="width: 20%; padding: 10pt 21pt;">CHI CỤC THÚ Y VÙNG V</td><td class="cell-center p15" style="height: 30pt;"> <b>PHIẾU GIẢI QUYẾT HỒ SƠ</b></td></tr><tr><td class="no-bordertop">Số: code/TYV5-TH</td></tr></table><p>&emsp; Tên đơn vị: senderemploy</p><p><div class="inline c50">&emsp; Ngày nhận: receive </div><div class="inline c50">Ngày hẹn trả kết quả: resend </div></p><p><div class="inline c30">&emsp; Hình thức nhận: </div><div class="inline c20">status-0 Trực tiếp</div><div class="inline c20"> status-1 Bưu điện</div><div class="inline c30">Khác: status-2</div></p><p>&emsp; Người nhận hồ sơ: receiveremploy</p><p><div class="inline c30">&emsp; Phòng chuyên môn:</div><div class="inline c40">Ngày nhận: ireceive </div><div class="inline c30">Ngày trả: iresend </div></p><table class="table-bordered" border="1"><tr><td class="text-center" style="height: 240px; vertical-align: baseline;"> <p class="text-center"> <u>Hồ sơ gồm:</u> </p> <div style="text-align: left;"> formcontent </div></td></tr></table><br><table class="table-bordered" border="1"><tr><th class="p13"> <b>Ý kiến của phòng, Bộ phận chịu trách nhiệm giải quyết</b> </th><th class="p13"> <b>Ý kiến của ban lãnh đạo</b> </th></tr><tr><td style="height: 220px;"></td><td></td></tr></table><p>&emsp;&emsp;Ghi chú: Hồ sơ có ý kiến của thủ trưởng (hoặc người được ủy quyền) phải giao lại cho Bộ phận một cửa trước 01 ngày so với ngày hẹn trả </p><br><br><br><p><div class="inline c40">Mã số: BM-02/TYV5-06</div><div class="inline c40">Mã số: Ngày ban hành: 02/11/2017</div><div class="inline c20">Lần sửa đổi: 02</div></p>',
    2: '<table class="table-bordered" border="1" style="width: 95%; margin: auto;"><tr><td style="width: 60%;" class="cell-center">CHI CỤC THÚ Y VÙNG V <br> <b> TRẠM CHẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT </b></td><td><div class="c20"></div><div class="c80"><b>Biểu mẫu số: BM.STTT.20.10 <br>Số soát xét: 03.02718</b></div></td></tr></table><br><div class="text-center"> <b>PHIẾU GIAO NHẬN MẪU VÀ KẾT QUẢ XÉT NGHIỆM</b> </div><div style="float: right; width: 160pt; margin-right: 10pt; border: 1px solid black; padding: 5pt;">Số ĐKXN: xcode-0/xcode-1/xcode-2 <br> Số trang: 01 <br> Liên: 01/02 </div><br><br><p><b>Bên giao mẫu: </b> isenderunit</p><p><b>Bên nhận mẫu: </b> ireceiverunit </p> <div> xtable </div> <div style="display: inline-block; width: 60px;"><b>Ghi chú:</b> </div><div style="margin-left: 1pt; display: inline-table; width: calc(100% - 65px);"></p> (note) - Bộ phận xét nghiệm trả kết quả trên chỉ tiêu xét nghiệm. <br>- Ngày xét nghiệm: examdate <br>- Ngày hẹn trả kết quả xét nghiệm: <i>ngày resend-0 tháng resend-1 năm resend-2</i>(result)</p></div><table><tr><td style="width: 5%"></td><td class="c30 text-center"><b>Người/Ngày giao mẫu <br></b><i>Ngày xsend-0 tháng xsend-1 năm xsend-2 <br> <br> <br> <br> <br></i> <div>xsender</div></td><td class="c30 text-center"><b>Người/Ngày nhận mẫu <br></b><i>Ngày xreceive-0 tháng xreceive-1 năm xreceive-2 <br> <br> <br> <br> <br></i> <div>xreceiver</div> </td><td class="c30 text-center"><b>Phụ trách bộ phận xét nghiệm <br></b><i>Ngày xresend-0 tháng xresend-1 năm xresend-2 <br> <br> <br> <br> <br></i> <div>xresender</div></td></tr></table>',
    3: '<table class="table-bordered" border="1"><tr><td class="cell-center"> <b>Biểu mẫu số: BM.STTT.22.01</b> </td><td class="cell-center"> <b>Số soát xét: 03.027148</b> </td></tr><tr><td colspan="2"><div class="cell-center">CHI CỤC THÚ Y VÙNG V <br> <b class="p16"> TRẠM CHẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT </b></div>Địa chỉ: Số 36, Phạm Hùng, phường Tân An, thành phố Buôn Ma Thuột, tỉnh Đăk Lăk. <br>Điện thoại: 0262 3877793</td></tr></table><br><div class="text-center p16"> <b> PHIẾU KẾT QUẢ XÉT NGHIỆM </b> </div><br><p> <b> Số ĐKXN: xcode-0/xcode-1/xcode-2 </b> </p><p class="text-center"> <b> Số phiếu kết quả thử nghiệm: xcode-0/xcode-1/xcode-2.CĐXN </b> </p><div id="a">xtable</div><p><div style="display: inline-block"><b> &emsp;&emsp; <u> Ghi chú: </u> </b> </div><div style="display: inline-flex"><i> (vnote) </i></div></p><p> <i> &emsp;&emsp; Kết quả chỉ có giá trị trên mẫu thử nghiệm. Việc sao chép kết quả này chỉ có giá trị khi được sao chép toàn bộ, và không có giá trị nếu chỉ sao chép một phần./. </i> </p><table><tr><td style="width: 5%"></td><td style="width: 40%" class="text-center"> <b>BỘ PHẬN XÉT NGHIỆM</b> <br> <i> (Ký, ghi rõ họ tên) </i> <br> <br> <br> <br> <br> xexam </td><td style="width: 20%"></td><td style="width: 40%" class="text-center"> <b> TRƯỞNG TRẠM </b> <br> <br> <br> <br> <br> <br> receiveleader </td><td style="width: 5%"></td></tr></table>',
    4: '<table border="1" class="table-bordered"> <tr> <td class="text-center"> <b>Biểu mẫu số: BM.STTT.22.01</b> </td> <td class="text-center"> <b>Số soát xét: 03.02718</b> </td> </tr> <tr> <td colspan="2"> <div class="text-center"> <b>CHI CỤC THÚ Y VÙNG V</b> </div> <div class="text-center"> <b>TRẠM CHUẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT</b> </div> <div> Địa chỉ: Số 36 Phạm Hùng, Phường Tân An, Thành phố Buôn Ma Thuột, Tỉnh Đăklăk </div> <div> Điện thoại: 0262 3877793 </div> </td> </tr> </table> <div class="text-center p16" style="margin: 10px;"> <b>PHIẾU KẾT QUẢ XÉT NGHIỆM</b> </div> <div style="margin: 4px;"> <div style="float: left"> Số phiếu kết quả xét nghiệm: xcode-0/xcode-1/xcode-2.CĐXN </div> <div style="float: right">Trang: 1/2</div> </div> <table border="1" class="table-bordered"> <tr> <td colspan="2"> Tên khách hàng: (customer) </td> <td style="width: 30%"> Số ĐKXN: xcode-0/xcode-1/xcode-2</td> </tr> <tr> <td colspan="3"> <div> Địa chỉ khách hàng: (address) </div> <div style="float: left; width: 400px;"> Số điện thoại: (phone) </div> <div style="float: left; "> Fax: (fax) </div> </td> </tr> <tr> <td colspan="3"> Loài động vật lấy mẫu: (sample) </td> </tr> <td colspan="3"> Loại mẫu: (type) </td> </tr> <tr> <td colspan="3"> Số lượng mẫu: (number) (numberword) </td> </tr> <tr> <td colspan="3"> Ký hiệu mẫu: (sampleCode) </td> </tr> <tr> <td colspan="3"> Tình trạng khi nhận mẫu: (status) </td> </tr> <tr> <td style="width: 50%"> Ngày lấy mẫu: (sampleReceive) </td> <td colspan="2"> Người lấy mẫu: (sampleReceiver) </td> </tr> <tr> <td style="width: 50%"> Ngày, giờ nhận mẫu: (receiveHour)<sup>h</sup>(receiveMinute)<sup>p</sup> (ireceive)</td> <td colspan="2"> Người nhận mẫu: (ireceiver) </td> </tr> <tr> <td colspan="3">  <b><u>Chỉ tiêu xét nghiệm</u></b> <br> (exam) (index) (exam-content) </div> <div> &nbsp;&nbsp; Phương pháp xét nghiệm: (method); Ký hiệu phương pháp: (symbol). </div> (/exam) (note) </td> </tr> <tr> <td colspan="3"> Ngày phân tích: (examDate) </td> </tr> <tr> <td colspan="3"> <b> Kết quả: </b> <br> (result) </td> </tr> </table> <table style="width: 100%"> <tr> <td class="text-center"> Ngày examdate-0 tháng examdate-1 năm examdate-2 <br> <b>BỘ PHẬN XÉT NGHIỆM</b> <br> (Ký, ghi rõ họ tên) </td> <td class="text-center"> Ngày examdate-0 tháng examdate-1 năm examdate-2 <br> <b>TRƯỞNG TRẠM</b> </td> </tr> </table> </div>',
    5: '<style> p {margin: 3px;} </style><table><tr><td class="cell-center p12" style="position: relative;"> <div style="position: absolute; border-top: 1px solid black; width: 70px; top: 45px; left: 82px;"></div> CỤC THÚ Y <br> <b> CHI CỤC THÚ Y VÙNG V </b> <div style="margin-top: 10px; "></div> <span class="p14"> Số: &emsp;&emsp;/TYV5-TH </span> </td><td class="cell-center" style="position: relative"><div style="position: absolute; border-top: 1px solid black; width: 205px; height: 100px; top: 41px; left: 95px;"></div> <span class="p12">CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</span> <br> <b class="p13"> Độc lập - Tự do - Hạnh phúc </b> <div style="margin-top: 15px;"></div> <span class="p14"> <i> Đăk Lăk, ngày noticetime-0 tháng noticetime-1 năm noticetime-2 </i> </span> </td></tr> </table><p class="text-center p16" style="padding-top: 5px;"> <b> THÔNG BÁO </b> </p><p class="text-center p15" style="padding-bottom: 15px;"> <b> Kết quả xét nghiệm </b> </p> <p class="p14">&emsp;&emsp; Chi cục Thú y vùng V thông báo kết quả xét nghiệm được thực hiện tại Trạm Chẩn đoán xét nghiệm bệnh động vật (trực thuộc Chi cục Thú y vùng V) như sau: </p> <p class="p14"> &emsp;&emsp; Tên khách hàng: senderemploy  </p> <p class="p14"> &emsp;&emsp; Địa chỉ: xaddress </p> (info) owner <p style="width: 60%; float: left;" class="p14"> &emsp;&emsp; Loài động vật được lấy mẫu: (sample)</p><p style="width: 35%; float: left; " class="p14">Loại mẫu: (sampletype)</p> <p style="clear: left; width: 60%; float: left;" class="p14"> &emsp;&emsp; Số lượng mẫu: number (numberword) </p> <p style="width: 35%; float: left;" class="p14">Số mẫu xét nghiệm: (examsample)</p> <p class="p14" style="clear: left;"> &emsp;&emsp; Ký hiệu mẫu: samplecode </p> <p class="p14"> &emsp;&emsp; Ngày nhận mẫu: sampletime </p> target <p class="p14"> &emsp;&emsp; <b> <u> Chỉ tiêu xét nghiệm: </u> </b> </p><div class="p14">(exam)</div>note<p class="p14"> &emsp;&emsp; <b> <u> Kết quả: </u> </b> </p><div class="p14">result</div><p class="p14"> <i> &emsp;&emsp;(Chi tiết xem phiếu kết quả xét nghiệm số: xcode-0/xcode-1/xcode-2.CĐXN của trạm chuẩn đoán xét nghiệm bệnh động vật)./. </i></p><div style="width: 60%; float: left;"><b class="p12"> <b> <i> Nơi nhận: </i> </b> </b> <p class="p11"> receivedis </p></div> <div style="width: 40%; float: left;" class="text-center p14"><b> CHI CỤC TRƯỞNG <br><br><br><br><br> receiveleader </b></td></tr></table>'
  }
  
  var ticked = ['Đạt', 'Không đạt']
  var methodModal = $("#method-modal")
  var formInsert = $('#form-insert')
  var remind = JSON.parse('{remind}')
  var remindv2 = JSON.parse('{remindv2}')
  var relation = JSON.parse('{relation}')
  var credit = $("#credit")
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
  var formInsertNumberWord = $("#form-insert-number-word")
  var formInsertNumber2 = $("#form-insert-number2")
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
  var formInsertAddressSuggest = $("#form-insert-address-suggest")

  var formInsertSampleReceiveTime = $("#form-insert-sample-receive-time")
  var formInsertSampleReceiveHour = $("#form-insert-sample-receive-hour")
  var formInsertSampleReceiveMinute = $("#form-insert-sample-receive-minute")
  var formInsertExamDate = $("#form-insert-exam-date")
  var formInsertTarget = $("#form-insert-target")

  var formInsertXcode1 = $("#form-insert-xcode-1")
  var formInsertXcode2 = $("#form-insert-xcode-2")
  var formInsertXcode3 = $("#form-insert-xcode-3")
  var formInsertNo1 = $("#form-insert-no-1")
  var formInsertNo2 = $("#form-insert-no-2")
  var formInsertPage1 = $("#form-insert-page-1")
  var formInsertPage2 = $("#form-insert-page-2")
  var formInsertQuality = $("#form-insert-quality")

  var formInsertInfo = $("#form-insert-info")
  var formInsertForm = $("#form-insert-form")
  var formInsertRequest = $("#form-insert-request")

  var filterLimit = $("#filter-limit")
  var filterPrinter = $("#filter-printer")
  var filterKeyword = $("#filter-keyword")

  var insertMethodSymbol = $("#insert-method-symbol")
  var insertMethodName = $("#insert-method-name")

  var formInsertEndedMinute =  $("#form-insert-ended-minute")
  var formInsertEndedHour =  $("#form-insert-ended-hour")
  var formInsertEndedCopy =  $("#form-insert-ended-copy")

  var formInsertNote =  $("#form-insert-note")
  var formInsertCnote =  $("#form-insert-cnote")
  var formInsertReceiveDis = $("#form-insert-receive-dis")
  var formInsertReceiveLeader = $("#form-insert-receive-leader")
  var formInsertAttach = $("#form-insert-attach")
  var formInsertXaddress = $("#form-insert-xaddress")
  var formInsertXaddressSuggest = $("#form-insert-xaddress-suggest")
  var formInsertOwner = $("#form-insert-owner")
  var formInsertOwnerSuggest = $("#form-insert-owner-suggest")
  var formInsertSamplePlace = $("#form-insert-sample-place")
  var formInsertSamplePlaceSuggest = $("#form-insert-sample-place-suggest")
  var formInsertXphone = $("#xphone-0")
  var formInsertXnote = $("#form-insert-xnote")
  var formInsertFax = $("#fax-0")

  var formInsertXresend = $("#form-insert-xresend")
  var formInsertXresender = $("#xresender-0")
  var formInsertXsend = $("#form-insert-xsend")
  var formInsertXsender = $("#xsender-0")
  var formInsertXreceive = $("#form-insert-xreceive")
  var formInsertXreceiver = $("#xreceiver-0")
  var formInsertXexam = $("#xexam-0")
  var formInsertVnote = $("#form-insert-vnote")
  var formInsertExamSample = $("#form-insert-examsample")
  var formInsertSampleCode5 = $("#form-insert-sample-code-5")
  var formInsertOwnerPhone = $("#ownerphone-0")
  var formInsertOwnerMail = $("#ownermail-0")

  var formSummary = $("#form-summary")
  var formSummaryFrom = $("#form-summary-from")
  var formSummaryEnd = $("#form-summary-end")
  var formSummaryContent = $("#form-summary-content")
  var formSummaryUnit = $("#form-summary-unit")
  var formSummarySample = $("#form-summary-sample")
  var formSummaryExam = $("#form-summary-exam")
  var formInsertNoticeTime = $("#form-insert-notice-time")
  var sample = $("#sample")

  var filterXcode = $("#filter-xcode")
  var filterUnit = $("#filter-unit")
  var filterExam = $("#filter-exam")
  var filterSample = $("#filter-sample")

  var global_html = {}
  var global_form = 1
  var global_saved = 0
  var global_id = 0
  var global_page = 1
  var global_printer = 1

  var visible = {
    0: {1: '1', 2: '1'},
    1: {1: '1, 2', 2: '1, 2'},
    2: {1: '1, 2, 3', 2: '1, 2, 3'},
    3: {1: '1, 2, 3, 4', 2: '1, 2, 3, 4'},
    4: {1: '1, 2, 3, 4, 5', 2: '1, 2, 3, 4, 5'},
    5: {1: '1, 2, 3, 4, 5', 2: '1, 2, 3, 4, 5'}
  }
  var dataPicker = {'form': 1, 'result': 3}
  var rdataPicker = {'1': 'form', 3: 'result'}
  var infoData = {1: [], 2: [], 3: []}
  var remindData = {}
  var today = '{today}'
  var global_field = [{
    code: '',
    type: '',
    number: 1,
    status: 1,
    mainer: [{
      main: '',
      method: '',
      note: [{
        result: '',
        note: ''
      }]
    }]
  }]
  var global_exam = [{
    method: '',
    symbol: '',
    exam: ['']
  }]
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
      data: 4,
      name: 'value'
    },
    'address': {
      input: formInsertAddress,
      suggest: formInsertAddressSuggest,
      data: 5,
      name: 'value'
    },
    'sample-receiver': {
      input: formInsertSampleReceiver,
      suggest: formInsertSampleReceiverSuggest,
      data: 1,
      name: 'value'
    },
    'xaddress': {
      input: formInsertXaddress,
      suggest: formInsertXaddressSuggest,
      data: 8,
      name: 'value'
    },
    'owner': {
      input: formInsertOwner,
      suggest: formInsertOwnerSuggest,
      data: 9,
      name: 'value'
    },
    'sample-place': {
      input: formInsertSamplePlace,
      suggest: formInsertSamplePlaceSuggest,
      data: 10,
      name: 'value'
    }
  }

  $(document).ready(() => {
    htmlInfo = formInsertInfo.html()
    addInfo(1)
    addInfo(3)
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
    installRemind('customer');
    installRemind('address');
    installRemind('xaddress');
    installRemind('owner');
    installRemind('sample-place');

    installRemindv2('0', 'xsender');
    installRemindv2('0', 'xreceiver');
    installRemindv2('0', 'xresender');
    installRemindv2('0', 'xexam');
    installRemindv2('0', 'xphone');
    installRemindv2('0', 'fax');
    installRemindv2('0', 'ownerphone');
    installRemindv2('0', 'ownermail');

    installExamRemind()
    parseField(global_field)
    parseExam(global_exam)        
    parseBox(1)
    parseSaved()
  })

  $("#form-insert-receive, #form-insert-resend, #form-insert-ireceive, #form-insert-iresend, #form-insert-sample-receive, #form-insert-sample-time, #form-insert-exam-date, #form-summary-from, #form-summary-end, #form-insert-notice-time, #form-insert-xresend, #form-insert-xreceive, #form-insert-xsend").datepicker({
    format: 'dd/mm/yyyy',
    changeMonth: true,
    changeYear: true
  });

  function parseBox(index) {
    if (visible[global_saved][1].search(index) >= 0) {
      global_form = index
      parseForm(index)
    }
  }

  function parseExam(data) {
    var installer = []
    var html = ''
    var mainIndex = -1
    data.forEach(main => {
      var temp = ''
      var examIndex = -1
      mainIndex ++
      main['exam'].forEach(exam => {
        examIndex ++
        temp += 
        `<div class="row">
          <button type="button" class="close" data-dismiss="modal" onclick="splitExam(\'0-`+ mainIndex +`-`+ examIndex +`\')">&times;</button>
          <label class="col-sm-4"> Yêu cầu </label>
          <div class="col-sm-10 relative">
            <input type="text" value="`+ exam +`" class="form-control input-box exam examed iex iex-exam-` + mainIndex + `-`+ examIndex +`" id="exam-`+ mainIndex +`-`+ examIndex +`" style="float: none;" autocomplete="off">
            <div class="suggest exam-suggest" id="exam-suggest-`+ mainIndex +`-`+ examIndex +`"> </div>
          </div>
        </div>`
        installer.push({
          name: mainIndex +`-`+ examIndex,
          type: 'exam'
        })
      })
      if (examIndex == -1) examIndex = 0
      if (mainIndex == -1) mainIndex = 0
      temp += '<button class="btn btn-success" onclick="splitExam(\'1-'+ mainIndex +'-'+ examIndex +'\')"><span class="glyphicon glyphicon-plus"></span></button>'
      
      html += `
      <div class="examed bordered">
        <button type="button" class="close" data-dismiss="modal" onclick="splitExam(\'0-`+ mainIndex +`\')">&times;</button>
        <div class="row">
          <label class="col-sm-4"> Phương pháp </label>
          <div class="col-sm-10 relative">
            <input type="text" value="`+ main['method'] +`" class="form-control input-box method iex iex-method-` + mainIndex + `" id="method-` + mainIndex + `" style="float: none;" autocomplete="off">
            <div class="suggest" id="method-suggest-` + mainIndex + `"> </div>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-4"> Ký hiệu </label>
          <div class="col-sm-10 relative">
            <input type="text" value="`+ main['symbol'] +`" class="form-control input-box symbol iex iex-symbol-` + mainIndex + `" id="symbol-` + mainIndex + `" style="float: none;" autocomplete="off">
            <div class="suggest" id="symbol-suggest-` + mainIndex + `"> </div>
          </div>
        </div>
        `+ temp +`
      </div>
      <button class="btn btn-success" onclick="splitExam(\'1-`+ mainIndex +`\')"><span class="glyphicon glyphicon-plus"></span></button>`
      installer.push({
        name: mainIndex,
        type: 'method'
      })
      installer.push({
        name: mainIndex,
        type: 'symbol'
      })
    })
    formInsertRequest.html(html)
    installer.forEach(item => {
      installRemindv2(item['name'], item['type'])
    })
  }

  function getExam() {
    list = []
    data = []
    $(".iex").each((index, item) => {
      list.push()
      className = item.getAttribute('class')
      var start = className.indexOf('iex-')
      var end = className.indexOf(' ', start)
      if (end < 0) {
        var pos = className.slice(start + 4) 
      }
      else {
        var pos = className.slice(start + 4, end) 
      }

      if (pos) {
        var poses = pos.split('-')
        var posesCount = poses.length
        switch (posesCount) {
          case 2:
            if (!data[poses[1]]) {
              data[poses[1]] = {}
            }
            data[poses[1]][poses[0]] = $(".iex-" + pos).val()
          break;
          case 3:
            if (!data[poses[1]]) {
              data[poses[1]] = {}
            }
            if (!data[poses[1]]['exam']) {
              data[poses[1]]['exam'] = []
            }
            data[poses[1]]['exam'][poses[2]] = $(".iex-" + pos).val()
          break;
        }
      }
    })
    return data
  }

  function splitExam(indexString) {
    var indexes = indexString.split('-')
    var indexCount = indexes.length
    indexes[0] = Number(indexes[0])
    global_exam = getExam()
    if (indexes[0]) {
      // insert
      if (indexes[2]) {
        global_exam[indexes[1]]['exam'].splice(indexes[2] + 1, 0, '')
      }
      else {
        global_exam.splice(indexes[1] + 1, 0, {method: '', symbol: '', exam: ['']})
      }
    }
    else {
      // remove
      if (indexes[2]) {
        global_exam[indexes[1]]['exam'].splice(indexes[2], 1)
      }
      else {
        global_exam.splice(indexes[2], 1)
      }
    }
    parseExam(global_exam)
  }

  function getFilter() {
    var data = {
      unit: filterUnit.val(),
      exam: filterExam.val(),
      sample: filterSample.val()
    }
    return data
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

  function parseInputs(data, name) {
    $("." + name + "ed").remove()
    
    var array = data['form'][name]
    array = array.split(', ')

    array.forEach((element, index) => {
      addInfo(dataPicker[name])
      if (dataPicker[name] == 1) {
        $("#formed-" + index).val(element)
      }
      else {
        $("#resulted-" + index).val(element)
      }
    });
  }

  function synchField() {
    var data = {
      type: getCheckbox('type', formInsertTypeOther),
      sample: formInsertSample.val(),
      samplecode: checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())['list'],
      exam: getExam()
    }
    var type = (data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
    var sampleCount = data['samplecode'].length
    var maintemp = []
    global_field = []
    for (let i = 0; i < sampleCount; i++) {
      var temp = []
      global_field.push({
        main: ''
      })

      data['exam'].forEach(main => {
        var temp2 = []
        main['exam'].forEach(exam => {
          temp2.push({
            result: '',
            note: exam
          })
        })
        temp.push({
          main: main['symbol'],
          method: main['method'],
          note: temp2
        })
      })

      maintemp.push({
        code: data['samplecode'][i],
        number: 1,
        status: 1,
        type: type,
        mainer: temp
      })
    }
    global_field = maintemp
    parseField(global_field)
  }

  function parseForm(id) {
    var list = []
    var credit = document.getElementById('credit')
    var box = $(".box-" + id)
    $(".boxed").hide()
    box.show()
    box.each((index, item) => {
      var className = item.getAttribute('class')
      var start = className.indexOf('box-' + id + '-')
      var end = className.indexOf(' ', start)
      if (end < 0) {
        var pos = className.slice(start + 6) 
      }
      else {
        var pos = className.slice(start + 6, end) 
      }

      if (pos) {
        list[pos] = item
      }
    })

    for (const listKey in list) {
      if (list.hasOwnProperty(listKey)) {
        const item = list[listKey];
        credit.appendChild(item)
      }
    }
  }

  function parseField(data) {
    var html = ''
    var installer = []
    var sampleX = -1
    global_field = data

    sample.html('')

    data.forEach((sample, sampleIndex) => {
      var html2 = ''
      var resultX = -1
      sampleX ++

      sample['mainer'].forEach((result, resultIndex) => {
        var html3 = ''
        var noteX = -1
        resultX ++
            
        result['note'].forEach((note, noteIndex) => {
          noteX ++
          html3 += `
          <div class="html-result bordered">
            <button class="close right" data-dismiss="modal" onclick="removeField('`+ sampleIndex +`,`+ resultIndex +`,`+ noteIndex +`')">&times;</button>
            <div class="row form-group">
              <label class="col-sm-6"> Kết quả </label>
              <div class="col-sm-10">
                <input type="text" value="`+ note['result'] +`" class="form-control ig ig-result-`+ sampleIndex +`-`+ resultIndex +`-`+ noteIndex +`">
              </div>
            </div>
            <div class="row form-group">
              <label class="col-sm-6"> Ghi chú </label>
              <div class="col-sm-10">
                <input type="text" value="`+ note['note'] +`" class="form-control ig ig-note-`+ sampleIndex +`-`+ resultIndex +`-`+ noteIndex +`">
              </div>
            </div>
          </div>`
        })

        html2 += `
        <div class="html-main bordered">
          <button class="close right" data-dismiss="modal" onclick="removeField('`+ sampleIndex +`,`+ resultIndex +`')">&times;</button>
          <div class="row form-group">
            <label class="col-sm-6"> Chỉ tiêu </label>
            <div class="col-sm-10">
              <div class="relative">
                <input type="text" value="`+ result['main'] +`" class="form-control ig ig-main-`+ sampleIndex +`-`+ resultIndex +`" id="main-s`+ sampleIndex +`">
                <div class="suggest" id="main-suggest-s`+ sampleIndex +`"></div>
              </div>
            </div>
          </div>
          
          <div class="row form-group">
            <label class="col-sm-6"> Phương pháp </label>
            <div class="col-sm-10">
              <div class="relative">
                <input type="text" value="`+ result['method'] +`" class="form-control ig ig-method-`+ sampleIndex +`-`+ resultIndex +`" id="method-s`+ sampleIndex +`">
                <div class="suggest" id="method-suggest-s`+ sampleIndex +`"></div>
              </div>
            </div>
          </div>
          `+ html3 +`
          <button class="btn btn-info" onclick="addField('`+ sampleX +`,`+ resultX +`,`+ noteX +`')"> <span class="glyphicon glyphicon-plus"></span> </button>
        </div>`
        installer.push({
          name: "s" + sampleIndex,
          type: 'main'
        })
        installer.push({
          name: "s" + sampleIndex,
          type: 'method'
        })
      })

      html += `    
      <div class="bordered">
        <p class="marker"> Mẫu `+(sampleIndex + 1)+` </p>
        <button class="close right" data-dismiss="modal" onclick="removeField('`+ sampleIndex +`')">&times;</button>
        <div class="row form-group">
          <label class="col-sm-6"> Kí hiệu mẫu </label>
          <div class="col-sm-10">
            <input type="text" name="samplecode[]" value="`+ sample['code'] +`" class="form-control ig ig-code-`+ sampleIndex +`">
          </div>
        </div>
        <div class="row form-group">
          <label class="col-sm-6"> Loại mẫu </label>
          <div class="col-sm-10">
            <input type="text" name="type[]" value="`+ sample['type'] +`" class="form-control ig ig-type-`+ sampleIndex +`">
          </div>
        </div>
        
        <div class="row form-group">
          <label class="col-sm-6"> Số lượng mẫu </label>
          <div class="col-sm-10">
            <input type="text" name="number[]" value="`+ sample['number'] +`" class="form-control ig ig-number-`+ sampleIndex +`">
          </div>
        </div>
        
        <div class="row form-group">
          <label class="col-sm-6"> Tình trạng mẫu </label>
            <input type="radio" name="samplestatus-`+ sampleIndex +`" `+ (Number(sample['status']) ? 'checked' : '' ) +` class="form-control ig ig-status0-`+ sampleIndex +`"> Đạt<br>
            <input type="radio" name="samplestatus" `+ (Number(sample['status']) ? '' : 'checked' ) +` class="form-control ig ig-status1-`+ sampleIndex +`"> Không đạt
        </div>
        `+ html2 +`
        <button class="btn btn-info" onclick="addField('`+ sampleX +`,`+ resultX +`')"><span class="glyphicon glyphicon-plus"></span></button>
      </div>`
    })
    html = `<button class="btn btn-info" onclick="synchField()"><span class="glyphicon glyphicon-refresh"></span></button>`+ html +`<button class="btn btn-info" onclick="addField('`+ sampleX +`')"><span class="glyphicon glyphicon-plus"></span></button>`
    sample.html(html)
    installer.forEach(item => {
      installRemindv2(item['name'], item['type'])
    })
  }

  function checkSamplecode(samplecode, samplenumber) {
    var result = []
    var sampleListA = samplecode.split(', ')
    sampleListA.forEach((sampleA, sampleAIndex) => {
      if (sampleA.search('-') >= 0) {
        var sampleListB = sampleA.split('-')
        if (sampleListB.length == 2) {
          var sampleFrom = sampleListB[0]
          var sampleEnd = sampleListB[1]
          var liberateCount = (sampleFrom.length > sampleEnd.length ? sampleEnd.length : sampleFrom.length)
          var liberate = ''
          for (let i = 0; i < liberateCount; i++) {
            if (sampleFrom[i] == sampleEnd[i]) {
              liberate += sampleFrom[i]
            }
            else {
              break;
            }
          }
          var sampleNumber = liberate.length
          if (sampleNumber) {
            var sampleNumberFrom = Number(sampleFrom.slice(sampleNumber))
            var sampleNumberEnd = Number(sampleEnd.slice(sampleNumber))
            sampleListA[sampleAIndex] = sampleFrom
            for (let i = sampleNumberEnd; i > sampleNumberFrom; i--) {
              sampleListA.splice(sampleAIndex + 1, 0, liberate + i)
            }
            // return true
          }
          else {
            // reutrn false
          }
        }
        else {
          // return false
        }
      }
    })
    var result = (sampleListA.length == samplenumber ? true : false)
    if (!result) {
      alert_msg('Ký hiệu mẫu không khớp số lượng')
    }
    return {list: sampleListA, result: result}
  }

  function parseFieldTable(data) {
    var html = `  <table class="table-bordered" border="1">
    <tr>
      <th rowspan="2" style="width: 10px"> TT </th>
      <th rowspan="2" style="width: 50px"> Kí hiệu mẫu </th>
      <th rowspan="2" style="width: 50px"> Loại mẫu </th> 
      <th rowspan="2" style="width: 50px"> Số lượng </th>
      <th rowspan="2"> Tình trạng mẫu </th>
      <th colspan="3"> Yêu cầu thử nghiệm </th>
      <th rowspan="2"> Ghi chú </th>
    </tr>
    <tr>
      <th style="width: 50px"> Chỉ tiêu </th>
      <th> Phương pháp </th>
      <th> Kết quả </th>
    </tr>`
    var html2 = ''
    var index = 1

    data.forEach((sample, sampleIndex) => {
      var html3 = ''
      var noteCount = 0 
      var xcode = getInputs('xcode')
      sample['mainer'].forEach((result, resultIndex) => {
        var html4 = ''
        var mainerNoteCount = 0;
            
        if (result['note'].length > 1) {
          result['note'].forEach((note, noteIndex) => {
            noteCount ++
            mainerNoteCount ++
            html4 += `<td>`+ note['result'] +`</td> <td>`+ note['note'] +`</td></tr>`
          })
          html4 = `<td class="text-center" rowspan="`+ mainerNoteCount +`"> ` + result['main'] + `</td><td class="text-center" rowspan="`+ mainerNoteCount +`">`+ result['method'] + `</td>` + html4
        }
        else {
          noteCount ++
          html4 += `<td class="text-center"> ` + result['main'] + `</td><td class="text-center">`+ result['method'] + `</td><td>`+ result['note'][0]['result'] +`</td> <td>`+ result['note'][0]['note'] +`</td></tr>`
        }
        html3 += html4
      })

      html2 += '<tr><td rowspan="'+ noteCount +'" class="text-center">'+ (index++) +'</td><td rowspan="'+ noteCount +'" class="text-center">'+ (sample['code'] + '-' + parseIntNum(index - 1)) +'</td><td rowspan="'+ noteCount +'" class="text-center"> '+ sample['type'] +'</td><td rowspan="'+ noteCount +'" class="text-center"> '+ sample['number'] +' </td><td rowspan="'+ noteCount +'" class="text-center"> '+ (sample['status'] ? 'Đạt' : 'Không đạt') +' YCXN </td>' + html3;
    })

    html += html2 + '</table>'
    return html
  }

  function parseIntNum(number) {
    return ((number < 10 ? '0' : '') + number)
  }

  function parseFieldTable2(data) {
    var html = `  <table class="table-bordered" border="1">
    <tr>
      <th style="width: 50px"> KHM </th>
      <th style="width: 50px"> Số nhận diện </th>
      <th> Phương pháp XN </th> 
      <th> Kết quả </th>
      <th> Ghi chú </th>
    </tr>`
    var html2 = ''
    var index = 1

    data.forEach((sample, sampleIndex) => {
      var html3 = ''
      var noteCount = 0 

      sample['mainer'].forEach((result, resultIndex) => {
        var html4 = ''
        var mainerNoteCount = 0;
            
        if (result['note'].length > 1) {
          result['note'].forEach((note, noteIndex) => {
            noteCount ++
            mainerNoteCount ++
            html4 += `<td>`+ note['result'] +`</td> <td>`+ note['note'] +`</td></tr>`
          })
          html4 = `<td rowspan="`+ mainerNoteCount +`">`+ result['method'] + `</td>` + html4
        }
        else {
          noteCount ++
          html4 += `<td>`+ result['method'] + `</td><td>`+ result['note'][0]['result'] +`</td> <td>`+ result['note'][0]['note'] +`</td></tr>`
        }
        html3 += html4
      })

      html2 += '<tr><td rowspan="'+ noteCount +'" class="text-center">'+ sample['code'] +'</td><td rowspan="'+ noteCount +'" class="text-center">'+ (index++) +'</td>' + html3;
    })

    html += html2 + '</table>'
    return html
  }


  function getIgField() {
    var list = []
    var data = []
    $(".ig").each((index, item) => {
      list.push()
      className = item.getAttribute('class')
      var start = className.indexOf('ig-')
      var end = className.indexOf(' ', start)
      if (end < 0) {
        var pos = className.slice(start + 3) 
      }
      else {
        var pos = className.slice(start + 3, end) 
      }

      if (pos) {
        var poses = pos.split('-')
        var posesCount = poses.length
        switch (posesCount) {
          case 2:
            if (!data[poses[1]]) {
              data[poses[1]] = {}
            }
            if (poses[0].search('status') >= 0) {
              var id = poses[0].replace('status', '')
              if ($(".ig-" + pos)[0].checked) {
                data[poses[1]]['status'] = id
              }
            }
            else {
              data[poses[1]][poses[0]] = $(".ig-" + pos)[0].value
            }
          break;
          case 3:
            if (!data[poses[1]]['mainer']) {
              data[poses[1]]['mainer'] = []
            }
            if (!data[poses[1]]['mainer'][poses[2]]) {
              data[poses[1]]['mainer'][poses[2]] = {}
            }
            data[poses[1]]['mainer'][poses[2]][poses[0]] = $(".ig-" + pos)[0].value
          break;
          case 4:
            if (!data[poses[1]]) {
              data[poses[1]] = {}
            }
          
            if (!data[poses[1]]['mainer']) {
              data[poses[1]]['mainer'] = []
            }
            if (!data[poses[1]]['mainer'][poses[2]]) {
              data[poses[1]]['mainer'][poses[2]] = {}
            }

            if (!data[poses[1]]['mainer'][poses[2]]['note']) {
              data[poses[1]]['mainer'][poses[2]]['note'] = []
            }
            if (!data[poses[1]]['mainer'][poses[2]]['note'][poses[3]]) {
              data[poses[1]]['mainer'][poses[2]]['note'][poses[3]] = {}
            }
            data[poses[1]]['mainer'][poses[2]]['note'][poses[3]][poses[0]] = $(".ig-" + pos)[0].value            
          break;
        }
      }
    })
    return data
  }

  function addField(indexString) {
    var indexType = indexString.split(',')
    var indexCount = indexType.length

    switch (indexCount) {
      case 1:
        global_field.splice(Number(indexType[0]) + 1, 0, {
          code: '',
          type: '',
          number: 1,
          status: 1,
          mainer: [
            {
              main: '',
              method: '',
              note: [
                {
                  result: '',
                  note: ''
                }
              ]
            }
          ]
        })
      break;
      case 2:
        global_field[indexType[0]]['mainer'].splice(Number(indexType[1]) + 1, 0, {
          main: '',
          method: '',
          number: 1,
          note: [
            {
              result: '',
              note: ''
            }
          ]
        })
      break;
      case 3:
        global_field[indexType[0]]['mainer'][indexType[1]]['note'].splice(Number(indexType[2]) + 1, 0, {
          result: '',
          note: ''
        })     
      break;
    }
    parseField(global_field)
  }

  function removeField(indexString) {
    var indexType = indexString.split(',')
    var indexCount = indexType.length
    switch (indexCount) {
      case 1:
        
        global_field = global_field.filter((item, index) => {
          return index != indexType[0]
        })
      break;
      case 2:
        global_field[indexType[0]]['mainer'] = global_field[indexType[0]]['mainer'].filter((item, index) => {
          return index != indexType[1]
        })        
      break;
      case 3:
        global_field[indexType[0]]['mainer'][indexType[1]]['note'] = global_field[indexType[0]]['mainer'][indexType[1]]['note'].filter((item, index) => {
          return index != indexType[2]
        })
      break;
    }
    
    parseField(global_field)
  }

  function selectRemind(name, selectValue) {
    globalTarget[name]['input'].val(selectValue)
  }

  function selectRemindv2a(id, selectValue) {
    $(id).val(selectValue)
  }

  function insertMethod() {
    methodModal.modal('show')
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
              html += '<div class="suggest_item" onclick="selectRemind(\'' + name + '\', \'' + remind[globalTarget[name]['data']][index]['value'] + '\')"><span class="right-click">' + remind[globalTarget[name]['data']][index]['value'] + '</span><button class="close right" data-dismiss="modal" onclick="removeRemind('+remind[globalTarget[name]['data']][index]['id']+', \''+name+'\')">&times;</button></div>'
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

  function installRemindv2(name, type) {
    var timeout
    var input = $("#"+ type +"-" + name)
    var suggest = $("#"+ type +"-suggest-" + name)
    
    input.keyup(() => {
      clearTimeout(timeout)
      setTimeout(() => {
        var key = paintext(input.val())
        var html = ''
        
        for (const index in remindv2[type]) {
          if (remindv2[type].hasOwnProperty(index)) {
            const element = paintext(remindv2[type][index]['name']);
            
            if (element.search(key) >= 0) {
              html += '<div class="suggest_item" onclick="selectRemindv2(\'' + name + '\', \'' + type + '\', \'' + remindv2[type][index]['name'] + '\')"><p class="right-click">' + remindv2[type][index]['name'] + '</p><button class="close right" data-dismiss="modal" onclick="removeRemindv2(\'' + name + '\', \'' + type + '\', ' + remindv2[type][index]['id']+')">&times;</button></div>'
            }
          }
        }
        suggest.html(html)
      }, 200);
    })
    input.focus(() => {
      suggest.show()
    })
    input.blur(() => {
      setTimeout(() => {
        suggest.hide()
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
            setTimeout(() => {
              globalTarget[name][input].val('')
            }, 100);
          }, () => {})
        }
      )
    }
  }

  function removeRemindv2(name, type) {
    if (id) {
      $.post(
        strHref,
        {action: 'removeRemindv2', id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            remindv2 = JSON.parse(data['remind'])
            $("#"+ type +"-" + name).val('')
          }, () => {})
        }
      )
    }
  }

  function selectRemindv2(name, type, value) {
    $("#"+ type +"-" + name).val(value)
  }

  function selectMethod(name, value) {
    $("#method-" + name).val(value)
  }

  function removeMethod(id, name) {
    if (id) {
      $.post(
        strHref,
        {action: 'removeMethod', id: id},
        (response, status) => {
          checkResult(response, status).then(data => {
            method = JSON.parse(data['method'])
            setTimeout(() => {
              $("#method-" + name).val('')
            }, 100);
          }, () => {})
        }
      )
    }
  }

  function newForm() {
    global_id = 0
    global_form = 1
    global_saved = 0
    parseSaved()
    parseBox(global_form)
    formInsertOwnerPhone.val('')
    formInsertOwnerMail.val('')
    formInsertCode.val('')
    formInsertSenderEmploy.val('')
    formInsertReceiverEmploy.val('')
    formInsertReceive.val('')
    formInsertResend.val('')
    formInsertExamSample.val('')
    formInsertIreceive.val('')
    formInsertIresend.val('')
    formInsertNumber.val('')
    formInsertSample.val('')
    formInsertStatus.val('')
    formInsertSampleCode.val('')
    formInsertSampleCode5.val('')
    formInsertTarget.val('')
    formInsertXcode1.val('')
    formInsertXcode2.val('')
    formInsertXcode3.val('')
    formInsertPage1.val('')
    formInsertPage2.val('')
    formInsertNo1.val('')
    formInsertNo2.val('')
    formInsertIsenderEmploy.val('')
    formInsertIsenderUnit.val('')
    formInsertIreceiverEmploy.val('')
    formInsertIreceiverUnit.val('')
    formInsertQuality.val('')
    formInsertCustomer.val('')
    formInsertNumberWord.val('')
    formInsertAddress.val('')
    formInsertPhone.val('')
    formInsertSampleReceive.val('')
    formInsertExamDate.val('')
    formInsertOther.val('')
    formInsertResult.val('')
    formInsertIreceiverEmploy.val('')
    formInsertIreceiverUnit.val('')
    formInsertTarget.val('')
    formInsertEndedCopy.val('')
    formInsertSampleReceiver.val('')
    formInsertNote.val('')
    formInsertReceiveDis.val('')
    formInsertReceiveLeader.val('')
    formInsertXaddress.val('')
    formInsertOwner.val('')
    formInsertSamplePlace.val('')
    formInsertXreceive.val('')
    formInsertXreceiver.val('')
    formInsertXresend.val('')
    formInsertXresender.val('')
    formInsertXsend.val('')
    formInsertXsender.val('')
    formInsertXexam.val('')
    formInsertXphone.val('')
    formInsertFax.val('')
    formInsertVnote.val('')
    global_field = [{
      code: '',
      type: '',
      number: 1,
      status: true,
      mainer: [
        {
          main: '',
          method: '',
          note: [
            {
              result: '',
              note: ''
            }
          ]
        }
      ]
    }]
    parseField(global_field)
    global_exam = [{
      method: '',
      symbol: '',
      exam: ['']
    }]
    parseExam(global_exam)

    formInsertEndedHour.each((index, item) => {
      item.removeAttribute('selected')
    })
    formInsertEndedHour[0].children[0].setAttribute('selected', true)

    formInsertEndedMinute.each((index, item) => {
      item.removeAttribute('selected')
    })
    formInsertEndedMinute[0].children[0].setAttribute('selected', true)

    formInsertSampleReceiveHour.each((index, item) => {
      item.removeAttribute('selected')
    })
    formInsertSampleReceiveHour[0].children[0].setAttribute('selected', true)

    formInsertSampleReceiveMinute.each((index, item) => {
      item.removeAttribute('selected')
    })
    formInsertSampleReceiveMinute[0].children[0].setAttribute('selected', true)

    $(".formed").each((index, item) => {
      removeInfo(1, index)
    })
    $(".examed").each((index, item) => {
      removeInfo(2, index)
    })
    $(".resulted").each((index, item) => {
      removeInfo(3, index)
    })
    infoData = {1: [], 2: [], 3: []}
    addInfo(1)
    addInfo(3)
    $(".type").prop('checked', false)
    $(".state").prop('checked', false)

    $("#typed-0").prop('checked', true)
    $("#state-0").prop('checked', true)
    formInsertReceiverStateOther.val('')
    formInsertTypeOther.val('')
  }

  function summary() {
    formSummary.modal('show')
  }

  function summaryFilter() {
    $.post(
      strHref,
      {action: 'summaryFilter', from: formSummaryFrom.val(), end: formSummaryEnd.val(), unit: formSummaryUnit.val(), exam: formSummaryExam.val(), sample: formSummarySample.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          formSummaryContent.html(data['html'])
        }, () => {  })
      }
    )
  }

  function insert() {
    formInsert.modal('show')
  }

  function installExamRemind() {
    $(".examed").each((index, item) => {
      var id = item.getAttribute('id').replace('examed-', '')
      var timeout
      
      $("#examed-" + id).keyup(() => {
        clearTimeout(timeout)
        setTimeout(() => {
          var key = paintext(item.value)
          var html = ''
          for (const index in remind[3]) {
            if (remind[3].hasOwnProperty(index)) {
              const element = paintext(remind[3][index]['value']);
              
              if (element.search(key) >= 0) {
                html += '<div class="suggest_item" onclick="selectRemindv2a(\'' + '#examed-' + id + '\', \'' + remind[3][index]['value'] + '\')"><span class="right2-click">' + remind[3][index]['value'] + '</span><button class="close right" data-dismiss="modal" onclick="removeRemind('+remind[3][index]['id']+', \''+'#examed-' + id+'\')">&times;</button></div>'
              }
            }
          }
          $("#exam-suggest-" + id).html(html)
        }, 200);
      })
      $("#examed-" + id).focus(() => {
        $("#exam-suggest-" + id).show()
      })
      $("#examed-" + id).blur(() => {
        setTimeout(() => {
          $("#exam-suggest-" + id).hide()
        }, 200);
      })
    })
  }

  function installResultRemind() {
    $(".resulted").each((index, item) => {
      var id = item.getAttribute('id').replace('resulted-', '')
      var timeout
      
      $("#resulted-" + id).keyup(() => {
        clearTimeout(timeout)
        setTimeout(() => {
          var key = paintext(item.value)
          var html = ''
          for (const index in remind[6]) {
            if (remind[6].hasOwnProperty(index)) {
              const element = paintext(remind[6][index]['value']);
              
              if (element.search(key) >= 0) {
                html += '<div class="suggest_item" onclick="selectRemindv2(\'' + '#resulted-' + id + '\', \'' + remind[6][index]['value'] + '\')"><span class="right-click">' + remind[6][index]['value'] + '</span><button class="close right" data-dismiss="modal" onclick="removeRemind('+remind[6][index]['id']+', \''+'#resulted-' + id+'\')">&times;</button></div>'
              }
            }
          }
          $("#resulted-suggest-" + id).html(html)
        }, 200);
      })
      $("#resulted-" + id).focus(() => {
        $("#resulted-suggest-" + id).show()
      })
      $("#examed-" + id).blur(() => {
        setTimeout(() => {
          $("#exam-suggest-" + id).hide()
        }, 200);
      })
    })
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
              <label class="col-sm-6"> Tên hồ sơ </label>
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box form" id="formed-` + length + `">
                <div class="suggest" id="formed-suggest-` + length + `"></div>
              </div>
            </div>
          </div>`
          
          formInsertForm.append(html)
          infoData[1].forEach(item => {
            installRemindv2('formed', 'form')
          })
        break;
      case 2:
        var html = `
          <div class="examed bordered" id="exam-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(2, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-4"> Phương pháp </label>
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box method" id="method-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest" id="method-suggest-` + length + `"> </div>
              </div>
            </div>
            <div class="row">
              <label class="col-sm-4"> Ký hiệu </label>
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box symbol" id="symbol-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest" id="symbol-suggest-` + length + `"> </div>
              </div>
            </div>
            <div class="row">
              <label class="col-sm-4"> Yêu cầu </label>
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box exam examed" id="examed-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest exam-suggest" id="exam-suggest-` + length + `"> </div>
              </div>
            </div>
          </div>`
        formInsertRequest.append(html)
        installRemindv2(length, 'symbol')
        installRemindv2(length, 'method')
        installExamRemind()
      break;
      case 3:
        var html = `
          <div class="resulted" id="result-` + length + `">
            <button type="button" class="close" data-dismiss="modal" onclick="removeInfo(3, ` + length + `)">&times;</button>
            <br>
            <div class="row">
              <label class="col-sm-4"> Kết quả </label>
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box resulted resulted" id="resulted-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest resulted-suggest" id="resulted-suggest-` + length + `"> </div>
              </div>
            </div>
          </div>`
        formInsertResult.append(html)
        installResultRemind()
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
      case 3:
        $("#result-" + index).remove()
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

  // function checkSampleCode(target, parent, number = 1) {
  //   var value = trim(target.val()).toUpperCase()
  //   while (value.search('  ') >= 0) {
  //     value = value.replace(/  /g, ' ')
  //   }
  //   value = value.replace(/;/g, ',')
  //   value = value.split(/, /g)
  //   target.val(value.join(', '))
    
  //   if (value.length != number) {
  //     parent.addClass('has-error')
  //     alert_msg('Sai số lượng ký hiệu mẫu: ' + value.length + '/' + number);
  //     return 0
  //   }
  //   parent.removeClass('has-error')
  //   return 1
  // }

  function remove(id) {
    formRemove.modal('show')
    global_id = id
  }

  function removeSubmit() {
    $.post(
      strHref, 
      {action: 'remove', id: global_id, page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val(), other: getFilter()},
      (response, status) => {
        checkResult(response, status).then(data => {
          content.html(data['html'])
          formRemove.modal('hide')
        }, () => {})
      }
    )
  }
//
  function checkForm(id) {
    var data = {}
    switch (id) {
      case 1:
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          data = {
            code: formInsertCode.val(),
            sender: formInsertSenderEmploy.val(),
            receive: formInsertReceive.val(),
            resend: formInsertResend.val(),
            state: getCheckbox('state', formInsertReceiverStateOther),
            receiver: formInsertReceiverEmploy.val(),
            ireceive: formInsertIreceive.val(),
            iresend: formInsertIresend.val(),
            form: getInputs('form', ') '),
            forms: getInputs('form'),
            number: formInsertNumber.val(),
            sample: formInsertSample.val(),
            type: getCheckbox('type', formInsertTypeOther),
            samplecode: formInsertSampleCode.val(),
            exam: getExam(),
            xnote: formInsertXnote.val(),
            numberword: formInsertNumberWord.val(),
          }
        }
      break;
      case 2: 
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          data = {
            xcode: getInputs('xcode'),
            isenderunit: formInsertIsenderUnit.val(),
            ireceiverunit: formInsertIreceiverUnit.val(),
            xreceiver: formInsertXreceiver.val(),
            xsender: formInsertXsender.val(),
            xresender: formInsertXresender.val(),
            examdate: formInsertExamDate.val(),
            iresend: formInsertIresend.val(),
            xreceive: formInsertXreceive.val(),
            xsend: formInsertXsend.val(),
            result: formInsertResult.val(),
            xresend: formInsertXresend.val(),
            note: formInsertCnote.val(),
            ig: getIgField()
          }
        }
      break;
      case 3:
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          data = {
            xcode: getInputs('xcode'),
            vnote: formInsertVnote.val(),
            xexam: formInsertXexam.val(),
            xresender: formInsertXresender.val(),
            ig: getIgField()
          }
        }
      break;            
      case 4:
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          data = {
            receive: formInsertReceive.val(),
            xcode: getInputs('xcode'),
            receivehour: formInsertSampleReceiveHour.val(),
            receiveminute: formInsertSampleReceiveMinute.val(),
            type: getCheckbox('type', formInsertTypeOther),
            number: formInsertNumber.val(),
            status: getCheckbox('status'),
            samplecode5: formInsertSampleCode5.val(),
            isenderunit: formInsertIsenderUnit.val(), 
            address: formInsertAddress.val(),
            fax: formInsertFax.val(),
            xphone: formInsertXphone.val(),
            samplereceive: formInsertSampleReceive.val(),
            samplereceiver: formInsertSampleReceiver.val(),
            examdate: formInsertExamDate.val(),
            result: formInsertResult.val(),
            sample: formInsertSample.val(),
            note: formInsertNote.val(),
            ireceiveremploy: formInsertIreceiverEmploy.val(),
            numberword: formInsertNumberWord.val(),
            exam: getExam()
          }
        }
      break;
      case 5:
        var sampleCode = checkSamplecode(formInsertSampleCode.val(), formInsertNumber.val())
        if (sampleCode['result']) {
          data = {
            xcode: getInputs('xcode'),
            sender: formInsertSenderEmploy.val(),
            resend: formInsertNoticeTime.val(),
            xaddress: formInsertXaddress.val(),
            number: formInsertNumber.val(),
            samplecode5: formInsertSampleCode5.val(),
            examsample: formInsertExamSample.val(),
            target: formInsertTarget.val(),
            note: formInsertNote.val(),
            receivedis: formInsertReceiveDis.val(),
            receiveleader: formInsertReceiveLeader.val(),
            sampleplace: formInsertSamplePlace.val(),
            sample: formInsertSample.val(),
            owner: formInsertOwner.val(),
            exam: getExam(),
            result: formInsertResult.val(),
            receive: formInsertReceive.val(),
            ownerphone: formInsertOwnerPhone.val(),
            ownermail: formInsertOwnerMail.val(),
            numberword: formInsertNumberWord.val(),
            type: getCheckbox('type', formInsertTypeOther),
          }
        }
      break;
    }
    return data
  }

  function edit(id) {
    $.post(
      strHref,
      {action: 'getForm', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          newForm()
          global_id = id
          global_form = global_printer
          global_saved = data['form']['printer']
          parseSaved()
          
          parseBox(global_form)
          infoData = {1: [], 2: [], 3: []}

          if (data['form']['printer'] >= 1) {
            try {
              temp = JSON.parse(data['form']['exam'])
              global_exam = temp
            }
            catch (e) {
              global_exam = [{
                method: '',
                symbol: '',
                exam: ['']
              }]
            }
            parseExam(global_exam)
            
            formInsertCode.val(data['form']['code'])
            formInsertSenderEmploy.val(data['form']['sender'])
            formInsertReceiverEmploy.val(data['form']['receiver'])
            formInsertReceive.val(data['form']['receive'])
            formInsertResend.val(data['form']['resend'])
            formInsertIreceive.val(data['form']['ireceive'])
            formInsertIresend.val(data['form']['iresend'])
            formInsertNumber.val(data['form']['number'])
            formInsertSample.val(data['form']['sample'])
            formInsertSampleCode.val(data['form']['samplecode'])
            formInsertXnote.val(data['form']['xnote'])
            formInsertNumberWord.val(data['form']['numberword']),

            parseInputs(data, 'form')
            $("#typed-" + data['form']['typeindex']).prop('checked', true)
            if (data['form']['typeindex'] == 5) {
              formInsertTypeOther.val(data['form']['typevalue'])
            }
            $("#state-" + data['form']['stateindex']).prop('checked', true)
            if (data['form']['stateindex'] == 2) {
              formInsertReceiverStateOther.val(data['form']['statevalue'])
            }
          }

          if (data['form']['printer'] >= 2) {
            var xcode = data['form']['xcode'].split(',')
            formInsertCnote.val(data['form']['note'])
            formInsertXcode1.val(xcode[0])
            formInsertXcode2.val(xcode[1])
            formInsertXcode3.val(xcode[2])
            formInsertIsenderUnit.val(data['form']['isenderunit'])
            formInsertIreceiverUnit.val(data['form']['ireceiverunit'])
            parseField(JSON.parse(data['form']['ig']))
            formInsertExamDate.val(data['form']['examdate'])
            formInsertIresend.val(data['form']['iresend'])
            formInsertXreceive.val(data['form']['xreceive'])
            formInsertXreceiver.val(data['form']['xreceiver'])
            formInsertXresend.val(data['form']['xresend'])
            formInsertXresender.val(data['form']['xresender'])
            formInsertXsend.val(data['form']['xsend'])
            formInsertXsender.val(data['form']['xsender'])
            formInsertResult.val(data['form']['result'])
          }

          if (data['form']['printer'] >= 3) {
            formInsertXexam.val(data['form']['xexam'])
            formInsertVnote.val(data['form']['vnote'])
          }

          if (data['form']['printer'] >= 4) {
            formInsertNote.val(data['form']['note'])
            formInsertIreceiverEmploy.val(data['form']['ireceiveremploy'])
            formInsertXphone.val(data['form']['xphone'])
            formInsertSampleReceiver.val(data['form']['samplereceiver'])
            formInsertSampleReceive.val(data['form']['samplereceive'])
            formInsertAddress.val(data['form']['address'])
            formInsertFax.val(data['form']['fax'])
            formInsertSampleCode5.val(data['form']['samplecode5'])
          }

          if (data['form']['printer'] >= 5) {
            formInsertOwnerPhone.val(data['form']['ownerphone'])
            formInsertOwnerMail.val(data['form']['ownermail'])
            formInsertReceiveLeader.val(data['form']['receiveleader'])
            formInsertOwner.val(data['form']['owner'])
            if (data['form']['noticetime']) {
              formInsertNoticeTime.val(data['form']['noticetime'])
            }
            else {
              formInsertNoticeTime.val(today)
            }
            formInsertSamplePlace.val(data['form']['sampleplace'])
            formInsertXaddress.val(data['form']['xaddress'])
            formInsertTarget.val(data['form']['target'])
            formInsertReceiveDis.val(data['form']['receivedis'])
            formInsertExamSample.val(data['form']['examsample'])
          }
          
          $('a[href="#menu1"]').tab('show')
        }, () => {})
      }
    )
  }

  function insertSubmit() {
    var data = checkForm(global_form)
    if (Object.keys(data).length) {
      $.post(
        strHref,
        {action: 'insert', form: global_form, id: global_id, data: data, page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val(), other: getFilter()},
        (response, status) => {
          checkResult(response, status).then(data => {
            remind = JSON.parse(data['remind'])
            remindv2 = JSON.parse(data['remindv2'])
            if (global_form > global_saved) {
              global_saved = global_form
            }
            parseSaved()
            content.html(data['html'])
            global_id = data['id']
          }, () => {})
        }
      )
    }
    else {
      
    }
  }

  function filter(e) {
    e.preventDefault()
    $.post(
      strHref,
      {action: 'filter', page: 1, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val(), other: getFilter(), xcode: filterXcode.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global_page = 1
          global_printer = filterPrinter.val()
          content.html(data['html'])
        }, () => {})
      }
    )
  }

  function goPage(page) {
    $.post(
      strHref,
      {action: 'filter', page: page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
      (response, status) => {
        checkResult(response, status).then(data => {
          global_page = page
          content.html(data['html'])
        }, () => {})
      }
    )
  }

  function findMethod(value) {
    for (const key in method) {
      item = method[key];
      if (item['name'] == value) {
        return item['symbol']
      }
    }
    return ''
  }

  function preview(id, printercount) {
    $.post(
      strHref,
      {action: 'preview', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          data['exam'] = JSON.parse(data['exam'])
          data['ig'] = JSON.parse(data['ig'])
          printer(printercount, data)
        }, () => {})
      }
    )
  }

  function extractExam(data, tag) {
    var list = []
    var result = []
    var index = 0

    data.forEach(main => {
      main['exam'].forEach(item => {
        list.push(item)
      })
    })
    var length = list.length
    list.forEach(item => {
      
      if (length > 1 && tag) {
        index ++
        result.push(index + tag + ' ' + item)
      }
      else {
        result.push(item)
      }
    })
    return result
  }

  function printer(id, data = {}) {
    if (Object.keys(data).length || visible[global_saved][2].search(id) >= 0) {
      if (!Object.keys(data).length) {
        var data = checkForm(id)
      }
      
      if (Object.keys(data).length) {
        var html = former[id]
        id = Number(id)
        var prop = 0
        switch (id) {
          case 1:
            html = html.replace('code', data['code'])
            html = html.replace('senderemploy', data['sender'])
            html = html.replace('receiveremploy', data['receiver'])
            html = html.replace('receive', data['receive'])
            html = html.replace('resend', data['resend'])
            html = html.replace('ireceive', data['ireceive'])
            html = html.replace('iresend', data['iresend'])
            html = html.replace('status-0', data['state']['index'] == 0 ? '&#9745;' : '&#9744;')
            html = html.replace('status-1', data['state']['index'] == 1 ? '&#9745;' : '&#9744;')
            html = html.replace('status-2', data['state']['index'] == 2 ? data['state']['value'] : '')
            html = html.replace('numberword', data['numberword'])
            var exam = extractExam(data['exam'], ')')

            html = html.replace('formcontent', (data['form'].join('<br>') + '<br>Số lượng mẫu: ' + data['number'] + ', loại mẫu: ' + (data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text())) + ', loài động vật: ' + data['sample'] + '<br> Ký hiệu mẫu: ' + data['samplecode'].replace('-', ' đến ') + '<br>Yêu cầu xét nghiệm:<br>' + (exam.join('<br>') + (trim(data['xnote']).length ? '<br>' + data['xnote'].replace(/\n/g, '<br>') : ''))))
          break;
          case 2:
            prop = 1
            resend = data['iresend'].split('/')
            xresend = data['xresend'].split('/')
            xreceive = data['xreceive'].split('/')
            xsend = data['xsend'].split('/')
            
            html = html.replace('isenderunit', data['isenderunit'])
            html = html.replace('ireceiverunit', data['ireceiverunit'])
            html = html.replace('xcode-0', trim(data['xcode'][0]))
            html = html.replace('xcode-1', trim(data['xcode'][1]))
            html = html.replace('xcode-2', trim(data['xcode'][2]))
            html = html.replace('resend-0', resend[0])
            html = html.replace('resend-1', resend[1])
            html = html.replace('resend-2', resend[2])
            html = html.replace('xresend-0', xresend[0])
            html = html.replace('xresend-1', xresend[1])
            html = html.replace('xresend-2', xresend[2])
            html = html.replace('xreceive-0', xreceive[0])
            html = html.replace('xreceive-1', xreceive[1])
            html = html.replace('xreceive-2', xreceive[2])
            html = html.replace('xsend-0', xsend[0])
            html = html.replace('xsend-1', xsend[1])
            html = html.replace('xsend-2', xsend[2])
            html = html.replace('examdate', data['examdate'])
            html = html.replace('iresend', data['iresend'])
            html = html.replace('xsender', ucword(data['xsender']))
            html = html.replace('xreceiver', ucword(data['xreceiver']))
            html = html.replace('xresender', ucword(data['xresender']))
            if (trim(data['result'])) {
              html = html.replace('(result)', '<br>- Kết quả: ' + data['result'].replace(/\n/g, '; '))
            }
            else {
              html = html.replace('(result)', '')
            }
            html = html.replace('xtable', parseFieldTable(data['ig']))
            data['note'] = trim(data['note'])
            if (data['note']) {
              html = html.replace('(note)', data['note'].replace(/\n/g, '; ') + '<br>')
            }
            else {
              html = html.replace('(note)', '')
            }
          break;
          case 3:
            html = html.replace(/xcode-0/g, trim(data['xcode'][0]))
            html = html.replace(/xcode-1/g, trim(data['xcode'][1]))
            html = html.replace(/xcode-2/g, trim(data['xcode'][2]))
            html = html.replace(/xexam/g, ucword(data['xexam']))
            html = html.replace(/receiveleader/g, ucword(data['xresender']))
            html = html.replace('xtable', parseFieldTable2(data['ig']))
            html = html.replace('(vnote)', data['vnote'].replace(/\n/g, '<br>'))
          break;
          case 4:
            var receive = data['receive'].split('/')
            var examdate = data['examdate'].split('/')
            html = html.replace(/xcode-0/g, trim(data['xcode'][0]))
            html = html.replace(/xcode-1/g, trim(data['xcode'][1]))
            html = html.replace(/xcode-2/g, trim(data['xcode'][2]))
            html = html.replace('(customer)', data['isenderunit'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['samplecode5'])

            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(sample)', data['sample'])
            html = html.replace('(receiveHour)', data['receivehour'])
            html = html.replace('(receiveMinute)', data['receiveminute'])
            html = html.replace('(address)', data['address'])
            html = html.replace('(phone)', data['xphone'])
            html = html.replace('(fax)', data['fax'])
            html = html.replace('(type)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('(status)', ticked[data['status']['index']] + ' yêu cầu xét nghiệm')
            html = html.replace('(sampleReceive)', data['samplereceive'])
            html = html.replace('(sampleReceiver)', data['samplereceiver'])
            html = html.replace('(ireceive)', data['receive'])
            html = html.replace('(ireceiver)', data['ireceiveremploy'])
            html = html.replace('(examDate)', data['examdate'])
            html = html.replace(/examdate-0/g, examdate[0])
            html = html.replace(/examdate-1/g, examdate[1])
            html = html.replace(/examdate-2/g, examdate[2])
            html = html.replace('(result)', data['result'].replace(/\n/g, '<br>'))
            var noteString = ''
            if (trim(data['note'])) {
              // (note)
              var note = data['note'].split('\n');
              var notes = []
              note.forEach(item => {
                notes.push('<i>' + item + '</i>')
              })
              noteString += '<u style="display: inline-block"><b>Ghi chú:</b></u> <div style="display: inline-table">' + notes.join('<br>') + '</div>'
            }
            html = html.replace('(note)', noteString)

            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var parse = ''
            var examS = extractExam(data['exam']).length
            var index = 1
            data['exam'].forEach(main => {
              main['exam'].forEach(exam => {
                var temp = part 
                if (examS > 1) {
                  temp = temp.replace('(index)', (index++) + '. ')
                }
                else {
                  temp = temp.replace('(index)', '')
                }
                
                temp = temp.replace('(exam-content)', exam)
                temp = temp.replace('(method)', main['method'])
                temp = temp.replace('(symbol)', main['symbol'])
                parse += temp
              })
            })
            html = html.replace('(parse)', parse)
          break;
          case 5:
            var iresend = data['resend'].split('/')
            var tabbed = '&emsp;&emsp;'
            
            html = html.replace('xcode-0', trim(data['xcode'][0]))
            html = html.replace('xcode-1', trim(data['xcode'][1]))
            html = html.replace('xcode-2', trim(data['xcode'][2]))
            
            html = html.replace('(code)', data['code'])
            html = html.replace('noticetime-0', iresend[0])
            html = html.replace('noticetime-1', iresend[1])
            html = html.replace('noticetime-2', iresend[2])
            html = html.replace('senderemploy', data['sender'])
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('xaddress', data['xaddress'])
            html = html.replace('samplecode', data['samplecode5'])
            html = html.replace('(examsample)', data['examsample'])
            html = html.replace('(sample)', data['sample'])
            html = html.replace('sampletime', data['receive'])
            html = html.replace('(sampletype)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('number', data['number'])
            
            if (trim(data['target']).length) {
              html = html.replace('target', '<p class="p14"> &emsp;&emsp; Mục đích xét nghiệm: '+ data['target']) +' </p>'
            }
            else {
              html = html.replace('target', '')
            }

            if (data['owner']) {
              var x = '<p class="p14"> &emsp;&emsp; Thông tin mẫu:</p> <p class="p14"> &emsp;&emsp;&emsp; Chủ hộ: (owner)</p> <p class="p14"> &emsp;&emsp;&emsp; Nơi lấy mẫu: (sampleplace)</p>'
              x = x.replace('(sampleplace)', data['sampleplace'])
              x = x.replace('(owner)', data['owner'])
              html = html.replace('owner', x)
            }
            else {
              html = html.replace('owner', '')
            }

            var length = data['exam'].length
            var part = '<p>&emsp;&emsp; (index)(content), Phương pháp xét nghiệm: (method); Ký hiệu phương pháp: (symbol)(dot)</p>'
            var parse = ''
            var examS = extractExam(data['exam']).length
            var index = 1
            
            data['exam'].forEach(main => {
              main['exam'].forEach(exam => {
                var temp = part 
                if (examS > 1) {
                  if (index == examS) {
                    temp = temp.replace('(dot)', '.')
                  }
                  else {
                    temp = temp.replace('(dot)', ';')
                  }
                  temp = temp.replace('(index)', (index ++) + '. ')
                }
                else {
                  temp = temp.replace('(index)', '')
                }
                temp = temp.replace('(content)', exam)
                temp = temp.replace('(method)', main['method'])
                temp = temp.replace('(symbol)', main['symbol'])
                parse += temp
              })
            })
            
            html = html.replace('(exam)', parse)
            html = html.replace('result', tabbed + data['result'].replace(/\n/g, '<br>' + tabbed))
            var owner = ''
            if (trim(data['ownermail']) || trim(data['ownerphone'])) {
              owner += '<p style="width: 60%; float: left;" class="p14"> &emsp;&emsp; Số điện thoại: '+data['ownerphone']+'</p><p style="width: 35%; float: left; " class="p14">Email: '+data['ownermail']+'</p>'
            }
            html = html.replace('(info)', owner)
            var noteString = ''
            if (trim(data['note'])) {
              // (note)
              var note = data['note'].split('\n');
              var notes = []
              note.forEach(item => {
                notes.push('<i>' + item + '</i>')
              })
              noteString += '<div class="p14"> <u style="display: inline-block"><b>Ghi chú:</b></u> <span style="display: inline-table">' + notes.join('<br>') + '</span></div>'
            }
            html = html.replace('note', noteString)
            html = html.replace('receivedis', data['receivedis'].replace(/\n/g, '<br>'))
            receiveleader = ucword(data['receiveleader'])
            // receiveleader = trim().replace(/\b[a-z]/g, function(letter) {
            //   return letter.toUpperCase();
            // });
            html = html.replace('receiveleader', receiveleader)
          break;
        }
        
        // console.log(html);
        
        var html = '<style>' + style + profile[prop] + '</style>' + html
        var winPrint = window.open('', '', 'left=0,top=0,width=800,height=600,toolbar=0,scrollbars=0,status=0');
        winPrint.focus()
        winPrint.document.write(html);
        winPrint.print()
        winPrint.close()
      }
    }
  }

  function ucword(str) {
  str = str.toLowerCase();
  return str.replace(/(^([a-zA-Z\p{M}]))|([ -][a-zA-Z\p{M}])/g,
  	function(s){
  	  return s.toUpperCase();
	});
};
</script>
<!-- END: main -->
