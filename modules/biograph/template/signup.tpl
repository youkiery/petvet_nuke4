<!-- BEGIN: main -->

<style>
  label {
    width: 100%;
  }
  .col-sm-4 {
    text-align: left;
  }
</style>

<div class="container">
  <div class="text-center start-content" style="max-width: 450px; margin: auto; padding-top: 50px; border: 1px solid lightgray; padding: 15px; border-radius: 20px;">
    <a href="/biograph/">
      <img src="/modules/biograph/src/banner.png" style="width: 200px; margin: 20px 20px;">
    </a>
    <div style="margin-top: 20px;"></div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Tên đăng nhập
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="username" autocomplete="off">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Mật khẩu
        </div>
        <div class="col-sm-8">
          <input type="password" class="form-control" id="password">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Xác nhận mật khẩu
        </div>
        <div class="col-sm-8">
          <input type="password" class="form-control" id="vpassword">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Họ và tên
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="fullname" autocomplete="off">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Số CMND
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="politic" autocomplete="off">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Điện thoại
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="phone" autocomplete="off">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Tỉnh
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="al1" autocomplete="off">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Quận/Huyện/Thành phố
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="al2" autocomplete="off">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Xã/Phường/Thị trấn
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="al3" autocomplete="off">
        </div>
      </label>
    </div>

    <div class="row">
      <label>
        <div class="col-sm-4">
          Địa chỉ
        </div>
        <div class="col-sm-8">
          <input type="text" class="form-control" id="address" autocomplete="off">
        </div>
      </label>
    </div>

    <div class="text-center">
      <button class="btn btn-info" id="button" onclick="signup()">
        Đăng ký
      </button>
    </div>
    <div id="error">

    </div>
    <br>
    Đã có tài khoản? <a href="/biograph/login"> Đăng nhập ngay!</a>
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

  var al1 = $("#al1")
  var al2 = $("#al2")
  var al3 = $("#al3")

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
    var check = false
    var data = {
      username: username.val(),
      password: password.val(),
      vpassword: vpassword.val(),
      fullname: fullname.val(),
      phone: phone.val(),
      politic: politic.val(),
      address: address.val(),
      al1: al1.val(),
      al2: al2.val()
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
    data['al3'] = al3.val()

    if (check) {
      return data
    }
    return false
  }

  function signup() {
    if (signupData = checkSignup()) {
      $.post(
          global['url'],
          {action: 'signup', data: checkSignup()},
          (response, status) => {
        checkResult(response, status).then(data => {
          window.location.reload();
        }, (data) => {
          displayError(data['error'])
        })
      }
      )
    } else {
      displayError('Chưa điền đủ thông tin, kiểm tra các trường và mật khẩu')
    }
  }

</script>
<!-- END: main -->
