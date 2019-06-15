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
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control" id="filter-keyword" placeholder="Mẫu phiếu" autocomplete="off">
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
        <div class="col-sm-6"><button class="btn btn-info"><span class="glyphicon glyphicon-search"></span></button></div>
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
    
    <div class="row form-group boxed box-2 box-2-1 box-3 box-3-1 box-21 box-21-1 box-31 box-31-2 box-4 box-4-1 box-5 box-5-15">
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

    <div class="row form-group boxed box-1 box-1-3 box-21 box-21-3 box-31 box-31-1 box-4 box-4-15 box-5 box-5-10">
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

    <div class="row form-group boxed box-1 box-1-8 box-2 box-2-6 box-3 box-3-6">
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

    <div class="row form-group boxed box-2 box-2-2 box-3 box-3-2 box-21 box-21-5 box-31 box-31-5 box-4 box-4-2">
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

    <div class="row form-group boxed box-5 box-5-4">
      <label class="col-sm-6">
        Chủ hộ
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-owner" autocomplete="off">
        <div class="suggest" id="form-insert-owner-suggest"></div>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-5">
      <label class="col-sm-6">
        Nơi lấy mẫu
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-sample-place" autocomplete="off">
        <div class="suggest" id="form-insert-sample-place-suggest"></div>
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

    <div class="row form-group boxed box-2 box-2-3 box-3 box-3-3 box-21 box-21-7">
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
        <input type="text" class="form-control" id="form-insert-xphone" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-21 box-21-8 box-4 box-4-5">
      <label class="col-sm-6">
        fax
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-fax" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-10 box-21 box-21-13 box-31 box-31-7 box-4 box-4-8 box-5 box-5-7">
      <label class="col-sm-6"> Số lượng mẫu </label>
      <div class="col-sm-12">
        <input type="number" class="form-control" id="form-insert-number" autocomplete="off">
      </div>
    </div>

    <div class="form-group row boxed box-1 box-1-11 box-21 box-21-14 box-31 box-31-8 box-4 box-4-9 box-5 box-5-8">
      <label class="col-sm-6"> Số lượng mẫu (Chữ) </label>
      <div class="col-sm-12">
        <input type="text" class="form-control" id="form-insert-number-word" autocomplete="off">
      </div>
    </div>

    <div class="boxed box-1 box-1-12 box-21 box-21-9 box-31 box-31-6 box-4 box-4-7 box-5 box-5-6">
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

    <div class="form-group row boxed box-1 box-1-13 box-21 box-21-10 box-31 box-31-9 box-4 box-4-6">
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

    <div class="form-group row boxed box-1 box-1-14 box-21 box-21-16 box-31 box-31-10 box-4 box-4-10 box-5 box-5-9">
      <label class="col-sm-6"> Ký hiệu mẫu </label>
      <div class="col-sm-12" id="form-insert-sample-parent">
        <input type="text" class="form-control" id="form-insert-sample-code" autocomplete="off">
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

    <div class="boxed box-1 box-1-15 box-21 box-21-20 box-31 box-31-12 box-4 box-4-17 box-5 box-5-12">
      <label>
        Yêu cầu xét nghiệm
        <button class="btn btn-success" onclick="insertMethod()"> <span class="glyphicon glyphicon-plus"></span> </button>
      </label>
      <div id="form-insert-request"></div>
      <button class="btn btn-success" onclick="addInfo(2)">
        <span class="glyphicon glyphicon-plus"></span>
      </button>
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

    <div class="row form-group boxed box-5 box-5-14 box-4 box-4-21">
      <label class="col-sm-6">
        Kết quả
      </label>
      <div class="col-sm-12">
        <textarea class="form-control" id="form-insert-result"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-13 box-4 box-4-19">
      <label class="col-sm-6">
        Ghi chú
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-note"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-5 box-3 box-3-5 box-4 box-4-20">
      <label class="col-sm-6">
        Ngày phân tích
      </label>
      <div class="relative col-sm-12">
        <input type="text" class="form-control" id="form-insert-exam-date" autocomplete="off">
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-16">
      <label class="col-sm-6">
        Nơi nhận
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-receive-dis"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-17">
      <label class="col-sm-6">
        Người phụ trách
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-receive-leader"></textarea>
      </div>
    </div>

    <div class="row form-group boxed box-5 box-5-11">
      <label class="col-sm-6">
        Mục đích xét nghiệm
      </label>
      <div class="col-sm-20">
        <textarea type="text" class="form-control" id="form-insert-target" autocomplete="off"></textarea>
      </div>
    </div>

    <div class="boxed box-2 box-2-4 box-3 box-3-4 html-sample" id="sample">

    </div>

    <div class="row form-group boxed box-2 box-2-7 box-3 box-3-7">
      <label class="col-sm-6"> Ngày giao mẫu </label>
      <div class="col-sm-10">
        <input type="text" id="form-insert-xsend" class="form-control">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-8 box-3 box-3-8">
      <label class="col-sm-6"> Người giao mẫu </label>
      <div class="col-sm-10">
        <input type="text" id="form-insert-xsender" class="form-control">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-9 box-3 box-3-9">
      <label class="col-sm-6"> Ngày nhận mẫu </label>
      <div class="col-sm-10">
        <input type="text" id="form-insert-xreceive" class="form-control">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-10 box-3 box-3-10">
      <label class="col-sm-6"> Người nhận mẫu </label>
      <div class="col-sm-10">
        <input type="text" id="form-insert-xreceiver" class="form-control">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-11 box-3 box-3-11">
      <label class="col-sm-6"> Ngày giao kết quả </label>
      <div class="col-sm-10">
        <input type="text" id="form-insert-xresend" class="form-control">
      </div>
    </div>

    <div class="row form-group boxed box-2 box-2-12 box-3 box-3-12">
      <label class="col-sm-6"> Người phụ trách bộ phận xét nghiệm </label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="form-insert-xresender">
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

    <button class="btn btn-info saved" id="saved-2-5" style="position: fixed; top: 150px; right: 10px;" onclick="printer(5)">
      <span class="glyphicon glyphicon-print"></span>
    </button>

    <button class="btn btn-warning saved" id="saved-1-1" style="position: fixed; top: 10px; right: 50px;" onclick="parseBox(1)">
      Mẫu 1
    </button>

    <button class="btn btn-warning saved" id="saved-1-2" style="position: fixed; top: 45px; right: 50px;" onclick="parseBox(2)">
      Mẫu 2
    </button>

    <button class="btn btn-warning saved" id="saved-1-3" style="position: fixed; top: 80px; right: 50px;" onclick="parseBox(3)">
      Mẫu 3
    </button>

    <button class="btn btn-warning saved" id="saved-1-4" style="position: fixed; top: 115px; right: 50px;" onclick="parseBox(4)">
      Mẫu 4
    </button>

    <button class="btn btn-warning saved" id="saved-1-5" style="position: fixed; top: 150px; right: 50px;" onclick="parseBox(5)">
      Mẫu 5
    </button>

    <button class="btn btn-success saved-0" style="position: fixed; top: 185px; right: 10px;" onclick="newForm()">
      <span class="glyphicon glyphicon-user"></span>
    </button>
  </div>
  <!-- END: mod2 -->
