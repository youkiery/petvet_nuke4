<!-- BEGIN: main -->
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script> 

<style>
  label {
    width: 100%;
  }
</style>

<div class="container">
  <a href="/biograph/"> Trang chủ </a>
  <div style="max-width: 500px; margin: auto;">

    <ul class="nav nav-tabs">
      <li class="active"><a class="tabber tabber-1" data-toggle="tab" href="#login"> Đăng nhập </a></li>
      <li><a class="tabber tabber-0" data-toggle="tab" href="#signup"> Đăng ký </a></li>
    </ul>

    <div class="row">
      <label>
        <div class="col-sm-3">
          Tên Đăng nhập
        </div>
        <div class="col-sm-9">
          <input type="text" class="form-control" id="username">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-3">
          Mật khẩu
        </div>
        <div class="col-sm-9">
          <input type="password" class="form-control" id="password">
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
              <input type="password" class="form-control" id="vpassword">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Họ và tên
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="fullname">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Số CMND
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="politic">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Điện thoại
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="phone">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Địa chỉ
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="address">
            </div>
          </label>
        </div>

        <div class="text-center">
          <button class="btn btn-info" id="button" onclick="signup()">
            Đăng ký
          </button>
        </div>

      </div>
    </div>    
  </div>
</div>

<script>
  var global = {
    url: '{origin}'
  }
  var username = $("#username")
  var password = $("#password")
  var vpassword = $("#vpassword")
  var fullname = $("#fullname")
  var phone = $("#phone")
  var politic = $("#politic")
  var address = $("#address")

  function checkLogin() {
    var data = {
      username: username.val(),
      password: password.val()
    }

    if (data['username'] && data['password']) {
      return data
    }
    return false
  }

  function checkSignup() {
    var check = true
    var data = {
      username: username.val(),
      password: password.val(),
      vpassword: vpassword.val(),
      fullname: fullname.val(),
      phone: phone.val(),
      politic: politic.val(),
      address: address.val(),
    }

    if (data['password'] == data['vpassword']) {
      for (const key in data) {
        if (data.hasOwnProperty(key)) {
          const element = data[key];
          
          if (!element) {
            check = false
          }
        }
      }
    }

    if (check) {
      return data
    }
    return false
  }

  function login() {
    if (loginData = checkLogin()) {
      $.post(
        global['url'],
        {action: 'login', data: loginData},
        (response, status) => {
          checkResult(response, status).then(data => {
            window.location.href = '/biograph/user'; 
          }, () => {})
        }
      )
    }
    else {
      
    }
  }

  function signup() {
    if (signupData = checkSignup()) {
      $.post(
        global['url'],
        {action: 'signup', data: checkSignup()},
        (response, status) => {
          checkResult(response, status).then(data => {
            window.location.href = '/biograph/user'; 
          }, () => {})
        }
      )
    }
    else {

    }
  }

</script>
<!-- END: main -->
