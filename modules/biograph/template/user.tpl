<!-- BEGIN: main -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>
    label {
      width: 100%;
    }
  </style>
  <div class="container">
  <!-- BEGIN: nolog -->
  <form>
    <ul class="nav nav-tabs">
      <li class="active"><a data-toggle="tab" href="#login"> Đăng nhập </a></li>
      <li><a data-toggle="tab" href="#signup"> Đăng ký </a></li>
    </ul>

    <div class="row">
      <label>
        <div class="col-sm-3">
          Tên Đăng nhập
        </div>
        <div class="col-sm-9">
          <input type="text" class="form-control" id="user-nolog-username">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-3">
          Mật khẩu
        </div>
        <div class="col-sm-9">
          <input type="text" class="form-control" id="user-nolog-password">
        </div>
      </label>
    </div>

    <div class="tab-content">
      <div id="login" class="tab-pane fade in active">
        <div class="text-center">
          <button class="btn btn-info" onclick="login()">
            Đăng nhập
          </button>
        </div>
      </div>
  
      <div id="signup" class="tab-pane fade">
        <div class="row">
          <label>
            <div class="col-sm-3">
              Xác nhận mật khẩu
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="user-nolog-password">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Họ và tên
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="user-nolog-password">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Điện thoại
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="user-nolog-password">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Địa chỉ
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="user-nolog-password">
            </div>
          </label>
        </div>

        <div class="text-center">
          <button class="btn btn-info" onclick="signup()">
            Đăng nhập
          </button>
        </div>
      </div>
    </div>    
  </form>
  <!-- END: nolog -->
  <!-- BEGIN: log -->
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#profile"> Thông tin cá nhân </a></li>
    <li><a data-toggle="tab" href="#list"> Danh sách thú cưng </a></li>
    <!-- BEGIN: adminnav -->
    <li><a data-toggle="tab" href="#adminuser"> Xác nhận người dùng </a></li>
    <li><a data-toggle="tab" href="#adminpet"> Xác nhận thú cưng </a></li>
    <!-- END: adminnav -->
  </ul>

  <div class="tab-content">
    <div id="profile" class="tab-pane fade in active">
      <h2> Thông tin cá nhân </h2>
      <div style="float: left;">
        <img src="" style="width: 50px; height: 50px;">
      </div>
      <div style="float: left; margin-left: 10px;">
        <p> Tên: (fullname) </p>
        <p> Điện thoại: (mobile) </p>
        <p> Địa chỉ: (address) </p>
      </div>
    </div>
    <div id="list" class="tab-pane fade">

    </div>
    <!-- BEGIN: adminnav2 -->
    <div id="adminuser" class="tab-pane fade">

    </div>
    <div id="adminpet" class="tab-pane fade">

    </div>
    <!-- END: adminnav2 -->

  </div>
    
  <!-- END: log -->
</div>
<!-- END: main -->
