<!-- BEGIN: main -->

<style>
  label {
    width: 100%;
  }
</style>

<div class="container">
  <div class="text-center start-content" style="padding-top: 50px;">
    <a href="/biograph/">
      <img src="/modules/biograph/src/banner.png" style="width: 200px;">
    </a>
  </div>

    <div style="margin-top: 20px;"></div>

    <div class="row">
      <label>
        <div class="col-sm-3">
          Tên Đăng nhập
        </div>
        <div class="col-sm-9">
          <input type="text" class="form-control" id="username" autocomplete="off">
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
              <input type="text" class="form-control" id="fullname" autocomplete="off">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Số CMND
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="politic" autocomplete="off">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Điện thoại
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="phone" autocomplete="off">
            </div>
          </label>
        </div>

        <div class="row">
          <label>
            <div class="col-sm-3">
              Địa chỉ
            </div>
            <div class="col-sm-9">
              <input type="text" class="form-control" id="address" autocomplete="off">
            </div>
          </label>
        </div>

        <div class="text-center">
          <button class="btn btn-info" id="button" onclick="signup()">
            Đăng ký
          </button>
        </div>

      </div>
      <div id="error">

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
  var error = $("#error")

  function displayError(errorText) {
    var text = ''
    
    if (errorText) {
      text = errorText
    }

    error.text(text)
  }

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
          }, (data) => {
            displayError(data['error'])
          })
        }
      )
    }
    else {
      displayError('Chưa điền đủ thông tin')
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
          }, (data) => {
            displayError(data['error'])
          })
        }
      )
    }
    else {
      displayError('Chưa điền đủ thông tin')
    }
  }

</script>
<!-- END: main -->
