<!-- BEGIN: main -->
<div class="row form-group">
  <label class="col-sm-4">Số phiếu</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-code" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">
    khách hàng
  </label>
  <div class="relative col-sm-10">
    <input type="text" class="form-control" id="form-insert-sender-employ" autocomplete="off">
    <div class="suggest" id="form-insert-sender-employ-suggest"></div>
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">Ngày nhận mẫu</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-receive" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">Ngày hẹn trả kết quả</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-resend" autocomplete="off">
  </div>
</div>

<div class="row form-group">
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
      <input type="text" class="form-control" id="form-insert-receive-state-other" autocomplete="off">
    </div>
  </div>
</div>

<div class="row form-group">
  <b> <p> Phòng chuyên môn </p> </b>
  <label class="col-sm-4">
    Người nhận hồ sơ
  </label>
  <div class="relative col-sm-10">
    <input type="text" class="form-control" id="form-insert-receiver-employ" autocomplete="off">
    <div class="suggest" id="form-insert-receiver-employ-suggest"></div>
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">Ngày nhận</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-ireceive" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label class="col-sm-4">Ngày trả</label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-iresend" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <div id="form-insert-form">

  </div>
  <button class="btn btn-success" onclick="addInfo(1)">
    <span class="glyphicon glyphicon-plus"></span>
  </button>
</div>
<div class="form-group row">
  <label class="col-sm-4"> Số lượng mẫu </label>
  <div class="col-sm-10">
    <input type="text" class="form-control" id="form-insert-number" autocomplete="off">
  </div>
</div>

<div class="row form-group">
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
      <input type="text" class="form-control" id="form-insert-type-other" autocomplete="off">
    </div>
  </div>
</div>

<div class="form-group row">
  <label class="col-sm-4"> Loài vật được lấy mẫu </label>
  <div class="col-sm-10">
    <input type="text" class="form-control sample" id="form-insert-sample" autocomplete="off">
  </div>
</div>
<div class="form-group row">
  <label class="col-sm-4"> Ký hiệu mẫu </label>
  <div class="col-sm-10" id="form-insert-sample-parent">
    <input type="text" class="form-control" id="form-insert-sample-code" autocomplete="off">
  </div>
</div>

<div class="row form-group">
  <label>
    Yêu cầu xét nghiệm
    <button class="btn btn-success" onclick="insertMethod()"> <span class="glyphicon glyphicon-plus"></span> </button>
  </label>
  <div id="form-insert-request"></div>
  <button class="btn btn-success" onclick="addInfo(2)">
    <span class="glyphicon glyphicon-plus"></span>
  </button>
</div>
<!-- <END: main> -->