</div>

<script>
  var style = '.table-bordered {border-collapse: collapse;}.table-wider td, .table-wider th {padding: 10px;}table {width: 100%;}table td {padding: 5px;}.no-bordertop {border-top: 1px solid white; }.no-borderleft {border-left: 1px solid white; }.c20, .c25, .c30, .c35, .c40, .c45, .c50, .c80 {display: inline-block;}.c20 {width: 19%;}.c25 {width: 24%;}.c30 {width: 29%;}.c35 {width: 34%;}.c40 {width: 39%;}.c45 {width: 44%;}.c50 {width: 49%;}.c80 {width: 79%;}.p12 {font-size: 12px}.p13 {font-size: 13px}.p14 {font-size: 14px}.p15 {font-size: 15px}.p16 {font-size: 16px}.text-center, .cell-center {text-align: center;}.cell-center {vertical-align: inherit;}'
  var profile = ['@page { size: A4 portrait; margin: 20mm 10mm 10mm 35mm; }', '@page { size: A4 landscape; margin: 20mm 10mm 10mm 35mm;}']
  var former = {
    1: '<table class="table-bordered" border="1"><tr><td rowspan="2" class="cell-center" style="width: 20%; padding: 10pt 21pt;">CHI CỤC THÚ Y VÙNG V</td><td class="cell-center" style="height: 30pt;">PHIẾU GIẢI QUYẾT HỒ SƠ</td></tr><tr><td class="no-bordertop">Số: {code}/TYV5-TH</td></tr></table><p>&emsp; Tên đơn vị: {}</p><p><div class="inline c50">&emsp; Ngày nhận: {}</div><div class="inline c50">Ngày hẹn trả kết quả: {}</div></p><p><div class="inline c30">&emsp; Hình thức nhận: </div><div class="inline c20">{} Trực tiếp</div><div class="inline c20">{} Bưu điện</div><div class="inline c30">Khác: {}</div></p><p>&emsp; Người nhận hồ sơ: </p><p><div class="inline c30">&emsp; Phòng chuyên môn:</div><div class="inline c40">Ngày nhận: {}</div><div class="inline c30">Ngày trả: {}</div></p><table class="table-bordered" border="1"><tr><td class="text-center"> <u>Hồ sơ gồm:</u></td></tr><tr class="no-bordertop"><td><p>.</p><p>.</p><p>.</p><p>.</p><p>.</p><p>.</p><p>.</p></td></tr></table><br><table class="table-bordered" border="1"><tr><th class="p13"> <b>Ý kiến của phòng, Bộ phận chịu trách nhiệm giải quyết</b> </th><th class="p13"> <b>Ý kiến của ban lãnh đạo</b> </th></tr><tr><td colspan="2"><p>.</p><p>.</p><p>.</p><p>.</p><p>.</p><p>.</p><p>.</p></td></tr></table><p>&emsp;&emsp;Ghi chú: Hồ sơ có ý kiến của thủ trưởng (hoặc người được ủy quyền) phải giao lại cho Bộ phận một cửa trước 01 ngày so với ngày hẹn trả </p><br><br><br><p><div class="inline c40">Mã số: BM-02/TYV5-06</div><div class="inline c40">Mã số: Ngày ban hành: 02/11/2017</div><div class="inline c20">Lần sửa đổi: 02</div></p>', 2: '<table class="table-bordered" border="1" style="width: 95%; margin: auto;"><tr><td style="width: 60%;" class="cell-center">CHI CỤC THÚ Y VÙNG V <br> <b> TRẠM CHẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT </b></td><td><div class="c20"></div><div class="c80"><b>Biểu mẫu số: BM.STTT.20.10 <br>Số soát xét: 03.02718</b></div></td></tr></table><br><div class="text-center"> <b>PHIẾU GIAO NHẬN MẪU VÀ KẾT QUẢ XÉT NGHIỆM</b> </div><div style="float: right; width: 160pt; margin-right: 10pt; border: 1px solid black; padding: 5pt;">Số ĐKXN: {xcode-0}/{xcode-1}/{xcode-2} <br> Số trang: {page-0} <br> Liên: {no-0}/{no-1} </div><br><p><b>Bên giao mẫu: </b> {isenderunit}</p><p><b>Bên nhận mẫu: </b> {ireceiverunit}</p><div id="a">{table}</div><p><div style="display: inline-block"><b>Ghi chú:</b> </div><div style="margin-left: 1pt; display: inline-flex">- Bộ phận xét nghiệm trả kết quả trên chỉ tiêu xét nghiệm. <br>- Ngày xét nghiệm: {examdate} <br>- Ngày hẹn trả kết quả xét nghiệm: <i>ngày {resend-0} tháng {resend-1} năm {resend-2}</i></div></p><table><tr><td style="width: 5%"></td><td class="c30"><b>Người/Ngày giao mẫu <br></b><i>Ngày {xsend-0} tháng {xsend-1} năm {xsend-2} <br> <br> <br></i> {xsender}</td><td class="c30"><b>Người/Ngày nhận mẫu <br></b><i>Ngày {xreceive-0} tháng {xreceive-1} năm {xreceive-2} <br> <br> <br></i> {xreceiver}</td><td class="c30"><b>Phụ trácch bộ phận xét nghiệm <br></b><i>Ngày {xresend-0} tháng {xresend-1} năm {xresend-} <br> <br> <br></i> {xresender}</td></tr></table>', 3: '<table class="table-bordered" border="1"><tr><td class="cell-center"> <b>Biểu mẫu số: BM.STTT.22.01</b> </td><td class="cell-center"> <b>Số soát xét: 03.027148</b> </td></tr><tr><td colspan="2"><div class="cell-center">CHI CỤC THÚ Y VÙNG V <br> <b> TRẠM CHẨN ĐOÁN XÉT NGHIỆM BỆNH ĐỘNG VẬT </b></div>Địa chỉ: Số 36, Phạm Hùng, phường Tân An, thành phố Buôn Ma Thuột, tỉnh Đăk Lăk. <br>Điện thoại: 0262 3877793</td></tr></table><br><div class="text-center p16"> <b> PHIẾU KẾT QUẢ XÉT NGHIỆM </b> </div><br><p> <b> Số ĐKXN: {xcode-0}/{xcode-1}/{xcode-2} </b> </p><p class="text-center"> <b> Số phiếu kết quả thử nghiệm: {xcode-0}/{xcode-1}/{xcode-2}.CĐXN </b> </p><div id="a">{table}</div><p><div style="display: inline-block"><b> &emsp;&emsp; <u> Ghi chú: </u> </b> <i>(*)</i></div><div style="display: inline-flex"><i> - Các chỉ tiêu được công nhận TCVN ISO/IEC 17025:2007. <br> - Các chỉ tiêu được chứng nhận đăng ký hoạt động thử nghiệm </i></div></p><p> <i> &emsp;&emsp; Kết quả chỉ có giá trị trên mẫu thử nghiệm. Việc sao chép Kết quả này chỉ có giá trị khi được sao chép toàn bộ, và không có giá trị nếu chỉ sao chép một phần./. </i> </p><table><tr><td style="width: 5%"></td><td style="width: 30%" class="text-center"> <b>BỘ PHẬN XÉT NGHIỆM</b> <br> <i> (Ký, ghi rõ họ tên) </i> <br> <br> <br> {} </td><td style="width: 30%"></td><td style="width: 30%" class="text-center"> <b> TRƯỞNG TRẠM </b> <br> <br> <br> <br> {disLeader} </td><td style="width: 5%"></td></tr></table>'
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
  var formInsertReceiveDis = $("#form-insert-receive-dis")
  var formInsertReceiveLeader = $("#form-insert-receive-leader")
  var formInsertAttach = $("#form-insert-attach")
  var formInsertXaddress = $("#form-insert-xaddress")
  var formInsertXaddressSuggest = $("#form-insert-xaddress-suggest")
  var formInsertOwner = $("#form-insert-owner")
  var formInsertOwnerSuggest = $("#form-insert-owner-suggest")
  var formInsertSamplePlace = $("#form-insert-sample-place")
  var formInsertSamplePlaceSuggest = $("#form-insert-sample-place-suggest")
  var formInsertXphone = $("#form-insert-xphone")
  var formInsertXnote = $("#form-insert-xnote")
  var formInsertFax = $("#form-insert-fax")

  var formInsertXresend = $("#form-insert-xresend")
  var formInsertXresender = $("#form-insert-xresender")
  var formInsertXsend = $("#form-insert-xsend")
  var formInsertXsender = $("#form-insert-xsender")
  var formInsertXreceive = $("#form-insert-xreceive")
  var formInsertXreceiver = $("#form-insert-xreceiver")

  var formSummary = $("#form-summary")
  var formSummaryFrom = $("#form-summary-from")
  var formSummaryEnd = $("#form-summary-end")
  var formSummaryContent = $("#form-summary-content")
  var formSummaryUnit = $("#form-summary-unit")
  var formSummarySample = $("#form-summary-sample")
  var formSummaryExam = $("#form-summary-exam")
  var formInsertNoticeTime = $("#form-insert-notice-time")
  var sample = $("#sample")

  var global_html = {}
  var global_form = 1
  var global_saved = 0
  var global_id = 0
  var global_page = 1
  var global_printer = 1

  var visible = {
    0: {1: '1', 2: '1'},
    1: {1: '1, 2, 3', 2: '1, 2, 3'},
    2: {1: '1, 2, 3', 2: '1, 2, 3'},
    3: {1: '1, 2, 3, 4', 2: '1, 2, 3, 4'},
    4: {1: '1, 2, 3, 4, 5', 2: '1, 2, 3, 4, 5'},
    5: {1: '1, 2, 3, 4, 5', 2: '1, 2, 3, 4, 5'}
  }
  var dataPicker = {'form': 1, 'exam': 2, 'result': 3}
  var rdataPicker = {'1': 'form', '2': 'exam', 3: 'result'}
  var infoData = {1: [], 2: [], 3: []}
  var remindData = {}
  var today = '{today}'
  var global_field = [
  {
    code: '',
    type: '',
    status: true,
    mainer: [
      {
        main: '',
        method: '',
        note: [
          {
            result: '',
            note: ''
          },{
            result: '',
            note: ''
          }
        ]
      },{
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
    addInfo(2)
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

    installExamRemind()
    parseField(global_field)
        
    parseBox(1)
    parseSaved()
  })

  $("#form-insert-receive, #form-insert-resend, #form-insert-ireceive, #form-insert-iresend, #form-insert-sample-receive, #form-insert-sample-time, #form-insert-exam-date, #form-summary-from, #form-summary-end, #form-insert-notice-time").datepicker({
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
    if (visible[global_saved][1].search(index) >= 0) {
      global_form = index
      parseForm(index)
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

  function parseInputs(data, name) {
    $("." + name + "ed").remove()
    
    var array = data['form'][name]
    array = array.split(', ')
    if (data['form']['method']) {
      methodx = data['form']['method'].split(', ')
      symbolx = data['form']['symbol'].split(', ')
    }
    
    array.forEach((element, index) => {
      addInfo(dataPicker[name])
      if (dataPicker[name] == 1) {
        $("#formed-" + index).val(element)
      }
      else if (dataPicker[name] == 2) {
        $("#examed-" + index).val(element)
        $("#method-" + index).val(methodx[index])
        $("#symbol-" + index).val(symbolx[index])
      }
      else {
        $("#resulted-" + index).val(element)
      }
    });
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
    global_field = data

    sample.html('')

    data.forEach((sample, sampleIndex) => {
      var html2 = ''

      sample['mainer'].forEach((result, resultIndex) => {
        var html3 = ''
            
        result['note'].forEach((note, noteIndex) => {
          html3 += `
          <fieldset class="html-result">
            <button class="close right" data-dismiss="modal" onclick="removeField('`+ sampleIndex +`,`+ resultIndex +`,`+ noteIndex +`')">&times;</button>
            <legend>
              Kết quả
            </legend>
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
          </fieldset>`
        })

        html2 += `
        <fieldset class="html-main">
          <button class="close right" data-dismiss="modal" onclick="removeField('`+ sampleIndex +`,`+ resultIndex +`')">&times;</button>
          <legend>
            Chỉ tiêu
          </legend>
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
        </fieldset>`
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
      <fieldset>
        <button class="close right" data-dismiss="modal" onclick="removeField('`+ sampleIndex +`')">&times;</button>
        <legend>
          Mẫu
        </legend>
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
          <label class="col-sm-6"> Tình trạng mẫu </label>
            <input type="radio" name="samplestatus" `+ (sample['status'] ? 'checked' : '' ) +` class="form-control ig ig-status0-`+ sampleIndex +`"> Đạt<br>
            <input type="radio" name="samplestatus" `+ (sample['status'] ? '' : 'checked' ) +` class="form-control ig ig-status1-`+ sampleIndex +`"> Không đạt
        </div>
        `+ html2 +`
      </fieldset>`
    })
    sample.html(html)
    installer.forEach(item => {
      installRemindv2(item['name'], item['type'])
    })
  }

  function parseFieldTable() {
    var html = `  <table class="table-bordered table-wider" border="1">
    <tr>
      <th rowspan="2"> TT </th>
      <th rowspan="2"> Kí hiệu mẫu </th>
      <th rowspan="2"> Loại mẫu </th> 
      <th rowspan="2"> Số lượng </th>
      <th rowspan="2"> Tình trạng mẫu </th>
      <th colspan="3"> Yêu cầu thử nghiệm </th>
      <th rowspan="2"> Ghi chú </th>
    </tr>
    <tr>
      <th> Chỉ tiêu </th>
      <th> Phương pháp </th>
      <th> Kết quả </th>
    </tr>`
    var html2 = ''
    var index = 1
    data = global_field
    a.innerHTML = ''

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
          html4 = `<td rowspan="`+ mainerNoteCount +`"> ` + result['main'] + `</td><td rowspan="`+ mainerNoteCount +`">`+ result['method'] + `</td>` + html4
        }
        else {
          noteCount ++
          html4 += `<td> ` + result['main'] + `</td><td>`+ result['method'] + `</td><td>`+ result['note'][0]['result'] +`</td> <td>`+ result['note'][0]['note'] +`</td></tr>`
        }
        html3 += html4
      })

      html2 += '<tr><td rowspan="'+ noteCount +'">'+ (index++) +'</td><td rowspan="'+ noteCount +'">'+ sample['code'] +'</td><td rowspan="'+ noteCount +'"> '+ sample['type'] +'</td><td rowspan="'+ noteCount +'"> 01 </td><td rowspan="'+ noteCount +'"> '+ (sample['status'] ? 'Đạt' : 'Không đạt') +' YCXN </td>' + html3;
    })

    html += html2 + '</html>'
    a.innerHTML = html
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

  function insertMethodSubmit(e) {
    e.preventDefault()
    if (insertMethodName.val().length > 0 && insertMethodSymbol.val().length > 0) {
      $.post(
        strHref,
        {action: 'insertMethod', name: insertMethodName.val(), symbol: insertMethodSymbol.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            $('.method').each((index, item) => {
              method = JSON.parse(data['method'])
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
                          <label class="col-sm-6"> Tên hồ sơ </label>
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
    addInfo(2)
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
              <div class="col-sm-10 relative">
                <input type="text" class="form-control input-box exam examed" id="examed-` + length + `" style="float: none;" autocomplete="off">
                <div class="suggest exam-suggest" id="exam-suggest-` + length + `"> </div>
              </div>
            </div>
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

  function checkSampleCode(target, parent, number = 1) {
    var value = trim(target.val()).toUpperCase()
    while (value.search('  ') >= 0) {
      value = value.replace(/  /g, ' ')
    }
    value = value.replace(/;/g, ',')
    value = value.split(/, /g)
    target.val(value.join(', '))
    
    if (value.length != number) {
      parent.addClass('has-error')
      alert_msg('Sai số lượng ký hiệu mẫu: ' + value.length + '/' + number);
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
//
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
            form: getInputs('form', ') '),
            forms: getInputs('form'),
            number: formInsertNumber.val(),
            sample: formInsertSample.val(),
            type: getCheckbox('type', formInsertTypeOther),
            samplecode: formInsertSampleCode.val(),
            exam: getInputs('exam', ') '),
            exams: getInputs('exam'),
            symbol: getInputs('symbol'),
            xnote: formInsertXnote.val(),
            numberword: formInsertNumberWord.val(),
            methods: getInputs('method')
          }
        }
      break;
      case 2: 
      case 3:
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
          xresend: formInsertXresend.val(),
          ig: getIgField()
        }
      break;            
      case 4:
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            receive: formInsertReceive.val(),
            xcode: getInputs('xcode'),
            receivehour: formInsertSampleReceiveHour.val(),
            receiveminute: formInsertSampleReceiveMinute.val(),
            type: getCheckbox('type', formInsertTypeOther),
            number: formInsertNumber.val(),
            status: getCheckbox('status'),
            samplecode: formInsertSampleCode.val(),
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
            exam: getInputs('exam', ') '),
            method: getInputs('method'),
            exams: getInputs('exam'),
            numberword: formInsertNumberWord.val(),
            symbol: getInputs('symbol'),
            methods: getInputs('method'),
          }
        }
      break;
      case 5:
        var sampleCode = checkSampleCode(formInsertSampleCode, formInsertSampleParent, formInsertNumber.val())
        if (sampleCode) {         
          data = {
            xcode: getInputs('xcode'),
            sender: formInsertSenderEmploy.val(),
            resend: formInsertNoticeTime.val(),
            xaddress: formInsertXaddress.val(),
            number: formInsertNumber.val(),
            samplecode: formInsertSampleCode.val(),
            target: formInsertTarget.val(),
            note: formInsertNote.val(),
            receivedis: formInsertReceiveDis.val(),
            receiveleader: formInsertReceiveLeader.val(),
            sampleplace: formInsertSamplePlace.val(),
            owner: formInsertOwner.val(),
            exam: getInputs('exam'),
            method: getInputs('method'),
            exams: getInputs('exam'),
            methods: getInputs('method'),
            symbol: getInputs('symbol'),
            result: formInsertResult.val(),
            receive: formInsertReceive.val(),
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

            parseInputs(data, 'exam')
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
            formInsertXcode1.val(xcode[0])
            formInsertXcode2.val(xcode[1])
            formInsertXcode3.val(xcode[2])
            formInsertIsenderUnit.val(data['isenderunit'])
            formInsertIreceiverUnit.val(data['ireceiverunit'])
            parseField(data['ig'])
            formInsertExamDate.val(data['examdate'])
            formInsertIresend.val(data['iresend'])
            formInsertXreceive.val(data['xreceive'])
            formInsertXreceiver.val(data['xreceiver'])
            formInsertXresend.val(data['xresend'])
            formInsertXresender.val(data['xresender'])
            formInsertXsend.val(data['xsend'])
            formInsertXsender.val(data['xsender'])

          }

          if (data['form']['printer'] >= 4) {
            formInsertResult.val(data['form']['result'])
            formInsertSampleReceiver.val(data['form']['samplereceiver'])
            formInsertSampleReceive.val(data['form']['samplereceive'])
            formInsertNote.val(data['form']['note'])
            formInsertAddress.val(data['form']['address'])
            formInsertFax.val(data['form']['fax'])
          }

          if (data['form']['printer'] >= 5) {
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
            formInsertReceiveLeader.val(data['form']['receiveleader'])
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
        {action: 'insert', form: global_form, id: global_id, data: data, page: global_page, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
        (response, status) => {
          checkResult(response, status).then(data => {
            remind = JSON.parse(data['remind'])
            if (global_form > global_saved) {
              if (global_form == 2) {
                global_saved = 3
              }
              else {
                global_saved = global_form
              }
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
      {action: 'filter', page: 1, limit: filterLimit.val(), printer: filterPrinter.val(), keyword: filterKeyword.val()},
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

  function preview(id) {
    $.post(
      strHref,
      {action: 'preview', id: id},
      (response, status) => {
        checkResult(response, status).then(data => {
          printer(global_printer, data)
        }, () => {})
      }
    )
  }

  function printer(id, data = {}) {
    if (Object.keys(data).length || visible[global_saved][2].search(id) >= 0) {
      if (!Object.keys(data).length) {
        var data = checkForm(id)
      }
      
      if (Object.keys(data).length) {
        var html = former[id]
        id = Number(id)
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
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(form)', (data['form'].join('<br>') + '<br>Số lượng mẫu: ' + data['number'] + ', loại mẫu: ' + (data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text())) + ', loài động vật: ' + data['sample'] + '<br> Ký hiệu mẫu: ' + data['samplecode'] + '<br>Yêu cầu xét nghiệm:<br>' + ((data['exam'].length > 1 ? data['exam'].join('<br>') : data['exams'].join('<br>')) + (trim(data['xnote']).length ? '<br>Ghi chú: <br>' + data['xnote'].replace(/\n/g, '<br>') : ''))))
          break;
          case 2:
            var receive = data['receive'].split('/')
            var xnote = data['xnote'].split('\n')
            html = html.replace('(xcode-0)', trim(data['xcode'][0]))
            html = html.replace('(xcode-1)', trim(data['xcode'][1]))
            html = html.replace('(xcode-2)', trim(data['xcode'][2]))
            html = html.replace('(attach-0)', data['attach']['index'] == 0 ? 'checked' : '')
            html = html.replace('(attach-1)', data['attach']['index'] == 1 ? 'checked' : '')
            html = html.replace('(receive-0)', receive[0])
            html = html.replace('(receive-1)', receive[1])
            html = html.replace('(receive-2)', receive[2])
            html = html.replace('(phone)', data['xphone'])
            html = html.replace('(ended-copy)', data['endedcopy'])
            html = html.replace('(ended-hour)', data['endedhour'])
            html = html.replace('(ended-minute)', data['endedminute'])
            html = html.replace('(receiveHour)', data['receivehour'])
            html = html.replace('(receiveMinute)', data['receiveminute'])
            html = html.replace('(isenderEmploy)', data['isenderemploy'])
            html = html.replace('(isenderUnit)', data['isenderunit'])
            html = html.replace('(ireceiverEmploy)', data['ireceiveremploy'])
            html = html.replace('(ireceiverUnit)', data['ireceiverunit'])
            html = html.replace('(type)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('(sample)', data['sample'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['samplecode'])
            html = html.replace('(status)', ticked[data['status']['index']])
            html = html.replace('(quality)', ticked[data['quality']['index']])
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(xstatus-0)', data['xstatus']['index'] == 0 ? 'checked' : '')
            html = html.replace('(xstatus-1)', data['xstatus']['index'] == 1 ? 'checked' : '')
            html = html.replace('(xstatus-2)', data['xstatus']['index'] == 2 ? 'checked' : '')
            var exam = ''
            var pos = 770;
            var top = 0
            
            if (!(data['exam'].length > 1)) {
              data['exam'] = data['exams']
            }
            for (const key in data['exam']) {
              item = data['exam'][key]
              exam += '<div class="text" style="top: '+top+'px">' + item + '</div>'
              top += 30
            }
            
            if (xnote.length && trim(xnote) != "") {
              exam += '<div class="text" style="top: '+top+'px">Ghi chú: </div>'
              top += 30
              for (const key in xnote) {
                item = xnote[key]
                exam += '<div class="text" style="top: '+top+'px">' + item + '</div>'
                top += 30
              }
            }

            html = html.replace('(exam)', exam)
            html = html.replace(/pos-1/g, (pos + top + 30) + 'px') 
            html = html.replace(/pos-2/g, (pos + top + 90) + 'px') 
            html = html.replace(/pos-3/g, (pos + top + 120) + 'px') 
          break;
          case 3:
            var receive = data['receive'].split('/')
            var resend = data['resend'].split('/')
            html = html.replace('(attach-0)', data['attach']['index'] == 0 ? 'checked' : '')
            html = html.replace('(attach-1)', data['attach']['index'] == 1 ? 'checked' : '')
            html = html.replace('(xcode-0)', trim(data['xcode'][0]))
            html = html.replace('(xcode-1)', trim(data['xcode'][1]))
            html = html.replace('(xcode-2)', trim(data['xcode'][2]))
            html = html.replace('(page-0)', trim(data['page'][0]))
            html = html.replace('(page-1)', trim(data['page'][1]))
            html = html.replace('(no-0)', trim(data['no'][0]))
            html = html.replace('(no-1)', trim(data['no'][1]))
            html = html.replace('(customer)', data['isenderunit'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sample)', data['sample'])
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(sampleCode)', data['samplecode'])
            html = html.replace('(type-0)', data['type']['index'] == 0 ? 'checked' : '')
            html = html.replace('(type-1)', data['type']['index'] == 1 ? 'checked' : '')
            html = html.replace('(type-2)', data['type']['index'] == 2 ? 'checked' : '')
            html = html.replace('(type-3)', data['type']['index'] == 3 ? 'checked' : '')
            html = html.replace('(type-4)', data['type']['index'] == 4 ? 'checked' : '')
            html = html.replace('(type-5)', data['type']['value'])
            html = html.replace('(result)', data['result'])
            
            html = html.replace(/(receive-0)/g, receive[0])
            html = html.replace(/(receive-1)/g, receive[1])
            html = html.replace(/(receive-2)/g, receive[2])
            html = html.replace('(resend-0)', resend[0])
            html = html.replace('(resend-1)', resend[1])
            html = html.replace('(resend-2)', resend[2])
            
            html = html.replace('(other)', data['other'])
            var length = data['exam'].length
            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var position = 540
            var parse = ''
            for (let i = 0; i < length; i++) {
              var temp = part 
              if (data['exams'].length > 1) {
                temp = temp.replace('(index)', i + 1)
              }
              else {
                temp = temp.replace('(index)', '')
              }
              temp = temp.replace('(position)', position + "px")
              temp = temp.replace('(position-2)', position + 30 + "px")
              temp = temp.replace('(position-3)', position + 60 + "px")
              temp = temp.replace('(exam-content)', data['exams'][i])
              temp = temp.replace('(method)', data['method'][i])
              temp = temp.replace('(symbol)', data['symbol'][i])
              parse += temp
              position += 90
            }
            html = html.replace('(parse)', parse)
            html = html.replace(/pos-0/g, position)
            html = html.replace(/pos-1/g, position + 30)
            html = html.replace(/pos-2/g, position + 60)
          break; 
          case 4:
            var receive = data['receive'].split('/')
            var examdate = data['examdate'].split('/')
            html = html.replace(/xcode-0/g, trim(data['xcode'][0]))
            html = html.replace(/xcode-1/g, trim(data['xcode'][1]))
            html = html.replace(/xcode-2/g, trim(data['xcode'][2]))
            html = html.replace('(customer)', data['isenderunit'])
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['samplecode'])

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

            var length = data['exam'].length
            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var parse = ''
            for (let i = 0; i < length; i++) {
              var temp = part 
              if (data['exams'].length > 1) {
                temp = temp.replace('(index)', i + 1 + '. ')
              }
              else {
                temp = temp.replace('(index)', '')
              }
              temp = temp.replace('(exam-content)', data['exams'][i])
              temp = temp.replace('(method)', data['method'][i])
              temp = temp.replace('(symbol)', data['symbol'][i])
              parse += temp
            }
            html = html.replace('(parse)', parse)
          break;
          case 5:
            var iresend = data['resend'].split('/')
            var tabbed = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
            
            html = html.replace('(xcode-0)', trim(data['xcode'][0]))
            html = html.replace('(xcode-1)', trim(data['xcode'][1]))
            html = html.replace('(xcode-2)', trim(data['xcode'][2]))
            html = html.replace('(code)', data['code'])
            html = html.replace('(iresend-0)', iresend[0])
            html = html.replace('(iresend-1)', iresend[1])
            html = html.replace('(iresend-2)', iresend[2])
            html = html.replace('(customer)', data['sender'])
            html = html.replace('(numberword)', data['numberword'])
            html = html.replace('(address)', data['xaddress'])
            html = html.replace('(sample)', data['type']['index'] == 5 ? data['type']['value'] : trim($("#type-" + data['type']['index']).text()))
            html = html.replace('(number)', data['number'])
            html = html.replace('(sampleCode)', data['samplecode'])
            html = html.replace('(ireceive)', data['receive'])
            html = html.replace('(target)', data['target'])

            if (data['owner']) {
              var x = '<div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thông tin mẫu: </div> <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chủ hộ: (owner)</div>  <div class="p14"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Nơi lấy mẫu: (sampleplace)</div>'
              x = x.replace('(sampleplace)', data['sampleplace'])
              x = x.replace('(owner)', data['owner'])
              html = html.replace('(owner)', x)
            }
            else {
              html = html.replace('(owner)', '')
            }

            var length = data['exam'].length
            var part = html.slice(html.search('(exam)') + '(exam)'.length, html.search('(/exam)') - 1)
            html = html.replace(part, '(parse)').replace('(exam)', '').replace('(/exam)', '')
            var parse = ''
            for (let i = 0; i < length; i++) {
              var temp = part 
              if (data['exams'].length > 1) {
                temp = temp.replace('(index)', i + 1 + '. ')
              }
              else {
                temp = temp.replace('(index)', '')
              }
              temp = temp.replace('(content)', data['exam'][i])
              temp = temp.replace('(method)', data['method'][i])
              temp = temp.replace('(symbol)', data['symbol'][i])
              parse += temp
            }
            html = html.replace('(parse)', parse)
            html = html.replace('(result)', tabbed + data['result'].replace(/\n/g, '<br>' + tabbed))
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
            
            html = html.replace('(receivedis)', data['receivedis'].replace(/\n/g, '<br>'))
            html = html.replace('(receiveleader)', data['receiveleader'].toUpperCase())
          break;
        }
        
        var html = style + html
        var winPrint = window.open('', '', 'left=0,top=0,width=800,height=600,toolbar=0,scrollbars=0,status=0');
        winPrint.focus()
        winPrint.document.write(html);
        winPrint.print()
        winPrint.close()
      }
    }
  }
</script>
<!-- END: main -->
